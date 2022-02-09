class RouletteService
  def initialize(attributes)
    @bet_amount = attributes.fetch(:bet_amount)
    @bet_color = attributes.fetch(:bet_color)
    @colors = %w[red black]
  end

  def prize
    @prize ||= roulette_data.sample
  end

  def final_result
    @final_result ||= prize[:score] * bet_amount
  end

  def lose?
    prize[:color] != bet_color
  end

  private

  attr_reader :bet_amount, :bet_color, :colors

  def roulette_data
    @roulette_data ||= (1..20).map.with_index { |x, i| { index: i, score: x * 5, color: colors[x % 2] } }
  end
end
