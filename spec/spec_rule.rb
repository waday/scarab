# coding: utf-8
require 'spec_helper'
require_relative '../lib/stock'
require_relative '../lib/base'

RSpec.describe "Rule" do
  before do
    
    class MyEntry < Entry
      def check_long(index)
        enter_long(index, 100, :close) if index % 2 == 0
      end

      def check_short(index)
        enter_short(index, 100, :close) if index % 2 == 1
      end
    end

    class MyExit < Exit
      def check_long(trade, index)
        exit(trade, index, 105, :close) if index % 2 == 1
      end

      def check_short(trade, index)
        exit(trade, index, 95, :close) if index % 2 == 0
      end
    end

    class MyStop < Stop
      def stop_price_long(position, index)
        Tick.down(position.entry_price, 5)
      end

      def stop_price_short(position, index)
        Tick.up(position.entry_price, 5)
      end
    end

    class MyFilter < Filter
      def filter(index)
        case index % 4
        when 0
          :long_only
        when 1
          :short_only
        when 2
          :no_entry
        when 3
          :long_and_short
        end
      end
    end

    @stock = Stock.new(1000, :t, 100)
    @entry = MyEntry.new
    @entry.stock = @stock

    @my_exit = MyExit.new
    @my_exit.stock = @stock

    @stop = MyStop.new

    @filter = MyFilter.new

  end
    
  it ": Entry can implement check_long and check short method" do

    #pp entry.check_long_entry(0)

    expect(@entry.check_long_entry(0)).not_to eq(nil)
    expect(@entry.check_long_entry(1)).to eq(nil)
    expect(@entry.check_short_entry(0)).to eq(nil)
    expect(@entry.check_short_entry(1)).not_to eq(nil)

  end


  it ": Exit can implement check_long and check short method" do

    trade1 = @entry.check_long(0)
    @my_exit.check_exit(trade1, 1)

    expect(trade1.entry_price).to eq(100)
    expect(trade1.exit_price).to eq(105)

    trade2 = @entry.check_short(1)
    @my_exit.check_exit(trade2, 2)
    
    expect(trade2.entry_price).to eq(100)
    expect(trade2.exit_price).to eq(95)

  end

  it ": Stop can implement check_long and check short method" do
    trade3 = @entry.check_long(0)
    expect(@stop.get_stop(trade3, 0)).to eq(95)

    trade4 = @entry.check_short(1)
    expect(@stop.get_stop(trade4, 1)).to eq(105)
  end

  it ": Filter can implement filter method" do
    expect(@filter.get_filter(0)).to eq(:long_only)
    expect(@filter.get_filter(1)).to eq(:short_only)
    expect(@filter.get_filter(2)).to eq(:no_entry)
    expect(@filter.get_filter(3)).to eq(:long_and_short)
  end

end
