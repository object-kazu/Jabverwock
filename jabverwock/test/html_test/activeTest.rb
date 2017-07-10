require 'test/unit' 

#gem uninstall version
require "../../lib/global/globalDef"
require "../../lib/global/jwTable"


module Jabverwock
  using StringExtension
  
  class TableTest < Test::Unit::TestCase
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
#      @table = JWTable.new
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
    
#     ## table ##
    # test "table" do
    #   t = JWTable.new

    #   assert_equal(t.pressDefault, "<table>\n</table>")
    # end

    test "add header"do
      t = JWTable.new
      t.caption "test"
      t.headerList = ["name","address","tel"]
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      lend="</table>"

      assert_equal(ans,l1 + l2 + l3 + lend)      
    end

    
  end
end

