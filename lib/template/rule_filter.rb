class FilterRuleName < Filter
  def initialize(params)
    # パラメータの設定
  end

  def calculate_indicators
    # テクニカル指標の計算
  end

  def filter(index)
    # :no_entry, :long_only, :short_only, :long_and_shortのいずれかを返却する
  end
end
