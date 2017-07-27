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
    
    
    self.define_attributes [:width, :height, :position]
    
    # attr_reader :use_id, :use_cls, :use_namae
    
    def initialize(name)
      super

      @name = name.to_s
      
      # @use_id = false
      # @use_cls = false
      # @use_namae = false
      
    end

    def initialize_copy(obj)
      @name = obj.name.dup
    end

    # def updateCssName(id,cls)
    #   updateCssNameWithID id
    #   updateCssNameWithCls cls
    # end

    # def updateCssNameWithID(id)
    #   unless id.empty?
    #     @name << $SPC << $ID_ELEM_ID << id
    #   end
    # end
    
    # def updateCssNameWithCls(cls)
    #   unless cls.empty?
    #     @name << $SPC << $ID_ELEM_CLS << cls
    #   end  
    # end

    # def useFlagsInit
    #   @use_id, @use_cls, @use_namae = false, false, false      
    # end
    
    # def use(*flags)
    #    # @name => p id:#test cls:.sample
    #   # @treatName => p #test .sample
    #   # use(:id) -> #test
    #   # use(:cls) -> .sample
    #   # use(:name) -> p
    #   # use(:id, :name) -> p #test
    
      
    #   return if flags.empty?
    #   @use_id = true if CssUtil.hasSymbolArrTargetSymbol :id, flags
    #   @use_cls = true if CssUtil.hasSymbolArrTargetSymbol :cls, flags
    #   @use_namae = true if CssUtil.hasSymbolArrTargetSymbol :name, flags
    #   self
    # end
    
     
    def dpName
      # cation, dup is deep copy of name only
      self.dup.name
    end
    
    def addChildrenName(*sel)
      ## head p { ... }
      sel.each do |s| 
        @name << $SPC << s
      end
      self
    end
    
    def addMembersName(*sel)
      ## head,p { ... }
      sel.each do |s|
        @name << ", " << s
      end
      self
    end
            
    
    def str      
      nameErrorCheck
      @cssResultString = ""
      # 接頭句
      @cssResultString += @name + $SPC + "{" + $RET + removeNameFlags
      # 接尾句
      @cssResultString += $RET + "}"
      
    end

    # def makeNameByFlags
    #   arr = []
    #   arr << :id if @use_id
    #   arr << :cls if @use_cls
    #   arr << :name if @use_namae
    #   useSelectorTreat arr
    # end
    
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

    private
    
    # def replaceCHILD_SELECTOR(arr)
    #   arr.inject([]) do |array, a|
    #     array << a.gsub(/#{$CHILD_SELECTOR}/, " ")
    #   end
    # end

    # def useSelectorTreat(*selector)
      
    #   flattenedSelector = selector.flatten
    #   return useSelectorTreat :name, :id, :cls  if flattenedSelector.empty?
      
    #   arr = CssUtil.dividBySpace @name

    #   # when addChildren use $CHILD_SELECTOR, replace $SPC
    #   ans = CssUtil.useCore flattenedSelector, replaceCHILD_SELECTOR(arr)  
    #   ans.join(" ")
    # end
    
    
  end
  
  # a = CSS.new("s")
  # p a.font_size(10)
  # # p a.name
  # p a.str
  # p a.pStr
  # p a.noNameStr
end
