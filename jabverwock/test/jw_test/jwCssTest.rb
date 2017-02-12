require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/css'
require '../../lib/css/property'
require "../../lib/global/jwCSS"

module Jabverwock
  using StringExtension
  
  class JWCssTest < Test::Unit::TestCase
    class << self
      # テスト群の実行前に呼ばれる．変な初期化トリックがいらなくなる
      def startup
        p :_startup
      
      end

      # テスト群の実行後に呼ばれる
      def shutdown
        p :_shutdown
      end
    end

    # 毎回テスト実行前に呼ばれる
    def setup
      p :setup
     # p "test".variable
       @jwcss= JWCSS.new
    end

    # テストがpassedになっている場合に，テスト実行後に呼ばれる．テスト後の状態確認とかに使える
    def cleanup
      p :cleanup
    end

    # 毎回テスト実行後に呼ばれる
    def teardown
      p :treadown
    end

    ############## test ###############

    # test "jwCss first test, for print debug " do
    #   p @jwcss      
    # end

    test "confirm name" do
      assert_equal(@jwcss.name, "jwcss")

    end
    
    test "jwCss style with name test"do

      @jwcss.cssWithName("p")
      @jwcss.css.color = "red"
      assert_equal(@jwcss.css.str, "p {\ncolor: red;\n}")
      
    end

    test "jwCss css with chain"do

      @jwcss.cssWithName("p")
      @jwcss.css.color("red").font_size(10)
      assert_equal(@jwcss.css.str, "p {\ncolor: red;\nfont-size: 10;\n}")
      
    end
    
    test "jwCss style defualt name is class name "do
      @jwcss.css.color("red").font_size(10)
      assert_equal(@jwcss.css.str, "jwcss {\ncolor: red;\nfont-size: 10;\n}")
      
    end
    
    test "jwCss style with Property "do
      @jwcss.cssWithName("p")
      @jwcss.css.color("red").font_size(10)
      assert_equal(@jwcss.css.str, "p {\ncolor: red;\nfont-size: 10;\n}")
      
    end

    test "cssArray add css" do
      c = CSS.new("p")
      b = CSS.new("b")
      ca = [c,b]
      @jwcss.cssAssemble(c, ca)
      assert_equal(@jwcss.cssString, "")
      
    end

    test "isExistCssString" do
      c = CSS.new("p")
      ans = @jwcss.isExistCssString c.noNameStr
      assert_false ans
      
    end

     test "isExistCssString case" do
       ### true ### no style
       a = "p {\n\n}"
       ans = @jwcss.isExistCssString a
       assert_false ans
       
       a = "p"
       ans = @jwcss.isExistCssString a
       assert_false ans
      
       a = "jwcss {\n" + "\n" + "}"
       ans = @jwcss.isExistCssString a
       assert_false ans
              
       ### false ### with style
       a = "p {aaa}"
       ans = @jwcss.isExistCssString a
       assert_true ans
       
       a = "p {aa}"
       ans = @jwcss.isExistCssString a
       assert_true ans
       
       a = "p {\nfont-size: 10;\n}"
       ans = @jwcss.isExistCssString a
       assert_true ans
           
    end
    
    
    test "cssArray add css" do
      
      c = CSS.new("p").font_size(10)      
      b = CSS.new("b")
      ca = [c,b]
      @jwcss.cssAssemble(c, ca)
      assert_equal(@jwcss.cssString, "p {\nfont-size: 10;\n}\n")
      
    end

    test "cssArray add css" do      
      c = CSS.new("p").font_size("10")
      b = CSS.new("b").color("red")
      ca = [c,b]
      @jwcss.cssAssemble(c, ca)
      assert_equal(@jwcss.cssString, "p {\nfont-size: 10;\n}\nb {\ncolor: red;\n}\n")
      
    end
    
    test "isSameCSSName, same CSS do not use" do
      c = CSS.new("p").font_size(10)
      b = CSS.new("p").color("red")
      ca = [c,b]
      @jwcss.cssAssemble(c, ca)
      assert_equal(@jwcss.cssString, "p {\nfont-size: 10;\n}\n")
    end

    # test "applyCss" do
    #   p ">>> "
    #   c = CSS.new("p").addProperty(p)
    #   p @jwcss.applyCss(c,[])
      
    # end
    
    test "add member, do not use same name" do
      
      j1 = JWCSS.new
      j1.css.color("red").font_size(10)
      
      j2 = JWCSS.new
      j2.cssWithName("p")
      j2.css.font_style("bold")

      j1.addMember j2

      assert_equal(j1.showCssString, "jwcss {\ncolor: red;\nfont-size: 10;\n}\np {\nfont-style: bold;\n}")
      
    end
    
    test "add member,same name" do
      
      j1 = JWCSS.new
      j1.css.color("red").font_size(10)
      
      j2 = JWCSS.new
      j2.css.font_style("bold")

      j1.addMember j2

      assert_equal(j1.showCssString, "jwcss {\ncolor: red;\nfont-size: 10;\n}")
      
    end

    
    test "add members" do
      
      j1 = JWCSS.new
      j1.css.color("red")

      j2 = JWCSS.new
      j2.cssWithName("p")
      j2.css.font_style("bold")
      
      j3 = JWCSS.new
      j3.cssWithName("b")
      j3.css.font_size(10)
        
      j1.addMembers(j2, j3)
      
      assert_equal(j1.showCssString, "jwcss {\ncolor: red;\n}\np {\nfont-style: bold;\n}\nb {\nfont-size: 10;\n}")
    
      
    end

    
    
