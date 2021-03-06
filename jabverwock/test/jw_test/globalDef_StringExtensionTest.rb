require 'test/unit'
require '../../lib/global/globalDef'  

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
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


    
    ############## String Extension ###############
    
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
  end
end
 
     
