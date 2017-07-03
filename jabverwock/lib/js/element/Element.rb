if $FOR_GEM  
  require 'global/globalDef'
  require 'js/element/elementUtil'
  require 'js/element/elementBase'
  
else
  require_relative '../.././global/globalDef' 
  require_relative '../element/elementUtil'
  require_relative '../element/elementBase'
  
end



module Jabverwock
  using StringExtension
  using ArrayExtension
    
  # This class express element
  class Element < ElementBase
        
    ### each element ###

    def attribute(str)
      elementChanging_Equal('attribute',str)
      rec
      self
    end

    # arg ex) :click_ or :click_2 and so on == :click
    # because addEventListener allow use same event(such as click),
    # but ruby hash do not allow same key
    # see jsDocumentTest.rb
    USECAPTIN = [',true', ''].freeze
    
    def addEventListener(**event_function_hash)
      addEventListenerBase USECAPTIN.last, event_function_hash
      rec
      countLastArgNumber event_function_hash
      self
    end
    
    def addEventListenerUseCapture(**event_function_hash)
      addEventListenerBase USECAPTIN.first, event_function_hash
      rec
      countLastArgNumber event_function_hash
      self
    end
    

    def innerHTML(str)
      elementChanging_Equal('innerHTML',str)
      rec
      self
    end

    def setAttribute(**attrStr)
      attrStr.each do |att, str|
        sKey = @eUtil.spliteSympbolByUnderBar att 
        e = ''.inDoubleQuot(sKey) + $COMMA.inDoubleQuot(str)
        @ecs << contentRemoveJSEnd.dot('setAttribute') + '(' + e + ')' + $JS_CMD_END
      end
      rec
      countLastArgNumber attrStr
      self
    end
    
    def style (**property_val)
      property_val.each do |property, val|
        @ecs << contentRemoveJSEnd.dot('style').dot(property.to_s) +  $EQUAL.inSingleQuo(val) + $JS_CMD_END
      end
      rec
      countLastArgNumber property_val
      self
    end
    
    def src (str)
      elementChanging_Equal('src', str)
      rec
      self
    end
    
    ### node ###
    def node(kind, *type)      
      t = type.empty? ? '' : type.first.to_s
           
      ans = contentRemoveJSEnd.dot(kind.to_s)
      ans << ''.dot(@eUtil.typeName(t)) unless t.empty?
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
      node :nextSibling, ''
    end

    def previousSibling
      node :previousSibling, ''
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

    def contentRemoveJSEnd
      KString.remove_Js_Cmd_End @content
    end
    
    def addEventListenerBase(ucp, event_function_hash)
      event_function_hash.each do |event, func| 
        rKey = @eUtil.spliteSympbolByUnderBar event
        @ecs << @eUtil.addEventListenerMain(contentRemoveJSEnd, rKey, func, ucp) 
      end
    end

    
  end

  # p a = Element.new(self)

  # p a = JsDocument.new('','','')
  # p a.byID
  # p a.write('adas')

end
