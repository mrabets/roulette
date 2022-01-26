require 'stripe'

class Api::V1::PaymentController < ApplicationController
  def create
    Payment::IntentService.call(params[:amount], params[:payment_id])

    render json: { message: 'Payment Successful' }, status: :ok
  end
end
