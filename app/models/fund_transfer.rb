# frozen_string_literal: true

class FundTransfer < ApplicationRecord
  validates :from, presence: true
  validates :to, presence: true
  validates :amount, presence: true

  belongs_to :sender, class_name: 'User', foreign_key: :from, inverse_of: :fund_transfers
  belongs_to :recipient, class_name: 'User', foreign_key: :to, inverse_of: :fund_transfers
end
