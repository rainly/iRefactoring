require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'SonarParser' do
  before(:each) do
    DDR_ENV[:project_root] = File.join(RAILS_ROOT, 'spec/fixtures/sonar_and_svn_projects')
  end
  
  it 'should parse class name and complexity' do
    parser = SonarParser.new("edcore")
    result = parser.get_complexity("")
    result.size.should == 2
    result["com.biomedcentral.business.publishing.process.EmailArchiveCommand"].complexity.should == 37.0
    result["com.biomedcentral.business.publishing.process.ProformaEmailBuilder"].complexity.should == 32.5
  end
end