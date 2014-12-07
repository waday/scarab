# Arrayクラス拡張
# 合計、平均、移動平均、区間高値、安値を求める
# 配列から指標計算する
class Array

  def sum
    self.inject(:+)
  end

  def average
    sum.to_f / self.size
  end

  # 元の配列と同じ要素数の配列を返す
  # 配列の各要素をspan個ずつ取り出した配列に対して順番に
  # ブロックで実装された処理を実行する
  # Usage: array.map_indicator(span) {|span_array| ... }
  def map_indicator(span)
    indicator_array = Array.new(self.size)
    self.each_cons(span).with_index do |span_array, index|
      # 指標からさらに指標を作る場合、最初に挿入されるnilを飛ばす
      next if span_array.include?(nil)
      indicator_array[index + span -1] = yield span_array
    end
    indicator_array
  end

  def moving_average(span)
    map_indicator(span) {|vals| vals.average}
  end

  # 区間高値
  def highs(span)
    map_indicator(span) {|vals| vals.max}
  end

  # 区間安値
  def lows(span)
    map_indicator(span) {|vals| vals.min}
  end

end
