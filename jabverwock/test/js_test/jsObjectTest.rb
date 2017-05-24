require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsObject'
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
      @jso = JsObject.new
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

    # test "jsObject first test, for print debug " do
    #   p @jso
    # end

    ############## jsFunction ###############
    test "JsFunction " do
      @jso.func.define "test", "name", "age", "code is dead;"
      assert_equal @jso.orders[0], "function test(name, age){
      code is dead;
      }"
    end
    
    
    test "JsFunction use symbol" do
      @jso.func.define :test, :name, :age, "code is dead;"
      assert_equal @jso.orders[0], "function test(name, age){
      code is dead;
      }"
    end

    
    # ############## jsDocument ###############
    test "document confirm, correct id setting" do
      @jso.updateSelector :id__koko
      @jso.doc.byID.rec
      # a = @jso.doc.orders[0]
      a = @jso.doc.record
      assert_equal(a, "document.getElementById('koko');")
    end

    test "document confirm, correct id setting case 2" do
      jso = JsObject.new("id__koko","cls__opop","name__iii")
      jso.doc.byID.rec
      a = jso.doc.record
      assert_equal(a, "document.getElementById('koko');")
    end
    
    test "document confirm, correct id setting case 3" do
      @jso.updateSelector(:id__koko).doc.byID.rec
      
      a = @jso.doc.orders[0]      
      assert_equal(a, "document.getElementById('koko');")
    end
    
    test "document confirm, correct id setting case 4" do
      @jso.updateSelector(:id__koko).doc.byID.rec      
      assert_equal(@jso.doc.orders.count , 1)
    end

    test "jsObject extract from jsObject" do
      @jso.updateSelector(:id__koko).doc.byID.rec
      assert_equal(@jso.orders[0], "document.getElementById('koko');")
    end


  end
end
