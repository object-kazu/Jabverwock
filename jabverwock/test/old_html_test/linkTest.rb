require 'test/unit'
#require "global/jwSingle"

require '../../lib/global/jwOneTag'

module Jabverwock
  using StringExtension
  
  class LinkTest < Test::Unit::TestCase
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
      @link = LINK.new
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
    test "single List" do
      assert_equal(@link.name , "link")
    end

    test "A tag" do
      ans = @link.pressDefault
      assert_equal(ans, "<link>")
    end
    
    test "content add, ignore" do
      
      @link.content = "test"
      ans = @link.pressDefault
      assert_equal(ans, "<link>test")

    end
    
    
    test "add label case: ignore content with variable" do

      @link.content = "test" + "a".variable
      ans = @link.pressDefault
      
      assert_equal(ans, "<link>test")
    end

       
    test "href add" do
      @link.tagManager .tagAttr(:href, "http://www")
      ans = @link.pressDefault
      assert_equal(ans,"<link href=\"http://www\">")
      
    end
    
    test "src add case 2" do
      @link.tagManager .tagAttr(:src, "http://www")
      ans = @link.pressDefault
      assert_equal(ans,"<link src=\"http://www\">")
      
    end

    
    
  end
end
