class ApplicationController < ActionController::Base
  layout :layout_by_resource

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
    if resource.is_admin?
      root_path
    elsif resource.is_doctor?
      backoffice_doctors_path
    elsif resource.is_operator?
      backoffice_operators_path
    end
  end
end
