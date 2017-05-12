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

    test "property method chain case 2" do
      
      @css.name = "head"
      @css.font_size("10").color("red").font_style("bold")
      assert_equal(@css.str, "head {\nfont-size: 10;\ncolor: red;\nfont-style: bold;\n}")

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

    test "css name symbole case use id" do
      c = CSS.new :id__head
      c.font_size("10").color("red").font_style("bold")
      assert_equal(c.str, "#head {\nfont-size: 10;\ncolor: red;\nfont-style: bold;\n}")
    end
    
    test "combineSelectors" do
      c = CSS.new("ss").addMembers "s","h"
      assert_equal(c.name, "ss,s,h")
    end
    
    test "combineSelectors, no name" do
      c = CSS.new("").addMembers "s","h"
      assert_equal(c.name, "s,h")
    end

    test "add child selector" do
      c = CSS.new("").addChildren "s", "h"
      assert_equal(c.name, "s h")
    end

    test "dup" do
      c = CSS.new(:id__reds)
      cc = c.dup
      ccc = cc.addChildren("p")

      assert_equal(c.name, "#reds")
      assert_equal(ccc.name, "#reds p")
    end

    test "dpName" do
      c = CSS.new(:id__reds)
      cc = c.dpName.addChildren "p"

      assert_equal(c.name, "#reds")
      assert_equal(cc.name, "#reds p")
    end

    test "dup css property" do
      c = CSS.new(:id__reds).color "red"
      cc = c.dpName.addChildren("p").color("yellow")

      assert_equal(c.str, "#reds {\ncolor: red;\n}")
      assert_equal(cc.str, "#reds p {\ncolor: yellow;\n}")
    end


    test "use case id"  do
      @css.name = "p id::#test cls::.sample"
      @css.use :id
      assert_equal @css.name, "#test"
      
    end

    test "use case cls"  do
      @css.name = "p id::#test cls::.sample"
      @css.use :cls
      assert_equal @css.name, ".sample"
      
    end

    test "use case id and cls"  do
      @css.name = "p id::#test cls::.sample"
      @css.use :cls, :id
      assert_equal @css.name, ".sample #test"
      
    end

    test "use case name"  do
      @css.name = "p id::#test cls::.sample"
      @css.use :name
      assert_equal @css.name, "p"
      
    end
    
    test "use case all-1"  do
      @css.name = "p id::#test cls::.sample"
      @css.use :name, :id, :cls
      assert_equal @css.name, "p #test .sample"
      
    end

    test "use case all-2"  do
      @css.name = "p id::#test cls::.sample"
      @css.use
      assert_equal @css.name, "p #test .sample"
      
    end

    test "no id use case name "  do
      @css.name = "p cls::.sample"
            
      @css.use :name
      assert_equal @css.name, "p"
      
    end
    
    test "no id use case id "  do
      @css.name = "p cls::.sample"
            
      @css.use :id
      assert_equal @css.name, ""
      
    end

    test "no id use case cls "  do
      @css.name = "p cls::.sample"
            
      @css.use :cls
      assert_equal @css.name, ".sample"
      
    end

    
    
  end

end
