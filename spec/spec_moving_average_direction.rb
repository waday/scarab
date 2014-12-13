# coding: utf-8
require 'spec_helper'
require_relative '../lib/text_to_stock'
require_relative '../lib/base'

RSpec.describe "Estrangement" do
  before do
    @tts = TextToStock.new(stock_list: "tosho_list.txt")
    @stock = @tts.generate_stock(8609)
    @tts.from = "2014/11/10"
    @tts.to = "2014/11/28"
    @mvd = MovingAverageDirection.new(@stock,
                                      span: 10).calculate
    @real_mvd = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, :up, :down, :up, :up, :up, :up, :up, :down] 
  end
    
  it "can calculate estranged" do
    @real_mvd.each_with_index do |value, i|
      next unless value
      expect(@real_mvd[i]).to eq(value)
    end
  end

end
