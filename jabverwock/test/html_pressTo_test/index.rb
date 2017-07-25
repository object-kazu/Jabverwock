require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension

  def self.bodier
    body = BODY.new
    a = A.new.contentIs("test").attr(:href,"www://")
    body.addChild a
    body
  end
  
  html = HTML.new
  html.addChild bodier

  html.pressConfig(name: 'indexPressed.html', dist: KSUtil.myPATH)
  html.press
  
  # html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff

  
end
