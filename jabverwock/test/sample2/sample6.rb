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
    l.each do |a|
      tdash = a.split(":")
      t = A.new.contentIs(tdash.last).attr(:href, a)
      arr << t
    end
    arr
  end
  
  def self.bodier
    body = BODY.new    
    al = aList

    body.addChildren al
    
    body
  end
  
  
  html.addChild header
  html.addChild bodier

  EXPORT_TESTPRESS_Dir2 = "/Users/shimizukazuyuki/BitTorrent Sync/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/sample2/"

  n = $SA + "Pressed" + ".html"
  html.pressConfig(name: n, dist: EXPORT_TESTPRESS_Dir2)
  html.pressDefault

  
  
end
