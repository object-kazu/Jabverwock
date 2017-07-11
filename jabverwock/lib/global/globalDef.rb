
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

    
    # "xxx".plus "aaa"
    # => "xxx" + "aaa"
    def plus(item)
      self + " + " + item
    end

    
    # "xxx".dQuo
    # => "xxx"
    def modifyDoubleQuo
      $DOUBLE_QUO + self + $DOUBLE_QUO
    end
    
    # "xxx".sQuo
    # => 'xxx'
    def modifySingleQuo
      $SINGLE_QUO + self + $SINGLE_QUO
    end
    
    alias_method :dQuo, :modifyDoubleQuo
    alias_method :sQuo, :modifySingleQuo
    
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

  $JS_UNITS_PREFIX = "js"
  
  ## struct ##########
  $CHILD = "_c_"
  $MEMBER = "_m_"
  $ENDMARK = "_e_"

  
  ## Table ####################
  $BR      = "<br>"
  $ROW_SPAN = "%rowSpan="
  $COL_SPAN = "%colSpan="

  ## Css ####################  
  $ID_ELEM_ID = "id::"
  $ID_ELEM_CLS = "cls::"

  
  module STYLE
    class << self
      styles = %w(none hidden dotted dashed solid double groove ridge inset outset)
      styles.each do |s| 
        define_method s.upcase do 
          "#{s}"
        end
      end
      
    end
    # 値	説明
    # none	線を表示せず、線幅は0になります。他のセルの線と重なる場合は、他のセル線が優先されます。
    # hidden	線を表示せず、線幅は0になります。他のセルの線と重なる場合は、hidden が優先されます。
    # dotted	点線で表示します。
    # dashed	破線で表示します。
    # solid	実線で表示します。
    # double	二重線で表示します。
    # groove	線が窪んで見えるような線で表示します。
    # ridge	線が突起して見えるような線で表示します。
    # inset	領域全体が窪んで見えるような線で表示します。
    # outset	領域全体が突起して見えるような線で表示します。
  end
  
  module ORIGIN
    class << self
      origin = %w(border padding content)
      origin.each do |o|
        define_method o.upcase do
          "#{o}-box"
        end
      end
    end
  end
  
  module ATTATCHMENT
    class << self
      atta = %w(scroll fixed local)
      atta.each do |a| 
        define_method a.upcase do
          "#{a}"
        end
      end
    end
  end
  
  module REPEAT
    class << self

      def repeatTemp(r)
        @result ||= ""
        @result << r + $SPC
        self        
      end
      
      def Yes()
        repeatTemp "repeat"
      end

      def No()
        repeatTemp "no-repeat"
      end

      def X()
        repeatTemp "repeat-x"
      end
      
      def Y()
        repeatTemp "repeat-y"
      end

      def SPC()
        repeatTemp "space"
      end

      def ROUND()
        repeatTemp "round"
      end
      
      def val()
        @result ||= ""
        ans = @result.rstrip
        @result = ""
        ans
      end
    end
  end
  
  module URL
    class << self
      def url(str)
        "url(#{str})"
      end
    end
  end
  
  module Color
    class << self
      
      
      def rgb(red, green, blue)
        "rgb(#{red}, #{green}, #{blue})"
      end

    end

  end
  
  #This class is utility for css.rb
  module CssUtil
    class << self
      def nameWithDividStr(sel, divi)
        sel.inject("") do |name, s|
          next name << s if name == ""
          name << divi << s        
        end
      end

      def useCore(sel, arr)
        ans = []
        sel.each do |s|
          next ans <<  idElm(arr) if includeID s,arr
          next ans <<  clsElm(arr) if includeCls s,arr          
          next ans.unshift useCoreWithName(arr) if s == :name
        end
        ans
      end

      def useCoreWithName(arr)
        ans = []
        arr.each do |v|
          ans.unshift v unless include_ID_ELEM_ID(v) || include_ID_ELEM_CLS(v)        
        end
        ans
      end
      
      def include_ID_ELEM_ID(val)
        val.include?($ID_ELEM_ID) ? true : false
      end

      def include_ID_ELEM_CLS(val)
        val.include?($ID_ELEM_CLS) ? true : false
      end
      
      def includeID(elm, arr)
        KSUtil.isID(elm.to_s) && symbolInclude(:id,arr) ? true:false
      end

      def includeCls(elm,arr)
        KSUtil.isCls(elm.to_s) && symbolInclude(:cls, arr) ? true : false
      end
      
      def dividBySpace(str)
        str.split
      end

      def idElm(arr)
        index = findIDIndex arr
        removeIDIndex arr[index]
      end

      def clsElm(arr)
        index = findClsIndex arr
        removeClsIndex arr[index]
      end

      def symbolInclude(sym, arr)
        arr.each do |a|
          return true if a.include? sym.to_s
        end
        false
      end

      def hasSymbolArrTargetSymbol(sym,symArr)
        symArr.each do |s|
          return true if s == sym
        end
        false
      end
      
      def findIDIndex(arr)      
        arr.index{ |f| f =~ /^#{$ID_ELEM_ID}/ }
      end

      def findClsIndex(arr)
        arr.index{ |f| f =~ /^#{$ID_ELEM_CLS}/ }
      end

      def removeIDIndex(str)
        str.split($ID_ELEM_ID).last
      end
      
      def removeClsIndex(str)
        str.split($ID_ELEM_CLS).last
      end

      
    end
  end
  
  #this module is utility for hash
  module KSHash
    FIRST_KEY = "#{$JS_UNITS_PREFIX}1".to_sym
    class << self
      
      def seqHash(val,step)
        sym = "#{$JS_UNITS_PREFIX}#{step}".to_sym
        {sym => val}
      end
      
      # hash needs made by seqHash function
      def firstHashValue(hash)
        hash[FIRST_KEY]
      end
      
      def lastHashValue(hash)
        lk = lastHashKey hash
        ans = hash[lk]
        ans ||= ''
      end

      def lastHashKey(hash)        
        lastKey = FIRST_KEY #:a1
        hash.each_key do |k|
          lastKey = k if compareKeys(k, lastKey)
        end
        lastKey
      end
      
      def compareKeys(a,b)
        return true if removePrefix(a) > removePrefix(b)
        false
      end
      
      def removePrefix(k)
        k.to_s.gsub($JS_UNITS_PREFIX,"").to_i
      end

      def hashValues(hash)
        hash.values
      end

      def removeLastHashValue(hash)
        lk = lastHashKey hash
        hash.delete lk
      end
      
    end
    
  end
  
  # This module is utility, not depend on class instance
  module KSUtil
    class << self
      
      def myPATH
        current = ENV['PWD']
        switch = false
        if current.include?("BitTorrent")
          switch = true
        end
        dirname = File.basename(Dir.getwd)
        switch ? vPath1 = "/BitTorrent Sync" :  vPath1 = ""
        "/Users/shimizukazuyuki#{vPath1}/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/#{dirname}/"
      end

      # def testPATH(folder)
      #   current = ENV['PWD']
      #   current.include?("BitTorrent") ? vPath1 = "/BitTorrent Sync" :  vPath1 = ""
      #   "/Users/shimizukazuyuki#{vPath1}/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/#{folder}/"
      # end

      ### file reading
      def fileReadingToArr (txt, arr)
        begin
          File.open(txt) do |file|
            file.each_line do |labmen|
              arr << labmen
            end
          end
        # 例外は小さい単位で捕捉する
        rescue SystemCallError => e
          puts %Q(class=[#{e.class}] message=[#{e.message}])
        rescue IOError => e
          puts %Q(class=[#{e.class}] message=[#{e.message}])
        end      
      end

      
      def isBool(v)
        !!v === v
      end
      
      def strinrgConvertSymbole(s)
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
        %w(P A B HR BR BUTTON I EM STRONG DT DD LIST_ITEM TITLE OPTION LI TD)
      end

      def oneTags
        %w(DOCTYPE IMG INPUT META LINK)
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

