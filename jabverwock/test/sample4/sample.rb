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

  def self.testPATH
    current = ENV['PWD']
    switch = false
    if current.include?("BitTorrent")
      switch = true
    end
    switch ? vPath1 = "/BitTorrent Sync" :  vPath1 = ""
    "/Users/shimizukazuyuki#{vPath1}/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/#{$SA}/"
  end
  
  $PAGES.each do |pp|
    if pp == "home"
      pp = "index"
    end
    n = pp + "Pressed" + ".html"
    html.pressConfig(name: n, dist: testPATH)
    html.pressInsert("a".varIs"#{pp}")

  end

  
  
end
