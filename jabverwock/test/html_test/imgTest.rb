require 'test/unit'
#require "global/jwSingle"

require '../../lib/global/jwOneTag'

module Jabverwock
  using StringExtension
  
  class ImgTest < Test::Unit::TestCase
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
      @img = IMG.new
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
      assert_equal(@img.name , "img")
    end

    test "A tag" do
      ans = @img.pressDefault
      assert_equal(ans, "<img>")
    end
    
    test "content add, ignore" do
      
      @img.content = "test"
      ans = @img.pressDefault
      assert_equal(ans, "<img>")

    end
    
    
    test "add label case: ignore content with variable" do

      @img.content = "test" + "a".variable
      ans = @img.pressDefault
      
      assert_equal(ans, "<img>")
    end

       
    test "href add" do
      @img.tagManager .tagAttr(:href, "http://www")
      ans = @img.pressDefault
      assert_equal(ans,"<img href=\"http://www\">")
      
    end
    
    test "src add" do
      @img.tagManager .tagAttr(:src, "http://www")
      ans = @img.pressDefault
      assert_equal(ans,"<img src=\"http://www\">")
      
    end

    
    
  end
end
