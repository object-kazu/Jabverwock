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


      #create new node
      div.jdoc.createElement(:p).is_var :para
      div.jdoc.createTextNode('This is new.'.sQuo).is_var :node
      div.jdoc.appendChild(:para, :node)
      div.jdoc.byID.is_var :element
      div.jdoc.insertBefore "element", "para"
      div.jdoc.byID.is_var :title3Node
      
      div.jdoc.selfy { |t|
        t.createElement(:div).is_var :newNode
        t.createTextNode('CSS').is_var :textNode
        t.appendChild(:newNode, :textNode)
        t.equal "newNode.id", "title2".sQuo
        t.insertBefore "title3Node", "newNode"
      }

      div.addChildren p1, p2
      body.addChild div
      body
    end
  end
  
  html = HTML.new
  html.addChild bodier
  
  doc = DOCTYPE.new
  doc.addMember html
  
  
  $SA = "sample_Js_12"
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
