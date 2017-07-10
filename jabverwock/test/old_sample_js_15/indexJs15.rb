require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  class << self
    def bodier
      body = BODY.new
      div = DIV.new.attr(:id__div1)
      
      p1 = P.new.attr(:id__p1).contentIs "this is paragraph"
      p2 = P.new.attr(:id__p2).contentIs "this is another paragraph"

      div.jdoc.selfy { |t|
        t.createElement(:p).is_var :para
        t.createTextNode('This is new.'.sQuo).is_var :node
        t.appendChild :para, :node

        t.byID.is_var :parent
      }

      p1.jdoc.byID.is_var :child
      p1.jdoc.replaceChild :parent, :para, :child

      
      div.addChildren p1, p2
      body.addChild div
      body
    end
  end
  
  html = HTML.new
  html.addChild bodier
  
  doc = DOCTYPE.new
  doc.addMember html
  
  
  $SA = "sample_Js_15"
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
