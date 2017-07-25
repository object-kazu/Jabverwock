require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension


  
  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end
  
  def self.bodier
    body = BODY.new    
    
    heading = HEADING.new(1).contentIs "Home page"
    heading.css.color("green")

    heading2 = HEADING.new(2).attr(:id__test).contentIs "About page"
    heading2.css.color "blue"

    heading3 = HEADING.new(3).attr(:id__test, :cls__sample).contentIs "Contact page"
    heading3.css.color "white"
    
    body.addChildren heading, heading2, heading3
    
    body
  end
  
  html= HTML.new
  html.addChildren header, bodier

  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  
end
