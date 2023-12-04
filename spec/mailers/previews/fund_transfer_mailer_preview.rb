# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/fund_transfer_mailer
class FundTransferMailerPreview < ActionMailer::Preview
  def new_transfer_email
    @sender = User.new(name: 'John Doe', email: 'john@example.com', phone: '07123456')
    @recipient = User.new(name: 'Jane Doe', email: 'jane@example.com', phone: '0798123876')
    @transfer = FundTransfer.new(from: @sender, to: @recipient, amount: "500".to_d)

    FundTransferMailer.with(sender: @sender, recipient: @recipient, transfer: @transfer).new_transfer_email
  end
end
