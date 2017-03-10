require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  $SA = "sample4"
  $PAGES =  %w(home)

  
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
    heading = HEADING.new(1).contentIs "Home page"
    heading.css.color("green")
    
    body.addChild heading
    
    body
  end
  
  
  html.addChild header
  html.addChild bodier

  # EXPORT_TESTPRESS_Dir3 = "/Users/shimizukazuyuki/BitTorrent Sync/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/sample4/"
    EXPORT_TESTPRESS_Dir3 = "/Users/shimizukazuyuki/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/sample4/"
  
  $PAGES.each do |pp|
    if pp == "home"
      pp = "index"
    end
    n = pp + "Pressed" + ".html"
    html.pressConfig(name: n, dist: EXPORT_TESTPRESS_Dir3)
    html.pressInsert("a".varIs"#{pp}")

  end

  
  
end
