require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  class << self
    
        
    
    def bodier
      body = BODY.new
      
      ### JSFunction ####
      h1 = HEADING.new.attr(:id__myBtn).contentIs "Click on this text!"
      func = "function(){alert(\"hello world\");}"
      h1.js.doc.byID.addEventListener(click:"#{func}")
      
      mf = "myFunc"
      h1.js.doc.byID.addEventListener(click_:"#{mf}")
      h1.js.func.define mf.to_sym,"#{func}"
      
      body.addChild h1

      body
    end

    
    
  end
  
  
  html = HTML.new
  html.addChild bodier
  
  doc = DOCTYPE.new
  doc.addMember html
  
  
  $SA = "sample_Js_9"
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
    doc.pressConfig(name: n, dist: testPATH)
    doc.pressInsert("a".varIs"#{pp}")

  end

end
