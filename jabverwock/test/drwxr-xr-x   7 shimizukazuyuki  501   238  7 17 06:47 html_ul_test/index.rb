require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  def self.lists
    item = %w(item1 item2)
    item.inject([]){ |arr,i|
      t = LI.new.contentIs i
      arr << t      
    }    
  end
  
  def self.unOrderList
    ol = UL.new.attr(:type__circle)
    ol.addChildren lists
    ol
  end

  def self.bodier
    body = BODY.new
    body.addChild unOrderList
    body
  end
  
  html = HTML.new
  html.addChild bodier

  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff

  
end
