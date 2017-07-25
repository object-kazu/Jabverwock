require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  html= HTML.new
  
  body = BODY.new
  h1 = HEADING.new.contentIs "Hello world!" 
  h2 = HEADING.new(2).contentIs "See you again"
  
  body.addChildren h1,h2
  html.addChild body
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
