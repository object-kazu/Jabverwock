require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/global/press'  


module Jabverwock
  using StringExtension
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

    test "templeteString is nothing" do
      pr = Press.new
      pr.initResutString
      assert_equal(pr.resultString, "")
      
    end
    
    test "templeteString check" do
      pr = Press.new
      pr.templeteString = "this is test"
      pr.initResutString
      assert_equal(pr.resultString, "this is test")
      
    end
    
    test "insert data " do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable
      pr.initResutString
      pr.insertLabelData("a".varIs(",again"))
      p pr.resultString
      assert_equal(pr.resultString, "this is test" + $LABEL_INSERT_START + "a" + $LABEL_INSERT_END + ",again" )
    end

    test "error raise" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable
      pr.initResutString
      assert_raise(RuntimeError){
        pr.insertData("a")        
      }      
    end

    test "use correct class at insertData method" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable
      pr.initResutString
      i = "a".varIs ",again"
      pr.insertData(i)
      assert_equal(pr.resultString, "this is test" + $LABEL_INSERT_START + "a" + $LABEL_INSERT_END + ",again" )      
    end
    
    test "use correct class at insertDataArray" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable + "b".variable
      pr.initResutString
      i = "a".varIs ",again"
      i2 ="b".varIs ",again"
      
      pr.insertDataList(i,i2)
      
      ans1 = $LABEL_INSERT_START + "a" + $LABEL_INSERT_END + ",again"
      ans2 = $LABEL_INSERT_START + "b" + $LABEL_INSERT_END + ",again"
      
      assert_equal(pr.resultString, "this is test" + ans1 + ans2 )      
    end

    test "use incorrect class at insertDataArray" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable + "b".variable
      pr.initResutString
      i = "a".varIs ",again"
      i2 ="b".varIs ",again"
      assert_raise(RuntimeError){
        pr.insertDataList(i,i2,"dd")
      }
      
    end

    test "remove all lable" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable + "b".variable
      pr.initResutString
      i = "a".varIs ",again"
      i2 ="b".varIs ",again"
      pr.insertDataList(i,i2)
      pr.removeAllLabel
      assert_equal(pr.resultString, "this is test" + ",again" + ",again")      
      
    end


    test "remove all lable when no label string" do
      pr = Press.new
      pr.templeteString = "this is test"
      pr.initResutString
      pr.removeAllLabel # no lable string treat with method removeAllLabel
      assert_equal(pr.resultString, "this is test")      
      
    end

    
    test "export result" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable + "b".variable
      pr.initResutString
      i = "a".varIs ",again"
      i2 ="b".varIs ",again"
      pr.insertDataList(i,i2)
      pr.removeAllLabel
      pr.core
    end

    test "isExistHeadTag case false" do
      
      pr = Press.new
      pr.templeteString = "<p>this is test</p>"
      pr.initResutString
      assert_false(pr.isExistHeadTag)
      
    end

    test "isExistHeadTag case false 2" do
      
      pr = Press.new
      pr.templeteString = "<head>this is test</p>"
      pr.initResutString
      assert_false(pr.isExistHeadTag)
      
    end

    test "isExistHeadTag case false 3" do
      
      pr = Press.new
      pr.templeteString = "<p>this is test</head>"
      pr.initResutString
      assert_false(pr.isExistHeadTag)
      
    end

    test "isExistHeadTag case true" do
      
      pr = Press.new
      pr.templeteString = "<head>this is test</head>"
      pr.initResutString
      assert_true(pr.isExistHeadTag)
      
    end
    
    test "isExistHeadTag case true case 2" do
      
      pr = Press.new
      pr.templeteString = "<head id=\"test\">this is test</head>"
      pr.initResutString
      assert_true(pr.isExistHeadTag)
      
    end

    
  end
end
