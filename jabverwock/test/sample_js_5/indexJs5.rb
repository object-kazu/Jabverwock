require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  class << self
    
    
    def header
      head = HEAD.new
      title = TITLE.new
      title.content = "Hello world"
      head.addChild title
      
      head
    end

    
    def bodier
      body = BODY.new

      # img = IMG.new.attr(:id__MyImage, :src, "simple.gif")
      img = IMG.new.attr(:id,"MyImage").attr(:src, "simple.gif")
      # img = IMG.new.attr(:id__MyImage).attr(:src, "simple.gif")
      img.js.doc.byID.src("landscape.jpg").rec
      
      body.addChild img
      body
    end

    
    
  end
  
  
  html = HTML.new
  
  html.addChild header
  html.addChild bodier

  # html.addMember header
  # html.addMember body
  
  
  $SA = "sample_Js_5"
  $PAGES =  %w(home)
  
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
