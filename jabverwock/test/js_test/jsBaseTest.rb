require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsObject'
require '../../lib/js/jsBase'
require '../../lib/js/jsDocument'
require "../../lib/global/jwSingle"
require "../../lib/global/jwMulti"
require "../../lib/global/jwOneTag"
require "../../lib/global/jwTable"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  class JsObjectTest < Test::Unit::TestCase
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

    # test "jsBase first test, for print debug " do
    #   p js = JsBase.new()
     
    # end

    test "id" do
      assert_true KSUtil.isID("id")
    end
    test "id case 2" do
      assert_true KSUtil.isID("id_s")
    end
    test "id case 3" do
      assert_false KSUtil.isID("name")
    end
    
    test "cls" do
      assert_true KSUtil.isCls("cls")
    end
    test "cls case 2" do
      assert_true KSUtil.isCls("cls_s")
    end
    test "cls case 3" do
      assert_false KSUtil.isCls("name")
    end
    
    test "name" do
      assert_true KSUtil.isName("name")
    end
    test "name case 2" do
      assert_true KSUtil.isName("name_s")
    end
    test "name case 3" do
      assert_false KSUtil.isName("cls")
    end
    
    test"initialize case 1" do
      js = JsBase.new("id__sample")
      assert_equal js.id, "sample" 
    end
    
    test"initialize case 2" do
      js = JsBase.new(:id__sample)
      assert_equal js.id, "sample" 
    end
    
    test"initialize case 3" do
      js = JsBase.new(:attr__test)
      assert_equal js.id, "" 
    end

    
    test"initialize case tagName case 1 " do
      js = JsBase.new(:name__sample)
      assert_equal js.name, "sample" 
    end
    
    test"initialize case tagName case 2 " do
      para = P.new.attr(:name__sample)
      assert_equal para.js.name, "sample" 
    end

    
    test"initialize case tagName default value is class name  " do
      para = P.new
      assert_equal para.js.name, "p" 
    end
    
    test"initialize case tagName default value is class name case 2 " do
      h = HTML.new
      assert_equal h.js.name, "html" 
    end
    
    test"initialize case tagName default value is class name case 3 " do
      h = DOCTYPE.new
      assert_equal h.js.name, "doctype" 
    end
    
    test"initialize case tagName default value is class name case 4 " do
      h = TABLE.new
      assert_equal h.js.name, "table" 
    end

    test "js.doc.byTagName set by default name" do
      para = P.new
      assert_equal para.js.doc.byTagName.export, "document.getElementByTagName('p');"
    end
    
    test "js.doc.byTagName set by default name case 2" do
      para = HTML.new
      assert_equal para.js.doc.byTagName.export, "document.getElementByTagName('html');"
    end

    #### sequence hash ###
    test "seqHash init test" do
      jsb = JsBase.new
      a = jsb.seqHash "shi"
      assert_equal a, {:js1 => "shi"}
    end
    
    test "seqHash twice" do
      jsb = JsBase.new
      jsb.seqHash "shi"
      a = jsb.seqHash "gooo"
      assert_equal a, {:js2 => "gooo"}
    end

    ### firstHashValue ##
    test "firstHashValue" do
      jsb= JsBase.new
      jsb.recBy "shi"
      jsb.recBy "Goo"
      jsb.recBy "DDD"
      
      assert_equal jsb.record, "shi"
    end

    test "recordLast" do
      jsb= JsBase.new
      jsb.recBy "shi"
      jsb.recBy "Goo"
      jsb.recBy "DDD"

      assert_equal jsb.recordLast, "DDD"
    end


    ### recBy ####
    
    test "recBy case 1" do
      jsb = JsBase.new
      jsb.recBy "shi"
      assert_equal jsb.orders[0], "shi"
      
      assert_equal jsb.orders, ["shi"]
    end
    
    test "recBy case 2" do
      jsb = JsBase.new
      jsb.recBy "shi"
      jsb.recBy "Goo"
      assert_equal jsb.orders[0], "shi"
      assert_equal jsb.orders[1], "Goo"

      assert_equal jsb.orders, ["shi","Goo"]
    end

    test "recBy case 3" do
      jsb = JsBase.new
      jsb.recBy "shi"
      jsb.recBy "Goo"
      jsb.recBy "DDD"
      assert_equal jsb.orders[0], "shi"
      assert_equal jsb.orders[1], "Goo"

      assert_equal jsb.orders, ["shi","Goo", "DDD"]
    end

    
  end
end
