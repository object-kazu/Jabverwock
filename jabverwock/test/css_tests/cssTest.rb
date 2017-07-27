require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/css'

require '../../lib/global/globalDef'  
require '../../lib/global/jw'  
require "../../lib/global/jwMulti"
require "../../lib/global/jwOneTag"
require "../../lib/global/jwSingle"
require "../../lib/global/jwTable"
require "../../lib/global/jw_CSS"
require "../../lib/global/jw_CSS_JS"
require "../../lib/global/press"


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

    # test "css first test, for print debug " do
    #   #p @css

      
    # end
    
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
      assert_equal(@css.str, "head {\nfont-size: 10;\ncolor: red;\n}")
    end

    test "property method chain" do      
      @css.name = "head"
      @css.font_size("10").color("red")

      assert_equal(@css.str, "head {\nfont-size: 10;\ncolor: red;\n}")
    end

    test "name divide by space" do
      
      @css.name = "head .cls"
      @css.font_size("10").color("red").font_style("bold")
      assert_equal(@css.str, "head .cls {\nfont-size: 10;\ncolor: red;\nfont-style: bold;\n}")

    end

    test "css name define" do
      c = CSS.new("head")
      c.font_size("10").color("red").font_style("bold")
      assert_equal(c.str, "head {\nfont-size: 10;\ncolor: red;\nfont-style: bold;\n}")
    end

    test "css name symbole case 1" do
      c = CSS.new :head
      c.font_size("10").color("red").font_style("bold")
      assert_equal(c.str, "head {\nfont-size: 10;\ncolor: red;\nfont-style: bold;\n}")
    end

    test "combineSelectors" do
      c = CSS.new "ss,s,h"
      assert_equal(c.name, "ss,s,h")
    end
    

    # # dpName, addChildrenName, addMembersName
    
    test 'dpName' do
      c = CSS.new :head
      c2 = c.dpName
      assert_equal c2, "head"
    end

    test 'dpName import' do
      c = CSS.new :head
      c2 = CSS.new c.dpName
      assert_equal c2.name, 'head'
    end
    
    test "dup and addChildren" do
      c = CSS.new :head
      c2 = CSS.new c.dpName
      ccc = c2.addChildrenName "p"

      assert_equal(c.name, "head")
      assert_equal(ccc.name, "head p")
    end

    test "dup and addMembers" do
      c = CSS.new :head
      c2 = CSS.new c.dpName
      ccc = c2.addMembersName "p"

      assert_equal(c.name, "head")
      assert_equal(ccc.name, "head, p")
    end

    test "dpName and css property" do
      c = CSS.new(:head).color "red"
      c2 = CSS.new c.dpName
      c2.addChildrenName("p").color("yellow")

      assert_equal(c.str, "head {\ncolor: red;\n}")
      assert_equal(c2.str, "head p {\ncolor: yellow;\n}")
    end




    
  end

end
