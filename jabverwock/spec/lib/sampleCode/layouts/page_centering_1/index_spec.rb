require 'spec_helper'
require_relative '../../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/layouts/" 
  sampleName = "page_centering_1/"


# /* --- 全体のリンクテキスト --- */
# a:link { color: #0000ff; }
# a:visited { color: #800080; }
# a:hover { color: #ff0000; }
# a:active { color: #ff0000; }

# /* --- コンテナ --- */
# #container {
# width: 780px; /* ページの幅 */
# margin: 0 auto; /* センタリング */
# }

# /* --- ヘッダ --- */
# #header {
# background-color: #ffe080; /* ヘッダの背景色 */
# }

# /* --- コンテンツ --- */
# #content {
# background-color: #ffffff; /* コンテンツの背景色 */
# }

  
  RSpec.describe sampleName do
    
    
    def makeHEAD
      h = JK.head
      m = JK.meta.attr(:http_equiv, "Content-Type").attr(:content, "text/html").attr(:charset, "Shift_JIS")
      l = JK.link.attr(:rel,"stylesheet").attr(:type,"text/css").attr(:href,"body.css")
      t = JK.title.contentIs"ページのタイトル"
      h.addChild m
      h.addChild l
      h.addChild t
      h
    end
    
# /* --- 全体の背景・テキスト --- */
# body {
# margin: 0;
# padding: 0;
# background-color: #f0f0f0; /* ページの背景色 */
# color: #000000; /* 全体の文字色 */
# font-size: 100%; /* 全体の文字サイズ */
# }
    def makeBody
      b = JK.body

      css = CSS.new
      css.margin = 0
      css.padding = 0
      b.addCss css
      
      c = JK.comment.contentIs "コンテナ開始"
      e = JK.comment.contentIs "コンテナ終了"
      b.addChildren [c,divContainer,e]
      b
    end
    
    def divContainer
      c = JK.div.attr(:id__container)
      c.css.background_color("cccccc")
      hs = JK.comment.contentIs "ヘッダ開始"
      he = JK.comment.contentIs "ヘッダ終了"
      cs = JK.comment.contentIs "コンテンツ開始"
      ce = JK.comment.contentIs "コンテンツ終了"
      
      h = JK.div.attr(:id__header)
      h.addChildString "[ヘッダ]"
      
      content = JK.div.attr(:id__contant)
      content.addChildString "[コンテンツ]"
      
      c.addChildren hs,h,he
      c.addChildren cs,content,ce
      c.addChildren divFooter
      c
    end
    
    def divFooter
      
      fs = JK.comment.contentIs "フッタ開始"
      
      f = JK.div.attr(:id__footer)
      f.addChildString "[フッタ]"
      c = CSS.new("#example1").color "blue"
      f.addCss c 
#      f.css.background_color("cccccc")
      
      fe = JK.comment.contentIs "フッタ終了"

      fs.addMembers(f,fe)
      fs
    end
    
    it "main description" do
     
      html = JK.html.attr(:lang, "ja")
      html.addChild makeHEAD
      html.addChild makeBody
      
      doc = JK.doctype
      doc.type = "HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\""
      doc.addMember html

      
      # #print result
      doc.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)
                   
      # show diff
      KSUtil.myDiff (testFolderPath + sampleName)
    end

    
  end
  
end
  
