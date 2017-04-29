require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  
  $SA = "sample71"

  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title
    head
  end

  def self.pContent

    b = B.new.contentIs "this"
    
    base = " is test #{$BR} for you"
    
    str = b.tgStr + base
    cc = P.new.contentIs str
    cc2 = P.new.contentIs "this" + base
    
    h = HR.new

    [cc, h, cc2]
    
  end
  
  def self.bodies
    body = BODY.new
    c = HEADING.new.contentIs "Hello #{$SA}! again"
    
    arr = self.pContent
    arr.unshift c
    
    body.addChildren arr
    body
  end
  
  html.addChildren [header,bodies]
  folder = "sample1"
  name = "sample71"
  html.testPress(folder, name)
  
end
