# frozen_string_literal: true

class WalletTransaction < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true
  validates :transaction_type, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 5 }

  scope :created_between, lambda { |start_date, end_date| where(created_at: start_date.beginning_of_day..end_date.end_of_day) }

  enum transaction_type: {
    credit: 0,
    debit: 1
  }
end
