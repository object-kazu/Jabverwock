if $FOR_GEM  
  require "global/globalDef"
  require "js/jsBase"
  require "js/jsVar"
  require "js/jsDocument"
else
  require_relative "../global/globalDef" 
  require_relative "./jsBase"
  require_relative "./jsVar"
  require_relative "./jsDocument"
end


module Jabverwock
  using StringExtension
  using ArrayExtension
    
  # This class express element
  class Element
    
    # contentを受け取ってecを返す
   attr_writer :content
   attr_reader :ec, :ecs
   
    def initialize(delegate)
      @delegate = delegate
      @content = ""
      @ec = ""
      @ecs = []
      @equality = [] # keep var statement 
    end
    
    def cutout # export and remove
      exp = self.recordLast

      if exp == nil
        return @content
      end
            
      removeLastDocHash
      KString.remove_Js_Cmd_End(exp)
    end
    
    # def export # rename 'element' to 'export'
    #   @content
    # end

    def record
      @delegate.record
    end

    def docHashLast
      @delegate.lastDocHashValue
    end

    def unitsHashLast
      @delegate.lastUnitsHashValue
    end

    def removeLastDocHash
      @delegate.removeLastDocHash
    end

    def removeLastUnitsHash
      @delegate.removeLastUnitsHash
    end
    
    def records
      @delegate.unitList
    end

    def equality
      @delegate.equality[0]
    end
    
    def is_var(name)
      v = JsVar.new

      # nodeが呼ばれた場合、docHashからunitsにデータが移行しているので、
      # units.lastのデータを使用する必要がある
      content = self.docHashLast

      
      if content == nil
        content = self.unitsHashLast
        self.removeLastUnitsHash #unitsデータを使用したので削除しておく
      end
      
      @delegate.recEqual v.is( name, content).record
      removeLastDocHash
    end
    
    
    def rec
      if @ecs.count > 0
        recs
        return
      end
      
      @ec = @content if @ec == ""
      @delegate.recBy @ec
      removeLastDocHash
      
      @ec = ""
    end
    
    def index(i)
      s = KString.remove_Js_Cmd_End @content
      @ec = s + "[#{i}];"
      @content = @ec
      @delegate.rewriteUnitsHashValue @content
      self
    end
    
    ### each element ###

    def attribute(str)
      elementChanging_Equal("attribute",str)
      rec
    end

    # arg ex) :click_ or :click_2 and so on == :click
    # because addEventListener allow use same event(such as click),
    # but ruby hash do not allow same key
    # see jsDocumentTest.rb
    def addEventListener(**event_function_hash)
      addEventListenerBase false, event_function_hash
      rec
    end
    
    def addEventListenerUseCapture(**event_function_hash)
      addEventListenerBase true, event_function_hash
      rec
    end

        
    def innerHTML(str)
      elementChanging_Equal("innerHTML",str)
      rec
    end

    def setAttribute(**attrStr)
      attrStr.each do |att, str|
        sKey = spliteSympbolByUnderBar att 
        e = "".inDoubleQuot(sKey) + $COMMA.inDoubleQuot(str)
        @ecs << contentRemoveJSEnd.dot("setAttribute") + "(" + e + ")" + $JS_CMD_END
      end
      rec
    end
    
    def style (**property_val)
      property_val.each do |property, val|
        @ecs << contentRemoveJSEnd.dot("style").dot(property.to_s) +  $EQUAL.inSingleQuo(val) + $JS_CMD_END
      end
      rec
      self
    end
    
    def src (str)
      elementChanging_Equal("src",str)
      rec
      self
    end

    def createTextNode(str)
      
      self
    end
    
    ### node ###
    def node(kind,*type)
      
      k = kind.to_s
      t = type.empty? ? "" : type.first.to_s
      
      ans = contentRemoveJSEnd.dot(k)
      ans << "".dot(typeName(t)) unless t.empty?
      @ecs << ans + $JS_CMD_END
      rec
      self
    end

    def parentNode(*type)
      node :parentNode, *type
    end
    
    def childNodes(position, *type)
      node "childNodes[#{position}]",*type
    end

    def nextSibling
      node :nextSibling,  ""
    end

    def previousSibling
      node :previousSibling,  ""
    end
    
    
    def firstChild(*type)
      node :firstChild, *type
    end

    def lastChild(*type)
      node :lastChild, *type
    end


    ### private methods ###

    private
    def recs
      @delegate.recsBy @ecs
      removeLastDocHash
      @ecs = []      
    end
    

    def spliteSympbolByUnderBar(sym)
      sym.to_s.split("_").first
    end

    def contentRemoveJSEnd
      KString.remove_Js_Cmd_End @content
    end
    
    def addEventListenerBase(ucp, event_function_hash)
      event_function_hash.each do |event, func| 
        rKey = spliteSympbolByUnderBar event
        @ecs << addEventListenerMain(contentRemoveJSEnd, rKey, func, ucp) 
      end
    end
    
    def addEventListenerMain(content, event, func, useCaption = false)
      ucp = useCaption ? ",true": ""
      content.dot("addEventListener") + "(".inDoubleQuot(event) + $COMMA + func + ucp + ")" + $JS_CMD_END
    end
    
    ### change element ###
    def elementChanging_Equal (act,str)
      s = KString.remove_Js_Cmd_End @content
      @ec = contentRemoveJSEnd.dot(act) + $EQUAL + str + $JS_CMD_END
      self
    end
    
    def elementChanging (act,str)
      @ec = contentRemoveJSEnd.dot(act) + "(" + str + ")" + $JS_CMD_END
      self
    end
 
    def typeName(t)
      v = "node"
      tArr = %w(Value Type Name)
      tArr.each do |a|
        if a.downcase == t.to_s
          return v << a
        end
      end
    end    
  end

  # p a = JsDocument.new

  # p a = JsDocument.new("","","")
  # p a.byID
  # p a.write("adas")
  
end
