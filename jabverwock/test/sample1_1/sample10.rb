require "./path"

### checking add member order ###

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  
  $SA = "sample10"

  
  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title
    head
  end
  
  def self.iTable
    t = JWTable.new.attr(:border, "1px")
    t.addRows ["row1 cell1", "row1 cell2" ]
    t.addRows ["row2 cell1", "row2 cell2" ]
    t.addRows ["row3 cell1", "row3 cell2" ]
    t
  end
  
  def self.bodies
    body = BODY.new
    c = HEADING.new.contentIs "Hello #{$SA}!"
    t = iTable
    body.addChildren [c,t]
    body
  end
  
  html.addChildren [header,bodies]
  folder = "sample1_1"
  name = "sample10"
  html.testPress(folder, name)
  
end
