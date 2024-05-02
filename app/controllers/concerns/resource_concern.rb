module ResourceConcern
  extend ActiveSupport::Concern

  included do
    def user_can_read?
      authorize controller_path, :has_read_permission?, policy_class: UserPolicy
    end

    def user_can_write?
      authorize controller_path, :has_read_and_write_permission?, policy_class: UserPolicy
    end

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
  end
end
