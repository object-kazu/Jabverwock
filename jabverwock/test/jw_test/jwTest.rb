require 'test/unit' 
require '../../lib/global/globalDef'  
require '../../lib/global/jw'  

module Jabverwock
  using StringExtension
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
      @tm = JW.new
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

    test "name" do
      assert_equal(@tm.name, "jw")
    end
    
    test "JW insert variable and data, preTest" do
      a = "a".varIs("aa")
      assert_equal(a[:label], "a")
      assert_equal(a[:data], "aa")
      
    end

    test "JW,  isSingle method" do
      ans = @tm.isSingleTag(true)
      assert_equal(ans, true)
    end

    test "JW,  isSingle method nil" do      
      ans = @tm.isSingleTag(1)
      assert_equal(ans, nil)
    end

    test "pretest: pressDefault, nothing" do 
      @tm.pressVal.initResutString
      assert_equal(@tm.pressVal.resultString, "")
    end

    test "pretest: pressDefault, add text" do 
      @tm.templeteString = "test"
      @tm.prepPress
      @tm.pressVal.initResutString    
      ans = @tm.pressVal.resultString
      assert_equal(ans, "test")
    end

    test "assemble" do      
      @tm.name = "test"
      ans = @tm.pressDefault
      assert_equal(ans, "<test>\n</test>")
    end

    test "assemble, bad Arg" do
      
      assert_raise(){
        @tm.setName=1
      }
    end


    test "set cls" do
      @tm.name ="p"
      @tm.attr(:cls,"test")
      
      ans = @tm.pressDefault
      assert_equal(ans, "<p class=\"test\">\n</p>")
    end

    test "set cls, bad Arg" do
      assert_raise(){
        @tm.setCls= 1
      }
    end

    test"get cls " do
      @tm.name = "test"
      @tm.attr(:cls,"sample")
      assert_equal(@tm.selectorCls, ".sample")
    end

    test"get id " do
      @tm.name = "test"
      @tm.attr(:cls,"sample").attr(:id,"dada")
      assert_equal(@tm.selectorID, "#dada")
    end

    
    
    test "add lang"do
      
      @tm.name = "p"
      @tm.attr(:lang,"en")
      ans = @tm.pressDefault
      assert_equal(ans, "<p lang=\"en\">\n</p>")
    end
    

    test "add id"do
      
      @tm.name = "p"
      @tm.attr(:id, "sample")
      ans = @tm.pressDefault
      assert_equal(ans, "<p id=\"sample\">\n</p>")
    end
    
  end
end
