class Oystercard
  attr_reader :balance, :entry_station, :journey_history

  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @journey_history = []
  end

  def in_journey?
    @in_journey
  end

  def top_up(amount)
    raise "Card limit of #{LIMIT} exceeded" if @balance + amount > LIMIT
    @balance += amount
  end


  def touch_in(station)
    raise "Insufficient balance" if @balance < MIN_FARE
    @in_journey = true
    journey = Journey.new(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journey_history.push({
      from: @entry_station,
      to: station
      })
    @in_journey = false
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
