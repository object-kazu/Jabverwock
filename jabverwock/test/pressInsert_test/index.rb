require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension


  
  def self.bodier
    body = BODY.new    

    p1 = P.new.contentIs "a".variable
    p2 = P.new.contentIs "b".variable
    
    body.addChildren p1,p2
    
    body
  end
  
  html = HTML.new
  html.addChild bodier

  html.pressConfig(name: 'indexPressed.html', dist: KSUtil.myPATH)
  html.pressInsert "a".varIs("test done"), "b".varIs( "test done again")

  
  # # show diff
  KSUtil.myDiff

  
end
