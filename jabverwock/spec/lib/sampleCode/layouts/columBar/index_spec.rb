require 'spec_helper'
require_relative '../../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/layouts/" 
  sampleName = "columBar/"

  
  RSpec.describe sampleName do


    
# @charset "Shift_JIS";

# /* --- 全体の背景・テキスト --- */
# body {
# margin: 0;
# padding: 0;
# background-color: #ffffff; /* ページの背景色 */
# color: #000000; /* 全体の文字色 */
# font-size: 100%; /* 全体の文字サイズ */
# }
    def cssBody
      c = CSS.new
      ha = { name: "body",
             margin: 0,
             background_color: "#ffffff",
             color: "#000000",
             font_size: "100%", #/* 全体の文字サイズ */
           }
      c.properties ha
      c
    end

# /* --- 全体のリンクテキスト --- */
# a:link { color: #0000ff; }
# a:visited { color: #800080; }
# a:hover { color: #ff0000; }
# a:active { color: #ff0000; }

    def cssA_array
      nameList = ["a:link", "a:visited","a:hover", "a:active" ]
      colorList = ["#0000ff", "#800080","#ff0000","#ff0000"]
      list = []
      
      nameList.each_with_index{ |s,i|
        c = CSS.new(s)
        c.color = colorList[i]
        list << c
      }

      list
    end

    
# /* --- コンテナ --- */
# #container {
# width: 780px; /* ページの幅 */
# margin: 0 auto; /* センタリング */
# background: url(sidebar_200.gif) repeat-y left; /* サイドバーの背景画像 */
# background-color: #ffffff; /* メインカラムの背景色 */
# border-left: 1px #c0c0c0 solid; /* 左の境界線 */
# border-right: 1px #c0c0c0 solid; /* 右の境界線 */
    # }

    
    def cssContainer
      c = CSS.new("container")
      c.width = "780px"
      c.margin = "0 auto"
      c
    end
    
    

# /* --- ヘッダ --- */
# #header {
# background-color: #ffe080; /* ヘッダの背景色 */
# }
    def cssHeader
      CSS.new("header").background_color("#ffe080")
    end

    
# /* --- ナビゲーション --- */
# #nav {
# float: left;
# width: 200px; /* サイドバーの幅 */
# }

    def cssNav
      c = CSS.new("nav")
      c.float = "left"
      c.width = "200px"
      c
    end
    
# /* --- メインカラム --- */
# #content {
# float: left;
# width: 580px; /* メインカラムの幅 */
    # }

    def cssContent
      c = cssNav
      c.name = "content"
      c
    end
   

# /* --- フッタ --- */
# #footer {
# clear: left; /* フロートのクリア */
# width: 100%;
# background-color: #ffe080; /* フッタの背景色 */
# }

    def cssFooter
      c = CSS.new "footer"
      c.clear = "left"
      c.background_color = "#ffe080"
      c
    end


    
    
    

    
    def makeHEAD
      h = JK.head
      m = JK.meta.attr(:http_equiv, "Content-Type").attr(:content, "text/html").attr(:charset, "Shift_JIS")
      l = JK.link.attr(:rel,"stylesheet").attr(:type,"text/css").attr(:href,"body.css")
      t = JK.title.contentIs"ページのタイトル"
      h.addChild m
      h.addChild l
      h.addChild t
      h.addCss cHeader
      h
    end
    
    def makeBody
      b = JK.body
      b.addCss cBody
      
      c = JK.comment.contentIs "コンテナ開始"
      e = JK.comment.contentIs "コンテナ終了"
      b.addChildren [c,divContainer,e]
      b
    end
    
    def divContainer
      c = JK.div.attr(:id__container)
      hs = JK.comment.contentIs "ヘッダ開始"
      he = JK.comment.contentIs "ヘッダ終了"
      cs = JK.comment.contentIs "コンテンツ開始"
      ce = JK.comment.contentIs "コンテンツ終了"
      
      h = JK.div.attr(:id__header)
      h.addChildString "[ヘッダ]"
      
      content = JK.div.attr(:id__contant)
      content.addChildString "[コンテンツ]"
      content.addCss cContent
      
      c.addChildren hs,h,he
      c.addChildren cs,content,ce
      c.addChildren divFooter
      c.addCss cContainer
      c
    end
    
    def divFooter
      
      fs = JK.comment.contentIs "フッタ開始"
      
      f = JK.div.attr(:id__footer)
      f.addChildString "[フッタ]"
      c = CSS.new("#example1").color "blue"
      f.addCss c 
      
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
      cAarray.each{ |s|
        doc.addCss s
      }


      
      # #print result
      doc.pressWithExport(name: 'indexPressed.html', dist: testFolderPath + sampleName, cssTo: "bodyPressed.css")
                            
      # show diff
      KSUtil.myDiff (testFolderPath + sampleName)
    end

    
  end
  
end
