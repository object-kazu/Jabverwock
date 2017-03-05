require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  $SA = "sample5"

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
    pp = P.new.contentIs "What is this? #{a.tgStr}"
    body.addChild pp
    body
  end
  
  
  html.addChild header
  html.addChild bodier


  EXPORT_TESTPRESS_Dir2 = "/Users/shimizukazuyuki/BitTorrent Sync/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/sample2/"

  n = $SA + "Pressed" + ".html"
  html.pressConfig(name: n, dist: EXPORT_TESTPRESS_Dir2)
  html.pressDefault

  
  
end
