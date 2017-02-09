require '../../lib/global/globalDef'  
require_relative "property"

module Jabverwock
  using StringExtension
  class CSS
    attr_reader :cssResultString
    attr_writer :property, :name
    
    def initialize(name)
      @name = name  # css name
      @property = Property.new
      @cssResultString = ""

    end

    def self.newWithJWObject(jwObject)
      if !jwObject.is_a?(JWObject)
        p "arg should be JWObject"
        raise RuntimeError
      end
      
      objc = self.new
      objc.name = jwObject.tagName
      # 今のところ実装していないのでコメントアウトしておく
      #      objc.property = jwObject.style.property

      objc
    end

    def addProperty (p)
      if p.is_a?(Property)
        @property = p
      end
      self
    end
    
    def str
      @cssResultString = ""
      if @name.empty?
        p "css name is empry. set cssName"
        raise RuntimeError
      end

      #接頭句
      @cssResultString += @name + $SPC + "{" + $RET +
                          @property.str
      
      #  接尾句
      @cssResultString += $RET + "}"
      return @cssResultString
      
    end

  end

end
