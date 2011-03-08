require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  before(:each) do
    @project = Project.find("admin")
  end
  
  it 'should find project by name' do
    @project.name.should == "admin"
  end
  
end