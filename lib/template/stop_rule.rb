class StopRuleName < Stop
  def initialize(params)
    # パラメータの設定
  end

  def calculate_indicators
    # テクニカル指標の計算
  end

  def stop_price_long(position, index)
    # 買いポジションに対するストップの計算
  end

  def stop_price_short(position, index)
    # 売りポジションに対するストップの計算
  end
end
