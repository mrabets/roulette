require 'stripe'

class Api::V1::PaymentController < ApplicationController

  def create
    Stripe::PaymentIntent.create({
      amount: params[:amount],
      currency: "USD",
      description: "Your Company Description",
      payment_method: params[:id],
      confirm: true,
    });

    render json: {message: 'Payment Successful'}, status: :ok

  rescue Stripe => e
    render json: { message: e }, status: :not_acceptable
  end
end
