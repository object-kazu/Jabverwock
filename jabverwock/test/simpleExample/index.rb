require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  doc = DOCTYPE.new

  n = "indexPressed.html"
  doc.pressConfig(name: n, dist: KSUtil.myPATH)   
  doc.press

end
