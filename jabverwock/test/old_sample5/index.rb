require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  $SA = "sample5"
  $PAGES =  %w(home)
  
  def self.testPATH
    switch = false
    switch ? vPath1 = "/BitTorrent Sync" :  vPath1 = ""
    "/Users/shimizukazuyuki#{vPath1}/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/#{$SA}/"
  end
  
  html= HTML.new
  
  c = CSS.new(:id_example2)
  c.color "blue"
  html.addCss c

  def self.header
    head = HEAD.new
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end
  
  def self.bodier
    
    body = BODY.new    
    heading = HEADING.new(1).contentIs "This text is red"
    heading.attr(:id, "example1")
    heading.css.color("red")
    
    
    head2 = HEADING.new(2).contentIs "This text is blue"
    head2.attr(:id, "example2")
    
    # c = CSS.new(:id_example2)
    # c.color "blue"
    # head2.addCss c
    
    body.addChild heading
    body.addChild head2
    
    body
  end
  
  
  html.addChild header
  html.addChild bodier

  
  
  $PAGES.each do |pp|
    if pp == "home"
      pp = "index"
    end
    n = pp + "Pressed" + ".html"
    html.pressConfig(name: n, dist: testPATH)
    html.pressInsert("a".varIs"#{pp}")

  end

  
  
end
