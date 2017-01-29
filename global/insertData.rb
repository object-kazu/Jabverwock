module Jabverwock
  class InsertData
    attr_accessor :label, :data
    
    def initialize(label: , data:)
      @label = label
      @data = data
    end
    
  end
end

# a = Jabverwock::InsertData.new(label:"ss", data:"dd")
# p a.data
# p a.label

# if a.is_a?(Jabverwock::InsertData)
#   p "yes"
# end


