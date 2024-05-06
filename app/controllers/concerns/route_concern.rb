module RouteConcern
  extend ActiveSupport::Concern

  included do
    def get_default_path_for_user(user, admin_fallback_route)
      if user.is_admin?
        admin_fallback_route
      elsif user.is_doctor?
        root_path
      else
        backoffice_calendar_index_path
      end
    end
  end
end
