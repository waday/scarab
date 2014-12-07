require 'spec_helper'
require_relative '../lib/array.rb'

RSpec.describe "Array" do
  before do
    @array = [100, 97, 111, 115, 116, 123, 121, 119, 115,110]
    @changes = @array.map_indicator(2) do |vals|
      vals.last - vals.first
    end
  end

  it "total of the element" do
    expect(@array.sum).to eq(1127)
  end

  it "average of the element" do
    expect(@array.average).to eq(112.7)
  end

  it "moving average of any span" do
    expect(@array.moving_average(4)).to eq([nil, nil, nil, 105.75, 109.75, 116.25, 118.75, 119.75, 119.5, 116.25])
  end

  it "highs of each span" do
    expect(@array.highs(3)).to eq([nil, nil, 111, 115, 116, 123, 123, 123, 121, 119])
  end

  it "lows of each span" do
    expect(@array.lows(3)).to eq([nil, nil, 97, 97, 111, 115, 116, 119, 115, 110])
  end

  it "calc middle of a high price and the low price" do
    @middle = @array.map_indicator(3) do |vals|
      (vals.max + vals.min) / 2.0
    end
    expect(@middle).to eq([nil, nil, 104.0, 106.0, 113.5, 119.0, 119.5, 121.0, 118.0, 114.5])
  end

  it "calc For a difference with the day before" do
    expect(@changes).to eq([nil, -3, 14, 4, 1, 7, -2, -2, -4, -5])
  end

  it "calc Average between three spans" do
    @average_changes = @changes.moving_average(3)
    expect(@average_changes).to eq([nil, nil, nil, 5.0, 6.333333333333333, 4.0, 2.0, 1.0, -2.6666666666666665, -3.6666666666666665])
  end

end
