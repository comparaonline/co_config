require 'rails/railtie'

module CoConfig
  class Railtie < ::Rails::Railtie
    config.before_configuration do
      CoConfig.load
    end
  end
end
