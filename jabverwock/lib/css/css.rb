if $FOR_GEM
  require "global/globalDef"
  require "css/propertyTemplete"
    
else

  require "../../lib/global/globalDef"
  require_relative "propertyTemplete"
  
end




module Jabverwock
  using StringExtension
  class CSS < CssAttrTemplate
        
    self.define_attributes [:cssResultString]
    
    self.define_attributes [:font, :font_style, :font_variant,:font_weight, :font_size, :font_family,
                            :font_size_adjust, :font_stretch]

    self.define_attributes [:color, :background, :background_attachment, :background_color,
                            :background_image, :background_position, :background_position_x,
                            :background_position_y,:background_repeat]

    def initialize(name)
      super
    end

    def initialize_copy(obj)
      @name = obj.name.dup
    end

    def dpName
      # cation, dup is deep copy of name only
      self.dup
    end
    
    def addMembers(*sel)
    #def andSelectorIs(*sel)
      addBaseic false, *sel
      self
    end

    def addChildren(*sel)
      addBaseic true, *sel
      self
    end

    def addBaseic(isChild, *sel)
      divi = ","
      if isChild
        divi = " "
      end
      name = ""
      sel.each do |s|
        next name << s if name == ""
        name << divi << s
      end

      if @name == ""
        @name << name
      else
        @name << divi << name
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
