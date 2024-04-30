module BackofficeHelper
  def policy_for(user, controller_name)
    UserPolicy.new(user, controller_name)
  end

  def backoffice_user_edit_path
    if current_user.is_admin?
      edit_backoffice_manager_path current_user
    elsif current_user.is_doctor?
      edit_backoffice_doctor_path current_user
    else
      edit_backoffice_operator_path current_user
    end
  end
end
