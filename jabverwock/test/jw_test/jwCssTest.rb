require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/css'
require "../../lib/global/jw_CSS"
require "../../lib/global/jwMulti"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
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
    
    test "jwCss style with name test"do

      @jwcss.cssWithName("p")
      @jwcss.css.color = "red"
      assert_equal(@jwcss.css.str, "p {\ncolor: red;\n}")
      
    end

    test "jwCss style, symbole allow use"do

      @jwcss.cssWithName :p
      @jwcss.css.color = :red
      assert_equal(@jwcss.css.str, "p {\ncolor: red;\n}")
      
    end

    
    test "jwCss css with chain"do

      @jwcss.cssWithName("p")
      @jwcss.css.color("red").font_size(10)
      assert_equal(@jwcss.css.str, "p {\nfont-size: 10;\ncolor: red;\n}")
      
    end

    test "jwCss css with chain use symbol"do

      @jwcss.cssWithName :p
      @jwcss.css.color(:red).font_size(10)
      assert_equal(@jwcss.css.str, "p {\nfont-size: 10;\ncolor: red;\n}")
      
    end

    
    test "jwCss style defualt name is class name "do
      @jwcss.css.color("red").font_size(10)
      assert_equal(@jwcss.css.str, "jw_css {\nfont-size: 10;\ncolor: red;\n}")
      
    end
    
    test "jwCss style with Property "do
      @jwcss.cssWithName("p")
      @jwcss.css.color("red").font_size(10)
      assert_equal(@jwcss.css.str, "p {\nfont-size: 10;\ncolor: red;\n}")
      
    end

    test "cssArray add css case 2" do
      c = CSS.new("p")
      b = CSS.new("b")
      ca = [c,b]
      @jwcss.cssAssemble(c, ca)
      assert_equal(@jwcss.cssString, "")
      
    end

    test "isExistCssString" do
      c = CSS.new("p")
      ans = KString.isExistCssString c.removeNameFlags
      assert_false ans
      
    end

    test "isExistCssString case" do 
       ### true ### no style
       a = "p {\n\n}"
       ans = KString.isExistCssString a
       assert_false ans
       
       a = "p"
       ans = KString.isExistCssString a
       assert_false ans
      
       a = "jw_css {\n" + "\n" + "}"
       ans = KString.isExistCssString a
       assert_false ans
              
       ### false ### with style
       a = "p {aaa}"
       ans = KString.isExistCssString a
       assert_true ans
       
       a = "p {aa}"
       ans = KString.isExistCssString a
       assert_true ans
       
       a = "p {\nfont-size: 10;\n}"
       ans = KString.isExistCssString a
       assert_true ans
            
    end    
    
    test "cssArray add css" do
      
      c = CSS.new("p").font_size(10)      
      b = CSS.new("b")
      ca = [c,b]
      @jwcss.cssAssemble(c, ca)
      assert_equal(@jwcss.cssString, "p {\nfont-size: 10;\n}\n")
      
    end

    test "cssArray add css case 3" do      
      c = CSS.new(:p).font_size(10)
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
    
    test "add member, do not use same name" do
      
      j1 = JW_CSS.new
      j1.css.color("red").font_size(10)
      
      j2 = JW_CSS.new
      j2.cssWithName("p")
      j2.css.font_style("bold")

      j1.addMember j2
     
      assert_equal(j1.showCssString, "jw_css {\nfont-size: 10;\ncolor: red;\n}\np {\nfont-style: bold;\n}")
      
    end
    
    test "add member,same name" do
      
      j1 = JW_CSS.new
      j1.css.color(:red).font_size(10)
      
      j2 = JW_CSS.new
      j2.css.font_style(:bold)

      j1.addMember j2

      assert_equal(j1.showCssString, "jw_css {\nfont-size: 10;\ncolor: red;\n}")
      
    end


    
    test "add members" do
      
      j1 = JW_CSS.new
      j1.css.color("red")

      j2 = JW_CSS.new
      j2.cssWithName("p")
      j2.css.font_style("bold")
      
      j3 = JW_CSS.new
      j3.cssWithName("b")
      j3.css.font_size(10)
        
      j1.addMembers(j2, j3)
      
      assert_equal(j1.showCssString, "jw_css {\ncolor: red;\n}\np {\nfont-style: bold;\n}\nb {\nfont-size: 10;\n}")
          
    end

    test "add css, caution!, because jw class and css class sometimes has different name" do
      j1 = JW_CSS.new
      
      c = CSS.new "t"
      c.font_size(10)
      
      j1.addCss c

      assert_equal(j1.showCssString, "t {\nfont-size: 10;\n}")
    end
        
    test "add css, when set css name void, name is same as class" do
      j1 = JW_CSS.new
      
      c = CSS.new ""
      c.font_size(10)
      
      j1.addCss c

      assert_equal(j1.showCssString, "jw_css {\nfont-size: 10;\n}")
    end


    test "export css style case true" do
      j = JW_CSS.new
      h = HEAD.new.contentIs "headsss"
            
      j.addMember h
      
      c = CSS.new ""
      c.font_size(10)
      
      j.addCss c
      assert_true(j.tgStr.include?("style"))
      
    end

    test "export css style case2 true" do
      j = JW_CSS.new
      h = HEAD.new.contentIs "headsss"
      
      c = CSS.new ""
      c.font_size(10)      
      h.addCss c
      
      j.addMember h
      assert_true(j.tgStr.include?("style"))
      
    end
    
    test "export css style case3 true" do
      j = JW_CSS.new
      
      h = HEAD.new.contentIs "headsss"
      h.css.font_size 10
      j.addMember h
      
      assert_true(j.tgStr.include?("style"))
      
    end
    
    test "export css style case false" do
      j = JW_CSS.new
      pp = JW_CSS.new
      j.addMember pp
      
      c = CSS.new ""
      c.font_size(10)
      
      j.addCss c      
      assert_false(j.tgStr.include?("style"))
      
    end

    

    
  end

end
