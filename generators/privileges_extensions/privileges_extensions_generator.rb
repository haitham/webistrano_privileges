class PrivilegesExtensionsGenerator < Rails::Generator::Base
  
  def manifest
    #added files and changed views
    record do |m|
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => "create_projects_users"
      m.template 'controller.rb', 'app/controllers/project_users_controller.rb'
      m.template 'views/show_project.html.erb', 'app/views/projects/show.html.erb'
      m.template 'views/users_partial.html.erb', 'app/views/projects/_users.html.erb'
      m.template 'views/projects_partial.html.erb', 'app/views/layouts/_projects.html.erb'
      m.template 'views/projects_index.html.erb', 'app/views/projects/index.html.erb'
      
      #added lines
      m.gsub_file 'app/models/project.rb', /(#{Regexp.escape("class Project < ActiveRecord::Base")})/mi do |match|
        "#{match}\n  has_and_belongs_to_many :users\n"
      end
      
      m.gsub_file 'app/models/user.rb', /(#{Regexp.escape("class User < ActiveRecord::Base")})/mi do |match|
        "#{match}\n  has_and_belongs_to_many :projects\n"
      end
      
      m.gsub_file 'config/routes.rb', /(#{Regexp.escape("map.resources :projects, :member => {:dashboard => :get} do |projects|")})/mi do |match|
        "#{match}\n    projects.resources :project_users\n"
      end
      
      m.gsub_file 'app/controllers/application.rb', /(#{Regexp.escape("class ApplicationController < ActionController::Base")})/mi do |match|
        "#{match}\n  include WebistranoPrivileges::ControllerExtensions\n  before_filter :setup_privileges\n"
      end
      
    end
  end
  
end