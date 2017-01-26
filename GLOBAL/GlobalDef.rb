# String extension ############
class String
  def >>(other)
      self + other + other
  end

  def inDoubleQuot(insert)
    self + $DOUBLE_QUO + insert + $DOUBLE_QUO
  end

  def inSingleQuo(insert)
    self +  $SINGLE_QUO + insert + $SINGLE_QUO
  end

  def inParenth(insert)
    self + "(" + $SINGLE_QUO + insert + $SINGLE_QUO + ")"
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

# Table ####################
  $BLA      = "<br>"
  $ROW_SPAN = "%rowSpan="
  $COL_SPAN = "%colSpan="

  
  
end



# Struct ####################

  InsertData = Struct.new(:label, :data)

# enum ####################
  
  # module AttrLang
  #   JP = "jp"
  #   EN = "en"

  # end

  # a = AttrLang::JP# => "jp"
  
__END__


