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
  
  def self.divSelections
    
    select = SELECT.new
    colors = %w(red blue white black)
    colors.each do |c|
      op = OPTION.new.attr(:value , "#{c}").contentIs "#{c.capitalize}"
      select.addChild op      
    end

    div = DIV.new.attr(:id__selctions)
    div.addChild select 
    div
  end

  def self.td (content)
    ti = TableData.new.contentIs content
    ti
  end

  def self.input (attrArr)
    input = INPUT.new.attrWithSymbolsArray attrArr
    input
  end
  
  def self.tRow(title, tdContents, *attrArr)
    t1 = td title
    
    tds = ""
    t2 = []
    attrArr.each_with_index do |a, index|
      c = tdContents[index]
      inp = input a
      unless c == ""
        inp.contentIs c
        t2 << inp.tgStr
      end            
    end
    
    # t2 = [con1, con2, ...]
    tt = ""
    t2.each do |s|
      tt << s + "\n"
    end
    tds = td(tt).tgStr

    tr = TableRow.new
    tr.addChild t1
    tr.addChildString tds
    tr
  end

  def self.form
    name = tRow "name", "", [:type__text, :name__namae]
    pswd = tRow "password", "", [:type__password, :name__passwd]
    fil  = tRow "files", "", [:type__file, :name__tensou]
    sex  = tRow "sex", ["male","female"], [:type__radio, :name__seibetu, :value__male], [:type__radio, :name__seibetu, :value__feMale]
    hoby = tRow "hoby",["pc", "sports","reading"], [:type__checkbox, :name__shumi,:value__PC],  [:type__checkbox, :name__shumi,:value__SP],
                [:type__checkbox, :name__shumi,:value__RD]
                
    send = tRow "", "", [:type__submit, :value__Send],  [:type__reset, :value__Cancel]
    
    table = TABLE.new
    table.addChildren [name, pswd, fil, sex,hoby,send]

    form = FORM.new.attr(:method__POST, :action, "xxx.cgi")
    form.addChild table
    form
    
  end
  
  def self.divInputs
    div = DIV.new.attr(:id__inputs)
    div.addChild form
    div
  end
  
    
  def self.bodier
    
    body = BODY.new    
    
    body.addChild divNav
    body.addChild divSelections
    body.addChild divInputs
        
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
