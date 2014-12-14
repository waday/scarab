require "./lib/trade"
require "./lib/tick"

class Rule
  attr_accessor :stock

  def calculate_indicators; end

  private
  def with_valid_indicators
    catch(:no_value) {yield}
  end
end

