require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/css'
require "../../lib/global/jw_CSS_JS"
require "../../lib/js/jsObject"
require "../../lib/js/jsDocument"


module Jabverwock
  using StringExtension
  using ArrayExtension
  
  class JWCssJsTest < Test::Unit::TestCase
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
      @jwjs = JW_CSS_JS.new
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

    # test "jwCssJs first test, for print debug " do
    #   p @jwjs
    # end

    test "isJsArrayAvailable, true" do
      @jwjs.jsArray = ["a"]
      assert_true(@jwjs.isJsArrayAvailable)
    end
    
    test "isJsArrayAvailable, false" do      
      assert_false(@jwjs.isJsArrayAvailable)
    end
    
    test "jwcssjs test isJsArrayAvailable" do
      a = JsObject.new("","","")
      @jwjs.jsArray = [a]
      assert_true(@jwjs.isJsArrayAvailable)
    end

    test "dot" do
      assert_equal("a.a", "a".dot("a"))
    end

    test "js cmd end" do
      assert_equal("a" << $JS_CMD_END, "a;")
     
    end
    
    ##### doc ###########
    
    test "document write" do
      d = JsDocument.new
      a = d.write("a")
      assert_equal(a[0], "document.write('a');")
    end


    test "document write case 2" do
      d = JsDocument.new.write("a")
      assert_equal(d[0], "document.write('a');")
    end
    
    test "document write case 3" do
      a = @jwjs.js.doc.write "a"
      assert_equal(a[0], "document.write('a');")
    end
    
    test "document write case 4" do
      @jwjs.js.doc.write "a"
      ans = @jwjs.js.doc.jsStrings[0]
      assert_equal ans, "document.write('a');"
      
    end
    
    
    test "document write case 5" do
      @jwjs.js.doc.write "a"
      @jwjs.js.doc.write "bb"
      
      ans1 = @jwjs.js.doc.jsStrings[0]
      ans2 = @jwjs.js.doc.jsStrings[1]
      
      assert_equal ans1, "document.write('a');"
      assert_equal ans2, "document.write('bb');"
      
    end


  end
end
