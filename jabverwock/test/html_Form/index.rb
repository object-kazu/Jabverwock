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
      tt << s #+ "\n"
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

  css_nav = CSS.new "#nav"
  css_nav.border("1px solid black").background_color("green").height("50px").width("200px").margin("0px Auto")

  css_nav_ul = CSS.new "#nav ul"
  css_nav_ul.list_style_type :none
  
  css_nav_ul_li = CSS.new "#nav ul li"
  css_nav_ul_li.border("1px solid red").display(:inline).padding("3px")
  
  css_alink = CSS.new "#nav ul li a:link"
  css_alink.text_decoration(:none)

  css_avist = CSS.new "#nav ul li a:visited"
  css_avist.text_decoration(:none).color(:blue)

  css_hover = CSS.new "#nav ul li a:hover"
  css_hover.text_decoration(:none).font_weight(:bold)

  css_active = CSS.new "#nav ul li a:active"
  css_active.text_decoration(:none).color(:white)
  
  
  html.addCss css_nav, css_nav_ul, css_nav_ul_li, css_alink, css_avist, css_hover, css_active
  
  html.addChild header
  html.addChild bodier
  
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  
  

end
