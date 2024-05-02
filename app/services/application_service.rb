# typed: true
# frozen_string_literal: true

class ApplicationService
  include DomainErrors

  def create(params)
  end

  def update(params, object)
    @params = params
    @object = object

    return apply_changes_if_valid
  end

  def destroy(object)
  end

  protected

  def apply_changes_if_valid(success_callback = Proc.new { }, error_callback = Proc.new { })
    unless @object[:id].nil?
      MissingParamsError.new if @params.nil?
      @object.assign_attributes(@params)
    end

    @valid = @object.valid?

    if @valid
      @object.save!
      success_callback.(@object) if success_callback
    else
      error_callback.(@object) if error_callback
    end

    return @object, @valid
  end
end
