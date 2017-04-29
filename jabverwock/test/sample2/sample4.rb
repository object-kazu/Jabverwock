require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  $SA = "sample4"

  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  
  def self.bodier
    body = BODY.new
    a = A.new.contentIs("test").attr(:href,"www://")
    body.addChild a
    body
  end
  
  
  html.addChild header
  html.addChild bodier

  folder = "sample2"
  name = "sample4"
  html.testPress(folder, name)

  
end
