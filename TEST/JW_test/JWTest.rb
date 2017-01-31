require 'test/unit' 
require_relative '../../global/globalDef'  
require_relative '../../global/insertData'  
require_relative '../../global/jw'  

module Jabverwock
  class JwTest < Test::Unit::TestCase
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
    
    test "JW use InsertData as Struct " do
      a = InsertData.new(label:"ss", data: "aa")
      assert_equal(a.label, "ss")
      assert_equal(a.data, "aa")
      
    end


    test "JW,  isSingle method" do
      tm = JW.new
      ans = tm.isSingleTag(true)
      assert_equal(ans, true)
    end

    test "JW,  isSingle method nil" do
      tm = JW.new
      ans = tm.isSingleTag(1)
      assert_equal(ans, nil)
    end

    test "addHeadTab" do
      tm = JW.new
      target = "kkkk"
      ans = KString.addHeadTab(str: target, num:  3)
      assert_equal(ans, $TAB + $TAB + $TAB + "kkkk" )
    end

    test "addTab" do
      tm = JW.new
      target = "kkkk" + $RET + "aaa" + $RET
      ans = KString.addTab(str: target, tabMax: 2)
      assert_equal(ans, $TAB + $TAB + "kkkk" + $RET + $TAB + $TAB + "aaa" + $RET )
    end

    test "getTabNumbre" do
      tm = JW.new
      target = $TAB + $TAB + "kkkk" + $RET + $TAB + $TAB + "aaa" + $RET + $TAB + $TAB + $TAB + $TAB + "aaa" + $RET
      ans = KString.getTabMax(target)
      assert_equal(ans,4)
    end
    
  end
end
