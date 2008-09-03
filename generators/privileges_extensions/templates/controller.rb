class ProjectUsersController < ApplicationController
  
  protect_from_forgery :except => [:create, :destroy]
  before_filter :ensure_admin, :only => [:destroy, :create]
  
  def create
    @project = Project.find params[:project_id]
    @project_user = User.find params[:project_user][:id]
    @project.users << @project_user unless @project.user_ids.include?(@project_user.id)
    redirect_to project_path(@project.id)
  end
  
  def destroy
    @project = Project.find params[:project_id]
    @project_user = User.find params[:id]
    @project.users.delete @project_user if @project.user_ids.include?(@project_user.id)
    redirect_to project_path(@project.id)
  end
  
end