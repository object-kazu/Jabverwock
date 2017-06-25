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

      ### JSFunction ####
      # h1 = HEADING.new.attr(:id__myBtn).contentIs "Click on this text!"
      # fmain = "alert(\"hello world\");"
      # func = "function(){#{fmain}}"
      # h1.js.doc.byID.addEventListener(click:"#{func}")
      
      # mf = "myFunc"
      # h1.js.doc.byID.addEventListener(click_:"#{mf}")
      # h1.js.func.define mf.to_sym,fmain
      
      ### out put ###
      # function myFunc(){
      #       alert("hello world");
      #       }

      
      div.jdoc.
      
      
      div.addChildren p1, p2
      body.addChild div
      body
    end
  end
  
  html = HTML.new
  html.addChild bodier
  
  doc = DOCTYPE.new
  doc.addMember html
  
  
  $SA = "sample_Js_13"
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
