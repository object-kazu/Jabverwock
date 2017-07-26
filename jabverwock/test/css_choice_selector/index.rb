require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
   
  def self.header
    head = HEAD.new
    head
  end
  
  def self.bodier
    body = BODY.new.attr(:id__ex1, :cls__ex2,)
    body.css.use :id
    body.css.color = "red"

    header = HEADING.new(1).attr(:id__head1, :cls__head2,)
    header.css.color "blue"
    body.addChild header
    body
  end
  
  html= HTML.new  
  html.addChildren header, bodier
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
