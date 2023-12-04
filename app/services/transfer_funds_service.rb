# frozen_string_literal: true

class TransferFundsService < ApplicationService
  def initialize(sender_id:, recipient_id:, amount:)
    @sender_id = sender_id
    @recipient_id = recipient_id
    @amount = amount
    super()
  end

  def call
    sender = User.find_by(id: @sender_id)
    recipient = User.find_by(id: @recipient_id)

    return failure(error: 'The sender does not exist on the system') unless sender

    return failure(error: 'The recipient does not exist on the system') unless recipient

    return failure(error: 'The amount to transfer must be greater than or equal to 5') if @amount.nil? || @amount < 5

    unless sender.wallet.sufficient_balance(amount: @amount)
      return failure(error: 'You do not have sufficient funds to complete the transfer')
    end

    ActiveRecord::Base.transaction do
      transfer = perform_transfer(sender:, recipient:)
      success(data: { transfer: })
    rescue ActiveRecord::ActiveRecordError => e
      Rails.logger.debug e.message
      failure(error: e.message)
    end
  end

  def perform_transfer(sender:, recipient:)
    sender.wallet.debit_account(amount: @amount)
    recipient.wallet.credit_account(amount: @amount)
    FundTransfer.create!(from: sender.id, to: recipient.id, amount: @amount)
  end
end