# //    func test_JW_css_addMember() {
# //        let jw = JWObject()
# //        let css = CSS(name: "jw")
# //        css.color.value = "red"
# //        css.opacity.value = "0.5"
# //        jw.style = css
# //        
# //        let jw2 = JWObject()
# //        let css2 = CSS(name: "jw2")
# //        css2.color.value = "blue"
# //        css2.opacity.value = "0.1"
# //        jw2.style = css2
# //        
# //        jw.addMember(member: jw2)
# //        
# //        XCTAssertEqual(jw.styleStr(), "jw {" + RET +
# //            "color: red;" + RET +
# //            "opacity: 0.5;" + RET +
# //            "}" + RET +
# //            "jw2 {" + RET +
# //            "color: blue;" + RET +
# //            "opacity: 0.1;" + RET +
# //            "}"
# //        )
# //    }

# //    func test_JW_css_addChild() {
# //        let jw = JWMulti()
# //        let css = CSS(name: "jw")
# //        css.color.value = "red"
# //        css.opacity.value = "0.5"
# //        jw.style = css
# //        
# //        let jw2 = JWObject()
# //        let css2 = CSS(name: "jw2")
# //        css2.color.value = "blue"
# //        css2.opacity.value = "0.1"
# //        jw2.style = css2
# //    
# //        jw.addChild(child: jw2)
# //        
# //        XCTAssertEqual(jw.styleStr(), "jw {" + RET +
# //            "color: red;" + RET +
# //            "opacity: 0.5;" + RET +
# //            "}" + RET +
# //            "jw2 {" + RET +
# //            "color: blue;" + RET +
# //            "opacity: 0.1;" + RET +
# //            "}"
# //        )
# //    }

# //    func test_JW_css_repeat() {
# //        let jw = JWObject()
# //        let css = CSS(name: "jw")
# //        css.color.value = "red"
# //        jw.style = css
# //        
# //
# //        let jw2 = JWObject()
# //        jw2.style = css
# //        
# //        jw.addMember(member: jw2)
# //        
# //        XCTAssertEqual(jw.styleStr(), "jw {" + RET + "color: red;" + RET + "}")
# //        
# //    }

# //    func test_myCSS (){
# //        let t = P(content: "test")
# //        let css = CSS(tag: t)
# //        css.color.value = "red"
# //        t.style = css
# //        XCTAssertEqual(t.styleStr(), "p {" + RET + "color: red;" + RET + "}")
# //
# //    }

# //    func test_css_no_id () {
# //        let t = P(content: "test")
# //        t.prepStyleByID()
# //        t.style.color.value = "red"
# //        
# //        // no id
# //        XCTAssertEqual(t.styleStr(), "")
# //
# //    }
# //    
# //    func test_css_id () {
# //        let t = P(content: "test")
# //        t.setID(id: "popo")
# //        t.prepStyleByID()
# //        t.style.color.value = "red"
# //        
# //        // no id
# //        XCTAssertEqual(t.styleStr(), "#popo {" + RET + "color: red;" + RET + "}")
# //        
# //    }


    
  end

end
