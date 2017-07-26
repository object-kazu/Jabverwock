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
    heading = HEADING.new(1).contentIs "This text is addMembers"
    heading.attr(:id, "example1")

    ## css selector -> addMembers
    c1 = CSS.new("ss").addMembers "tt","gg"
    c1.color "red"
    heading.addCss c1
    
    head2 = HEADING.new(2).contentIs "This text is addChildren"
    head2.attr(:id, "example2")

    ## css selector -> addChildren
    c2 = CSS.new("").addChildren "tt", "gg"
    c2.color "blue"
    head2.addCss c2
    
    body.addChildren heading, head2    
    body
  end
  
  html= HTML.new  
  html.addChildren header, bodier
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
