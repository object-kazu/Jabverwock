require 'test/unit'
#require "global/jwSingle"

require '../../lib/global/jwSingle'

module Jabverwock
  using StringExtension
  
  class HeadingTest < Test::Unit::TestCase
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
    test "Heading first test" do
      a = HEADING.new(2)
      assert_equal(a.tgStr , "<h2></h2>")
    end
    
    test "Heading defualt test" do
      a = HEADING.new()
      assert_equal(a.tgStr , "<h1></h1>")
    end
    

    test "Heading add content" do
      a = HEADING.new().contentIs "test"
      assert_equal(a.tgStr , "<h1>test</h1>")
    end
    
    
    
    
  end
end
