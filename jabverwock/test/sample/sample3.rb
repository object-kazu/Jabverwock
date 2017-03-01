require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  
  $SA = "sample3"

  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title
    head.tgStr
  end
  
  def self.bodies
    body = BODY.new
    c = HEADING.new.contentIs "Hello sample3! again" 
    body.addChild c
    body.tgStr
  end

   
  # html.addChildString header
  # html.addChildString bodies
  
  html.addChildStrings [header,bodies]
  html.testPress($SA) 
  
end
