# frozen_string_literal: true

class TransferService < ApplicationService
  def initialize(sender_id:, recipient_id:, amount:)
    @sender_id = sender_id
    @recipient_id = recipient_id
    @amount = amount.to_d
    super()
  end

  def call
    transfer_response = TransferFundsService.call(sender_id: @sender_id,
                                                  recipient_id: @recipient_id,
                                                  amount: @amount)

    if transfer_response.success?
      send_notification
      success(data: transfer_response.data)
    else
      failure(error: transfer_response.error)
    end
  end

  private

  def send_notification
    recipient = User.find_by(id: @recipient_id)
    message = "You have received #{@amount} to your account from #{recipient&.email}."
    Notification::TransferNotificationService.call(user_id: @recipient_id, title: 'Funds Transfer', message:)
  end
end
