require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  
  $SA = "sample7"

  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title
    head.tgStr
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
    body.tgStr
    
  end
  
  # def self.bodies
  #   body = BODY.new
  #   c = HEADING.new.contentIs "Hello #{$SA}! again"
  #   b = B.new.contentIs "this"
    
  #   base = " is test #{$BR} for you"
    
  #   str = b.tgStr + base
  #   cc = P.new.contentIs str
  #   cc2 = P.new.contentIs "this" + base
    
  #   h = HR.new
    
  #   body.addChildren [c,cc,h,cc2]
  #   body.tgStr
  # end
  
  html.addChildStrings [header,bodies]
  
  folder = "sample1"
  name = "sample7"
  html.testPress(folder, name)
  
end
