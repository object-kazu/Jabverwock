require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/css'
require "../../lib/global/jw_CSS_JS"

module Jabverwock
  using StringExtension
  
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
      @jwjs.js = ["a"]
      assert_true(@jwjs.isJsAvailable)
    end
    
    test "isJsAvailable, false" do      
      assert_false(@jwjs.isJsAvailable)
    end

    

  end
end
