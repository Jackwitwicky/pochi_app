# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password

  # a better approach would be to soft delete this
  # to prevent loss of data
  has_many :wallet_transactions, dependent: :destroy
end
