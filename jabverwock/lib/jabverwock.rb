require "jabverwock/version"
require "global/globalDef"
require "global/jw"
require "global/jwCSS"
require "global/jwMulti"
require "global/jwSingle"
require "global/jwOneTag"
require "global/jwTable"


module Jabverwock

    class Koko
    attr_accessor :name
    def initialize
      @name = self.class.name.downcase
    end
  end

  
  listA = ["Car", "Train"]

  # class generate
  listA.each do |vahi|
    Object.const_set vahi, Class.new(Koko){
      def initialize
        super
      end

    }
  end     
  
end


__END__

# module Kaz
#   class Koko
#     attr_accessor :name
#     def initialize
#       @name = self.class.name.downcase
#     end
#   end

  
#   listA = ["Car", "Train"]

#   # class generate
#   listA.each do |vahi|
#     Object.const_set vahi, Class.new(Koko){
#       def initialize
#         super
#       end

#     }
#   end    
# end

# module Test2
#   include Kaz
# p Car.new.name
# end


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



  # class << self
 
  #   def callMe
  #     p "Hello, my name is Jabverwock! #{$RET}"
  #     p "version is #{VERSION}"
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
