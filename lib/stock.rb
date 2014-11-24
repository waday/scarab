# coding: utf-8

class Stock
  attr_reader :code, :market, :unit, :prices

  def initialize(code, market, unit)
    @code = code
    @market = market
    @unit = unit
    @prices = []
    @price_hash = Hash.new
  end

  def add_price(date, open, high, low, close, volume)
    @prices << {:date => date,
      :open => open,
      :high => high,
      :low => low,
      :close => close,
      :volume => volume}
  end

  def map_prices(price_name)
    @price_hash[price_name] ||= @prices.map do |price|
      price[price_name]
    end
  end

  def dates
    map_prices(:date)
  end

  def open_prices
    map_prices(:open)
  end

  def high_prices
    map_prices(:high)
  end

  def low_prices
    map_prices(:low)
  end

  def close_prices
    map_prices(:close)
  end

  def volumes
    map_prices(:volume)
  end

end
