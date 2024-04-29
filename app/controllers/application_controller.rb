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
    if resource.roles.find_by(name: "Administrator")
      root_path
    elsif resource.roles.find_by(name: "Doctor")
      backoffice_doctors_path
    elsif resource.roles.find_by(name: "Operator")
      backoffice_attendants_index_path
    end
  end
end
