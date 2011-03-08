class ProjectsController < ApplicationController
  def index
    @projects = DDR_ENV[:projects]
  end
end