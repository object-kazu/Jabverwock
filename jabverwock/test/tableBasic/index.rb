require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
    
  def self.iTable
    t = JWTable.new.attr(:border, "1px")
    t.addRows ["row1 cell1", "row1 cell2" ]
    t.addRows ["row2 cell1", "row2 cell2" ]
    t.addRows ["row3 cell1", "row3 cell2" ]
    t
  end
  
  def self.bodies
    body = BODY.new
    c = HEADING.new.contentIs "Hello table"
    body.addChildren c, iTable
    body
  end

  html= HTML.new
  html.addChild bodies
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
