class BackofficeController < ApplicationController
  layout "backoffice"
  include RescueConcern
  include ResourceConcern
  include AuthorizationConcern
  include Pundit::Authorization

  def initialize
    @bypass_controllers = [Backoffice::DoctorsController.controller_name,
                           Backoffice::OperatorsController.controller_name]
    @bypass_actions = ["edit", "update"]
    super
  end

  def index
    @pagy, @objects = pagy(get_scope())
  end

  def new
    @object = default_class.new
  end

  def create
    @valid, @object = get_default_service.create permitted_params

    respond_to do |format|
      if @valid
        format.html {
          redirect_to get_default_path,
                      notice: t("admin.action_response.created",
                                object_name: default_class.model_name.human)
        }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    @valid, @object = get_default_service.update permitted_params, @object
    respond_to do |format|
      if @valid
        format.html {
          redirect_to get_default_path,
                      notice: t("admin.action_response.updated", object_name: default_class.model_name.human)
        }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    default_name = @object.has_attribute?(:name) ? @object.name : ""
    is_destroyed = get_default_service.destroy @object

    respond_to do |format|
      if is_destroyed
        format.html {
          redirect_back fallback_location: root_path,
                        notice: t("admin.action_response.deleted",
                                  object_name: default_class.model_name.human,
                                  name: default_name)
        }
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def policy(user)
    UserPolicy.new(current_user, controller_path)
  end
end
