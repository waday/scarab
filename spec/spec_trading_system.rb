# coding: utf-8
require 'spec_helper'
require_relative '../lib/trading_system'
require_relative '../lib/base'
require_relative '../lib/text_to_stock'
require "pp"

RSpec.describe "TradingSystem" do
  before do
    @data = TextToStock.new(stock_list: "tosho_list.txt")
    @trading_system =
      TradingSystem.new(
        entries: EstrangementEntry.new(span: 10, rate: 0.2),
        exits:   [StopOutExit.new, EstrangementExit.new(span: 10, rate: 0.1)],
        stops:   AverageTrueRangeStop.new(span: 10),
        filters: MovingAverageDirectionFilter.new(span: 10))

    def simulate(code)
      stock = @data.generate_stock(code)
      @trading_system.set_stock(stock)
      @trading_system.calculate_indicators
      trade = nil
      trades = []
      stock.prices.size.times do |i|
        if trade
          @trading_system.set_stop(trade, i)
          trade.length += 1
        end
        unless trade
          trade = @trading_system.check_entry(i)
          trade.volume = stock.unit if trade
        end
        if trade
          @trading_system.check_exit(trade, i)
          if trade.closed?
            trades << trade
            trade = nil
          end
        end
      end
      trades
    end

  end
    
  it "simulate specific code" do

    trades = simulate(8065)
    pp trades

    puts

    trades.each {|trade| puts trade.profit}
    puts "総損益: #{trades.map {|trade| trade.profit}.sum}"

  end

end
