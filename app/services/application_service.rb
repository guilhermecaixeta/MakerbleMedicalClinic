# typed: true
# frozen_string_literal: true

class ApplicationService
  include DomainErrors

  def initialize
    @klass = nil
  end

  protected

  def create(params, success_callback = nil, error_callback = nil)
    MissingKlassError.new if @klass.nil?
    MissingParamsError.new if params.nil? || params.empty?

    @object = @klass.new params

    apply_changes_if_valid success_callback, error_callback
  end

  def update(params, object, success_callback = nil, error_callback = nil)
    MissingParamsError.new if params.nil? || params.empty?

    @object = object

    @object.assign_attributes(params)

    apply_changes_if_valid success_callback, error_callback
  end

  def destroy(object)
    @object = object
    @object.destroy
  end

  def apply_changes_if_valid(success_callback = nil, error_callback = nil)
    @valid = @object.valid?

    if @valid
      @object.save!
      success_callback.(@object) unless success_callback.nil?
    else
      error_callback.(@object) unless error_callback.nil?
    end

    return @valid, @object
  end
end
