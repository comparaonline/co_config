require 'spec_helper'

describe CoConfig do

  after :each do
    CoConfig.send(:remove_const, :DEFAULT_CONFIG) if defined? CoConfig::DEFAULT_CONFIG
    CoConfig.send(:remove_const, :SIMPLE_CONFIG) if defined? CoConfig::SIMPLE_CONFIG
  end

  it 'has a version number' do
    expect(CoConfig::VERSION).not_to be nil
  end

  it "fails if the file doesn't exist" do
    stub_env('test_env')
    stub_config_path do |file|
      case file
      when 'configuration.rb' then 'simple_configuration.rb'
      when 'simple_config.yml' then 'unexistent_file.yml'
      end
    end

    expect { CoConfig.load }.to raise_error(CoConfig::MissingFileError)
  end

  it "fails if there is no configuration for the environment" do
    stub_env('unexistent_env')
    stub_config_path do |file|
      'simple_configuration.rb' if file == 'configuration.rb'
    end

    expect { CoConfig.load }.to raise_error(CoConfig::MissingConfigError)
  end

  it 'loads a simple test yml with corrent environment' do
    stub_env('test_env')
    stub_config_path do |file|
      'simple_configuration.rb' if file == 'configuration.rb'
    end

    CoConfig.load
    expect(CoConfig::SIMPLE_CONFIG[:test_value]).to eq('test value from env!')
  end

  it "loads defaults if there aren't configurations for the current environment" do
    stub_env('unexistent_env')
    stub_config_path do |file|
      'default_configuration.rb' if file == 'configuration.rb'
    end

    CoConfig.load
    expect(CoConfig::DEFAULT_CONFIG[:test_value]).to eq('test value from defaults!')
  end

  it 'loads the correct environment even with defaults' do
    stub_env('test_env')
    stub_config_path do |file|
      'default_configuration.rb' if file == 'configuration.rb'
    end

    CoConfig.load
    expect(CoConfig::DEFAULT_CONFIG[:test_value]).to eq('test value from env!')
  end

  it 'raises a validation error if validation raises an error' do
    stub_env('test_env')
    stub_config_path do |file|
      'invalid_raise_configuration.rb' if file == 'configuration.rb'
    end

    expect { CoConfig.load }.to raise_error(CoConfig::FailedValidationError)
  end

  it 'raises a validation error if validation returns false' do
    stub_env('test_env')
    stub_config_path do |file|
      'invalid_false_configuration.rb' if file == 'configuration.rb'
    end

    expect { CoConfig.load }.to raise_error(CoConfig::FailedValidationError)
  end

  it 'load configuration if validation passes' do
    stub_env('test_env')
    stub_config_path do |file|
      'valid_configuration.rb' if file == 'configuration.rb'
    end

    CoConfig.load
    expect(CoConfig::DEFAULT_CONFIG[:test_value]).to eq('test value from env!')
  end

  def stub_env(env)
    allow(CoConfig).to receive(:env).and_return(env)
  end

  def stub_config_path
    allow(CoConfig).to receive(:config_path) do |file|
      file_name = yield(file) || file
      Pathname.new(__FILE__).dirname.join('fixtures', file_name)
    end
  end
end
