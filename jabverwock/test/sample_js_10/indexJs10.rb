require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  class << self
    
    def bodier
      body = BODY.new
      
      ### JSFunction ####
      h1 = HEADING.new.attr(:id__id01).contentIs "My First Page"
      h1.js.doc.byID.firstChild
             
      
      title = TITLE.new.attr(:id__demo).contentIs "DOM Tutorial"
      tf = title.js.doc.byID.firstChild(:value).record
      
      pp = P.new.attr(:id__id02)
      pp.js.doc.byID.firstChild(:value).isVar(:myP)
      
      body.addChildren  title,pp
      body.js.var.is(:myHead, tf)
      body
    end

    
    
  end
  
  
  html = HTML.new
  html.addChild bodier
  
  doc = DOCTYPE.new
  doc.addMember html
  
  
  $SA = "sample_Js_10"
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
