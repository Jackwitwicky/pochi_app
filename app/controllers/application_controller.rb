# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user

  before_action :authenticate_token!

  private

  def authenticate_token!
    payload = JsonWebToken.decode(auth_token)
    @current_user = User.find(payload['user_id'])
  rescue JWT::ExpiredSignature
    render json: ApiResponse.render(message: 'Auth token has expired'), status: :unauthorized
  rescue JWT::DecodeError
    render json: ApiResponse.render(message: 'Invalid auth token'), status: :unauthorized
  end

  def auth_token
    @auth_token ||= request.headers.fetch('Authorization', '').split.last
  end
end
