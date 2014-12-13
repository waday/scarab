require "./lib/base"

# :open => 始値
# :high => 高値
# :low  => 安値
# :close=> 終値
# MovingAverage.new(stock, span: 20, price_at: :open)
class MovingAverage < Indicator
  def initialize(stock, params)
    @stock = stock
    @span = params[:span]
    @price_at = params[:price_at] || :close
  end

  def calculate_indicator
    prices = @stock.send(@price_at.to_s + "_prices")
    prices.moving_average(@span)
  end
end
