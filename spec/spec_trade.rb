require 'spec_helper'
require_relative '../lib/trade.rb'

RSpec.describe "Trade" do
  before do
    @trade = Trade.new(stock_code: 8604,
                      trade_type: :long,
                      entry_date: "2014/11/17",
                      entry_price: 251,
                      entry_time: :open,
                      volume: 100)
    @trade.first_stop = 241
    @trade.stop = 241
    @trade.length = 1
  end

  it "can refer parameters" do
    expect(@trade.stock_code).to eq(8604)
    expect(@trade.entry_date).to eq("2014/11/17")
    expect(@trade.entry_price).to eq(251)
    expect(@trade.long?).to be_truthy
    expect(@trade.short?).to be_falsy
    expect(@trade.closed?).to be_falsy
  end

  it "can substitute parameters" do
    expect(@trade.first_stop).to eq(241)
    expect(@trade.stop).to eq(241)
    expect(@trade.r).to eq(10)
    expect(@trade.length).to eq(1)
    @trade.length += 1
    expect(@trade.length).to eq(2)
  end

  it "can exit" do
    @trade.exit(date: "2014/11/21",
                price: 255,
                time: :in_session)
    expect(@trade.closed?).to be_truthy
    expect(@trade.exit_date).to eq("2014/11/21")
    expect(@trade.profit).to eq(400)
    expect("%.2f" % @trade.percentage_result).to eq("1.59")
    expect(@trade.r_multiple).to eq(0.4)
  end

end
