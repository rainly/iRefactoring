require 'rubygems'
require 'nokogiri'

class NcoverParser
  def initialize project_name
    @project_name = project_name
  end
  
  def get_complexity class_path_needs_to_be_trimed
    log = File.join(DDR_ENV[:project_root], @project_name, log_file_name)
    parse_file(log, class_path_needs_to_be_trimed)
  end
  
  private
  
  def log_file_name
    "sources_full.html"
  end
  
  def parse_file file, class_path_needs_to_be_trimed
    @doc = Nokogiri::HTML(open(file), nil, "utf-8")
    rows = @doc.xpath("//table[@class='sortable']/tr")
    result = {}
    #the first row is the heading and the last row is the summary, so those two rows needs to be filtered out from parsing class
    rows[1..rows.length-2].each do |row|
      class_name = row.xpath("td[@class='detail']/a").inner_html.strip.split(class_path_needs_to_be_trimed)[1]
      class_name_converted = class_name.split("\\").join(File::SEPARATOR)
      result[class_name_converted]= Code.new(class_name_converted, 0, row.xpath("td[5]/span").inner_html.strip.to_i)
    end
    result
  end

end