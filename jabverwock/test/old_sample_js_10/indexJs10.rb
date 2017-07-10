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
      hv =  h1.js.doc.byID.firstChild(:value).cut
      h1.js.doc.byID.firstChild(:value).is_var(:myHead)
      
      title = TITLE.new.attr(:id__demo).contentIs "DOM Tutorial"
      title.js.doc.byID.childNodes(0,:value).is_var(:myTitle)
      
      pp = P.new.attr(:id__id02)
      pp.js.doc.byID.innerHTML(hv)
      body.addChildren h1,title,pp
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
