require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  html= HTML.new  
  body = BODY.new
  
  br = BR.new
  p1 = P.new.contentIs "this is " << br.tgStr << "br class"
  p2 = P.new.contentIs "this is #{$BR}br string"
  
  body.addChildren p1, p2
  html.addChild body
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
