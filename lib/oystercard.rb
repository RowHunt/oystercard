class Oystercard
  attr_reader :balance
  attr_reader :in_journey
  attr_reader :entry_station

  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
  end

  def top_up(cash)
    if @balance + cash > LIMIT then fail "Invalid. The limit is #{LIMIT}" else @balance += cash end
  end

  def touch_in(station)
    fail "Insufficient funds." if @balance < MIN_FARE
    @in_journey = true 
    @entry_station = station
  end

  def touch_out
    @in_journey = false
    @entry_station = nil
    deduct
  end

  private
  def deduct(cash = MIN_FARE)
    @balance -= cash
  end
end