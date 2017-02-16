require 'test/unit' 
require '../../lib/global/jwOneTag'
require '../../lib/global/jwSingle'


module Jabverwock
  using StringExtension
  
  class DoctypeTest < Test::Unit::TestCase
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
      @d = DOCTYPE.new
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
    test "confirm name" do
      assert_equal(@d.name , "doctype")
    end

    test "press" do
      assert_equal(@d.pressDefault, "<!DOCTYPE html>")
    end

    test "add member string" do
      @d.addMemberString "my first task"
      ans = @d.pressDefault
      assert_equal(ans, "<!DOCTYPE html>\nmy first task\n")
    end

    test "add member" do
      a = A.new
      @d.addMember a
      ans = @d.pressDefault
      assert_equal(ans, "<!DOCTYPE html>\n<a></a>\n")
    end
    
    
  end
end
