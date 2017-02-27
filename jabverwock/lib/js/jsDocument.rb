require_relative "../global/globalDef" 
require_relative "./jsBase"

# require "global/globalDef"

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  class JsDocument < JsBase
    attr_accessor :result, :query
    
    def initialize(id,cls,name)
      super
      @obj = "document"
      @query = ""
      @element = Element.new
      @result = ""
    end
    
    def selectElement(slect,obj)
      attrBaseInit(@id,@cls,@name)
      @element.content = @obj.dot(slect).inParenth(obj) + $JS_CMD_END
      @element
    end

    def modifyElement(order, elem)
      attrBaseInit(@id,@cls,@name)
      @result = @obj.dot(order).inParenth(elem)
    end

    ### add and delete element ###
    # document.createElement(element)	Create an HTML element
    # document.removeChild(element)	Remove an HTML element
    # document.appendChild(element)	Add an HTML element
    # document.replaceChild(element)	Replace an HTML element
    
    def createElement(ele)
      modifyElement("createElement",ele)
      @result + $JS_CMD_END      
    end
    
    def write(str)
      modifyElement("write", str)
      @result + $JS_CMD_END
    end    
    


    ### find element ###
    
    def byID
     selectElement("getElementById", @id)
    end
    
    def byClassName
      selectElement("getElementByClassName",@cls)
    end

    def byTagName
      selectElement("getElementByTagName", @name)
    end

    def querySelectorAll
      selectElement("querySelectorAll",@query)
    end
    
    def querySelectorAllBy(que)
      @query = que
      querySelectorAll
    end

    ### evant handler ###
    #    document.getElementById(id).onclick = function(){code}

    ### Finding HTML Objects ###
    # document.anchors	Returns all <a> elements that have a name attribute	1
    # document.applets	Returns all <applet> elements (Deprecated in HTML5)	1
    # document.baseURI	Returns the absolute base URI of the document	3
    # document.body	Returns the <body> element	1
    # document.cookie	Returns the document's cookie	1
    # document.doctype	Returns the document's doctype	3
    # document.documentElement	Returns the <html> element	3
    # document.documentMode	Returns the mode used by the browser	3
    # document.documentURI	Returns the URI of the document	3
    # document.domain	Returns the domain name of the document server	1
    # document.domConfig	Obsolete. Returns the DOM configuration	3
    # document.embeds	Returns all <embed> elements	3
    # document.forms	Returns all <form> elements	1
    # document.head	Returns the <head> element	3
    # document.images	Returns all <img> elements	1
    # document.implementation	Returns the DOM implementation	3
    # document.inputEncoding	Returns the document's encoding (character set)	3
    # document.lastModified	Returns the date and time the document was updated	3
    # document.links	Returns all <area> and <a> elements that have a href attribute	1
    # document.readyState	Returns the (loading) status of the document	3
    # document.referrer	Returns the URI of the referrer (the linking document)	1
    # document.scripts	Returns all <script> elements	3
    # document.strictErrorChecking	Returns if error checking is enforced	3
    # document.title	Returns the <title> element	1
    # document.URL	Returns the complete URL of the document
    
    
  end

  # p a = JsDocument.new("","","")
  # p a.byID
  # a.id = "gege"
  # p a.byID
  # p a.write("adas")

  class Element
    attr_accessor :content
    
    def initialize
      @content = ""
    end

    def element
      @content
    end

    def index(i)
      s = KString.remove_Js_Cmd_End @content
      @content = s + "[#{i}];"
      self
    end
    
    ### change element ###
    def elementChanging_Equal (act,str)
      s = KString.remove_Js_Cmd_End @content
      s.dot(act) + $EQUAL.inDoubleQuot(str) + $JS_CMD_END      
    end
    
    def elementChanging (act,str)
      s = KString.remove_Js_Cmd_End @content
      s.dot(act) + "(" + str + ")" + $JS_CMD_END
    end
    
    def innerHTML(str)
      elementChanging_Equal("innerHTML",str)
    end

    def attribute(str)
      elementChanging_Equal("attribute",str)
    end

    def setAttribute(attr,str)
      s = "".inDoubleQuot(attr) + $COMMA.inDoubleQuot(str)      
      elementChanging("setAttribute",s)
    end
    
    def style (property, val)
      s = KString.remove_Js_Cmd_End @content
      s.dot("style").dot(property) + $EQUAL.inDoubleQuot(val) + $JS_CMD_END
    end
    
  end

  # a = Element.new
  # a.content = "aaaa;"
  # a.innerHTML "bbbb"
  
end
