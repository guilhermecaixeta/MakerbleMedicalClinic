class Backoffice::OperatorsController < BackofficeController
  def index
    super
  end

  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  def get_default_path
    get_default_path_for_user current_user, backoffice_operators_path
  end
end
