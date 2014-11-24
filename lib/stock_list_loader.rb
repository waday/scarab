# coding: utf-8
class StockListLoader
  def initialize(stock_list_file)
    unless stock_list_file
      raise "銘柄リストを指定してください"
    end
    @stock_list = File.readlines(stock_list_file).map do |line|
      line.split(",")
    end
  end

  def stock_info
    @stock_info ||= pstock_list.map do |data|
      {code: data[0].to_i, market_section: data[1], unit: data[2].to_i}
    end
  end

  def codes
    @codes ||= stock_info.map {|info| info[:code]}
  end

  def market_sections
    @market_sections ||= stock_info.map {|info| info[:market_section]}
  end

  def filter_by_market_section(*sections)
    return self unless sections[0]
    @stock_info = stock_info.find_all do |info|
      sections.include?(info[:market_section])
    end
    self
  end

end
