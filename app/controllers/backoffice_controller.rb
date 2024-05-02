class BackofficeController < ApplicationController
  layout "backoffice"
  include RescueConcern
  include ResourceConcern
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :user_can_read?, only: [:index]
  before_action :user_can_write?, except: [:show, :index]
  before_action :get_instance, only: [:edit, :update, :destroy]

  def index
    @pagy, @objects = pagy(get_scope())
  end

  def new
    @object = default_class.new
  end

  def create
    @valid, @object = get_default_service.create(permitted_params)

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
    @valid, @object = get_default_service.update(permitted_params, @object)
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

    respond_to do |format|
      if @object.destroy
        format.html {
          redirect_back fallback_location: root_path,
                        status: :see_other,
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
