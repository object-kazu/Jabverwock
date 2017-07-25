require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
 

  html= HTML.new

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
    body.addChild orderList
    body
  end
  
  html.addChild bodier
  
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  
end
