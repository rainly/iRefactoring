require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectsController do
  
  describe 'GET index' do
    it 'show configuration information' do
      DDR_ENV[:projects] = ["project1", "project2"]
      get :index
      projects = assigns(:projects)
      projects.size.should == 2
    end
  end
end 