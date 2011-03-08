ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'static_pages', :action => 'introduction'
  
  map.resources :plots
  map.resources :user_guide
  map.resources :projects

  map.with_options :controller => "plots" do |plot|
    plot.project_plot 'projects/:id/plot', :action => 'project_plot'
  end
  
  map.connect '/introduction', :controller => 'static_pages', :action => 'introduction'
  map.connect '/configuration', :controller => 'static_pages', :action => 'configuration'
  map.connect '/acknowledgement', :controller => 'static_pages', :action => 'acknowledgement'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
