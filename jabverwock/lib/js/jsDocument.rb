
if $FOR_GEM
  
  require "global/globalDef"
  require "js/jsBase"
  
else
  require_relative "../global/globalDef" 
  require_relative "./jsBase"
  
end


module Jabverwock
  using StringExtension
  using ArrayExtension
  
  #This class express JS Document class
  class JsDocument < JsBase
    attr_accessor :result, :query
    
    def initialize(*inits)
      super inits
      @obj = "document"
      @query = ""
      @element = Element.new(self)
    end

    #delegate    
    def rec
      recBy @element.ec
    end

    def recBy (str)
      @orders << str
    end
    
    def selectElement(slect,obj)
      cp =  @obj.dot(slect).inParenth(obj) + $JS_CMD_END
      @element.content = cp
      @element
    end

    def modifyElement(order, elem)
      updateSelector(@id,@cls,@name)
      cp =  @obj.dot(order).inParenth(elem) + $JS_CMD_END
      @element.content = cp
      @element
    end

    def treatElement (order,elem)
      updateSelector(@id,@cls,@name)
      cp = @obj.dot(order) + "(" + "#{elem}" + ")"  + $JS_CMD_END
      @element.content = cp
      @element
    end

    ### add and delete element ###
    def createElement(ele)
      modifyElement("createElement",ele)
    end

    def removeChild(child)
      treatElement("removeChild",child)
    end

    def appendChild(child)
      treatElement("appendChild",child)
    end

    def replaceChild(child)
      treatElement("replaceChild",child)
    end

    def write(str)
      modifyElement("write", str)
    end    
    


    ### find element ###
    def byID
      updateSelector(@id,@cls,@name)
      selectElement("getElementById", @id)
    end
    
    def byClassName
      updateSelector(@id,@cls,@name)
      selectElement("getElementByClassName",@cls)
    end

    def byTagName
      updateSelector(@id,@cls,@name)
      selectElement("getElementByTagName", @name)
    end

    def querySelectorAll
      updateSelector(@id,@cls,@name)
      selectElement("querySelectorAll",@query)
    end
    
    def querySelectorAllBy(que)
      updateSelector(@id,@cls,@name)
      @query = que
      querySelectorAll
    end

    ### evant handler ###
    #    document.getElementById(id).onclick = function(){code}
    def onclick (code)
      #under constuct
      p "#{code}"
    end

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

  
  # This class express element
  class Element
    
    # contentを受け取ってecを返す
   attr_writer :content
   attr_reader :ec
   
    def initialize(delegate)
      @delegate = delegate
      @content = ""
      @ec = ""
    end

    def element
      @content
    end

    def export
      @ec
    end
    
    def rec
      if @ec == ""
        @ec = @content
      end
      @delegate.recBy @ec
      @ec = ""
    end
    
    def index(i)
      s = KString.remove_Js_Cmd_End @content
      @ec = s + "[#{i}];"
      @content = @ec
      self
    end
    
    ### change element ###
    def elementChanging_Equal (act,str)
      s = KString.remove_Js_Cmd_End @content
      @ec = s.dot(act) + $EQUAL.inDoubleQuot(str) + $JS_CMD_END
      self
    end
    
    def elementChanging (act,str)
      s = KString.remove_Js_Cmd_End @content
      @ec = s.dot(act) + "(" + str + ")" + $JS_CMD_END
      self
    end
    
    def innerHTML(str)
      elementChanging_Equal("innerHTML",str)
    end

    def src (str)
      elementChanging_Equal("src",str)
    end
     
    def attribute(str)
      elementChanging_Equal("attribute",str)
    end

    def setAttribute(attr,str)
      e = "".inDoubleQuot(attr) + $COMMA.inDoubleQuot(str)      
      elementChanging("setAttribute",e)
    end
    
    def style (property, val)
      
      s = KString.remove_Js_Cmd_End @content
    
      @ec = s.dot("style").dot(property.to_s) +  $EQUAL.inSingleQuo(val) + $JS_CMD_END
      self
    end

    
    
  end


  # p a = JsDocument.new("","","")
  # p a.byID
  # p a.write("adas")

  
  # a = Element.new
  # a.content = "aaaa;"
  # a.innerHTML "bbbb"
  
end
