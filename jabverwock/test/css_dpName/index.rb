require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension



  def self.header
    head = HEAD.new
    title = TITLE.new.contentIs "This is my first page"
    head.addChild title
    head
  end
  
  def self.bodier
    
    body = BODY.new    
    heading = HEADING.new(1).contentIs "This text is red"
    heading.attr(:id, "example1")
    body.addChild heading
    body
  end
  
  html= HTML.new.attr(:id__example2)
  c = CSS.new("#example1").color "blue"
  
  changed = CSS.new ""
  changed.name = c.dpName
  changed.color "red"
  html.addCss changed
  
  html.addChildren header, bodier
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
