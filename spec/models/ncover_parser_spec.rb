require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'NcoverParser' do
  before(:each) do
    DDR_ENV[:project_root] = File.join(RAILS_ROOT, 'spec/fixtures/ncover_and_hg_projects')
  end
  
  it 'should parse class name and complexity' do
    parser = NcoverParser.new("admin")
    result = parser.get_complexity("c:\\Cruise-Agent\\pipelines\\Trunk-Quality-of-Service\\")
    result.size.should == 2
    result["src/admin/Controllers/StaffAssigneeConnectionController.cs"].complexity.should == 8
    result["src/admin/Controllers/TaxpayerDetailsController.cs"].complexity.should == 1
  end
end