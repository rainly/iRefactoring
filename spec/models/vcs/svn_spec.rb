require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Vcs::Svn do
  before(:each) do
    DDR_ENV[:vcs] = "Svn"
    DDR_ENV[:language] = "java"
    @parser = Vcs::Svn.new()
    DDR_ENV[:project_root] = File.join(RAILS_ROOT+ "/spec/fixtures/sonar_and_svn_projects")
  end
  
  it 'should ignore commits which is not source code' do
    commits = @parser.get_code_committed()
    commits['/workflow/trunk/administrator/pom.xml'].should == nil
  end
  
  it 'should trim useless classpath' do
    commits = @parser.get_code_committed()
    commits['com.biomedcentral.application.editor.controllers.ManuscriptNoCorrectionsController'].should_not == nil
  end
  
  it 'should combine commits for the same source code' do
    commits = @parser.get_code_committed()
    commits.size.should == 2
    commits['com.biomedcentral.application.editor.controllers.ManuscriptNoCorrectionsController'].should == 2
  end
end