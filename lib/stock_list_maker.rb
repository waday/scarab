# coding: utf-8
require "open-uri"

# Get stock informaiton from Yahoo

class StockListMaker
  attr_accessor :data_dir, :file_name

  def initialize(market)
    @market = market
    @data_dir = "data"
    @stock_info = []
  end

  def get_stock_info(code)
    page = open_page(code)
    return unless page
    text = page.read.encode("UTF-8", undef: :replace)
    data = parse(text)
    data[:code] = code
    return unless data[:market_section]
    puts code
    @stock_info << data
  end

  def save_stock_list
    File.open(@data_dir + "/" + @file_name, "w") do |file|
      @stock_info.each do |data|
        file.puts [data[:code],data[:market_section],data[:unit]].join(",")
      end
    end
  end


  private

  def open_page(code)
    begin
      open("http://stocks.finance.yahoo.co.jp/stocks/detail/?code=#{code}.#{@market}")
    rescue OpenURL::HTTPError => e
      puts e
      return
    end
  end

  def parse(text)
    data = Hash.new
    sections = []
    reg_market = /stockMainTabName">([^< ]+) ?</
    reg_unit = %r!<dd class="ymuiEditLink mar0"><strong>((?:\d|,)+|---)</strong>株</dd>!
    text.lines do |line|
      if line =~ reg_market
        sections << $+
      elsif line =~ reg_unit
        data[:market_section] = sections[0]
        data[:unit] = get_unit($+)
        return data
      end
    end
    data
  end

  def get_unit(str)
    if str == "---"
      "1"
    else
      str.gsub(/,/,"")
    end
  end
end
