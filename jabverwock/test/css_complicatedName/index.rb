require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
   
  def self.header
    head = HEAD.new
    head
  end
  
  def self.bodier
    body = BODY.new
    div = DIV.new
    div.css.name = "div.sample h2 ~ p"
    div.css.color "red"
    body.addChild div
    body
  end
  
  html= HTML.new  
  html.addChildren header, bodier
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
