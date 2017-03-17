##

# ## String extension ############
module StringExtension
  
  refine String do
    def dot(str)
      self + "." + str
    end

    def removeLastRET
      self.chomp
    end

    def removeAllTab
      return self unless self.include?("\t")
      self.gsub!(/\t/, "")
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

    
    
  end
end

# ## Array extension ############
module ArrayExtension
  
  refine Array do
    
    def append(element)
      self << element
    end

    def appends (*element)
      element.each do |a| 
        self.append a
      end
    end

    def appendArray(arr)
      self.concat arr
    end

    # a = [1,2,3]
    # a.append 4 # => [1, 2, 3, 4]

    # b = [4,5,6]
    # #a.append b # => [1, 2, 3, 4, [4, 5, 6]]

    # a.appendArray b # => [1, 2, 3, 4, 4, 5, 6]
    
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

  
  # # Table ####################
  $BR      = "<br>"
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

      
      def labelDataPair?(p)
        if !p.is_a?(Hash)
          p "pair is hash, like {label:, data:}"
          raise RuntimeError
        end        
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
      
      def remove_Js_Cmd_End(text)
        text = checkString(text)
        ans  = text.gsub!(/;$/, "")
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

      def addTab(str:, num:)
        str = checkString(str)
        tabMax = chechInt(num)

        ans = ""
        str.each_line { |l|
          tn = tabCount(l)
          df = tabMax - tn
          ans += addHeadTab(str: l, num: df)
        }
        ans
      end

      def addTabEachLine (str)
        ans = ""
        str.each_line { |l|
          ans += addHeadTab(str: l, num: 1)
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

      def getTabNumber (testStr)
        testStr = checkString(testStr)
        testStr.each_line{ |l|
          if l.count("#{$TAB}") > 0
            return tabCount(l) 
          end  
        }
        return 0
      end

      # def getTabMax(str)
      #   str = checkString(str)
      #   max = 0
      #   str.each_line{ |l|
      #     a = tabCount(l)
      #     if a > max
      #       max = a
      #     end
      #   }
      #   return max
      # end
      
    end 
  end
end 

