module WebistranoPrivileges
  
  module ControllerExtensions
    def setup_privileges
      
      #check if in a resource nested in a project
      unless params[:project_id].nil?
        unless current_user.admin? or current_user.project_ids.include?(params[:project_id].to_i)
          flash[:notice] = "Action not allowed"
          redirect_to home_path
          return false
        end
      end
      
      #check if in projects controller
      if controller_name == "projects" and action_name != "index" and action_name != "dashboard"
        unless current_user.admin? or current_user.project_ids.include?(params[:id].to_i)
          flash[:notice] = "Action not allowed"
          redirect_to home_path
          return false
        end
      end
      
    end
  end
  
end