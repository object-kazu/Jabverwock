require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  $SA = "sample11"

  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  def self.dtdd

    ul = DT.new

    ul
  end
  
  def self.bodier
    body = BODY.new
    body.addChild oderList

    body
  end
  

  html.addChild header
  html.addChild bodier


  $EXPORT_TESTPRESS_Dir2 = "/Users/shimizukazuyuki/BitTorrent Sync/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/sample2/"

  n = $SA + "Pressed" + ".html" 
  html.press(name: n, dist:$EXPORT_TESTPRESS_Dir2)

  
  
end
