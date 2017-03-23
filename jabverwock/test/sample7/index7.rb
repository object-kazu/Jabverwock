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

  def self.makeTD(title, *attr)
    ti = TableData.new.contentIs title
    input = INPUT.new.attr(:type__text, :name__namae)
    
  end
  
  def self.divInputs
    table = TABLE.new
    
  end
	# <div id="inputs">
	#     <form method="POST" action="xxx.cgi">
	# 	<table>
	# 	    <tr>
	# 		<td>名前：</td>
	# 		<td><input type=text name="namae"></td>
	# 	    </tr>
	# 	    <tr>
	# 		<td>パスワード：</td>
	# 		<td><input type=password name="passwd"></td>
	# 	    </tr>
	# 	    <tr>
	# 		<td>転送ファイル：</td>
	# 		<td><input type=file name="tensou"></td>
	# 	    </tr>
	# 	    <tr>
	# 		<td>性別：</td>
	# 		<td>
	# 		    <input type=radio name="seibetsu" value="male" checked>男
	# 		    <input type=radio name="seibetsu" value="female">女
	# 		</td>
	# 	    </tr>
	# 	    <tr>
	# 		<td>趣味：</td>
	# 		<td>
	# 		    <input type=checkbox name="shumi" value="PC">パソコン
	# 		    <input type=checkbox name="shumi" value="SP">スポーツ
	# 		    <input type=checkbox name="shumi" value="RD">読書
	# 		</td>
	# 	    </tr>
	# 	    <tr>
	# 		<td></td>
	# 		<td>
	# 		    <input type=submit value=" 送信 ">
	# 		    <input type=reset value=" 取消 ">
	# 		</td>
	# 	    </tr>
	# 	</table>
	#     </form>	    
	# </div>
    
  # end
  
  def self.bodier
    
    body = BODY.new    
    
    body.addChild divNav
    body.addChild divSelections

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
