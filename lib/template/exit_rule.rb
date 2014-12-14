class EntryRuleName < Entry
  def initialize(params)
    # パラメータの設定
  end

  def calculate_indicators
    # テクニカル指標の計算
  end

  def check_long(index)
    # 買い仕掛けのチェック
    # 仕掛け発生なら、enter_long(index, price, entry_time)で仕掛ける
  end

  def check_short(index)
    # 売り仕掛けのチェック
    # 仕掛け発生なら、enter_short(index, price, entry_time)で仕掛ける
  end
end
