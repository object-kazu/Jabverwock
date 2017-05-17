require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  class << self
    
        
    
    def bodier
      body = BODY.new
      
      ### JSFunction ####
      h1 = HEADING.new.attr(:onclick,"changeText(this)").contentIs "Click on this text!"
      h1.js.func.define :changeText,:id, :name,"id.innerHTML = \"Ooops!\";"

      ### onchange attr ###
      input = INPUT.new.attr(:type__text, :id__frame, :onchange, "upperCase()")
      
      body.addChild h1
      body.addChild input
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
