require "./lib/rule/rule"

### 仕掛けクラス
# - 仕掛けルールを作る際はcheck_long、check_shortメソッドを実装すること
# - check_longの中ではenter_longを、check_shortの中ではenter_shortを呼び出す
class Entry < Rule
  def check_long_entry(index)
    with_valid_indicators {check_long(index)}
  end

  def check_short_entry(index)
    with_valid_indicators {check_short(index)}
  end

  private
  def enter(index, price, long_short, entry_time)
    Trade.new(stock_code: @stock.code,
              trade_type: long_short,
              entry_date: @stock.dates[index],
              entry_price: price,
              entry_time: entry_time)
  end

  def enter_long(index, price, entry_time)
    enter(index, price, :long, entry_time)
  end

  def enter_short(index, price, entry_time)
    enter(index, price, :short, entry_time)
  end
end
