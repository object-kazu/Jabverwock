require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/css'
require '../../lib/css/property'


module Jabverwock
  using StringExtension
  
  class CssTest < Test::Unit::TestCase
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
       @css= CSS.new "t"
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

    test "css first test, for print debug " do
      #p @css

      
    end
    
    test "set property" do
      @css.name = "head"
      @css.font_size = 10
      assert_raise{
        @css.gogo(1) # no property
      }
    end

    
    test "insert property class" do
      @css.name = "head"
      @css.font_size = 10
      assert_equal(@css.str,
                   "head {\nfont-size: 10;\n}")
    end

    test "property default method, not chain" do
      @css.name = "head"
      @css.font_size = 10
      @css.color = "red"
      assert_equal(@css.str, "head {\ncolor: red;\nfont-size: 10;\n}")
    end

    test "property method chain" do      
      @css.name = "head"
      @css.font_size("10").color("red")

      assert_equal(@css.str, "head {\ncolor: red;\nfont-size: 10;\n}")
    end

    test "property method chain case 2" do
      
      @css.name = "head"
      @css.font_size("10").color("red").font_style("bold")
      assert_equal(@css.str, "head {\ncolor: red;\nfont-size: 10;\nfont-style: bold;\n}")
    end


    test "css name define" do
      c = CSS.new("head")
      c.font_size("10").color("red").font_style("bold")
      assert_equal(c.str, "head {\ncolor: red;\nfont-size: 10;\nfont-style: bold;\n}")
    end
   
    
  end

end
