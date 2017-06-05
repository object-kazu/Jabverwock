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

    head
  end

  def self.aList
    l = %w(www:home www:about www:contact)
    arr = []
    arr << HEADING.new.contentIs("Home Page")
    l.each do |a|
      tdash = a.split(":")
      t = A.new.contentIs(tdash.last).attr(:href, a)
      arr << t
    end
    arr
  end
  
  def self.bodier
    body = BODY.new    
    
    aList.each do |a|
      body.addChild a
    end
    # body.addChildren al
    
    body
  end
  
  
  html.addChild header
  html.addChild bodier

  folder = "sample2"
  name = "sample6"
  html.testPress(folder, name)

  
  
end
