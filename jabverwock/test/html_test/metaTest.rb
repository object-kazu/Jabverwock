require 'test/unit'
# require "global/jwOneTag"
# require "global/jwSingle"

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
      @meta = META.new
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
      assert_equal(@meta.name , "meta")
    end

    test "press" do
      assert_equal(@meta.pressDefault, "<meta>")
    end

    test "add charset" do
      @meta.attr(:charset, "en")
      assert_equal(@meta.pressDefault, "<meta charset=\"en\">")
    end

    
    
  end
end
