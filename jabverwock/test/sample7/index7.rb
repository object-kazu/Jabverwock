require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  
  def self.header
    head = HEAD.new
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  def self.divNav
    ul = UL.new
    list = %w(index contact adress)
    for i in list
      a = A.new.attr(:href, i).contentIs"#{i.capitalize}"      
      l = LI.new.contentIs a.tgStr
      ul.addChild l
    end
    
    d = DIV.new
    d.attr(:id, "nav")
    d.addChild ul
    
    d
  end

  # def self.divSelections
  #   head2 = HEADING.new(2).contentIs "This text is blue"
  #   head2.attr(:id, "example2")
  #   d = DIV.new
  #   d.attr(:id, "blues")
  #   d.addChild head2
  #   d
  # end

  # def self.divInputs

    
  # end
  
  def self.bodier
    
    body = BODY.new    
    
    body.addChild divNav

    # c = CSS.new(:id_reds).color "red"
    # cc = CSS.new(:id_blues).color "blue"
    # ccc = c.dpName.addChildren("p").color("yellow")    
    # body.addCss c, cc, ccc
    
    body
  end

  
  
  html = HTML.new
  html.addChild header
  html.addChild bodier
  
  
  
  $SA = "sample7"
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
