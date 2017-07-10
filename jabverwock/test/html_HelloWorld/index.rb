require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  html= HTML.new
  head = HEAD.new
  
  title = TITLE.new
  title.content = "This is my first page"
  head.addChild title
  
  body = BODY.new
  c = P.new.contentIs "Hello world!" 
  body.addChild c

  html.addChild head
  html.addChild body
  
  doc = DOCTYPE.new
  doc.addMember html
  

  $PAGES =  %w(home)
  
  def self.testPATH
    current = ENV['PWD']
    switch = false
    if current.include?("BitTorrent")
      switch = true
    end
    dirname = File.basename(Dir.getwd)
    switch ? vPath1 = "/BitTorrent Sync" :  vPath1 = ""
    "/Users/shimizukazuyuki#{vPath1}/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/#{dirname}/"
  end
  
  
  $PAGES.each do |pp|
    if pp == "home"
      pp = "index"
    end
    n = pp + "Pressed" + ".html"
    doc.pressConfig(name: n, dist: testPATH)
   
#    doc.pressInsert("a".varIs"#{pp}")
    doc.pressDefault
  end

end
