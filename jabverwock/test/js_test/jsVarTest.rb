require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsObject'
require '../../lib/js/jsBase'
require '../../lib/js/jsDocument'
require '../../lib/js/jsVar'

require "../../lib/global/jwSingle"
require "../../lib/global/jwMulti"
require "../../lib/global/jwOneTag"
require "../../lib/global/jwTable"


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  class JsVarTest < Test::Unit::TestCase
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

    # test "jsVar first test, for print debug " do
    #   p js = JsVar.new()
     
    # end

    test "jsVar case 1" do
      v = JsVar.new.is :n, "koko"
      assert_equal v.record, "var n = koko"
    end
    
  end
end
