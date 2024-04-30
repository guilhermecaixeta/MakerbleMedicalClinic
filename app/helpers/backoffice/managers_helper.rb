module Backoffice::ManagersHelper
  def role_options
    Role.all
  end
end
