# coding: utf-8
require 'spec_helper'
require_relative '../lib/text_to_stock.rb'

RSpec.describe "TextToStock" do
  before do
    @tts = TextToStock.new(data_dir: "data",
                           stock_list: "tosho_list.txt",
                           market_section: "東証1部")
  end
    
  it "create stock object" do
    stock = @tts.generate_stock(1301)
    expect(stock.code).to eq(1301)
    expect(stock.dates.first).to match(%r!\d{4}/\d{2}/\d{2}!)
    expect(stock.open_prices.first.to_s).to match(/\d*/)
  end

  it "create stock objects" do
    @tts.each_stock do |stock|
      expect(stock.class).to match(Stock)
      expect(stock.code.to_s).to match(/\d{4}/)
    end
  end

  it "can specify a duration" do
    @tts.from = "2014/11/17"
    @tts.to   = "2014/11/21"

    @tts.each_stock do |stock|
      #puts [stock.code, stock.dates.first,
      #      stock.dates.last].join(" ")
      expect(stock.dates.first).to match (%r!2014/11/\d{2}!) unless stock.dates.first.nil?
      expect(stock.dates.last).to  match (%r!2014/11/\d{2}!) unless stock.dates.last.nil?
    end
  end
end
