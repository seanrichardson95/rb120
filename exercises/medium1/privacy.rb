class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end
  
  def state_of_switch
    switch
  end
  
  private
  
  attr_writer :switch
  attr_reader :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

mach = Machine.new
mach.start
puts mach.state_of_switch
# Modify this class so both flip_switch and the setter method switch= are private methods.