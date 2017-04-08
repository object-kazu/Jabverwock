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


    
    
    # ## Array extension ############
    test "append val" do
      a = [2,3,4]
      a.append 5
      assert_equal(a, [2,3,4,5])
    end
    
    test "append val case 2" do
      a = [2,3,4]
      a.append [5]
      assert_equal(a, [2,3,4,5])
    end

    test "appends vals" do
      a = [2,3,4]
      a.appends [5,6]
      assert_equal(a, [2,3,4,5,6])
    end
    
    test "appends vals case 2" do
      a = [2,3,4]
      a.appends [11,22], [33,33]
      assert_equal(a, [2,3,4,11,22,33,33])
    end
    
  end

end
