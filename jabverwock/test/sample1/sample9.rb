require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  
  $SA = "sample9"

  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title
    head
  end

  def self.contents
    i1 = IMG.new.attr(:src ,"aaa")
    a1 = A.new.contentIs("test a is done #{i1.tgStr} ?").withBreak

    i2 = IMG.new.attr(:src ,"bbb")
    a2 = A.new.contentIs("test b is done #{i2.tgStr} !").withBreak

    [a1, a2]
  end
  
  def self.bodies
    body = BODY.new
    c = HEADING.new.contentIs "Hello #{$SA}!"
    
    arr = contents
    # arr.each do |a|
    #   body.addChild a
    # end
    body.addChildren arr
    body
  end
  
  html.addChildren header, bodies
  folder = "sample1"
  name = "sample9"
  html.testPress(folder, name)
  
end
