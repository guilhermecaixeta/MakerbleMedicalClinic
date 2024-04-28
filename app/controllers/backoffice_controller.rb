class BackofficeController < ApplicationController
  layout "backoffice"
  include RescueConcern
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :user_can_read?, only: [:index]
  before_action :user_can_write?, except: [:show, :index]

  def index
    @pagy, @objects = pagy("#{default_class_name}Policy::Scope".constantize.new(default_class, controller_path).resolve())
  end

  def new
    @object = default_class.new
  end

  def create
    @object = get_default_service.create(permitted_params)

    respond_to do |format|
      if @object.valid?
        format.html {
          redirect_to get_default_path,
                      notice: t("layout.action_text.created",
                                object_name: default_class.model_name.human,
                                :gender => :n)
        }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if get_default_service.update(permitted_params, @object).valid?
        format.html {
          redirect_to get_default_path,
                      notice: t("layout.action_text.updated", object_name: default_class.model_name.human, :gender => :n)
        }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    default_name = @object.name

    respond_to do |format|
      if @object.destroy
        format.html {
          redirect_to get_default_path,
                      notice: t("layout.action_text.deleted",
                                object_name: default_class.model_name.human,
                                name: default_name,
                                :gender => :n)
        }
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def policy(user)
    UserPolicy.new(user, controller_path)
  end

  def user_can_read?
    authorize controller_path, :has_read_permission?, policy_class: UserPolicy
  end

  def user_can_write?
    authorize controller_path, :has_read_and_write_permission?, policy_class: UserPolicy
  end

  private

  def get_instance
    @object = default_class.find(params[:id])
  end

  def get_default_service
    class_name = default_class_name
    "#{class_name}Service".constantize
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
