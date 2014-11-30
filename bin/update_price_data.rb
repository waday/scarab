# coding: utf-8

require "./lib/stock_data_getter"

file = "./data/tosho_list.txt"
from = "2014/11/3"
to   = Date.today.to_s # 2014-11-30
market = :t # 名証 => :m, 福証 => :f、札証 => :s
ydg = StockDataGetter.new(from, to, market)

begin
  File.open(file) do |f|
    f.each do |l|
      code = l.split(",")[0]
      ydg.update_price_data(code)
    end
  end
rescue => e
  p e
end
