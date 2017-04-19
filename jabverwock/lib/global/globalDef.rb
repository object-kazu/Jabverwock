
# ## String extension ############
module StringExtension
  
  refine String do
    def dot(str)
      self + "." + str
    end

    def removeLastRET
      self.chomp
    end
    
    def inDoubleQuot(insert)
      if insert.is_a?(String)
        self + insert.modifyDoubleQuo
      end
    end

    def inSingleQuo(insert)
      if insert.is_a?(String)
        self +  $SINGLE_QUO + insert + $SINGLE_QUO  
      end
    end

    def inParenth(insert)
      if insert.is_a?(String)
        self + "(" + $SINGLE_QUO + insert + $SINGLE_QUO + ")"     
      end
      
    end

    def modifyDoubleQuo
      $DOUBLE_QUO + self + $DOUBLE_QUO
    end
    
    def variable
      $LABEL_INSERT_START + self + $LABEL_INSERT_END
    end  


    <<-VAL_Usage
        a = "a".dataIs "dddd"# => {:label=>"a", :data=>"dddd"}
        p a
        p a[:label]
        p a[:data]
    
        # >> {:label=>"a", :data=>"dddd"}
        # >> "a"
        # >> "dddd"
    VAL_Usage
    def varIs(val)
      {:label => self, :data => val}
    end

    def rowSpan(val)
      self + $ROW_SPAN + "#{val}"
    end

    def colSpan(val)
      self + $COL_SPAN + "#{val}"
    end
    
  end
end

# ## Symbol extension ############

module SymbolExtension
  refine Symbol do
    def variable
      $LABEL_INSERT_START + self.to_s + $LABEL_INSERT_END
    end  
    
    def varIs(val)
      {:label => self.to_s, :data => val}
    end

    def divid
      sim = self.to_s
      elem = sim.split "__"
      elem
    end

    def hasDoubleUnderBar?
      ans = self.to_s
      return true if ans.include? "__"
      false
    end
  end
end

# ## Array extension ############
module ArrayExtension
  
  refine Array do
    
    def append(element)      
      self << element
      self.flatten!
    end

    def appends (*element)
      element.each do |a| 
        self.append a
      end
    end

    # def appendArray(arr)
    #   self.concat arr
    # end

    # a = [1,2,3,4]
    # b = [4,5,6]
    # p a.append 4 # => [1, 2, 3, 4]
   
    

    # c = []
    # p a.append c
    #p a.append b # => [1, 2, 3, 4, [4, 5, 6]]

    #p a.appendArray b # => [1, 2, 3, 4, 4, 5, 6]
    
  end
end



module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # global constant ############

  $RET             = "\n"
  $TAB             = "\t"
  $SPC             = " "
  $COMMA           = ","
  $COLON           = ":"
  $SEMI_COLON      = ";"
  $JS_CMD_END      = $SEMI_COLON
  $DOUBLE_QUO      = "\""
  $SINGLE_QUO      = "'"
  $EQUAL           = "="

  $INSERTSTRING        = "%%"
  $STYLE_CONTENT       = "##STYLE##"
  $LABEL_INSERT_START  = "##LABELSTART##"
  $LABEL_INSERT_END    = "##LABELEND##"

  
  ## struct ##########
  $CHILD = "_c_"
  $MEMBER = "_m_"
  $ENDMARK = "_e_"

  
  ## Table ####################
  $BR      = "<br>"
  $ROW_SPAN = "%rowSpan="
  $COL_SPAN = "%colSpan="
  
  
  # This module is utility, not depend on class instance
  module KSUtil
    class << self
      
      def pressPath
        _dir_ = $EXPORT_TESTPRESS_Dir_iMAC
        current = ENV['PWD']
        if current.include?("BitTorrent")
          _dir_ = $EXPORT_TESTPRESS_Dir_MACBOOK 
        end
        _dir_
      end

      def isBool(v)
        !!v === v
      end

      def isDoubleUnderBarSymbol(sym)
        return nil unless sym.is_a? Symbol
        sym.hasDoubleUnderBar?
      end


      
    end
  end
  
  
  # this class is HTML arrange, especialy treat with RET and TAB.
  module KString
    # 型チェック
    class << self

      def renameCls (str)
        if str == "cls"
          return "class"
        end
        str
      end

      def renameUnderBar (str)
        if str.include?("_")
          return str.gsub(/_/, "-")
        end
        str
      end
      
      def reader(str) # sentence -> arr
        str.lines
      end
      
      def insertText(arr,txt)
        index = insertIndex arr
        tArr = removeAllRET arr
        tArr.insert index, txt
        insertTextLoop tArr
      end

      def insertTextLoop (arr)
        ans = arr.inject("")do |a,t|
          a << t << $RET
        end
      end
      
      def insertIndex (arr)
        arr.index { |i| i =~ /<\/head>/ }
      end
      
      def check_type(type, instance)
        # pass check -> true
        # fail check -> ArgumentError
        
        unless instance.kind_of?(type)
          raise ArgumentError::new("type mismatch: #{instance.class} for #{type}")
        end
        true
      end

      def isString? (instance)
        check_type(String, instance)
      end

      def isInt?(instance)
        check_type(Integer,instance)
      end

      def removeLastRET(text)
        isString? text
        text.chomp
      end

      def removeAllRET(arr)
        arr.map { |s| s.chomp }
      end
      
      def remove_Js_Cmd_End(text)
        isString? text
        text.gsub(/;$/, "")
      end
      

      def addSpace(str)
        isString? str
        unless str.empty?
          str = $SPC + str
        end
        str
      end

      def isStringInArray(arr)
        arr.each do |a|
          isString? a
        end
      end
      
      def stringArrayConectRET (arr)
        return if arr.empty? 
        isStringInArray arr
        
        arr.inject("") do |ans, d|
          ans << d << $RET
        end
      end

      def reprace(str:, of:, with:)
        isString? str
        isString? of
        isString? with

        str.gsub(of,with)
      end

      def intoStyleTag (str)
        "<style>\n" << "#{str}\n" << "</style>\n"
        
        # tabbedEachLine = addTabEachLine str
        # styTag   = "<style>\n" << "#{tabbedEachLine}\n" << "\t</style>\n"
        # addTabEachLine styTag
      end
      
      def makeElementArray (element, elementArray)
        tempArray = []
        
        if element != nil
          tempArray << element
        end
        
        if elementArray.count > 0
          tempArray += elementArray
        end      
        return tempArray
      end

      def isExistCssString(str)
        return false if str.empty?

        if !str.include?("{") || !str.include?("}")
          return false
        end
        
        removeFront = str.gsub(/.*{/, "").gsub(/}/, "").gsub(/\n/, "")        
        
        return false if removeFront == ""
        true
      end
      
    end 
  end
end 

