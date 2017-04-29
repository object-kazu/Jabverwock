require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  $SA = "sample"

  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  def self.oderList

    ol = OL.new
    l1 = LI.new.contentIs "item1"
    l2 = LI.new.contentIs "item2"
    ol.addChildren [l1,l2]
    ol
  end
  
  def self.bodier
    body = BODY.new
    body.addChild oderList

    body
  end
  

  html.addChild header
  html.addChild bodier

  folder = "sample2"
  name = "sample"
  html.testPress(folder, name)

  
end
