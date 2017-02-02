## String extension ############ 
class String

  def inDoubleQuot(insert)
    if insert.is_a?(String)
      self + $DOUBLE_QUO + insert + $DOUBLE_QUO
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
    
  def variable
    $LABEL_INSERT_START + self + $LABEL_INSERT_END
  end  

    
end

module Jabverwock

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

  # # Table ####################
  $BLA      = "<br>"
  $ROW_SPAN = "%rowSpan="
  $COL_SPAN = "%colSpan="
  module KSUtil
    class << self
      def callSelfCls(cls)
        "#{cls.class}"
      end
    
      def is_bool(v)
        !!v === v
      end      
    end
  end
  
  module KString
    # 型チェック
    class << self

      def check_type(type, instance, nilable =false)

        if (instance.nil?)
          unless nilable
            raise ArgumentError::new("non-nil constraint vioration")
          end # nilable
        else
          unless instance.kind_of?(type)
            raise ArgumentError::new("type mismatch: #{instance.class} for #{type}")
          end # instance, type
        end # instance.nil?

        return instance
      end

      def checkString (instance, nilable=false)
        check_type(String, instance)
      end

      def chechInt(instance,nilable=false)
        check_type(Integer,instance)
      end
      

      def removeLastRET(text)
        text = checkString(text)
        ans = text.chomp
        if ans != nil
          return ans
        end
        text
      end

      def removeLastTAB(text)
        text = checkString(text)
        ans  = text.gsub!(/\t$/, "")
        if ans != nil
          return ans
        end
        text
      end

      def removeHeadTAB(text)
        text = checkString(text)
        ans = text.gsub!(/^\t/, "")
        if ans != nil
          return ans
        end
        text
      end


      def addSpace(str)
        if !str.empty?
          str = checkString(str)
          str = $SPC + str
        end
        str
      end

      def stringArrayConectRET (arr)
        ans = ""
        if arr.count > 0
          arr.each { |d| 
            ans += checkString(d)
            ans += $RET
          }
        end
        ans
      end


      def reprace(str:, of:, with:)
        str = checkString(str)
        of = checkString(of)
        with = checkString(with)
        str = str.gsub!(of,with)
      end

      # tab揃え
      def tabCount(str)
        str = checkString(str)
        # //余分なTabを除く
        str = removeLastTAB(str)
        str.count("#{$TAB}")
      end

      def addTab(str:, tabMax:)
        str = checkString(str)
        tabMax = chechInt(tabMax)

        ans = ""
        str.each_line { |l|
          tn = tabCount(l)
          df = tabMax - tn
          ans += addHeadTab(str: l, num: df)
        }
        ans
      end
      
      def addHeadTab(str:, num:)
        str = checkString(str)
        num = chechInt(num)

        t = ""
        num.times do |i| 
          t += $TAB
        end
        t += str
        
      end

      def getTabNumber (testStr, targetStr=$STYLE_CONTENT)
        testStr = checkString(testStr)
        targetStr = checkString(targetStr)
        
        testStr.each_line{ |l|
          if l.count("#{$TAB}") > 0
            return tabCount(l) 
          end  
        }
        return 0
      end

      def getTabMax(str)
        str = checkString(str)
        max = 0
        str.each_line{ |l|
          a = tabCount(l)
          if a > max
            max = a
          end
        }
        return max
      end
      
    end

    
      
  end #globaleDef    
end #Jabverwock