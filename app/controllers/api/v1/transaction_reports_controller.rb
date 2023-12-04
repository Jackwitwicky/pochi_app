# frozen_string_literal: true

class Api::V1::TransactionReportsController < ApplicationController
  def create
    unless transaction_report_params[:start_date] && transaction_report_params[:end_date]
      render json: ApiResponse.render(message: 'Please provide a start and end date field to generate your report')
      return
    end

    begin
      start_date = transaction_report_params[:start_date].to_datetime
      end_date = transaction_report_params[:end_date].to_datetime

      # this should be sent as an attachment and use deliver_later to run on the background
      transactions = current_user.wallet_transactions.created_between(start_date, end_date)
      TransactionReportMailer.with(transactions:, user: current_user).report_email.deliver

      render json: ApiResponse.render(message: 'Your request was successful. Please check your email for your transaction report'), status: :ok
    rescue Date::Error => e
      render json: ApiResponse.render(message: 'Please provide valid date fields', errors: [e.message])
    end
  end

  private

  def transaction_report_params
    params.require(:transaction_report).permit(:start_date, :end_date)
  end
end
