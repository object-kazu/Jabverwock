require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/css'
require "../../lib/global/jw_CSS"
require "../../lib/global/jwMulti"

module Jabverwock
  using StringExtension
  
  class JWCssApplyTest < Test::Unit::TestCase
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
       @jwcss= JW_CSS.new
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

    # test "confirm name" do
    #   assert_equal(@jwcss.name, "jw_css")

    # end
    
    # test "Style tag" do
    #   a = STYLE.new.contentIs "test"
    #   p a.tgStr

    #   assert_equal(a.tgStr , "<style>\n\ttest\n</style>")
    # end

    test "add css style tag case 1-1" do
      j1 = JW_CSS.new
      
      c = CSS.new ""
      c.font_size(10)
      
      j1.addCss c
      
      ans = "jw_css {\n\tfont-size: 10;\n}"

      assert_equal(j1.showCssString, ans)
      
      
    end
    
    test "add css style tag case 1-2" do
      j1 = JW_CSS.new
      
      c = CSS.new ""
      c.font_size(10)
      
      j1.addCss c
      
      ans = "jw_css {\n\tfont-size: 10;\n}"

      
      styStart   = "<style>\n"
      styContent = "\t#{ans}\n"
      styEnd     = "</style>\n"
      styAns = styStart << styContent << styEnd
      assert_equal(j1.applyCss, styAns)
      
    end

    test "add css style tag case 2-1" do
      j1 = JW_CSS.new
      
      c = CSS.new ""
      c.font_size(10).color("red")

      cc = CSS.new "p"
      cc.color("blue")
      
      j1.addCss c, cc
      
      ans = "jw_css {\n\tcolor: red;\n\tfont-size: 10;\n}"
      ans2 = "\np {\n\tcolor: blue;\n}"
      
      assert_equal(j1.showCssString, ans + ans2)
            
    end
    
    test "add css style tag case 2-2" do
      j1 = JW_CSS.new
      
      c = CSS.new ""
      c.font_size(10).color("red")

      cc = CSS.new "p"
      cc.color("blue")
      
      j1.addCss c, cc
      
      ans = "jw_css {\n\tcolor: red;\n\tfont-size: 10;\n}"
      ans2 = "p {\n\tcolor: blue;\n}"
      
      styStart   = "<style>\n"
      styContent = "\t#{ans}\n" + "\t#{ans2}\n"
      styEnd     = "</style>\n"
      styAns = styStart << styContent << styEnd
      
      assert_equal(j1.applyCss, styAns)
      
    end

    
  end

end
