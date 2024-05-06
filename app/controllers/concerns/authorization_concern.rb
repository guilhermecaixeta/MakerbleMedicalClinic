module AuthorizationConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :user_can_read?, only: [:index]
    before_action :user_can_write?, except: [:show, :index]

    @bypass_controllers = []
    @bypass_actions = []

    def can_bypass_authorization?
      @bypass_controllers.include?(controller_name) &&
      @bypass_actions.include?(action_name) &&
      current_user.id == params[:id].to_i
    end

    def user_can_read?
      authorize controller_path,
                :has_read_permission?,
                policy_class: UserPolicy
    end

    def user_can_write?
      if can_bypass_authorization?
        authorize controller_path,
                  :has_read_and_write_permission?,
                  policy_class: "#{default_class_name}Policy".constantize
      else
        authorize controller_path,
                  :has_read_and_write_permission?,
                  policy_class: UserPolicy
      end
    end
  end
end
