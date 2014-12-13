# coding: utf-8
require 'spec_helper'
require_relative '../lib/text_to_stock'
require_relative '../lib/base'

RSpec.describe "AverageTrueRange" do
  before do
    @tts = TextToStock.new(stock_list: "tosho_list.txt")
    @stock = @tts.generate_stock(8609)
    @tts.from = "2014/11/10"
    @tts.to = "2014/11/28"
    @atr = AverageTrueRange.new(@stock,
                                span: 10).calculate
    @real_atr =  [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 23.8, 22.9, 20.9, 22.0, 20.4, 19.9, 18.9, 18.5]
  end
    
  it "can calculate average true range" do
    @real_atr.each_with_index do |value, i|
      next unless value
      expect(@real_atr[i].round(2)).to eq(value.round(2))
    end
  end

end
