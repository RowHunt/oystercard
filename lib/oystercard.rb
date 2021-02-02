class Oystercard
  attr_reader :balance
  attr_reader :in_journey
  LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(cash)
    if @balance + cash > LIMIT then fail "Invalid. The limit is #{LIMIT}" else @balance += cash end
  end

  def touch_in
    if @balance < 1 then fail "Insufficient funds." else @in_journey = true end
  end

  def touch_out
    @in_journey = false
    deduct
  end

  private 
  def deduct(cash = 1)
    @balance -= cash
  end
end