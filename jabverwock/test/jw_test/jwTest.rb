require 'test/unit' 
require_relative '../../lib/global/globalDef'  
require_relative '../../lib/global/jw'  

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
      ans = @tm.isSingleTag 1
      assert_equal ans,nil
    end

    test "pretest: pressDefault, nothing" do 
      @tm.pressVal.initResutString
      assert_equal(@tm.pressVal.resultString, "")
    end

    # # test "pretest: pressDefault, add text" do 
    # #   @tm.templeteString = "test"
    # #   @tm.pressVal.initResutString    
    # #   @tm.prepPress
    # #   ans = @tm.pressVal.resultString
    # #   assert_equal(ans, "test")
    # # end

    test "assemble" do      
      @tm.name = "test"
      assert_equal(@tm.tgStr, "<test>\n</test>")
    end

    test "assemble, bad Arg" do
      
      assert_raise(){
        @tm.setName=1
      }
    end


    test "set cls" do
      @tm.name ="p"
      @tm.attr(:cls,"test")
      assert_equal(@tm.tgStr, "<p class=\"test\">\n</p>")
    end
 
    test "set cls, bad Arg" do
      assert_raise(){
        @tm.setCls= 1
      }
    end

    
    test"get id and clss " do
      @tm.name = "test"
      @tm.attr(:cls,"sample").attr(:id,"dada")
      assert_equal @tm.tgStr, "<test class=\"sample\" id=\"dada\">\n</test>"      
    end
    
    test"get id and clss case 2 " do
      @tm.name = "test"
      @tm.attrSymbol :cls__sample
      @tm.attrSymbol :id__data
      assert_equal @tm.tgStr, "<test class=\"sample\" id=\"data\">\n</test>"      
    end
    
    test"get id and clss case 3-1 " do
      @tm.name = "test"
      @tm.attr(:cls__sample)
      assert_equal @tm.tgStr, "<test class=\"sample\">\n</test>"      
    end
    
    test"get id and clss case 3-2 " do
      @tm.name = "test"
      @tm.attr(:cls__sample,:id__data)
      assert_equal @tm.tgStr, "<test class=\"sample\" id=\"data\">\n</test>"      
    end
    
    test"get id and clss case 4 " do
      @tm.name = "test"
      @tm.attr(:cls__sample,:id__data, :name, "test")
      assert_equal @tm.tgStr, "<test class=\"sample\" id=\"data\" name=\"test\">\n</test>"      
    end
    
    test"get id and clss error case " do
      @tm.name = "test"
      @tm.attr(:cls__sample,:id__data, :name) # ignore :name
      assert_equal @tm.tgStr, "<test class=\"sample\" id=\"data\">\n</test>"      

    end
    
    test"get id and clss error case 2 " do
      @tm.name = "test"
      @tm.attr(:cls__sample,:id__data, "name") #ignore "name"
      assert_equal @tm.tgStr, "<test class=\"sample\" id=\"data\">\n</test>"      

    end
    
    test "add lang"do
      
      @tm.name = "p"
      @tm.attr(:lang,"en")
      assert_equal(@tm.tgStr, "<p lang=\"en\">\n</p>")
    end
    

    test "add id"do
      
      @tm.name = "p"
      @tm.attr(:id, "sample")
      assert_equal(@tm.tgStr, "<p id=\"sample\">\n</p>")
    end

    test "attr bind with  __ " do
      j = JW.new.attr(:id__sample)
      assert_equal j.tgStr, "<jw id=\"sample\">\n</jw>"
    end
    
    test "attr: replace _ to - " do
      j = JW.new.attr(:font_size, "10")
      assert_equal j.tgStr, "<jw font-size=\"10\">\n</jw>"
    end
    
    test "attr bind with __ case 2" do
      j = JW.new.attr(:font_size__10)
      assert_equal j.tgStr, "<jw font-size=\"10\">\n</jw>"
    end
    
    test "attr bind with __ case 3" do
      j = JW.new.attr(:font_size, "10")
      assert_equal j.tgStr, "<jw font-size=\"10\">\n</jw>"
    end

    test "set cls use symble" do
      @tm.name ="p"
      @tm.attr(:cls__test)
      assert_equal(@tm.tgStr, "<p class=\"test\">\n</p>")
      
    end
    
    test "set cls use not symble" do
      @tm.name ="p"
      @tm.attr("cla")      
      assert_equal(@tm.tgStr, "<p>\n</p>")
      
    end


    test "attrWithSymbolsArray" do
      @tm.name = "p"
      arr = [:id__test, :cls__sample]
      @tm.attrWithSymbolsArray arr
      assert_equal @tm.tgStr, "<p id=\"test\" class=\"sample\">\n</p>"
     
    end

    
  end
end
