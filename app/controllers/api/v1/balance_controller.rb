module Api
  module V1
    class BalanceController < ApplicationController
      def index
        balance = User.find(params[:id]).balance
        render json: { balance: balance }, status: :ok
      end
    end
  end
end