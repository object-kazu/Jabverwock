require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  
  # RSpec.describe 'sample1' do

    # b = JK.body.contentIs "body要素の内容は、ブラウザに表示されます。"
    # h = JK.html
    # h.addChild b
    # h.pressTo(name: 'indexPressed.html', dist: testFolderPath + "sample1/")
    
    
  #   # show diff
  #   KSUtil.myDiff (testFolderPath + "sample1/")
  # end
  
  RSpec.describe 'sample1, another method, use structure' do

    # b = JK.body.contentIs "body要素の内容は、ブラウザに表示されます。"
    # h = JK.html
    # ans = JWS.build [h[b]]

    # div2 = DIV.new
    # body = BODY.new
    # ans = JWS.buildToString [div2,[body]]

    # div3 = JK.div
    # h = JK.html
    # ans = JWS.buildToString [div3, [h]]
    # p ans

    div3 = JK.div
    h = JK.html
    ans = JWS.build [div3, [h]]
    ans.pressTo(name: 'indexPressed.html', dist: testFolderPath + "sample1/")

    # a = JW.new
    # a.templeteString =  "<p>test</p>"
    # p a.pressTo(name: 'indexPressed.html', dist: testFolderPath + "sample1/")
    
    # # show diff
    # KSUtil.myDiff (testFolderPath + "sample1/")
  end

  
  
end
  
