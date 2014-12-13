# coding: utf-8
require 'spec_helper'
require_relative '../lib/tick.rb'

RSpec.describe "Tick" do
    
  it "has Price movement in consideration of the stock prices" do
    expect(Tick.size(100)).to eq(1)
    expect(Tick.size(2999)).to eq(1)
    expect(Tick.size(3000)).to eq(1)
    expect(Tick.size(3001)).to eq(5)
    expect(Tick.size(4000)).to eq(5)
    expect(Tick.size(5100)).to eq(10)
    expect(Tick.size(30000)).to eq(10)
    expect(Tick.size(30050)).to eq(50)
  end

  it "has truncate function in consideration of the stock prices" do
    expect(Tick.truncate(99.99)).to eq(99)
    expect(Tick.truncate(3004)).to eq(3000)
    expect(Tick.truncate(3006)).to eq(3005)
  end

  it "has ceil function in consideration of the stock prices" do
    expect(Tick.truncate(99.99)).to eq(99)
    expect(Tick.truncate(3004)).to eq(3000)
    expect(Tick.truncate(3006)).to eq(3005)
  end

  it "has round function in consideration of the stock prices" do
    expect(Tick.round(99.99)).to eq(100)
    expect(Tick.round(99.49)).to eq(99)
    expect(Tick.round(3004)).to eq(3005)
    expect(Tick.round(3002)).to eq(3000)
  end

  it "has up function in consideration of the stock prices" do
    expect(Tick.up(100)).to eq(101)
    expect(Tick.up(100, 3)).to eq(103)
    expect(Tick.up(2999, 1)).to eq(3000)
    expect(Tick.up(2999, 2)).to eq(3005)
    expect(Tick.up(3000)).to eq(3005)
  end
    
  it "has down function in consideration of the stock prices" do
    expect(Tick.down(100)).to eq(99)
    expect(Tick.down(100, 3)).to eq(97)
    expect(Tick.down(3005, 1)).to eq(3000)
    expect(Tick.down(3005, 2)).to eq(2999)
    expect(Tick.down(3000)).to eq(2999)
    expect(Tick.down(3001)).to eq(2999)
  end
end
