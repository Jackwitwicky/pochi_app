# frozen_string_literal: true

FactoryBot.define do
  factory :wallet_transaction do
    amount { "9.99" }
    transaction_type { "credit" }
    user
  end
end
