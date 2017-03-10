require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  $SA = "sample"
  $PAGES =  %w(home about contact)

  
  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  def self.aList
    
    arr = []
    $PAGES.each do |a|
      tdash = a + ".html"
      t = A.new.contentIs(a).attr(:href, tdash).withBreak
      arr << t
    end
    arr
  end
  
  def self.bodier
    body = BODY.new    
    heading = HEADING.new(1).contentIs "a".variable
    
    body.addChild heading
    
    al = aList
    body.addChildren al
    
    body
  end
  
  
  html.addChild header
  html.addChild bodier

   EXPORT_TESTPRESS_Dir3 = "/Users/shimizukazuyuki/BitTorrent Sync/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/sample3/"
  # EXPORT_TESTPRESS_Dir3 = "/Users/shimizukazuyuki/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/sample3/"
  
  $PAGES.each do |pp|
    if pp == "home"
      pp = "index"
    end
    n = pp + "Pressed" + ".html"
    html.pressConfig(name: n, dist: EXPORT_TESTPRESS_Dir3)
    html.pressInsert("a".varIs"#{pp}")

  end

  
  
end
