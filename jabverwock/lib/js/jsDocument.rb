
if $FOR_GEM  
  require "global/globalDef"
  require "js/jsBase"
  require "js/jsVar"
  require "js/element/Element"
else
  require_relative "../global/globalDef" 
  require_relative "./jsBase"
  require_relative "./jsVar"
  require_relative "./element/Element"
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

    def selfy
      yield self
    end

    
    ## change function of var    
    ## callback var, it is deprecated
    # def var(name,&block)

    #   if block_given?
    #     z = block.call self
        
    #     # p ">>> units:"
    #     # p unitList

    #     # p ">>> docHash:"
    #     # p docHashList

    #     zet = docHashList + unitList
    #     zet.each{ |t|
    #       ans = name.to_s << " = " << t
    #       recEqual ans
    #     }

    #     @docHash = {}
    #     @units = {}
        
    #     # zz = z.cutOrders
    #     # zz.each{ |t|
    #     #   ans = name.to_s << " = " << t
    #     #   recEqual ans
    #     # }        
    #   end
    #   # z.is_var name
    #   # if block_given?  # ブロック渡しされているかどうかチェック
    #   #   z = block.call self
    #   #   if z.is_a? String
    #   #     ans = "var " << name.to_s << " = " << z
    #   #     recEqual ans
    #   #     return
    #   #   end
    #   #   z.is_var name
    #   # end
    # end

    
    def equal(leftSide, rightSide)
      ans = leftSide << " = " << rightSide + $JS_CMD_END
      recBy ans
    end

    ### delegate  ###
    def rec
      recBy @element.ec
    end

    def recBy (str)
      @units.update seqHash(str)
    end    

    def recsBy (str)
      str.each{ |s| recBy s }
    end

    def recEqual (str) # keep var statement
      @equality.update seqHash(str)
    end
   
    # @docHash = {}  #=> keep jsDocument hash (ex. doc.byID)
    # @units = {}    # => keep element hash (ex. doc.byID.innerHTML)
    # @equality = {} #=> keep equality hash (ex. var id = test)

    ### doc hash ###
    def lastDocHashValue
      KSHash.lastHashValue @docHash
    end

    def removeLastDocHash
      KSHash.removeLastHashValue @docHash
    end

    ### units hash ###
    def lastUnitsHashValue
      KSHash.lastHashValue @units
    end

    def removeLastUnitsHash
      KSHash.removeLastHashValue @units
    end

    def unitList
      KSHash.hashValues @units
    end

    def docHashList
      KSHash.hashValues @docHash      
    end

    def record
      self.unitList.first
    end

    def rewriteUnitsHashValue(str)
      lk = KSHash.lastHashKey @docHash
      @docHash[lk] =  str
    end

    ### equality hash ###
    def lastEqualityValue
      KSHash.lastHashValue @equality
    end

    def equalities
      KSHash.hashValues @equality
    end


    ### element ###
    def connectToElement(cnt)
      @element.content = cnt
      @element
    end

    def selectElement(slect,obj)
      cp =  @obj.dot(slect).inParenth(obj) + $JS_CMD_END
      @docHash.update seqHash(cp)
      connectToElement cp
    end

    def modifyElement(order, elem)
      cp =  @obj.dot(order).inParenth(elem.to_s) + $JS_CMD_END
      @docHash.update seqHash(cp)
      connectToElement cp
    end

    def treatElement (order, elem)
      cp = @obj.dot(order) + "(" + "#{elem}" + ")"  + $JS_CMD_END
      @docHash.update seqHash(cp)
      connectToElement cp
    end

    ### add and delete element ###
    def createElement(name)
      cp =  @obj.dot("createElement").inParenth(name.to_s) + $JS_CMD_END
      @docHash.update seqHash(cp)
      connectToElement cp
    end

    def removeChild(parent, child)
      cp = parent.to_s + ".removeChild(#{child.to_s})" + $JS_CMD_END
      recEqual cp
    end

    def appendChild(parent, child)
      cp = parent.to_s + ".appendChild(#{child.to_s})" + $JS_CMD_END
      recEqual cp
    end

    def insertBefore(targetNode,newNode)
      # <body>
      #  <div id="title1">DOM</div>
      #  <div id="title3">HTML</div>
      # </body>
      
      # <body>
      #  <div id="title1">DOM</div>
      #  <div id="title2">CSS</div>
      #  <div id="title3">HTML</div>
      # </body>

      ans = newNode + "," + targetNode
      cp = targetNode << ".parentNode.insertBefore(#{ans})" + $JS_CMD_END
      recEqual cp
    end
    
    # def replaceChild(child)
    #   treatElement("replaceChild",child)
    # end

    
    # write function include rec, so do not allow to chain other method
    # like: createElement.innerHTML....
    def write(str)
      modifyElement("write", str).rec
    end    

    ### cleate ###
    def createTextNode(str)
      treatElement("createTextNode",str)
      @element
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
end
