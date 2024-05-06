module BackofficeHelper
  include RouteConcern

  def policy_for(user, controller_name)
    UserPolicy.new(user, controller_name)
  end

  def backoffice_user_edit_path(user)
    if user.is_admin?
      edit_backoffice_manager_path user
    elsif user.is_doctor?
      edit_backoffice_doctor_path user
    else
      edit_backoffice_operator_path user
    end
  end
end
