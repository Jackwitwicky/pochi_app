# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_token!, only: [:create]

  def show
    user = User.find_by(id: params[:id])
    unless user
      render json: ApiResponse.render(message: 'The requested user does not exist'), status: :not_found
      return
    end

    render json: ApiResponse.render(data: user.as_json(except: :password_digest)), status: :ok
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: ApiResponse.render(message: 'User has been created successfully', data: @user.as_json(except: :password_digest)), status: :created
    else
      render json: ApiResponse.render(message: 'We were unable to create your account', errors: @user.errors), status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
  end
end
