require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsObject'
require '../../lib/js/jsDocument'

module Jabverwock
  using StringExtension
  using ArrayExtension
  
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
      @jso = JsObject.new("","","")
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

    
    test "document confirm, correct id setting" do
      @jso.attrInit("koko","","")
      assert_equal(@jso.doc.byID, "document.getElementById('koko');")
    end

    test "document confirm, correct id setting case 2" do
      jso = JsObject.new("koko","opop","iii")
      assert_equal(jso.doc.byID, "document.getElementById('koko');")
    end
    
    test "document confirm, correct id setting case 3" do
      a = @jso.attrInit("koko","","").byID
      assert_equal(a, "document.getElementById('koko');")
    end
    

  end
end
