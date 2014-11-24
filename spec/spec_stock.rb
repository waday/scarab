# coding: utf-8
require 'spec_helper'
require_relative '../lib/stock.rb'

RSpec.describe "Stock" do
  before do
    @stock = Stock.new(8604, :t, 100)
  end
    
  it "can reference informations of code and market, unit" do
    expect(@stock.code).to eq(8604)
    expect(@stock.market).to eq(:t)
    expect(@stock.unit).to eq(100)
  end

  it "can add a postscript to stock prices information" do
    @stock.add_price("2014-07-01", 402, 402, 395, 397, 17495700)
    @stock.add_price("2014-07-04", 402, 404, 400, 403, 18819300)
    @stock.add_price("2014-07-05", 402, 408, 399, 401, 20678000)
    expect(@stock.prices[0][:date]).to eq("2014-07-01")
    expect(@stock.prices[1][:open]).to eq(402)
    expect(@stock.prices[2][:high]).to eq(408)
  end
    
end
