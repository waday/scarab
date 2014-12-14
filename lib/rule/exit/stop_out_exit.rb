require "./lib/base"

### ストップアウトクラス
# - 株価がストップに掛かったら手仕舞う
# - ストップに掛かった瞬間即座に手仕舞う
# - 寄り付きで掛かったら寄り付きで、
#   場中で掛かったら場中で手仕舞う
class StopOutExit < Exit
  def check_long(trade, index)
    stop = trade.stop
    price = @stock.prices[index]
    # 買いポジションの場合、その日の安値がストップ以下であれば手仕舞う　
    return unless stop >= price[:low]
    # 始値がストップを割っていれば寄り付きに始値で手仕舞い
    price, time = if stop >= price[:open]
                    [price[:open], :open]
                  # そうでなければ場中にストップの値段で行う
                  else
                    [stop, :in_session]
                  end
    exit(trade, index, price, time)
  end

  def check_short(trade, index)
    stop = trade.stop
    price = @stock.prices[index]
    return unless stop <= price[:high]
    price, time = if stop <= price[:open]
                    [price[:open], :open]
                  else
                    [stop, :in_session]
                  end
    exit(trade, index, price, time)
  end
end
