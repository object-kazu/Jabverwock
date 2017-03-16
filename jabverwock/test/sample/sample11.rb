require "./path"

### checking add member order ###

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  
  $SA = "sample11"

  
  html= HTML.new
  head = HEAD.new
  body = BODY.new

  #a,b,c
  # head.addMember body
  # html.addMember head
  
  # equal following code
  # heml.addMembers head, body


  #a{b},c
  #a.addChild b
  #a.addMember c
  html.addMember body
  html.addChild head
  
  html.testPress($SA) 
  
end
