require 'test/unit'
#require "global/jwSingle"

require '../../lib/global/globalDef'
require '../../lib/global/jwSingle'
require '../../lib/global/jw_CSS_JS'



module Jabverwock
  using StringExtension
  class JwSingleTest < Test::Unit::TestCase
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
      @t = JWSingle.new
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
      s = P.new
      assert_equal(s.name , "p")
    end

    test "JWSingle first test" do
      @t.name = "p"
      ans = @t.pressDefault
      assert_equal(ans, "<p></p>")

    end
        
    test "content add" do
      @t.name="j"
      @t.content = "test"
      ans = @t.pressDefault
      ans2 = @t.pressVal.showTempleteString
      
      assert_equal(ans, "<j>test</j>")
      assert_equal(ans, ans2)
    end
    
    test "add label case 1" do

      @t.name="j"
      @t.content = "test" + "a".variable
      ans = @t.pressDefault
      ans2 = @t.pressVal.showTempleteString
      
      assert_equal(ans, "<j>test</j>")
      assert_not_equal(ans, ans2)
      
    #     // not equal <j>testLABEL_INSERT_START + "a" + LABEL_INSERT_END</j>
    #     // because at press method , remove LABEL_INSERT_START + "a" + LABEL_INSERT_END
      
    end

    
    test "add label case 2" do
      @t.name="j"
      @t.content = "test" + "a".variable
      @t.pressDefault
      ans = @t.pressAInsert("a".varIs" is done")
      assert_equal(ans, "<j>test is done</j>")

    end
    
    test "add label case 3" do
      @t.name="j"
      @t.content = "test" + "a".variable + "-> yes!"
      @t.pressDefault
      ans = @t.pressAInsert("a".varIs" is done")
      assert_equal(ans, "<j>test is done-> yes!</j>")
      
    end
    
    test "add label case 4, retry insert data" do
      @t.name="j"
      @t.content = "test" + "a".variable + "-> yes!"
      @t.pressDefault
      ans = @t.pressAInsert("a".varIs" is done")
      assert_equal(ans, "<j>test is done-> yes!</j>")

      #retry
      ans2 = @t.pressAInsert("a".varIs" was success!")
      assert_equal(ans2, "<j>test was success!-> yes!</j>")
      
    end

    test "add labels" do

      @t.name="j"
      @t.content = "test" + "a".variable + "b".variable
      @t.pressDefault
      i1 = "a".varIs" first"
      i2 = "b".varIs",but..."
      ans = @t.pressInsertEach(i1,i2)
      assert_equal(ans, "<j>test first,but...</j>")

      
    end

    
    
  end
end
