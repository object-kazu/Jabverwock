require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  class << self
    
    
    def header
      header = HEAD.new
    end
    
    
    def bodier
      body = BODY.new

      div = DIV.new.attr(:id__container)
      divin = DIV.new.attr(:id__animate).contentIs "My animate will go here"
      
      #case 1
      # c = CSS.new "#container"
      # c.width("100px").height("100px").position("100px").background("red")
      # div.addCss c
      
      #case 2
      # c = CSS.new :id__container
      # c.width("100px").height("100px").position("100px").background("red")
      # div.addCss c

      #case 3
      # div.css.use(:id).width("100px")
      
      # #case 4
      # c = CSS.new
      # c.width("100px").height("100px").position("100px").background("red")
      # div.addCssUse(:id) c

      
      div.addChild divin
      body.addChild div
      body
    end

    
    
  end
  
  
  html = HTML.new
  
  html.addChild header
  html.addChild bodier

  # html.addMember header
  # html.addMember body
  
  
  $SA = "sample_Js_8"
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
