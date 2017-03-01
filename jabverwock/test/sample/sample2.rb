require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  
  $SA = "sample2"
  
  html= HTML.new
  head = HEAD.new
  
  title = TITLE.new
  title.content = "This is my first page"
  head.addChild title
  
  body = BODY.new
  c = HEADING.new.contentIs "Hello world! again" 
  body.addChild c

  html.addChild head
  html.addChild body

  html.testPress($SA)
  
  
end