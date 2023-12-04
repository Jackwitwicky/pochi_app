# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    title { "MyString" }
    message { "MyString" }
    user { nil }
  end
end
