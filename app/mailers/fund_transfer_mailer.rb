# frozen_string_literal: true

class FundTransferMailer < ApplicationMailer
  def new_transfer_email
    @sender = params[:sender]
    @recipient = params[:recipient]
    @transfer = params[:transfer]

    mail(to: @recipient.email, subject: 'New Fund Transfer')
  end
end
