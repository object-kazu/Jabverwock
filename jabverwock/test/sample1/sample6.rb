require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  
  $SA = "sample6"

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
    c = HEADING.new.contentIs "Hello #{$SA}! again"
    cc = P.new.contentIs "this is test #{$BR} for you"
    h = HR.new
    body.addChildren [c,cc,h,cc]
    body.tgStr
  end
  
  html.addChildStrings [header,bodies]


  folder = "sample1"
  name = "sample6"
  html.testPress(folder, name)

  

  
end
