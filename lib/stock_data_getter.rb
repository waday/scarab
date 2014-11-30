# coding: utf-8
require "open-uri"
require "date"

# get price datas from Yahoo
class StockDataGetter
  attr_accessor :data_dir

  def initialize(from, to, market)
    @from_date = Date.parse(from)
    @to_date   = Date.parse(to)
    @market    = market
    @data_dir  = "data"
  end

  # get new price data
  def get_price_data(code)
    @code = code
    save_to_file(prices_text)
  end

  def update_price_data(code)
    @code = code
    if File.exist?(data_file_name)
      get_from_date
      append_to_file(prices_text)
    else
      save_to_file(prices_text)
    end
  end

  private
  def prices_text
    prices = get_price_data_from_historical_data_pages
    return if prices.empty?
    prices_to_text(prices)
  end

  def get_price_data_from_historical_data_pages
    page_num = 1
    prices = []
    begin
      url = url_for_historical_data(page_num)
      begin
        text = open(url).read.encode("UTF-8", :undef => :replace)
      rescue EOFError
        return []
      end
      # create price infotmation array to each brand
      prices += text.scan(reg_prices)
      page_num += 1
    end while text  =~ %r!次へ</a></ul>!
    prices
  end

  def url_for_historical_data(page_num)
    "http://info.finance.yahoo.co.jp/history/" + 
     "?code=#{@code}.#{@market}" +
     "&sy=#{@from_date.year}" +
     "&sm=#{@from_date.month}" +
     "&sd=#{@from_date.day}" +
     "&ey=#{@to_date.year}" +
     "&em=#{@to_date.month}" +
     "&ed=#{@to_date.day}" +
     "&tm=d&p=#{page_num}"
   end

  def reg_prices
    %r!<tr><td>(\d{4}年\d{1,2}月\d{1,2}日)</td><td>((?:\d|,)+)</td><td>((?:\d|,)+)</td><td>((?:\d|,)+)</td><td>((?:\d|,)+)</td><td>((?:\d|,)+)</td><td>((?:\d|,)+)</td></tr>!
  end

  def prices_to_text(prices)
    # price format: 日付,始値,高値,安値,終値,出来高,調整後終値
    new_prices = prices.reverse.map do |price|
      # replace 年月日 to "/"
      price[0].gsub!(/[年月]/, "\/")
      price[0].gsub!(/日/, "")
      # replace digit to 2 digits
      price[0].gsub!(%r!/(\d)/!, '/0\1/') # month
      price[0].gsub!(%r!/(\d)$!, '/0\1')  # day
      # remove comma between numbers
      price[1..6].each{|price| price.gsub!(",", "")}
      # array to String with comma
      price.join(",")
    end
    new_prices.join("\n")
  end

  def data_file_name
    "#{@data_dir}/#{@code}.txt"
  end

  # do the next day of the last day in the file with the starting date
  def get_from_date
    # File.readlines.last[0..9] is date(YYYY/MM/DD)
    last_date = File.readlines(data_file_name).last[0..9]
    @from_date = Date.parse(last_date).next
  end

  def save_to_file(prices_text)
    save(prices_text, "w")
  end

  def append_to_file(prices_text)
    save(prices_text, "a")
  end

  def save(prices_text, open_mode)
    return unless prices_text
    File.open(data_file_name, open_mode) do |file|
      file.puts prices_text
    end
    puts @code
  end
end
