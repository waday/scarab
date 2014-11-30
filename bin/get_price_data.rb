# encoding: utf-8
require "./lib/stock_data_getter"
require "Date"

file = "./data/tosho_list.txt"
from = "2014/11/3"
to   = "2014/11/21"
#to   = Date.today.to_s # 2014-11-30
market = :t # 名証 => :m, 福証 => :f、札証 => :s
sdg = StockDataGetter.new(from, to, market)

begin
  File.open(file) do |f|
    f.each do |l|
      code = l.split(",")[0]
      sdg.get_price_data(code)
    end
  end
rescue => e
  p e
end
=begin
(1300..9999).each do |code|
  sdg.get_price_data(code)
end
=end
