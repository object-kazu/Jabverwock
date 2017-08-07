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
                            :background_position_y,:background_repeat, :background_origin, :background_size]
    
    self.define_attributes [:border,
                            :border_top, :border_bottom, :border_left, :border_right]
    
    self.define_attributes [
                            :border_width,
                            :border_top_width, :border_bottom_width, :border_left_width,:border_right_width]
    
    self.define_attributes [
                            :border_style,
                            :border_top_style, :border_bottom_style, :border_left_style, :border_right_style]
    
    self.define_attributes [
                            :border_color,
                            :border_top_color, :border_bottom_color, :border_left_color, :border_right_color]

    self.define_attributes [:margin,
                            :margin_top, :margin_bottom, :margin_left, :margin_right]
    
    self.define_attributes [:padding,
                            :padding_top, :padding_bottom, :padding_left, :padding_right]

    self.define_attributes [:text_decoration
                           ]
  
    self.define_attributes [:list_style_type,
                           ]
    
    self.define_attributes [:display
                           ]

    
    self.define_attributes [:width, :height, :position]
    
    
    def initialize(name)
      super
      nameTreatment name
    end

    def initialize_copy(obj)
      @name = obj.name.dup
    end
    
    # name treatment
    def nameTreatment(name)
      @name = ""
      if name.is_a? String
        @name = name
        return
      end

      if name.is_a? Symbol
        symbolName name        
        return
      end

      @name = name.to_s
      
    end

    def symbolName(name)
      if KSUtil.isDoubleUnderBarSymbol name
        names = name.divid
        
        if KSUtil.isID names[0]
          idSymbol names[1]
          return
        end
        
        if KSUtil.isCls names[0]
          classSymbol names[1]
          return
        end
        
        # remove "_ _"        
        @name = removeDoubleUnderBar name
        return
      end
      @name = name.to_s
    end

    # goto private
    def idSymbol(sym)
      @name ||= ""
      @name << "#" << sym
    end

    def classSymbol(sym)
      @name ||= ""
      @name << "." << sym
    end

    def removeDoubleUnderBar(sym)
      sym.to_s.gsub(/__/,"")
    end
    
    # # name copy
    def dpName
      # cation, dup is deep copy of name only
      self.dup.name
    end
    
    def addChildrenName(*sel)
      ## head p { ... }
      n = dpName
      sel.each do |s| 
        n << $SPC << s
      end
      n
    end
    
    def addMembersName(*sel)
      ## head, p { ... }
      n = dpName
      sel.each do |s|
        n << ", " << s
      end
      n
    end
        
    def str      
      nameErrorCheck
      nameTreatment @name
      @cssResultString = ""
      # 接頭句
      @cssResultString += @name + $SPC + "{" + $RET + removeNameFlags
      # 接尾句
      @cssResultString += $RET + "}"
      
    end

    
    def nameErrorCheck
      if @name.empty?
        p "css name is empry. set cssName"
        raise RuntimeError
      end
    end

    def removeNameFlags  # rename noNameStr
      ans = pStr

      ans.gsub!(/\nuse-(id|cls|namae).*;/, "") || ""      
      ans.gsub!(/name:.*;\n/, "") || ""
    end    
  end

    
    
  # a = CSS.new("s")
  # p a.font_size(10)
  # # p a.name
  # p a.str
  # p a.pStr
  # p a.noNameStr
end
