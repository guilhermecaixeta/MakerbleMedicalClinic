module DomainErrors
  class BaseDomainError < StandardError
  end

  class MissingIntervalError < BaseDomainError
    def initialize
      super I18n.t("admin.errors.missing_date_time")
    end
  end
end
