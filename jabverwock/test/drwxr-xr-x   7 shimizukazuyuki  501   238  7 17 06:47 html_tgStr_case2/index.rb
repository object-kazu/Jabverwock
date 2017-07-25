require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  
  body = BODY.new
  
  a = A.new.contentIs("test").attr(:href,"www://")
  pp = P.new.contentIs "What is this? #{a.tgStr}"
  body.addChild pp

  html= HTML.new  
  html.addChild body
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
