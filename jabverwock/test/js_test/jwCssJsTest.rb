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

    test "isJsAvailable, true" do
      @jwjs.jsObjects = ["a"]
      assert_true(@jwjs.isJsAvailable)
    end
    
    test "isJsAvailable, false" do      
      assert_false(@jwjs.isJsAvailable)
    end
    
    test "jwcssjs test writing" do
      a = JsObject.new
      @jwjs.jsObjects =[a]
      assert_true(@jwjs.isJsAvailable)
    end

    test "dot" do
      assert_equal("a.a", "a".dot("a"))
    end

    test "js cmd end" do
      assert_equal("a" << $JS_CMD_END, "a;")
     
    end

    test "document write" do
      d = JsDocument.new
      assert_equal(d.write("a"), "document.write('a');")
    end

    test "document write case 2" do
      d = JsDocument.new.write("a")
      assert_equal(d, "document.write('a');")
    end


  end
end
