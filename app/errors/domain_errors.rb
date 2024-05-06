module DomainErrors
  class BaseDomainError < StandardError
  end

  class MissingIntervalError < BaseDomainError
    def initialize
      super I18n.t("admin.errors.missing_date_time")
    end
  end

  class MissingParamsError < BaseDomainError
    def initialize
      super I18n.t("admin.errors.missing_params")
    end
  end

  class MissingRoleNameError < BaseDomainError
    def initialize
      super I18n.t("admin.errors.missing_role_name")
    end
  end

  class MissingKlassError < BaseDomainError
    def initialize
      super I18n.t("admin.errors.missing_klass")
    end
  end
end
