require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  $SA = "sample6"
  $PAGES =  %w(home)
  
  def self.testPATH
    switch = true
    switch ? vPath1 = "/BitTorrent Sync" :  vPath1 = ""
    "/Users/shimizukazuyuki#{vPath1}/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/#{$SA}/"
  end
  
  html= HTML.new
  
  def self.header
    head = HEAD.new
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  def self.divReds
    heading = HEADING.new(1).contentIs "This text is red"
    heading.attr(:id, "example1")

    pp = P.new.contentIs "This text is yellow"
    
    d = DIV.new
    d.attr(:id, "reds")
    d.addChild heading
    d.addChild pp
    
    d
  end

  def self.divBlues
    head2 = HEADING.new(2).contentIs "This text is blue"
    head2.attr(:id, "example2")
    d = DIV.new
    d.attr(:id, "blues")
    d.addChild head2
    d
  end
  
  def self.bodier
    
    body = BODY.new    
    

    body.addChild divReds
    body.addChild divBlues

    c = CSS.new(:id_reds).color "red"
    cc = CSS.new(:id_blues).color "blue"
    ccc = c.dpName.addChildren("p").color("yellow")
    
    # another way 
    #ccc = CSS.new(:id_reds).addChildren("p").color("yellow")
    
    body.addCss c, cc, ccc
    
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
