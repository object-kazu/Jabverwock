require '../../lib/global/globalDef'  
require_relative "property"

module Jabverwock
  using StringExtension
  class CSS < CssAttrTemplateImproved
        
    self.define_attributes [:cssResultString]
    
    self.define_attributes [:font, :font_style, :font_variant,:font_weight, :font_size, :font_family,
                            :font_size_adjust, :font_stretch]

    self.define_attributes [:color, :background, :background_attachment, :background_color,
                            :background_image, :background_position, :background_position_x,
                            :background_position_y,:background_repeat]

    def initialize(name)
      super
    end
    
    # def self.newWithJWObject(jwObject)
    #   if !jwObject.is_a?(JWObject)
    #     p "arg should be JWObject"
    #     raise RuntimeError
    #   end
      
    #   objc = self.new
    #   objc.name = jwObject.tagName
    #   # 今のところ実装していないのでコメントアウトしておく
    #   #      objc.property = jwObject.style.property

    #   objc
    # end

    # def addProperty (p)
    #   if p.is_a?(Property)
    #     @property = p
    #   end
    #   self
    # end
    
    def str
      @cssResultString = ""
      if @name.empty?
        p "css name is empry. set cssName"
        raise RuntimeError
      end
      
      #接頭句
      @cssResultString += @name + $SPC + "{" + $RET + noNameStr
                                
      # #  接尾句
      @cssResultString += $RET + "}"
      return @cssResultString
      
    end

    # remove name form  pStr
    def noNameStr
      ans = self.pStr.gsub!(/name:.+?;\n/, "")
      if ans.nil?
        return ""
      end
      ans
    end
    
  end

  # a = CSS.new("s")
  # p a.font_size(10)
  # # p a.name
  # p a.str
  # p a.pStr
  # p a.noNameStr
end


  # class CSS_old
  #   attr_reader :cssResultString
  #   attr_accessor :property, :name
    
  #   def initialize(name)

  #     @name = name  # css name
  #     @property = Property.new
  #     @cssResultString = ""

  #   end

  #   def self.newWithJWObject(jwObject)
  #     if !jwObject.is_a?(JWObject)
  #       p "arg should be JWObject"
  #       raise RuntimeError
  #     end
      
  #     objc = self.new
  #     objc.name = jwObject.tagName
  #     # 今のところ実装していないのでコメントアウトしておく
  #     #      objc.property = jwObject.style.property

  #     objc
  #   end

  #   def addProperty (p)
  #     if p.is_a?(Property)
  #       @property = p
  #     end
  #     self
  #   end
    
  #   def str
  #     @cssResultString = ""
  #     if @name.empty?
  #       p "css name is empry. set cssName"
  #       raise RuntimeError
  #     end

  #     #接頭句
  #     @cssResultString += @name + $SPC + "{" + $RET +
  #                         @property.str
      
  #     #  接尾句
  #     @cssResultString += $RET + "}"
  #     return @cssResultString
      
  #   end

  # end
