require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  html= HTML.new  
  body = BODY.new
  
  i1 = IMG.new.attr(:src ,"aaa")
  a1 = A.new.contentIs("test a is done #{i1.tgStr} ?").withBreak

  i2 = IMG.new.attr :src__bbb
  
  i3 = IMG.new.attr(:id__test, :src__ccc)
  
  body.addChildren [a1, i2, i3]
  # body.addChildren a1, i2, i3
  html.addChild body
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
