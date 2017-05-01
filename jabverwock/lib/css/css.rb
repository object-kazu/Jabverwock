if $FOR_GEM
  require "global/globalDef"
  require "css/propertyTemplete"
    
else

  require "../../lib/global/globalDef"
  require_relative "propertyTemplete"
  
end

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # this class manage CSS
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

    def updateCssName(id,cls)
      updateCssNameWithID id
      updateCssNameWithCls cls
    end
    
    def updateCssNameWithID(id)
      unless id.empty?
        @name << $SPC << id
      end
    end
    def updateCssNameWithCls(cls)
      unless cls.empty?
        @name << $SPC << cls
      end
      
    end
    
    
    def dpName
      # cation, dup is deep copy of name only
      self.dup
    end
    
    def addMembers(*sel)
      addBaseic ",", *sel
      self
    end

    def addChildren(*sel)
      addBaseic " ", *sel
      self
    end

    def addBaseic (divi, *sel)
      name = nameWithDividStr sel, divi
      addName name, divi
      self
    end
    

    def addName(name, divi)
      if @name == ""
        @name << name
      else
        @name << divi << name
      end
      
    end
    
    def nameWithDividStr(sel, divi)
      sel.inject("") do |name, s|
        next name << s if name == ""
        name << divi << s        
      end
    end
    
    def str      
      nameErrorCheck
      
      @cssResultString = ""
      # 接頭句
      @cssResultString += @name + $SPC + "{" + $RET + noNameStr                                
      # 接尾句
      @cssResultString += $RET + "}"
    end

    def nameErrorCheck
      if @name.empty?
        p "css name is empry. set cssName"
        raise RuntimeError
      end
    end
    
    # remove name form  pStr
    def noNameStr
      self.pStr.gsub!(/name:.+?;\n/, "") || ""
    end
    
  end

  # a = CSS.new("s")
  # p a.font_size(10)
  # # p a.name
  # p a.str
  # p a.pStr
  # p a.noNameStr
end
