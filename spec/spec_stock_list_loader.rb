# coding: utf-8
require 'spec_helper'
require_relative '../lib/stock_list_loader.rb'

RSpec.describe "StockListLoader" do
  before do
    @sll = StockListLoader.new("data/tosho_list.txt")
    @sll.stock_info
  end
    
  it "provide array object when initialize" do
    expect(@sll.stock_info[0].class).to eq(Hash)
  end

  it "has stock code" do
    expect(@sll.codes[0].to_s).to match(/\d{4}/)
  end

  it "has market section" do
    expect(@sll.market_sections[0]).to match("東証1部")
  end

  it "can return specify market sections" do
    expect(@sll.market_sections.include?("東証1部")).to be_truthy
  end

  it "can filter market sections" do
    @sll.filter_by_market_section("東証2部")
    expect(@sll.market_sections.include?("東証1部")).to be_falsy
  end

end
