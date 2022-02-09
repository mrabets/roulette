require 'stripe'

module Api
  module V1
    class PaymentController < ApplicationController
      def create
        Payment::IntentService.new(payment_params).call

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

      private

      def payment_params
        params.require(:payment).permit(:user_id, :amount, :payment_id)
      end
    end
  end
end
