module Api
  module V1
    class RouletteController < ApplicationController
      def create
          
        roulette = RouletteService.new(roulette_params(:bet_amount, :bet_color))

        Payment::BalanceService.new(params[:user_id], roulette.final_result, roulette.lose?).update
        
        render json: { 
          prize_index: roulette.prize[:index],
          prize_score: roulette.prize[:score],
          color: roulette.prize[:color]
        },
        status: :ok
      end
      
      private
      
      def roulette_params(*args)
        params.require(:roulette).permit(*args)
      end
    end
  end
end