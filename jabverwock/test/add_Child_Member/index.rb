require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  doc = DOCTYPE.new
  html= HTML.new.contentIs "This is Member."
  doc.addMember html
  
  
  head = HEAD.new
  title = TITLE.new.contentIs "This is Child."
  head.addChild title
  
  
  doc.addMember head 
  doc.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
