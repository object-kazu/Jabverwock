require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/global/tagAttribute'  
 
module Jabverwock
  using StringExtension
  class TagAttributeTest < Test::Unit::TestCase
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
    
    test "TagAttribute, path confirm " do
      tm = TagAttribute.new 
      tm.addLang("jp")

      assert_equal(tm.aString, "lang=\"jp\"")
      
    end  

    
  end
end
