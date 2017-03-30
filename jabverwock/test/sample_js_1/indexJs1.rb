require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  # class << self
    
    
  #   def header
  #     head = HEAD.new
  #     title = TITLE.new
  #     title.content = "Hello world"
  #     head.addChild title
      
  #     head.js.doc.write("hello world").rec
      
      
  #     head
  #   end

    
  #   def bodier
  #     body = BODY.new
  #     body.js.doc.write("next world").rec
      
  #     body
  #   end

    
    
  # end
  
  
  html = HTML.new

  header = HEAD.new
  header.js.doc.write("hello!").rec
  body = BODY.new
  body.js.doc.write("new world").rec
  
  # html.addChild header
  # html.addChild body

  html.addMember header
  html.addMember body
  
  
  $SA = "sample_Js_1"
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
