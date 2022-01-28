require 'stripe'

module Api
  module V1
    class PaymentController < ApplicationController
      def create
        Payment::IntentService.new(
          params[:amount],
          params[:payment_id]
        ).call

        render json: { message: 'Payment Successful' }, status: :ok
      end

      def update
        Payment::BalanceService.new(
          params[:user_id],
          params[:amount],
          params[:spending]
        ).update

        render json: { message: 'Balance Updated' }, status: :ok
      end

      def balance
        balance = User.find(params[:id]).balance
        render json: { balance: balance }, status: :ok
      end
    end
  end
end
