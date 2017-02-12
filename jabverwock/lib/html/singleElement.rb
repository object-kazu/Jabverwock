class Vesicle

  attr_accessor :size
  
  def initialize
    @size = 1
  end
  
  def speed(max)
    "speed max is #{max * 2}"
  end
end


["Car", "Train"].each do |vahi|

  Object.const_set vahi, Class.new(Vesicle){

    
    attr_accessor :name
    def initialize
      super
      @size = 0
      @name = self.class.name.downcase
    end
    
  }
  
  
  
end

p a = Car.new # => #<Car:0x007f878b8742d0 @name="car">
p a.speed(2)# => "speed max is 4"
p b = Train.new# => #<Train:0x007f878b86f9b0 @name="train">
p b.name# => "train"
p b.size# => nil
# => nil

# >> #<Car:0x007f878b8742d0 @name="car">
# >> "speed max is 4"
# >> #<Train:0x007f878b86f9b0 @name="train">
# >> "train"
# >> nil
