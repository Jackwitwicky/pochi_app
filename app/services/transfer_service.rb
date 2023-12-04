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
      send_notification(transfer: transfer_response.data[:transfer])
      success(data: transfer_response.data)
    else
      failure(error: transfer_response.error)
    end
  end

  private

  def send_notification(transfer:)
    sender = User.find_by(id: @sender_id)
    recipient = User.find_by(id: @recipient_id)
    message = "You have received #{@amount} to your account from #{recipient&.email}."
    Notification::TransferNotificationService.call(user_id: @recipient_id, title: 'Funds Transfer', message:)
    FundTransferMailer.with(sender:, recipient:, transfer:).new_transfer_email.deliver_later
  end
end
