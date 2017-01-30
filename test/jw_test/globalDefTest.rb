require 'test/unit'
require_relative '../../global/globalDef'  

module Jabverwock
  class GlobaDefTest < Test::Unit::TestCase
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
    test "global?" do
      p $SPC + "good"
    end
    
    test "string extension inSingleQuo" do
      tm =  "a".inSingleQuo("bc")
      assert_equal(tm, "a'bc'")

    end

    test "string extension inSingleQuo fail" do
      tm =  "a".inSingleQuo(1)
      assert_equal(tm, nil)

    end

    test "string extension inDoubleQuot" do
      tm =  "a".inDoubleQuot("bc")
      assert_equal(tm, "a\"bc\"")

    end

    test "string extension inDoubleQuot fail" do
      tm =  "a".inDoubleQuot(1)
      assert_equal(tm, nil)

    end


    test"string extension inPara" do
      tm = "a".inParenth("bc")
      assert_equal(tm,"a('bc')")
    end
    
    test"string extension inPara fail" do
      tm = "a".inParenth(1)
      assert_equal(tm,nil)
    end

    #check_type
    test"check type case pass"do
      tm = "a"
      tm = KS.check_type(String,tm)
      assert_equal(tm,"a")
    end
       
    test "check type straing" do
      tm = "a"
      tm = KS.checkString(tm)
      assert_equal(tm ,"a")
    end

    #variable
    test "variable insert" do
      tm = "a".variable
      ans = $LABEL_INSERT_START + "a" + $LABEL_INSERT_END
      assert_equal(tm, ans)
    end

    test "callSelfCls" do
      tm = "d"
       assert_equal("String", KS.callSelfCls(tm))
    end

    test "removeLastRET" do
      tm = "dadfafadfa\nfdfafadfa\n"
      tm = KS.removeLastRET(tm)
      assert_equal(tm, "dadfafadfa\nfdfafadfa")

    end

    test "removeLastTAB" do
      tm = "dadfafadfa\tfdfafadfa\t"
      tm = KS.removeLastTAB(tm)
      assert_equal(tm, "dadfafadfa\tfdfafadfa")

    end

    test "removeHeadTAB" do
      tm = "\tdadfafadfa\tfdfafadfa\t"
      tm = KS.removeHeadTAB(tm)
      assert_equal(tm, "dadfafadfa\tfdfafadfa\t")

    end
    
    test "is_Bool" do
      assert_true(KS.is_bool(true))
      assert_false(KS.is_bool(1))
    end

    
  end

end
