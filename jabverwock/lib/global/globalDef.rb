
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
      
      def testPATH(folder)
        current = ENV['PWD']
        current.include?("BitTorrent") ? vPath1 = "/BitTorrent Sync" :  vPath1 = ""
        "/Users/shimizukazuyuki#{vPath1}/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/#{folder}/"
      end
      
      def isBool(v)
        !!v === v
      end
      
      def stringConvertSymbole(s)
        if s.is_a? String
          s = s.to_sym
        end
        s
      end
      
      # attr(:id, "test") -> attr(:id__test) -> treat attr
      def combineSym(sym, str)
        ans = sym.to_s << "__" << str
        ans.to_sym
      end

      def isDoubleUnderBarSymbol(sym)
        return nil unless sym.is_a? Symbol
        sym.hasDoubleUnderBar?
      end

      def isDoubleArray (data)
        data[0].is_a?(Array)
      end

      def isBase (i,s)
        s.to_s.include?(i) ? true : false            
      end

      def isID(s)
        isBase "id", s
      end

      def isCls(s)
        isBase "cls", s
      end

      def isName(s)
        isBase "name", s      
      end

      
      def multiTags
          %w(BLOCKQUOTE BODY DIV FOOTER FORM HTML HEAD PRE SCRIPT STYLE SELECT OL UL LI_multi)
      end

      def tableTags
        %w(TR TABLE)
      end
      
      def singleTags
        %w(P A B HR BR I EM STRONG DT DD LIST_ITEM TITLE OPTION LI TD)
      end

      def oneTags
        %w(DOCTYPE META IMG LINK INPUT)
      end
      
      def intoStyleTag (str)
        "<style>\n" << "#{str}\n" << "</style>\n"
        
        # tabbedEachLine = addTabEachLine str
        # styTag   = "<style>\n" << "#{tabbedEachLine}\n" << "\t</style>\n"
        # addTabEachLine styTag
      end
      
      def isOpenTag(tag)
        tag.match(/^(\t)*<(\w+)/) do |d|
          return true
        end
        false
      end
      
      def isCloseTag(tag)
        tag.match(/<\/(\w+)/) do
          return true
        end
        false
      end
      
      def isOpenPara(tag)
        tag.include? "{"
      end

      def isClosePara(tag)
        tag.include? "}"
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
        arr.index { |i| i =~ /<\/body>/ }
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
        return unless isStringInArray arr
        
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

      def addTabEachArray(arr, number)
        return "" if arr.empty?    
        arr.map{ |a|
          "\t" * number << a
        }.join.sub!("\t" * number, "")
      end

      def isIntegerIndex(range)
        return false unless range.first.is_a? Integer
        return false unless range.last.is_a? Integer
        true
      end

      def sliceRange(range)      
        (range.first + 1)..(range.last + 1)
      end
      
    end 
  end
end 

