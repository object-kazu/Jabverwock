require 'test/unit'
require '../../lib/global/globalDef'  

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  class GlobaDef_Hash_Test < Test::Unit::TestCase
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



    # ## Symbol extension ############
    test "first key" do      
      assert_equal KSHash::FIRST_KEY, :js1
    end

    test "seqHash" do
      assert_equal KSHash.seqHash("a",1), {:js1=>"a"}
    end

    test "first hash value" do
      a = {}
      a.update KSHash.seqHash("a",1)
      a.update KSHash.seqHash("b",2)
      a.update KSHash.seqHash("c",3)
      
      assert_equal KSHash.firstHashValue(a), "a"
      
    end

    test "last hash value"do
      a = {}
      a.update KSHash.seqHash("b",2)
      a.update KSHash.seqHash("a",1)
      a.update KSHash.seqHash("c",3)
      
      assert_equal KSHash.lastHashValue(a), "c"
      
    end
    

    test "hasValues" do
      a = {}
      a.update KSHash.seqHash("b",2)
      a.update KSHash.seqHash("a",1)
      a.update KSHash.seqHash("c",3)

      assert_equal KSHash.hashValues(a), ["b","a","c"]
    end
    
    test "compareKeys, case true" do
      
      assert_true KSHash.compareKeys :js22, :js2
    end
    
    test "compareKeys, case false" do
      assert_false KSHash.compareKeys :js1, :js22
    end

    test "remove Prefix" do
      txt = "#{$JS_UNITS_PREFIX}1"
      ans = KSHash.removePrefix txt

      assert_equal ans, 1
    end

    test "remove last hash" do
      a = {}
      a.update KSHash.seqHash("b",2)
      a.update KSHash.seqHash("a",1)
      a.update KSHash.seqHash("c",3)
      
      KSHash.removeLastHashValue(a)
      
      assert_equal KSHash.hashValues(a),["b","a"]
    end

  end

end
