# frozen_string_literal: true

class Api::V1::FundTransfersController < ApplicationController
  def create
    unless recipient
      render json: ApiResponse.render(message: 'Invalid recipient')
      return
    end

    transfer_response = TransferFundsService.call(sender_id: current_user.id,
                                                  recipient_id: recipient.id,
                                                  amount: fund_transfer_params[:amount])

    if transfer_response.success?
      render json: ApiResponse.render(message: 'Funds have been transferred successfully', data: transfer_response.data)
    else
      render json: ApiResponse.render(message: 'We were unable to complete the transfer', errors: [transfer_response.error])
    end
  end

  private

  def fund_transfer_params
    params.require(:fund_transfer).permit(:to, :amount)
  end

  def recipient
    @recipient ||= User.where(phone: fund_transfer_params[:to]).or(User.where(email: fund_transfer_params[:to])).first
  end
end
