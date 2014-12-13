require "./lib/base"

# 前日の移動平均と本日の移動平均を比較
# :up => 前日より上向いている
# :down => 前日より下向いている
# :flat => 前日から変わらない
class MovingAverageDirection < Indicator
  def initialize(stock, params)
    @stock = stock
    @span = params[:span]
  end

  # 最新の終値と@span日前の終値を比較する
  def calculate_indicator
    @stock.close_prices.map_indicator(@span + 1) do |prices|
      if prices.first < prices.last
        :up
      elsif prices.first > prices.last
        :down
      else
        :flat
      end
    end
  end
end
