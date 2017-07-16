require 'test/unit'
#require "global/jwSingle"


require '../../lib/global/jwSingle'
require '../../lib/global/jwOneTag'
require "../../lib/global/globalDef"

module Jabverwock
  using StringExtension
  
  class BRTest < Test::Unit::TestCase
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
      @br = BR.new
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

    ## BR change : Class BR and Global constat $BR are exist! 

    
    ## class BR test
    test "single List" do
      assert_equal(@br.name , "br")
    end
    
    test "tag Str" do
      assert_equal(@br.tgStr , "<br>")
    end
    
    test "br basically" do
      @br.content = "this is test"
      assert_equal(@br.tgStr, "this is test<br>")
    end

    test "class br with p tag" do
      @br.content = "this is test"
      pp = P.new
      pp.content = @br.tgStr
      assert_equal(pp.tgStr,"<p>this is test<br></p>")
      
    end

    
    test "add br tag after other tag" do
      pp = P.new.contentIs "test"
      pp.addMember(@br)
      assert_equal(pp.tgStr, "<p>test</p>\n<br>\n")
      
    end
    
    
    ### Constant BR test
    test "new test BR" do
      assert_equal($BR, "<br>")
    end

    test "constant br with p tag" do
      pp = P.new.contentIs "this is test,#{$BR} for you "
      assert_equal(pp.tgStr, "<p>this is test,<br> for you </p>")
    end

    test "withBreak" do
      pp = P.new.contentIs "test"
      pp.withBreak
      assert_equal(pp.tgStr, "<p>test</p><br>")
    end

    test "not withBreak" do
      pp = P.new.contentIs "test"
      assert_equal(pp.tgStr, "<p>test</p>")
      
    end
  end
end
 
