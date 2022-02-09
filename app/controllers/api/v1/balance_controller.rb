module Api
  module V1
    class BalanceController < ApplicationController
      def index
        render json: { balance: balance }, status: :ok
      end

      private

      def balance
        balance ||= User.find(params[:id]).balance
      end
    end
  end
end
