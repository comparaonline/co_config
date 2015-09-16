require "co_config/version"
require 'co_config/loader'
require 'co_config/railtie'

module CoConfig
  class Configuration
    include Loader

    def initialize(file)
      instance_eval(File.read(file.to_s), file.to_s) if file.exist?
    end
  end

  def config_path(file)
    Rails.root.join('config', file)
  end

  def env
    Rails.env
  end

  def load
    file = config_path('configuration.rb')
    Configuration.new(file)
  end

  module_function :load, :config_path, :env
end
