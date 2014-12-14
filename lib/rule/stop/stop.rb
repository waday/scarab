require "./lib/base"

### 手仕舞いのボーダー値段を設定
# - stop_price_long、stop_price_shortメソッドを実装すること
# - stop_price_long: 買いposition（Tradeクラス）に対する値段
# - stop_price_short: 売りpositionに対するストップの値段
class Stop < Rule
  def get_stop(position, index)
    with_valid_indicators do
      if position.long?
        stop_price_long(position, index)
      elsif position.short?
        stop_price_short(position, index)
      end
    end
  end
end
