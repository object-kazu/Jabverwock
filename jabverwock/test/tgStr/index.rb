require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  html= HTML.new  
  body = BODY.new
  
  bold = B.new.contentIs "test"
  
  pp = P.new.contentIs "This is #{bold.tgStr}"
  body.addChild pp
  html.addChild body
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
