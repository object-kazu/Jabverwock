require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  class << self
    
    

    
    def bodier
      body = BODY.new

      h1 = HEADING.new.attr(:id__id1).contentIs "My Heading 1"
      h1s = h1.js.doc.byID.style(color:"red").cutout
      
      btn = BUTTON.new.attr(:type__button, :onclick, h1s).contentIs "Click Me!"
      
      body.addChildren [h1, btn]
      body
    end

    
    
  end
  
  
  html = HTML.new
  
  html.addChild bodier

  # html.addMember header
  # html.addMember body
  
  
  $SA = "sample_Js_7"
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
