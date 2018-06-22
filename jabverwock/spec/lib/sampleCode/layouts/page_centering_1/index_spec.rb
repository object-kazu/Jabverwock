require 'spec_helper'
require_relative '../../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/layouts/" 
  sampleName = "page_centering_1/"

  
  RSpec.describe sampleName do

    def cHeader
      CSS.new("header").background_color("#ffe080")
    end
    def cContent
      CSS.new("content").background_color("#ffffff")
    end
    
    def cContainer
      c = CSS.new("container")
      c.width = "780px"
      c.margin = "0 auto"
      c
    end
    
    def cBody
      c = CSS.new
      ha = { name: "body",
             margin: 0,
             background_color: "#f0f0f0",
             color: "#000000",
             font_size: "100%", #/* 全体の文字サイズ */
           }
      c.properties ha
      c
    end

    def cAarray
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
      # doc.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)
      doc.pressWithExport(name: 'indexPressed.html', dist: testFolderPath + sampleName, cssTo: "body_ref.css")
                            
      # show diff
      KSUtil.myDiff (testFolderPath + sampleName)
    end

    
  end
  
end
