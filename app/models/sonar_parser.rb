class SonarParser
  def initialize project_name
    @project_name = project_name
  end
  
  def get_complexity class_path_needs_to_be_trimed
    log = File.join(DDR_ENV[:project_root], @project_name, log_file_name)
    parse_file(log)
  end
  
  private
  
  def log_file_name
    "sonar.txt"
  end
  
  def parse_file file
    codes = {}
    File.open(file) do |f|
      while line = f.gets
        tmp = line.split(' ')
        codes[tmp[0]] = Code.new(tmp[0], 0, tmp[1].to_f)
      end
    end
    codes
  end
end