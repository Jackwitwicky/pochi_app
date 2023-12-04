# frozen_string_literal: true

FactoryBot.define do
  factory :fund_transfer do
    from { 1 }
    to { 1 }
    amount { "9.99" }
  end
end
