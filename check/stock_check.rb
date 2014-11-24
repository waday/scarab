# coding: utf-8
require "./lib/stock"

stock = Stock.new(8604, :t, 100)
puts stock.code
puts stock.market
puts stock.unit
