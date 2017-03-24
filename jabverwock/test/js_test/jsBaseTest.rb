require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsObject'
require '../../lib/js/jsBase'
require '../../lib/js/jsDocument'

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  class JsObjectTest < Test::Unit::TestCase
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

    # test "jsBase first test, for print debug " do
    #   p js = JsBase.new()
     
    # end

    test "id" do
      js = JsBase.new
      assert_true js.isID("id")
    end
    test "id case 2" do
      js = JsBase.new
      assert_true js.isID("id_s")
    end
    test "id case 3" do
      js = JsBase.new
      assert_false js.isID("name")
    end
    
    test "cls" do
      js = JsBase.new
      assert_true js.isCls("cls")
    end
    test "cls case 2" do
      js = JsBase.new
      assert_true js.isCls("cls_s")
    end
    test "cls case 3" do
      js = JsBase.new
      assert_false js.isCls("name")
    end
    
    test "name" do
      js = JsBase.new
      assert_true js.isName("name")
    end
    test "name case 2" do
      js = JsBase.new
      assert_true js.isName("name_s")
    end
    test "name case 3" do
      js = JsBase.new
      assert_false js.isName("cls")
    end
    
    test"initialize case 1" do
      js = JsBase.new("id__sample")
      assert_equal js.id, "sample" 
    end
    
    test"initialize case 2" do
      js = JsBase.new(:id__sample)
      assert_equal js.id, "sample" 
    end
    test"initialize case 3" do
      js = JsBase.new(:attr__test)
      assert_equal js.id, "" 
    end

    

  end
end
