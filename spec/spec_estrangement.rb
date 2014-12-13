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
    @es = Estrangement.new(@stock,
                           span: 10).calculate
    @real_es = [nil, nil, nil, nil, nil, nil, nil, nil, nil, -0.21344717182497333, 0.4687832942680564, 0.3091354866218929, -0.41493775933609717, 0.7743714861567788, 1.185436071126169, 0.45468964787987254, -0.8351834231948385, 0.45468964787987254]
  end
    
  it "can calculate estranged" do
    @es.each_with_index do |value, i|
      next unless value
      expect(@real_es[i].round(2)).to eq(value.round(2))
    end
  end

end
