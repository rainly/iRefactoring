class Vcs::Svn
  include Vcs::LogParser
  
  def initialize
    @language = DDR_ENV[:language]
    @vcs = DDR_ENV[:vcs]
  end

  private
  
  def is_source_code_log? line
    line.end_with? source_code_postfix and (line.start_with? "M " or line.start_with? "A ")
  end
  
  def read_line_into_commits line, commits
    code_changed = change_in_one_commit(line)
    return if code_changed.nil?
    if(commits.has_key?(code_changed))
      commits[code_changed] = commits[code_changed] + 1
    else
      commits[code_changed] = 1
    end
  end
  
  def change_in_one_commit line
    code = line.split(" ")[1]
    java_code = code.split("java/")[1]
    return if java_code.nil? 
    java_code.gsub("/", ".").slice(0, java_code.size - source_code_postfix.size)
  end
end