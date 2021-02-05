class Oystercard
  attr_reader :balance, :entry_station, :history, :exit_station

  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @history = []
    @exit_station = nil
  end

  def top_up(cash)
    @balance + cash > LIMIT ? (raise "Invalid. The limit is #{LIMIT}") : (@balance += cash)
  end

  def touch_in(entry_station)
    raise 'Insufficient funds.' if @balance < MIN_FARE

    @entry_station = entry_station
    journey_tracker(entry_station)
    # keep_entry(station)
  end

  def touch_out(exit_station)
    @entry_station = nil
    @exit_station = exit_station
    journey_tracker(nil, exit_station)
    # keep_exit(station)
    deduct
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct
    @balance -= MIN_FARE
  end

  def journey_tracker(exit_station = nil)
    @history << { entry: nil, exit: exit_station }
  end

  # Isn't keeping track of all stations, just the most recent
  # def keep_entry(station)
  #   @history[:entry] = station
  # end

  # def keep_exit(station)
  #   @history[:exit] = station
  # end
end
