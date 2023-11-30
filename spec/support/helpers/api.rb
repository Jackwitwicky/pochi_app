# frozen_string_literal: true

module Api
  def json_response
    case body = JSON.parse(response.body)
    when Hash
      body.with_indifferent_access
    when Array
      body
    end
  end
end

RSpec.configure do |config|
  config.include Api, type: :controller
  config.include Api, type: :api
  config.include Api, type: :request
end
