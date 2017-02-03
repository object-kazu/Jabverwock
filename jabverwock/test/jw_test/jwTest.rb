require 'test/unit' 
require '../../lib/global/globalDef'  
require '../../lib/global/insertData'  
require '../../lib/global/jw'  

require "pry"

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
    
    test "JW use InsertData as Struct " do
      a = InsertData.new(label:"ss", data: "aa")
      assert_equal(a.label, "ss")
      assert_equal(a.data, "aa")
      
    end

    test "JW,  isSingle method" do
      tm = JW.new
      ans = tm.isSingleTag(true)
      assert_equal(ans, true)
    end

    test "JW,  isSingle method nil" do
      tm = JW.new
      ans = tm.isSingleTag(1)
      assert_equal(ans, nil)
    end

    test "pretest: pressDefault, nothing" do 
      tm =JW.new
      tm.pressVal.initResutString
      assert_equal(tm.pressVal.resultString, "")
    end

    test "pretest: pressDefault, add text" do 
      tm =JW.new
      tm.templeteString = "test"
      tm.prepPress
      tm.pressVal.initResutString    
      ans = tm.pressVal.resultString
      assert_equal(ans, "test")
    end

    test "pressDefault, add text" do 
      tm =JW.new
      tm.templeteString = "test"     
      ans = tm.pressDefault
      assert_equal(ans, "test")
    end

    test "assemble" do
      tm = JW.new
      tm.setName="test"
      ans = tm.pressDefault
      assert_equal(ans, "<test>\n</test>")
    end

    test "assemble, bad Arg" do
      tm = JW.new
      assert_raise(){
        tm.setName=1
      }
    end


    test "set cls" do
      tm =JW.new
      tm.setCls="test"
      tm.setName="p"
      
      ans = tm.pressDefault
      assert_equal(ans, "<p class=\"test\">\n</p>")
    end

    test "set cls, bad Arg" do
      tm =JW.new
      assert_raise(){
        tm.setCls= 1
      }
    end
    
    test "add lang"do
      tm = JW.new
      tm.setName = "p"
      tm.setLang = "en"
      ans = tm.pressDefault
      assert_equal(ans, "<p lang=\"en\">\n</p>")
    end
    

    test "add id"do
      tm = JW.new
      tm.setName = "p"
      tm.setID = "sample"
      ans = tm.pressDefault
      assert_equal(ans, "<p id=\"sample\">\n</p>")
    end
    
  end
end
