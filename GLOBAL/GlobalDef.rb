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
  

__END__



