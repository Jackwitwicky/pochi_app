# frozen_string_literal: true

class Api::V1::WalletTransactionsController < ApplicationController
  def create
    user = if wallet_params[:phone]
             User.find_by(phone: wallet_params[:phone])
           else
             current_user
           end

    unless user
      render json: ApiResponse.render(message: 'The phone number provided does not exist'), status: :created
      return
    end

    wallet_transaction = WalletTransaction.new(user:, amount: wallet_params[:amount], transaction_type: :debit)

    if wallet_transaction.save
      render json: ApiResponse.render(message: 'The funds have been topped up successfully', data: wallet_transaction), status: :created
    else
      render json: ApiResponse.render(message: 'We were unable to top up the funds', errors: wallet_transaction.errors), status: :unprocessable_entity
    end
  end

  private

  def wallet_params
    params.permit(:phone, :amount)
  end
end
