module ResourceConcern
  extend ActiveSupport::Concern

  included do
    before_action :get_instance, only: [:edit, :update, :destroy]

    def get_scope
      "#{default_class_name}Policy::Scope".constantize.new(current_user, controller_path).resolve()
    end

    def get_instance
      @object = default_class.find(params[:id])
    end

    def get_default_service
      "#{default_class_name}Service".constantize.new
    end

    def permitted_params
      permitted_attributes = get_current_class_policy.new(default_class, controller_path).permitted_attributes
      params.require(default_class_name.underscore.to_sym).permit(permitted_attributes)
    end

    def default_class
      default_class_name.constantize
    end

    def get_current_class_policy
      "#{default_class_name}Policy".constantize
    end

    def default_class_name
      controller_name.classify
    end

    def get_default_path_for_user(user, fallback_route)
      if user.is_admin?
        fallback_route
      elsif user.is_doctor?
        root_path
      else
        backoffice_calendar_index_path
      end
    end
  end
end
