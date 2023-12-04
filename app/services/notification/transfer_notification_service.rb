# frozen_string_literal: true

class Notification::TransferNotificationService < ApplicationService
  def initialize(user_id:, title:, message:)
    @user_id = user_id
    @title = title
    @message = message
    super()
  end

  def call
    user = User.find_by(id: @user_id)

    return failure(error: 'Unable to send notification as the user does not exist on the system') unless user

    notification = Notification.new(title: @title, message: @message, user:)
    unless notification.save
      Rails.logger.error do
        "Unable to save system notification for user: #{@user_id} with title: #{@title} and message: #{@message}"
      end
      return
    end

    success(data: { notification: })
  end
end
