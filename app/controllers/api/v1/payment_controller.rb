require 'stripe'

module Api
  module V1
    class PaymentController < ApplicationController
      def create
        Payment::IntentService.new(
          params[:user_id],
          params[:amount],
          params[:payment_id]
        ).call

        render json: { message: 'Payment Successful' }, status: :ok
      rescue Stripe::InvalidRequestError => e
        raise CustomError.new(400), e.message
      end

      def balance
        balance = User.find(params[:id]).balance
        render json: { balance: balance }, status: :ok
      end
    end
  end
end
