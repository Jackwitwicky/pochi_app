# frozen_string_literal: true

class ApiResponse
  def self.render(...)
    new(...).call
  end

  attr_accessor :message, :data, :errors

  def initialize(message: nil, data: nil, errors: nil)
    @message = message
    @data = data
    @errors = errors
  end

  def call
    {
      message: @message,
      data: @data,
      errors: @errors
    }.to_json
  end
end
