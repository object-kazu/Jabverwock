require 'global/globalDef'
require 'js/jsVar'
require 'js/element/elementUtil'

# if $FOR_GEM  
#   require 'global/globalDef'
#   require 'js/jsVar'
#   require 'js/element/elementUtil'
  
# else
#   require_relative '../.././global/globalDef' 
#   require_relative '../jsVar'
#   require_relative '../element/elementUtil'
  
# end


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # This class express element
  class ElementBase
    
    # contentを受け取ってecを返す
   attr_writer :content
   attr_reader :ec, :ecs
   
    def initialize(delegate)
      @delegate = delegate
      @content = ''
      @ec = ''
      @ecs = []
      @equality = [] # keep var statement
      lastArgNumberInit
      @eUtil = ElementUtil.new
    end

    # def cutOrders

    #   ans = @delegate.orders
    #   @delegate.clearHash
    #   # @delegate.printHash      
    #   ans
    # end

    
    # ### cut and cuts ###
    def lastArgNumberInit
      @lastArgNumber = 1
    end
    
    def countLastArgNumber(correction)
      @lastArgNumber = correction.count
    end
    
    # cutout rename cut
    # ex)
    #  h1 = HEADING.new.attr(:id__id01).contentIs "My First Page"
    #  hv =  h1.js.doc.byID.firstChild(:value).cut
    #  pp = P.new.attr(:id__id02)
    #  pp.js.doc.byID.innerHTML(hv)
    #  document.getElementById("id02").innerHTML = document.getElementById("id01").firstChild.nodeValue;

    def cuts
      ans = []
      # number = @lastArgNumber
      # number.times{ans << cut}
      
      @lastArgNumber.times{ans << cut}
      lastArgNumberInit
      ans.reverse
    end
    
    def cut # export and remove
      
      return cutDocHash if isExistDocHash
      return cutUnitsHash if isExistUnitsHash
          
      assert_raise{"error at cut"}      
    end

    def isExistDocHash
      self.docHashLast == '' ? false : true
    end

    def isExistUnitsHash
      self.unitsHashLast == '' ? false : true
    end
    
    def cutDocHash
      exp = self.docHashLast      
      removeLastDocHash
      lastArgNumberInit
      KString.remove_Js_Cmd_End(exp)
    end

    def cutUnitsHash
      exp = self.unitsHashLast
      removeLastUnitsHash
      lastArgNumberInit
      KString.remove_Js_Cmd_End(exp)
    end

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

      # nodeが呼ばれた場合、docHashからunitsにデータが移行しているので、
      # units.lastのデータを使用する必要がある
      content = self.docHashLast
      
      if content == ''
        content = self.unitsHashLast
        self.removeLastUnitsHash #unitsデータを使用したので削除しておく
      end
      
      isVarMain name, content
      # v = JsVar.new
      # @delegate.recEqual v.is( name, content).record
      # removeLastDocHash
    end

    def isVarMain(name, content)
      v = JsVar.new
      @delegate.recEqual v.is( name, content).record
      removeLastDocHash      
    end
        
    def rec
      if @ecs.count > 0
        recs
        return
      end

      recMain
      
      # @ec = @content if @ec == ''
      # @delegate.recBy @ec
      # removeLastDocHash
      
      # @ec = ''
    end

    def recMain
      @ec = @content if @ec == ''
      @delegate.recBy @ec
      removeLastDocHash      
      @ec = ''
    end
    
    def index(i)
      s = KString.remove_Js_Cmd_End @content
      @ec = s + "[#{i}];"
      @content = @ec
      @delegate.rewriteUnitsHashValue @content
      self
    end

    ### change element ###
    def elementChanging_Equal (act,str)
      s = KString.remove_Js_Cmd_End @content
      @ec = contentRemoveJSEnd.dot(act) + $SPC + $EQUAL + $SPC + + str + $JS_CMD_END
      self
    end
    
    def elementChanging (act,str)
      @ec = contentRemoveJSEnd.dot(act) + '(' + str + ')' + $JS_CMD_END
      self
    end
    
  end    

end
