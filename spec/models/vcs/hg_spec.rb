require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Vcs::Hg do
  before(:each) do
    DDR_ENV[:vcs] = "Hg"
    DDR_ENV[:language] = "csharp"
    @parser = Vcs::Hg.new()
    DDR_ENV[:project_root] = File.join(RAILS_ROOT+ "/spec/fixtures/ncover_and_hg_projects")
  end
  
  it 'should ignore commits which is not source code' do
    commits = @parser.get_code_committed()
    commits['toolkit/libs/paver.py'].should == nil
  end
  
  it 'should combine commits for the same source code' do
    commits = @parser.get_code_committed()
    commits.size.should == 2
    commits['src/integration-provision/ProvisionService.cs'].should == 2
  end
end