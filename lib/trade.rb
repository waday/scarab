# coding; utf-8

class Trade
  attr_accessor :stock_code, :trade_type, :entry_date,
                :entry_price, :entry_time, :volume, :exit_date,
                :exit_price, :exit_time, :length, :first_stop,
                :stop

  def initialize(params)
    @stock_code = params[:stock_code]
    @trade_type = params[:trade_type]
    @entry_date = params[:entry_date]
    @entry_price = params[:entry_price]
    @volume = params[:volume]
    @enty_time = params[:entry_time]
    @length = 1
  end

  def exit(params)
    @exit_date = params[:exit_date] || params[:date]
    @exit_price = params[:exit_price] || params[:price]
    @exit_time = params[:exit_time] || params[:time]
  end

  def closed?
    if @exit_date && @exit_price
      true
    else
      false
    end
  end

  def long?
    @trade_type == :long
  end

  def short?
    @trade_type == :short
  end

  def profit
    plain_result * @volume
  end

  def percentage_result
    (plain_result.to_f / @entry_price) * 100
  end

  def r
    return unless @first_stop
    if long?
      @entry_price - @first_stop
    elsif short?
      @first_stop - @entry_price
    end
  end

  def r_multiple
    return unless @first_stop
    return if r == 0
    plain_result.to_f / r.to_f
  end

  private
  # Profit and loss not to multiply by the number of the stocks
  def plain_result
    if long?
      @exit_price - @entry_price
    elsif short?
      @entry_price - @exit_price
    end
  end
end
