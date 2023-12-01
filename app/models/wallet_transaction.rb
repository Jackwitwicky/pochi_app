# frozen_string_literal: true

class WalletTransaction < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true
  validates :transaction_type, presence: true
  validates :amount, numericality: { only_integer: true,
                                     greater_than_or_equal_to: 5 }

  enum transaction_type: {
    credit: 0,
    debit: 1
  }
end
