# frozen_string_literal: true

class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_token!

  def create
    user = User.authenticate_by(email: auth_params[:email], password: auth_params[:password])
    if user
      render json: ApiResponse.render(message: 'User has been authenticated', data: { token: JsonWebToken.encode(user_id: user.id) })
    else
      render json: ApiResponse.render(message: 'Invalid email or password')
    end
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
