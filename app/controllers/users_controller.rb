# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render json: ApiResponse.render(message: 'User has been created successfully', data: @user), status: :created, location: @user
    else
      render json: ApiResponse.render(message: 'We were unable to create your account', errors: @user.errors), status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
  end
end
