require "./lib/base"

### 真の値幅の移動平均（ATR）に基づくストップを求めるクラス
# - 仕掛け値から買いでは、n日間のATRのx倍、下にストップを置く
# - 仕掛け値から売りでは、n日間のATRのx倍、上にストップを置く
class AverageTrueRangeStop < Stop
  # :span => ATRの期間
  # :ratio => ATRの何倍か
  def initialize(params)
    @span = params[:span]
    @ratio = params[:ratio] || 1
  end

  def calculate_indicators
    @average_true_range =
      AverageTrueRange.new(@stock, span: @span).calculate
  end

  # 仕掛値からn日ATR（前日）のx倍下に行ったところにストップを置く
  def stop_price_long(position, index)
    Tick.truncate(position.entry_price - range(index))
  end

  # 仕掛値からn日ATR（前日）のx倍上に行ったところにストップを置く
  def stop_price_short(position, index)
    Tick.ceil(position.entry_price + range(index))
  end

  private
  def range(index)
    @average_true_range[index - 1] * @ratio
  end
end_

