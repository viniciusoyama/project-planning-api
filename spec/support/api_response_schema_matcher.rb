RSpec::Matchers.define :match_json_schema do |schema|
  match do |target|
    schema_directory = "#{Dir.pwd}/spec/support/json_schemas"
    schema_path = "#{schema_directory}/#{schema}.json"
    if target.respond_to?(:body) # is a response
      JSON::Validator.validate!(schema_path, target.body, strict: true)
    elsif target.is_a?(Hash)
      JSON::Validator.validate!(schema_path, target, strict: true)
    else
      raise 'target for match_json_schema matcher not registered'
    end
    
  end
end