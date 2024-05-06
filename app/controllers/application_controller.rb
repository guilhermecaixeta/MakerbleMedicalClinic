class ApplicationController < ActionController::Base
  layout :layout_by_resource

  include RouteConcern
  include Pagy::Backend

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :user
      "authentication"
    else
      "application"
    end
  end

  def after_sign_in_path_for(resource)
    get_default_path_for_user current_user, root_path
  end
end
