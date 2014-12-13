# coding: utf-8
require 'spec_helper'
require_relative '../lib/text_to_stock'
require_relative '../lib/base'

RSpec.describe "MovingAverage" do
  before do
    @tts = TextToStock.new(stock_list: "tosho_list.txt")
    @stock = @tts.generate_stock(8609)
    @tts.from = "2014/11/10"
    @tts.to = "2014/11/28"
    @ma = MovingAverage.new(@stock, 
                            span: 10,
                            price_at: :close).calculate
    @real_ma = [nil, nil, nil, nil, nil, nil, nil, nil, nil, 937.0, 938.6, 938.1, 939.9, 942.7, 944.8, 945.7, 945.9, 945.7]
  end
    
  it "can calculate moving average" do
    @ma.each_with_index do |value, i|
      next unless value
      expect(@real_ma[i].round(2)).to eq(value.round(2))
    end
  end

end
