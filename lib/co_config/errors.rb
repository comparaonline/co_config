module CoConfig
  class ConfigurationLoadError < RuntimeError
    attr_reader :message
    alias_method :to_s, :message
  end

  class MissingFileError < ConfigurationLoadError
    def initialize(file_name)
      @message = "Configuration file '#{file_name}' not found"
    end
  end

  class MissingConfigError < ConfigurationLoadError
    def initialize(file_name, env)
      @message = "Missing configuration for '#{env}' on '#{file_name}'"
    end
  end

  class FailedValidationError < ConfigurationLoadError
    def initialize(file_name, error)
      @message = "Failed validation for '#{file_name}' (#{error.to_s})"
    end
  end
end
