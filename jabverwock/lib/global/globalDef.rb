# TODO: single, multi -> 引数で切り替え　、default value
# TODO: jws!
# TODO: sample web app making


# String extensions
module StringExtension
  
  
  refine String do
    
    # Combine strings by dot(.).
    #
    # @example
    # "sample".dot("is_test") => "sample.is_test"
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
    
    # To make string as variable
    # @example
    #   :abc.variable  => "$LABEL_INSERT_STARTabc$LABEL_INSERT_END"
    def variable
      $LABEL_INSERT_START + self.to_s + $LABEL_INSERT_END
    end  
    
    # to meke array
    # @example
    # :id__test.varIs "sample" => {:label => "id__test", :data => "sample"}
    def varIs(val)
      {:label => self.to_s, :data => val}
    end
    
    # @return [string] divid by "__"
    # @example
    #     :id__test.divid => "test"
    def divid
      sim = self.to_s
      elem = sim.split "__"
      elem
    end
    
    # :id__test  => true
    # :id_test  => false
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
    
    # @example
    # a = [1,2,3]
    # b = [4,5,6]
    # a.append b # => [1, 2, 3, 4, 5, 6]
    def append(element)      
      self << element
      self.flatten!
    end

    
    # @example
    # a = [1,2,3]
    # b = [4,5,6]
    # a.appends [11,22], [33,55] # => [1, 2, 3, [4, 5, 6]]
    # p a # => [1, 2, 3, 11, 22, 33, 55]
    def appends (*element)
      element.each do |a| 
        self.append a
      end
    end
    
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

  # CSS border style list
  #
  # none, hidden, dotted, dashed, solid, double, groove, ridge, inset, outset
  #
  # @return [String] border style  
  # @example  css.border_style = STYLE.NONE
  #   "css {\nborder-style: none;\n}"
  module STYLE
    class << self
      styles = %w(none hidden dotted dashed solid double groove ridge inset outset)
      styles.each do |s| 
        define_method s.upcase do 
          "#{s}"
        end
      end
    end
  end
  
  
  # CSS origin property list
  #
  # border, padding, content
  # @return [String] property style
  # @example
  #    css.background_origin = ORIGIN.BORDER
  #    =>  "{\nbackground-origin: border-box;\n}"
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
  
  # CSS attachment property list
  #
  # scroll, fixed, local
  # @return [String] attachment property
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
  
  # CSS repeat property list
  module REPEAT
    class << self

      def repeatTemp(r)
        @result ||= ""
        @result << r + $SPC
        self        
      end
      
      # @return [String]
      def Yes()
        repeatTemp "repeat"
      end
      
      # @return [String]
      def No()
        repeatTemp "no-repeat"
      end
      
      # @return [String]
      def X()
        repeatTemp "repeat-x"
      end
      
      # @return [String]
      def Y()
        repeatTemp "repeat-y"
      end

      # @return [String]
      def SPC()
        repeatTemp "space"
      end
      
      # @return [String]
      def ROUND()
        repeatTemp "round"
      end
      
      # @return [String]
      def val()
        @result ||= ""
        ans = @result.rstrip
        @result = ""
        ans
      end
    end
  end
  
  # express url property
  module URL
    class << self
      
      # @return [String]
      # @example css.background_image = URL.url 'paper.gif'.dQuo
      #   "css {\nbackground-image: url(\"paper.gif\");\n}"
      def url(str)
        "url(#{str})"
      end
    end
  end
  
  # express color property
  module Color
    class << self
      
      # rgb color
      # @param [String] red value
      # @param [String] green value
      # @param [String] blue value
      # @return [String] 
      def rgb(red, green, blue)
        "rgb(#{red}, #{green}, #{blue})"
      end
    end

  end
  
  #This is utilities for css.rb
  module CssUtil
    class << self
      
      # koko now 
      # def nameWithDividStr(sel, divi)
      #   sel.inject("") do |name, s|
      #     next name << s if name == ""
      #     name << divi << s        
      #   end
      # end
      
      
      # def useCore(sel, arr)
      #   ans = []
      #   se
      #   l.each do |s|
      #     next ans <<  idElm(arr) if includeID s,arr
      #     next ans <<  clsElm(arr) if includeCls s,arr          
      #     next ans.unshift useCoreWithName(arr) if s == :name
      #   end
      #   ans
      # end

      # def useCoreWithName(arr)
      #   ans = []
      #   arr.each do |v|
      #     ans.unshift v unless include_ID_ELEM_ID(v) || include_ID_ELEM_CLS(v)        
      #   end
      #   ans
      # end
      
      # def include_ID_ELEM_ID(val)
      #   val.include?($ID_ELEM_ID) ? true : false
      # end

      # def include_ID_ELEM_CLS(val)
      #   val.include?($ID_ELEM_CLS) ? true : false
      # end
      
      # def includeID(elm, arr)
      #   KSUtil.isID(elm.to_s) && symbolInclude(:id,arr) ? true:false
      # end

      # def includeCls(elm,arr)
      #   KSUtil.isCls(elm.to_s) && symbolInclude(:cls, arr) ? true : false
      # end
      
      # def dividBySpace(str)
      #   str.split
      # end

      # def idElm(arr)
      #   index = findIDIndex arr
      #   removeIDIndex arr[index]
      # end

      # def clsElm(arr)
      #   index = findClsIndex arr
      #   removeClsIndex arr[index]
      # end

      # def symbolInclude(sym, arr)
      #   arr.each do |a|
      #     return true if a.include? sym.to_s
      #   end
      #   false
      # end

      # def hasSymbolArrTargetSymbol(sym,symArr)
      #   symArr.each do |s|
      #     return true if s == sym
      #   end
      #   false
      # end
      
      # def findIDIndex(arr)      
      #   arr.index{ |f| f =~ /^#{$ID_ELEM_ID}/ }
      # end

      # def findClsIndex(arr)
      #   arr.index{ |f| f =~ /^#{$ID_ELEM_CLS}/ }
      # end

      # def removeIDIndex(str)
      #   str.split($ID_ELEM_ID).last
      # end
      
      # def removeClsIndex(str)
      #   str.split($ID_ELEM_CLS).last
      # end

      
    end
  end
  
  # This module provide utility for hash
  # Hash needs made by seqHash function in jabverwock
  # make hash with js keyword
  
  module KSHash

    # FIRST_KEY is keyword and symbol eqal to ":js1"
    FIRST_KEY = "#{$JS_UNITS_PREFIX}1".to_sym
    
    class << self
      
      #
      # @param [String] val hash value 
      # @param [Int] step make symbol like js1:
      # @return [Hash]
      # @example 
      #    seqHash "test", 1 => {:js1 => "test"}
      def seqHash(val,step)
        sym = "#{$JS_UNITS_PREFIX}#{step}".to_sym
        {sym => val}
      end
                  
      # @param [Hash] hash target hash
      # @return [String] value of hash[0]
      def firstHashValue(hash)
        hash[FIRST_KEY]
      end
      
      # @param [Hash] hash target hash
      # @return [String] value of last hash
      def lastHashValue(hash)
        lk = lastHashKey hash
        ans = hash[lk]
        ans ||= ''
      end
      
      # @param [Hash] hash target hash
      # @return [String] key of last hash
      def lastHashKey(hash)        
        lastKey = FIRST_KEY #:a1
        hash.each_key do |k|
          lastKey = k if compareKeys(k, lastKey)
        end
        lastKey
      end
      
      # @param [Symbol] a symbol made by seqHash function
      # @param [Symbol] b symbol made by seqHash function
      # @return [Bool] whether a is bigger key
      # @example hash key used by seqHash function is like :js1
      #  compareKeys :js2, :js1 => true
      def compareKeys(a,b)
        return true if removePrefix(a) > removePrefix(b)
        false
      end
      
      # @param [Symbol] k symbol
      # @return [Int]
      # @example remove string = $JS_UNITS_PREFIX
      #   $JS_UNITS_PREFIX + "1" => 1
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
      
      # For debugging, can remove?
      def pathForTest(currentFilePath)
         File.dirname(currentFilePath) + "/"      
      end
      
      # For debugging, can remove?
      def myPATH
        pathForTest "test"
      end
      
      # For Test
      # diff form index.html and indexPressed.html
      # index.html and indexPressed.html should be same folder
      # @param [String] currentFilePath path of files
      # @return diff result
      def myDiff(currentFilePath)
        path = pathForTest currentFilePath      
        dif = `diff -b "#{path}index.html" "#{path}indexPressed.html"`
        if dif != ""
          p dif
          return
        end
        p 'no difference!'
      end
      

      # file reading, array make from each line
      # @param [String] txt
      # @param [Array] arr
      # @return [Array]
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
      
      # @param [Anything] v value
      # @return [Bool]
      def isBool(v)
        !!v === v
      end
      
      # @param [String] s
      # @return [Symbol]
      def strinrgConvertSymbole(s)
        if s.is_a? String
          s = s.to_sym
        end
        s
      end
      
      # @param [Symbol] sym
      # @param [String] str
      # @example
      #  attr(:id, "test") => attr(:id__test)
      def combineSym(sym, str)
        ans = sym.to_s << "__" << str
        ans.to_sym
      end
      
      # @param [Anything] sym
      # @return [Bool] whether symbol has "__" double underbar
      # @example
      #   :id__test => true
      def isDoubleUnderBarSymbol(sym)
        return nil unless sym.is_a? Symbol
        sym.hasDoubleUnderBar?
      end

      
      # @param [Anything] data
      # @return [Bool] whether array
      def isDoubleArray (data)
        data[0].is_a?(Array)
      end
      
      # @return [Bool]
      def isBase (i,s)
        s.to_s.include?(i) ? true : false            
      end
      
      # @param [Anything] s
      # @return [Bool] whether inclued "id" as string
      def isID(s)
        isBase "id", s
      end

      # @param [Anything] s
      # @return [Bool] whether inclued "cls" as string
      def isCls(s)
        isBase "cls", s
      end

      # @param [Anything] s
      # @return [Bool] whether inclued "name" as string
      def isName(s)
        isBase "name", s      
      end

      # define multi line tag
      # @return [Array] array of multi tags
      # @example
      #   <HTML> \n </HTML>
      def multiTags
        m = %w(HEAD )
        m += %w(ADDRESS ARTICLE ASIDE AREA AUDIO)
        m += %w(BODY BLOCKQUOTE CANVAS)
        m += %w(DATALIST DETAILS DIALOG DIV DL DEL)
        m += %w(FORM FOOTER FIGURE FIELDSET)
        m += %w(HTML HEADER HGGROUP INS)
        m += %w(MAIN MAP NAV NOSCRIPT OL OPTGROUP PRE )
        m += %w(SCRIPT STYLE SECTION SELECT SMALL SPAN)
        m += %w(TEXTAREA TEMPLATE UL )
        m += %w(LI_multi )
        m += %w(VIDEO )
        m += %w( )
      end
      
      # define table tag
      # @return [Array] array of table tags
      # @example
      #   <Table> \n </Table>
      def tableTags
        %w(TR TABLE)
      end
      
      # define single tag
      # @return [Array] array of single tags
      # @example
      #   <P> </P>      
      def singleTags
        s = %w( LIST_ITEM TD)
        s += %w(A ABBR)
        s += %w(B BDI BDO BR BUTTON )
        s += %w(CITE CODE )
        s += %w(DT DD DATA DFN)
        s += %w(EM )
        s += %w(FIGCAPTION HR )
        s += %w(I KBD )
        s += %w(LI LABEL LEGEND MARK METER)
        s += %w(OPTION OUTPUT P PROGRESS Q)
        s += %w(RP RT RTC RUBY)
        s += %w(S SAMP STRONG SUB SUP SUMMARY)
        s += %w(TITLE TIME TT U)
        s += %w(VAR WBR)
      end
      
      # define one tag
      # @return [Array] array of one tags
      # @example
      #   <DOCTYPE>
      def oneTags
        o = %w(DOCTYPE IMG INPUT EMBED PARAM SOURCE)
        o = %w(LINK META TRACK)
      end
      
      # string insert to style tags
      # @param [String] str
      # @return [String]
      # @example
      #   intoStyleTag "test"
      #   => "<style>\n test\n </style>\n"
      def intoStyleTag (str)
        "<style>\n" << "#{str}\n" << "</style>\n"        
      end
      
      # @param [String] tag
      # @return [Bool] whether tag is "<"
      def isOpenTag(tag)
        tag.match(/^(\t)*<(\w+)/) do |d|
          return true
        end
        false
      end
      
      # @param [String] tag
      # @return [Bool] whether tag is ">"
      def isCloseTag(tag)
        tag.match(/<\/(\w+)/) do
          return true
        end
        false
      end
      
      # @param [String] tag
      # @return [Bool] whether tag is "{"
      def isOpenPara(tag)
        tag.include? "{"
      end
      
      # @param [String] tag
      # @return [Bool] whether tag is "}"
      def isClosePara(tag)
        tag.include? "}"
      end

    end
  end
  
  
  # this class is HTML arrange, especialy treat with RET and TAB.
  module KString
    # 型チェック
    class << self
      
      
      def testPrint
        p "test done"
      end
      
      # cls reName to class
      # @example
      #  renameCls "cls" => "class"
      #  renameCls "name" => "name"
      def renameCls (str)
        if str == "cls"
          return "class"
        end
        str
      end
      
      # "_" convert to "-"
      # @example
      #   renameUnderBar "cls_height" => "cls-height"
      def renameUnderBar (str)
        if str.include?("_")
          return str.gsub(/_/, "-")
        end
        str
      end
      
      # text line to Array
      # @param [String] str 
      # @return [Array] 
      def reader(str) # sentence -> arr
        str.lines
      end
      
      # insert string to array
      # @param [Array] arr
      # @param [String] txt
      # @return [Array]
      # @example
      #    a = ["a", "b", "<\/body>"]
      #    KString.insertText a, "!!"
      #    => "a\nb\n!!\n<\/body>\n"
      def insertText(arr,txt)
        index = insertBodyEndTag arr
        tArr = removeAllRET arr
        tArr.insert index, txt
        insertReturnEachLine tArr
      end
      
      # @param [Array] arr String Array
      # return [Array]
      def insertReturnEachLine (arr)
        ans = arr.inject("")do |a,t|
          a << t << $RET
        end
      end
      
      
      # @param [Array] arr String Array
      # @return [Array]
      def insertBodyEndTag (arr)
        arr.index { |i| i =~ /<\/body>/ }
      end
      
      # @param [Any] type type of instance
      # @param [Any] instance
      # @return [Bool]
      def check_type(type, instance)
        # pass check -> true
        # fail check -> ArgumentError
        
        unless instance.kind_of?(type)
          raise ArgumentError::new("type mismatch: #{instance.class} for #{type}")
        end
        true
      end
      
      # whether instance type is string
      # @param [String] instance
      # @return [Bool]
      def isString? (instance)
        check_type(String, instance)
      end

      # whether instance type is Int
      # @param [Int] instance
      # @return [Bool]
      def isInt?(instance)
        check_type(Integer,instance)
      end
      
      # last Return remove from text line
      # @param [String] text line of text
      # @return [String]
      def removeLastRET(text)
        isString? text
        text.chomp
      end
      
      # remove Return from all of text lines
      # @param [Array<String>] arr String Array
      # @return [Array]
      def removeAllRET(arr)
        arr.map { |s| s.chomp }
      end

      
      # remove ";$" characters from text
      # @param [String] text
      # @return [String]
      def remove_Js_Cmd_End(text)
        isString? text
        text.gsub(/;$/, "")
      end
      
      # add space to top of string
      # @param [String] str
      # @return [String]
      # @example
      #   addSpace "test" => " test"
      def addSpace(str)
        isString? str
        unless str.empty?
          str = $SPC + str
        end
        str
      end
      
      
      # whether Array include string
      # @param [Array] arr
      # @return [Bool] 
      def isStringInArray(arr)
        arr.each do |a|
          isString? a
        end
      end
      
      # @param [Array] arr
      # @return [String]
      # @example
      #   [a,b,c] => "a\nb\nc\n"
      def stringArrayConectRET (arr)
        return if arr.empty?
        return unless isStringInArray arr
        
        arr.inject("") do |ans, d|
          ans << d << $RET
        end          
      end
      
      
      # replace word "of" to "with" in strings
      # @param [String] str target string
      # @param [String] of target word
      # @param [String] with replace word
      # @return [String]
      def reprace(str:, of:, with:)
        isString? str
        isString? of
        isString? with

        str.gsub(of,with)
      end
      
      # @param [element] element css element
      # @param [Array] elementArray css array
      # @return [Array] css element array
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
      
      # check including css string, such as {}
      # @param [String] str
      # @return [Bool] true if css string include
      def isExistCssString(str)
        return false if str.empty?

        if !str.include?("{") || !str.include?("}")
          return false
        end
        
        removeFront = str.gsub(/.*{/, "").gsub(/}/, "").gsub(/\n/, "")        
        
        return false if removeFront == ""
        true
      end
      
      # add tab each line
      # @param [Array] arr array<String>
      # @param [Int] number express how many tab adding in front of line
      # @return [Array]
      def addTabEachArray(arr, number)
        return "" if arr.empty?    
        arr.map{ |a|
          "\t" * number << a
        }.join.sub!("\t" * number, "")
      end
      
      # whether range has Int
      # @param [Int] range
      # @return [Bool] whether range is Int
      def isIntegerIndex(range)
        return false unless range.first.is_a? Integer
        return false unless range.last.is_a? Integer
        true
      end
      
      # @param [Array] range
      # @return [Range]
      def sliceRange(range)      
        (range.first + 1)..(range.last + 1)
      end
      
    end 
  end
end 

