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
    
    test "jwCss style with name test"do

      @jwcss.styleWithName("p")
      @jwcss.style.property.color = "red"
      assert_equal(@jwcss.style.str, "p {\ncolor: red;\n}")
      
    end

    test "jwCss style with chain"do

      @jwcss.styleWithName("p")
      @jwcss.style.property.color("red").font_size(10)
      assert_equal(@jwcss.style.str, "p {\ncolor: red;\nfont-size: 10;\n}")
      
    end
    
    test "jwCss style defualt name is class name "do

      p = Property.new.color("red").font_size(10)
      @jwcss.styleWithProperty p
      assert_equal(@jwcss.style.str, "jwcss {\ncolor: red;\nfont-size: 10;\n}")
      
    end

    
    test "jwCss style with Property "do

      @jwcss.styleWithName("p")

      p = Property.new.color("red").font_size(10)
      @jwcss.styleWithProperty p
      assert_equal(@jwcss.style.str, "p {\ncolor: red;\nfont-size: 10;\n}")
      
    end


    
    # test "add member" do
      
    #   j1 = JWCSS.new
    #   #j1.styleWithName "j1"
    #   p1 = Property.new.color("red").font_size(10)
    #   j1.styleWithProperty p1
      
    #   j2 = JWCSS.new
    #   j2.styleWithName "j2"
    #   p2 = Property.new.color("blue").font_size(20)
    #   j2.styleWithProperty p2

    #   j1.addMember j2

    #   assert_equal(j1.style.str, "j1 {\ncolor: red;\nfont-size: 10;\n}")
    
      
    # end
    
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
