require 'test/unit' 
require_relative '../../global/globalDef'  
require_relative '../../global/insertData'  

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
    
    
  end
end
