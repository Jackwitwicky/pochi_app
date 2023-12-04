# frozen_string_literal: true

class ApplicationService
  def self.call(...)
    new(...).call
  end

  def success(data: nil)
    Response.new(true, data, nil)
  end

  def failure(error: nil)
    Response.new(false, nil, error)
  end

  Response = Struct.new(:success, :data, :error) do
    def success?
      success
    end
  end
end
