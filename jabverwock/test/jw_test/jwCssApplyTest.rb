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

    test "confirm name" do
      assert_equal(@jwcss.name, "jw_css")

    end
    
    # test "Style tag" do
    #   a = STYLE.new.contentIs "test"
    #   p a.tgStr

    #   assert_equal(a.tgStr , "<style>\ntest\n</style>")
    # end

    test "add css style tag case 1-1" do
      j1 = JW_CSS.new
      
      c = CSS.new ""
      c.font_size(10)
      
      j1.addCss c
      
      ans = "jw_css {\nfont-size: 10;\n}"

      assert_equal(j1.showCssString, ans)
        
    end
    
    

    
  end

end


__END__


    # test "add css style tag case 1-2" do
    #   j1 = JW_CSS.new
      
    #   c = CSS.new ""
    #   c.font_size(10)
      
    #   j1.addCss c
    #   s = j1.assembleTabedCss
    #   ss = j1.intoStyleTag s
      
      
    #   ans = "jw_css {\nfont-size: 10;\n}"

      
    #   styStart   = "<style>\n"
    #   styContent = "#{ans}\n"
    #   styEnd     = "</style>\n"
    #   styAns = styStart << styContent << styEnd
    #   assert_equal(ss, styAns)
      
    # end

    # test "add css style tag case 2-1" do
    #   j1 = JW_CSS.new
      
    #   c = CSS.new ""
    #   c.font_size(10).color("red")

    #   cc = CSS.new "p"
    #   cc.color("blue")
      
    #   j1.addCss c, cc
    #   s = j1.assembleTabedCss
      
    #   ans = "jw_css {\n\tcolor: red;\n\tfont-size: 10;\n}"
    #   ans2 = "\np {\n\tcolor: blue;\n}"
    #   ans3 = ans + ans2
    #   assert_equal(s.removeAllTab, ans3.removeAllTab)
            
    # end
    # test "add css style tag case 2-2" do
    #   j1 = JW_CSS.new
      
    #   c = CSS.new ""
    #   c.font_size(10).color("red")

    #   cc = CSS.new "p"
    #   cc.color("blue")
      
    #   j1.addCss c, cc
    #   s = j1.assembleTabedCss
    #   ss = j1.intoStyleTag s
      
    #   ans = "jw_css {\n\tcolor: red;\n\tfont-size: 10;\n}"
    #   ans2 = "p {\n\tcolor: blue;\n}"
      
    #   styStart   = "<style>\n"
    #   styContent = "\t#{ans}\n" + "\t#{ans2}\n"
    #   styEnd     = "</style>\n"
    #   styAns = styStart << styContent << styEnd
      
    #   assert_equal(ss.removeAllTab, styAns.removeAllTab)
      
    # end

    # test "add id" do
    #   j1 = JW_CSS.new
    #   j1.attr(:id, "sample")
    #   j1.css.font_size(10).color("red")
      
    #   cc = CSS.new "p"
    #   cc.color("blue")
      
    #   j1.addCss cc
    #   s = j1.assembleTabedCss
    #   ss = j1.intoStyleTag s
      
    #   ans = "jw_css #sample {\n\tcolor: red;\n\tfont-size: 10;\n}"
    #   ans2 = "p {\n\tcolor: blue;\n}"
      
    #   styStart   = "<style>\n"
    #   styContent = "\t#{ans}\n" + "\t#{ans2}\n"
    #   styEnd     = "</style>\n"
    #   styAns = styStart << styContent << styEnd

      
      
    #   assert_equal(ss.removeAllTab, styAns.removeAllTab)
      
    # end
