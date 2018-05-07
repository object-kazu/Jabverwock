require "global/globalDef"
require "global/jw_CSS_OPAL_JS"
require "global/jw"
require "css/css"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  #This class express multi line html tag, like head, body etc.
  class JWOriginal 

    SINGLE = "single tag like <p></p>"
    MULTI  = "multi tag like <html>¥n</html>"

    # attr_accessor :obj
    
    def initialize(toggle="")
     self = JWMulti.new 
    end
    
  end

    all = KSUtil.allTags
  all.each do |tag|
    if KSUtil.singleTags.include? tag
      Object.const_set tag, Class.new(JWSingle){
      }
    end
    
    if KSUtil.multiTags.include? tag
      Object.const_set tag, Class.new(JWMulti){
      }
    end

    if KSUtil.oneTags.include? tag
      Object.const_set tag, Class.new(JWOneTag){
      }
    end

    if KSUtil.tableTags.include? tag
      obj = ""
      case tag
      when "TABLE"
        obj = JWTable
      when "TROW"
        obj = TableRow
      when "THEAD"
        obj = TableHeader
      when "TDATA"
        obj = TableData
      end
      Object.const_set tag, Class.new(obj){
      }
    end

  
end


