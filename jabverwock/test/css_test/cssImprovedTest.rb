require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/css'
require '../../lib/css/property'


module Jabverwock
  using StringExtension
  
  class CssImprovedTest < Test::Unit::TestCase
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
      #p "test".variable

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

    test "cssimproved first test, for print debug " do
      p CSS.new("s")
    end
    
    # test "set property" do
    #   @css.name = "head"
    #   assert_raise{
    #     @css.property.font_size = 10
    #   }

    # end

    
    # test "insert property class" do
    #   p = Property.new
    #   p.font_size = 10
    #   @css.name = "head"
    #   @css.property = p
    #   p @css.str
    #   assert_equal(@css.str, "head {\nfont-size: 10;\n}")
    # end

    # test "property default method, not chain" do
    #   p = Property.new
    #   p.font_size = 10
    #   p.color = "red"

    #   @css.name = "head"
    #   @css.property = p
    #   assert_equal(@css.str, "head {\ncolor: red;\nfont-size: 10;\n}")
    # end

    # test "property method chain" do
    #   p = Property.new
    #   # p.font_size = 10
    #   # p.color = "red"

    #   p.font_size("10").color("red")
      
    #   @css.name = "head"
    #   @css.property = p
    #   assert_equal(@css.str, "head {\ncolor: red;\nfont-size: 10;\n}")
    # end

    # test "property method chain" do
    #   p = Property.new

    #   p.font_size("10").color("red").font_style("bold")
      
    #   @css.name = "head"
    #   @css.property = p
    #   assert_equal(@css.str, "head {\ncolor: red;\nfont-size: 10;\nfont-style: bold;\n}")
    # end


    # test "css name define" do
    #   p = Property.new
    #   p.font_size("10").color("red").font_style("bold")
      
    #   c = CSS.new("head")
    #   c.property = p
    #   assert_equal(c.str, "head {\ncolor: red;\nfont-size: 10;\nfont-style: bold;\n}")
    # end
    
    
    # test "css name define, with chain method" do
    #   p = Property.new
    #   p.font_size("10").color("red").font_style("bold")
      
    #   c = CSS.new("head").addProperty(p)
    #   assert_equal(c.str, "head {\ncolor: red;\nfont-size: 10;\nfont-style: bold;\n}")
    # end

    
  end

end
