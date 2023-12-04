# frozen_string_literal: true

class TransactionReportMailer < ApplicationMailer
  def report_email
    @transactions = params[:transactions]
    @user = params[:user]

    mail(to: @user.email, subject: 'Pochi App Transaction Report')
  end
end
