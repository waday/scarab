# coding; utf-8
require "./lib/stock_list_maker"

# 東証銘柄の銘柄リストを生成する
# file_nameは省略可能。省略するとtosho_list.txtになる
# Usage: ruby bin/make_stock_list.rb file_name

slm = StockListMaker.new(:t)
slm.file_name = ARGV[0] || "tosho_list.txt"
puts slm.file_name
(1300..9999).each do |code|
  slm.get_stock_info(code)
end
slm.save_stock_list
