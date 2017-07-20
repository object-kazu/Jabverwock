require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  html= HTML.new  
  body = BODY.new

  def self.dtdd(title, desc)
    dt = DT.new.contentIs title
    dd = DD.new.contentIs desc    
    dt.addMember dd    
    dt
  end
  
  def self.dfList
    dl = DL.new
    d1 = self.dtdd("car", "car is car")
    d2 = self.dtdd("train", "train is train")
    d3 = self.dtdd("ship", "ship is ship")
    dl.addChildren d1, d2, d3
    dl
  end
  
  def self.bodier
    body = BODY.new
    body.addChild dfList
    body
  end
  
  html.addChild bodier
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
