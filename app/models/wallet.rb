# frozen_string_literal: true

class Wallet
  attr_accessor :user

  def initialize(user_id:)
    @user = User.find_by(id: user_id)
  end

  def balance
    @user.wallet_transactions.where(transaction_type: :debit).sum(:amount) - user.wallet_transactions.where(transaction_type: :credit).sum(:amount)
  end

  def debit_account(amount:)
    wallet_transaction = WalletTransaction.new(amount:, transaction_type: :credit, user_id: @user.id)
    wallet_transaction.save!
  end

  def credit_account(amount:)
    wallet_transaction = WalletTransaction.new(amount:, transaction_type: :debit, user_id: @user.id)
    wallet_transaction.save!
  end

  def sufficient_balance(amount:)
    balance >= amount
  end
end
