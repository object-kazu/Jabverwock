require 'test/unit'
require_relative '../../global/globalDef'  
require_relative '../../global/press'
require_relative '../../global/insertData'


module Jabverwock
  class PressTest < Test::Unit::TestCase
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
    test "test?" do
      p $SPC  
    end
    
    test "insert data " do
      pr = Press.new
      pr.resultString = "this is test" + "a".variable
      pr.insertLabelData(label:"a", data:",again")
      p pr.resultString
      assert_equal(pr.resultString, "this is test" + $LABEL_INSERT_START + "a" + $LABEL_INSERT_END + ",again" )
    end

    test "error raise" do
      pr = Press.new
      pr.resultString = "this is test" + "a".variable
      assert_raise(RuntimeError){
        pr.insertData("a")        
      }
      
    end

    test "use correct class at insertData method" do
      pr = Press.new
      pr.resultString = "this is test" + "a".variable
      i = InsertData.new(label:"a", data: ",again")
      pr.insertData(i)
      assert_equal(pr.resultString, "this is test" + $LABEL_INSERT_START + "a" + $LABEL_INSERT_END + ",again" )      
    end
    
    test "use correct class at insertDataArray" do
      pr = Press.new
      pr.resultString = "this is test" + "a".variable + "b".variable
      i = InsertData.new(label:"a", data: ",again")
      i2 = InsertData.new(label:"b", data: ",again")
      
      pr.insertDataList(i,i2)
      
      ans1 = $LABEL_INSERT_START + "a" + $LABEL_INSERT_END + ",again"
      ans2 = $LABEL_INSERT_START + "b" + $LABEL_INSERT_END + ",again"
      
      assert_equal(pr.resultString, "this is test" + ans1 + ans2 )      
    end

    
    
  end
end
