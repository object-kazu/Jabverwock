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
  
  module KS
    # 型チェック
    def self.check_type(type, instance, nilable =false)

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

    def self.checkString (instance, nilable=false)
      check_type(String, instance)
    end
    
  end
end
  # a = "a"
  # p a = KSG.check_type(String,a )
  
__END__



