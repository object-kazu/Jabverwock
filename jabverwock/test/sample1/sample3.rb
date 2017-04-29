require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  
 

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
  
  folder = "sample1"
  name = "sample3"
  html.testPress(folder, name)

  
end
