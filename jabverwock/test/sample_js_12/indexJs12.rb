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
      
      div.js.doc.var(:element) do
        div.js.doc.byID
      end
      
      div.jdoc.insertBefore "element", "para"
      
      # var title3Node = document.getElementById('div1');
      # var newNode = document.createElement('div');
      # var textNode = document.createTextNode('CSS');
      # newNode.appendChild(textNode);
      # newNode.id = 'title2';
      # title3Node.parentNode.insertBefore(newNode, title3Node);
      
      div.jdoc.var(:title3Node){ |t| t.byID}
      
      a = "createElement(:div).is_var :newNode"
      b = "createTextNode('CSS').is_var :textNode"
      c = "appendChild(:newNode, :textNode)"
      div.jdoc.selfy a,b,c

      div.jdoc.equal "newNode.id", "title2".sQuo
      div.jdoc.insertBefore "title3Node", "newNode"
      
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
