require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  class << self
    
    def bodier
      body = BODY.new
      div = DIV.new.attr(:id__div1)
      
      ### JSFunction ####
      p1 = P.new.attr(:id__p1).contentIs "this is paragraph"
      p2 = P.new.attr(:id__p2).contentIs "this is another paragraph"

      
      div.js.doc.createElement(:p).is_var :para
      div.js.doc.createTextNode('This is new.'.sQuo).is_var :node
      div.js.doc.appendChild(:para, :node)
      

      div.js.doc.var(:element) do
        div.js.doc.byID.export
      end        
      div.js.doc.appendChild(:element, :para)
      
      
      body.addChild div
      body
    end

    
    
  end
  
  
  html = HTML.new
  html.addChild bodier
  
  doc = DOCTYPE.new
  doc.addMember html
  
  
  $SA = "sample_Js_11"
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
