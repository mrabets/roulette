require 'stripe'

module Api
  module V1
    class PaymentController < ApplicationController
      def create
        Payment::IntentService.new(payment_params).call

        render json: { message: 'Payment Successful' }, status: :ok
      end

      def update
        byebug
        Payment::BalanceService.new(balance_params).update

        render json: { message: 'Balance Updated' }, status: :ok
      end

      private

      def payment_params
        params.require(:payment).permit(:user_id, :amount, :payment_id)
      end

      def balance_params
        params.require(:payment).permit(:user_id, :amount, :spending)
      end
    end
  end
end
