class BackofficeController < ApplicationController
  layout "backoffice"
  include RescueConcern
  include Pundit::Authorization

  before_action :authenticate_user!
end
