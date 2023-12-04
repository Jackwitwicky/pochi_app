# frozen_string_literal: true

class Api::V1::NotificationsController < ApplicationController
  def index
    render json: ApiResponse.render(data: current_user.notifications), status: :ok
  end

  def show
    notification = current_user.notifications.find_by(id: params[:id])

    if notification
      render json: ApiResponse.render(data: notification), status: :ok
    else
      render json: ApiResponse.render(message: 'The notification you are looking for does not exist'), status: :not_found
    end
  end
end
