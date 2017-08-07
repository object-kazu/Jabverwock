require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  html = HTML.new  
  body = BODY.new
  
  p1 = P.new.contentIs "this is " << "a".variable
  
  body.addChild p1
  html.addChild body
      
  html.pressConfig(name: 'indexPressed.html', dist: KSUtil.myPATH)
  html.pressInsert("a".varIs "class")
  
  # # show diff
  KSUtil.myDiff
  

end
