require 'spec_helper'
require_relative '../lib/indicator/indicator'

RSpec.describe "Indicator" do
  before do
    class MyIndicator < Indicator
      def calculate_indicator
        [nil, nil, 3, 5, 8, 4]
      end
    end
    @my_indicator = MyIndicator.new(nil).calculate
  end

  it "implements each method" do
    @ind = @my_indicator.each do |ind|
      ind
    end
    expect(@ind).to eq([nil, nil, 3, 5, 8, 4])
  end

  it "can refer indicator" do
    expect(@my_indicator.first).to eq(nil)
    expect(@my_indicator[2]).to eq(3)
    expect(@my_indicator[3]).to eq(5)
  end

  it "throw nil if no value in indicator array" do
    @res
    catch(:no_value) do
      @res = @my_indicator[0]
    end
    expect(@res).to eq(nil)
  end

  it "can use range object" do
    expect(@my_indicator[0..2]).to eq([nil, nil, 3])
    expect(@my_indicator[2..4]).to eq([3, 5, 8])
  end

end
