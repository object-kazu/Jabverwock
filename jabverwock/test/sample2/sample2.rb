require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  $SA = "sample2"

  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  def self.dtdd(title, desc)
    
    dt = DT.new.contentIs title
    dd = DD.new.contentIs desc
    
    dt.addMember dd
    
    dt
  end
  
  def self.bodier
    body = BODY.new

    d1 = self.dtdd("car", "car is car")
    d2 = self.dtdd("train", "train is train")
    d3 = self.dtdd("ship", "ship is ship")
    
    body.addChildren [d1,d2,d3]

    body
  end
  

  html.addChild header
  html.addChild bodier
  
  folder = "sample2"
  name = "sample2"
  html.testPress(folder, name)

  
  
end
