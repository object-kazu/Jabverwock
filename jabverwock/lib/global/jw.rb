
if $FOR_GEM
  require "global/globalDef"
  require "global/tagManager"
  require "global/press"
  require "global/structDescript"

else

  #test
  require_relative "globalDef" 
  require_relative "tagManager"  
  require_relative "press"
  require_relative "structDescript"

end


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  class JW

    attr_accessor :name, :aData, :templeteString, :pressVal, :tagManager
    
    def initialize
      @name           = self.name
      @aData          = "".varIs("")
      @Data           = [] # insertData array
      @openString     = ""
      @closeString    = ""
      @templeteString = ""
      @memberStringArray   = []
      @pressVal       = Press.new ## input -> templeteString, output -> resultString
      @tagManager     = TagManager.new
      @isWithBreak    = false
      @struct         = StructDescript.new
    end

    ### struct description ####
    def structExp(str)
      # @struct.structing str
      # res = @struct.showResult
      # arr = res.split("\n")
      # arr.each do |s|
      #   eval "s"
      # end
    end

    def showStructExp
      @struct.showResult
    end
    
    def attr(tag, *val)
      return unless tag.is_a? Symbol
      
      if val.count > 0
        @tagManager.tagAttr(tag,val.first)
        return self
      end
      
      sim = tag.to_s
      elem = sim.split "__"
      @tagManager.tagAttr elem[0], elem[1]
      
      self
    end
    
    # def attr(tag, val)
    #   @tagManager.tagAttr(tag,val)
    #   self
    # end

    def withBreak(with = true)
      @isWithBreak = with
      self
    end
    
    # ex) @tagManager.Id = id
    # mainAttr.each do |attr| 
    #   define_method "#{attr}=" do |val|
    #     val = KString.checkString val
    #     eval "@tagManager.#{attr} = val"
    #   end
    # end    
    mainAttr =  [:id, :cls, :name]
    # ex) return @tagManager.Id
    mainAttr.each do |attr|      
      define_method "tag#{attr.capitalize}" do
        eval "@tagManager.#{attr}"
      end
    end
    
    
    def name
      self.class.to_s.split("::").last.downcase
    end
    
    
    def tgStr
      assemble
      @templeteString
    end
        
    def isSingleTag(isSingle)
      if KSUtil.is_bool(isSingle)
        @tagManager.isSingleTag = isSingle        
      end
    end
    
    
    def setLang= (lang)
      lang = KString.checkString(lang)
      @tagManager.tagAttribute.addLang = lang
    end

        
    def selectorID
      "#" + @tagManager.tagAttribute.id
    end

    def isExistID
      if @tagManager.tagAttribute.id == ""
        return false
      end
      true
    end

    def selectorCls
      "." + @tagManager.tagAttribute.cls
    end

    def isExistCls
      if @tagManager.tagAttribute.cls == ""
        return false
      end
      true
    end
    
    
    def makeResult
      @templeteString += @tagManager.tempOpenString + $RET
      if !@tagManager.tempCloseString.empty?
          @templeteString += @tagManager.tempCloseString
      end
      @templeteString = KString.removeLastRET(@templeteString)
    end
    
    def memberAssemble
      if @memberStringArray.count > 0
         @templeteString += $RET
         ans = KString.stringArrayConectRET(@memberStringArray)
         @templeteString += ans
      end
      @memberStringArray = []
    end
    
    def makeTag
      @tagManager.withBreak = @isWithBreak
      @tagManager.openString
      @tagManager.closeString
    end

    def tag
      if @tagManager.name == ""
        @tagManager.name = @name        
      end
      @tagManager.name
    end
    
    def assemble
      tag
      makeTag
      makeResult
      memberAssemble
      @pressVal.templeteString = @templeteString

    end

    def pressConfig(name:, dist:)
      @pressVal.exportFile = name
      @pressVal.exportPath = dist
    end

    def pressFingerPrint
      @pressVal.resultString # 確認用の戻り値
    end
    
    def prepPress
      assemble
      
#      if @tagManager.isJsAvailable
#         if self.tagManager.isJsAvailable() {
#             if self.tagManager.isNeedJsSrc() {
#                 // prep for js
#                 // <script>　と<その他>を分離
#                 // <その他>を別ファイルに書き出す
#                 // ＜script＞を通常通り書き出す
#                 let a = enumerateLine(target: self.templeteString)
#                 let ans = self.tagManager.extranctBetweenScriptTag(target: a)
#                 var b : [String] = []
#                 for t in ans.extract {
#                     b.append(removeHeadTAB(str: t))
#                 }
#                 self.templeteString = b.joined(separator: "\n")
                
#                 // export to js file
#                 self.pressVal.templeteString = self.templeteString
#                 self.pressVal.initResutString()               // templeteString -> resultString
#                 self.pressVal.removeAllLabel()                // remove label string
#                 let tempName = self.tagManager.jsFileName
#                 let tempDir = self.tagManager.jsPath
#                 self.pressVal.core(name: tempName, dist: tempDir)    // press resultString

#                 // prep for html and css
#                 self.templeteString = ans.scriptTag.joined(separator: "\n")
                
                
#             }else{
#                 //通常のTagと同じ処理
#             }
            
#         }
        
###      end
      
      @pressVal.initResutString      
      @pressVal.removeAllLabel
    end
    
    def press
      @pressVal.core      
      p "Press Done!"
      pressFingerPrint
    end

    
    def pressDefault
      prepPress
      press
    end
        
    
    def pressInsert(insertData)
      if @pressVal.isResultStringEmpty
        prepPress
      end
      
      @pressVal.withInsert(insertData)
      press
      pressFingerPrint
    end
        
    def pressInsertEach(*insertData)
      if @pressVal.isResultStringEmpty
        prepPress
      end
      
      @pressVal.withInsertEach(insertData)
      press
      pressFingerPrint
    end
    
    # press for testing
    
    $EXPORT_TESTPRESS_Dir_MACBOOK = "/Users/shimizukazuyuki/BitTorrent Sync/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/sample/"
    $EXPORT_TESTPRESS_Dir_iMAC = "/Users/shimizukazuyuki/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/sample/"
    
    def testPress(name)
      _dir_ = $EXPORT_TESTPRESS_Dir_iMAC
      
      current = ENV['PWD']
      if current.include?("BitTorrent")
        _dir_ = $EXPORT_TESTPRESS_Dir_MACBOOK 
      end
      
      n = name + "Pressed" + ".html"
      pressConfig(name: n, dist: _dir_)
      prepPress
      press
    end

    
  end

  #p a = JW.new

end


