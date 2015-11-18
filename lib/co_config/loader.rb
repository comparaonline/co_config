require 'co_config/errors'
require 'yaml'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/object/blank'

module CoConfig
  module Loader
    module_function :load

    def load(file_name, &validation)
      config = load!(full_name(file_name), &validation)
      CoConfig.const_set(base_name(file_name).upcase, config)
    end

    private

    def load!(file_name, &validation)
      hash = load_yaml(file_name)
      config = hash.fetch(CoConfig.env, hash[:defaults])
      fail MissingConfigError.new(file_name, CoConfig.env) unless config.present?
      validate(config, file_name, &validation)
      config
    end

    def validate(config, file_name)
      return unless block_given?
      raise 'Validation block returned false' if yield(config) == false
    rescue StandardError => e
      fail FailedValidationError.new(file_name, e)
    end

    def load_yaml(file_name)
      file = config_path(file_name)
      fail MissingFileError.new(file_name.to_s) unless file.exist?
      ::YAML.load_file(file).with_indifferent_access
    end

    def config_path(file_name)
      if defined?(@location)
        @location.join(file_name)
      else
        CoConfig.config_path(file_name)
      end
    end

    def full_name(file_name)
      if /\.yml\Z/ =~ file_name
        file_name
      else
        "#{file_name}.yml"
      end
    end

    def base_name(file_name)
      File.basename(file_name, '.*')
    end

  end
end
