# 呼値モジュール
# 呼値単位に合わせて値段を増減、丸め処理を行う
module Tick
  module_function
  def size(price)
    if price <= 3000
      1
    elsif 3000 < price && price <= 5000
      5
    elsif 5000 < price && price <= 30000
      10
    elsif 30000 < price && price <= 50000
      50
    elsif 50000 < price && price <= 300000
      100
    elsif 300000 < price && price <= 500000
      500
    elsif 500000 < price && price <= 3000000
      1000
    elsif 3000000 < price && price <= 5000000
      5000
    elsif 5000000 < price && price <= 30000000
      10000
    elsif 30000000 < price && price <= 50000000
      50000
    elsif 50000000 < price
      100000
    end
  end

  # 切り上げ
  def ceil(price)
    tick_size = size(price)
    if price % tick_size == 0
      price
    else
      truncate(price) + tick_size
    end
  end

  # 切り下げ
  def truncate(price)
    (price - price % size(price)).truncate
  end

  # 近い方に丸める
  def round(price)
    tick_size = size(price)
    if price % tick_size * 2 > tick_size
      ceil(price)
    else
      truncate(price)
    end
  end

  # 指定ティック分加算
  def up(price, tick = 1)
    tick.times {price += size(price)}
    ceil(price)
  end

  # 指定ティック分減算
  def down(price, tick = 1)
    price = truncate(price)
    tick.times {price -= size(price)}
    price
  end
end
