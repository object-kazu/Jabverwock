require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  $SA = "sample3"

  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  def self.itemList (item)
    arr = []
    unless item.is_a? Array
      l = LI.new.contentIs item
      arr.append l
      return arr
    end
    
    if item.count > 0
      item.each do |i|
        l = LI.new.contentIs i     
        arr.append l 
      end
    end

    arr
  end
  
  def self.mList(title, *items)
    lm = LI_multi.new.contentIs title
    ul = UL.new
    l1 = itemList items
    ul.addChildren l1
    lm.addChild ul
    lm    
  end
  
  def self.orderList()
    o = OL.new
    ml = mList("Food", "a","b","c")
    mm = mList("Toy","1","2","3")
    o.addChildren [ml, mm]
    o
  end
  
  def self.bodier
    body = BODY.new
    ol = orderList
    body.addChild ol
    body
  end
  
  
  html.addChild header
  html.addChild bodier


  $EXPORT_TESTPRESS_Dir2 = "/Users/shimizukazuyuki/BitTorrent Sync/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/sample2/"

  n = $SA + "Pressed" + ".html" 
  html.press(name: n, dist:$EXPORT_TESTPRESS_Dir2)

  
  
end
