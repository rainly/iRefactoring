module Vcs::LogName
  def log_file
    File.join(DDR_ENV[:project_root], @vcs.downcase + ".txt")
  end
end

module Vcs::CodePostfix;
  def source_code_postfix
    return ".cs" if @language == "csharp"
    return ".java" if @language == "java"
    ""
  end
end

module Vcs::LogParser
  include Vcs::LogName
  include Vcs::CodePostfix
  
  def get_code_committed()
    commits = {}
    File.open(log_file) do |file|
      while line = file.gets
        line = line.strip
        next if(!is_source_code_log?line)
        read_line_into_commits(line, commits)
      end
    end
    commits
  end
end
