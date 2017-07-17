require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  # def self.orderList
  #   ol = OL.new
  #   l1 = LI.new.contentIs "item1"
  #   l2 = LI.new.contentIs "item2"
  #   ol.addChildren l1,l2
  #   ol
  # end

  def self.orderedList
    item = %w(item1 item2)
    item.inject([]){ |arr,i|
      t = OL.new.contentIs i
      arr << t      
    }
  end
  
  def self.bodier
    body = BODY.new
    body.addChildren orderedList
    body
  end
  
  html = HTML.new
  html.addChild bodier

  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff

  
end
