load 'default_config' do |config|
  config[:test_value].is_a?(String)
end
