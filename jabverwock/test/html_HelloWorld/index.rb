require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  html= HTML.new
  head = HEAD.new
  
  title = TITLE.new
  title.content = "This is my first page"
  head.addChild title
  
  body = BODY.new
  c = P.new.contentIs "Hello world!" 
  body.addChild c

  html.addChild head
  html.addChild body
  
  doc = DOCTYPE.new
  doc.addMember html
      
  doc.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
