class Notes < Root
  attr :note, true
  attr :start_time, true
  attr :duration, true
  attr :start_velocity, true
  attr :end_velocity, true
  attr :rpb, true
  def initialize
    super
    @note = 0
    @start_velocity = 101
    @end_velocity = 127
    @start_time = 0
    @duration = 0
    @rpb = 1
  end
end
