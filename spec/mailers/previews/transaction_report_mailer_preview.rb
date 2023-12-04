# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/transaction_report_mailer
require 'factory_bot_rails'
class TransactionReportMailerPreview < ActionMailer::Preview
  include FactoryBot::Syntax::Methods

  def report_email
    @user = create(:user)
    @transactions = create_list(:wallet_transaction, 5, user: @user)

    TransactionReportMailer.with(transactions: @transactions, user: @user).report_email
  end
end
