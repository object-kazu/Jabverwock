require "jabverwock/version"
require "global/globalDef"

module Jabverwock
  class << self
 
    def callMe
      p "Hello, my name is Jabverwock! #{$RET}"
      p "version is #{VERSION}"
    end
    
  end   
end


__END__
# module Kaz
#   def callMe
#     "this is kaz"
#   end

#   listA = ["Car", "Train"]
#   listB = ["Moon", "Earth"]
#   listAll =  listA + listB
  
#   # method generate
#   listAll.each do |c|
#     define_method "#{c}" do
#       eval "#{c}.new"
#     end    
#   end
  
#   # class generate
#   listA.each do |vahi|
#     Object.const_set vahi, Class.new(){
#       attr_accessor :name
#       def initialize
#         @name = self.class.name.downcase
#       end

#     }
#   end

#   listB.each do |planet|
#     Object.const_set planet, Class.new(){
#       attr_accessor :size
#       def initialize
#         @size = self.class.name.downcase + ":size"
#       end
#     }
#   end

#   # basic pattern
#   def liffe
#     Life.new
#   end
  
#   class Life
#     def What
#       "life is beautiful"
#     end
#   end
  
# end


# class Live
#   include Kaz
# end


# a = Live.new
# p a.liffe.What

# p a.Car.name
# p a.Train
# p a.Earth.size

