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
                            :border_top, :border_bottom, :border_left, :border_right,
                            :border_width,
                            :border_top_width,:border_bottom_width, :border_left_width,:border_right_width,
                            :border_style,
                            :border_top_style, :border_bottom_style, :border_left_style, :border_right_style,
                            :border_color,
                            :border_top_color, :border_bottom_color, :border_left_color, :border_right_color
                           ]

    self.define_attributes [:margin,
                            :margin_top, :margin_bottom, :margin_left, :margin_right
                           ]
    
    self.define_attributes [:padding,
                            :padding_top, :padding_bottom, :padding_left, :padding_right                            
                           ]
    
    
    self.define_attributes [:width, :height, :position]
    
    attr_reader :use_id, :use_cls, :use_namae
    
    def initialize(name)
      super

      @use_id = false
      @use_cls = false
      @use_namae = false
      
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
        @name << $SPC << $ID_ELEM_ID << id
      end
    end
    
    def updateCssNameWithCls(cls)
      unless cls.empty?
        @name << $SPC << $ID_ELEM_CLS << cls
      end  
    end

    def useFlagsInit
      @use_id, @use_cls, @use_namae = false, false, false      
    end
    
    def use(*flags)
      return if flags.empty?
      @use_id = true if CssUtil.hasSymbolArrTargetSymbol :id, flags
      @use_cls = true if CssUtil.hasSymbolArrTargetSymbol :cls, flags
      @use_namae = true if CssUtil.hasSymbolArrTargetSymbol :name, flags
      self
    end
    
    def useSelectorTreat(*selector)
      # @name => p id:#test cls:.sample
      # @treatName => p #test .sample
      # use(:id) -> #test
      # use(:cls) -> .sample
      # use(:name) -> p
      # use(:id, :name) -> p #test

      
      flattenedSelector = selector.flatten
      return useSelectorTreat :name, :id, :cls  if flattenedSelector.empty?
      
      arr = CssUtil.dividBySpace @name

      # when addChildren use $CHILD_SELECTOR, replace $SPC
      ans = CssUtil.useCore flattenedSelector, replaceCHILD_SELECTOR(arr)  
      ans.join(" ")
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
      addBaseic $CHILD_SELECTOR, *sel
      self
    end

    def addBaseic (divi, *sel)
      name = CssUtil.nameWithDividStr sel, divi
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
        
    def str      
      nameErrorCheck
      @cssResultString = ""
      # 接頭句
      @cssResultString += makeNameByFlags + $SPC + "{" + $RET + removeNameFlags
      # 接尾句
      @cssResultString += $RET + "}"
      
    end

    def makeNameByFlags
      arr = []
      arr << :id if @use_id
      arr << :cls if @use_cls
      arr << :name if @use_namae
      useSelectorTreat arr
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

    private
    
    def replaceCHILD_SELECTOR(arr)
      arr.inject([]) do |array, a|
        array << a.gsub(/#{$CHILD_SELECTOR}/, " ")
      end
    end
    
  end
  
  # a = CSS.new("s")
  # p a.font_size(10)
  # # p a.name
  # p a.str
  # p a.pStr
  # p a.noNameStr
end
