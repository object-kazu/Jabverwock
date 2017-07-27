require 'test/unit'

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
  
  class HTML_cssTest < Test::Unit::TestCase
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

    # test "css html first test, for print debug " do
    #   # p CSS.new "t"
    #   # p HEAD.new

      
    # end

    test "set css property" do
      h = HEAD.new().contentIs "this is test"
      h.css.font_size = 10
      assert_equal(h.css.str, "head {\nfont-size: 10;\n}")
    end
    
    test "set css property case 2" do
      h = HEAD.new().contentIs "this is test"
      h.css.font_size("10")
      assert_equal(h.css.str, "head {\nfont-size: 10;\n}")
    end
    
    test "add css property not" do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c
      a = h.showCssString
      
      assert_equal(a, "head {\nfont-size: 10;\n}")
    end
    
    test "add css property , different name" do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "p"
      c.font_size = 10
      p c.str
      
      h.addCss c
      a = h.showCssString
      
      assert_equal(a, "p {\nfont-size: 10;\n}")
    end

    
    test "add css property" do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c

      pressed = h.tgStr
      
      assert_true(pressed.include?("<style>\n"))
      assert_true(pressed.include?("head {\nfont-size: 10;\n}\n"))
      assert_true(pressed.include?("</style>"))

    end

    
    test "add member " do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c

      body = BODY.new
      body.css.color "red"

      h.addMember body
      
      pressed = h.tgStr
      
      assert_true(pressed.include?("<style>\n"))
      assert_true(pressed.include?("head {\nfont-size: 10;\n}\n"))
      assert_true(pressed.include?("body {\ncolor: red;\n}\n"))
      assert_true(pressed.include?("</style>"))

    end
    
     test "css name override" do

       head = HEAD.new.attr(:id, "sample")
       c = CSS.new ".head"
       c.color "red"
       head.addCss c
         
      
      pressed = head.tgStr

      assert_true(pressed.include?("<style>\n"))
      assert_true(pressed.include?(".head {\ncolor: red;\n}\n"))
      assert_true(pressed.include?("</style>"))

    end


    
  end

end
