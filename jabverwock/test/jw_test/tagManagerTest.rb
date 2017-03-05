require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/global/tagManager'  

module Jabverwock
  using StringExtension
  class TagManagerTest < Test::Unit::TestCase
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
    
    test "TagManager, path confirm " do
      tm =  TagManager.new 
      tm.name = "first"

      assert_equal(tm.openString, "<first>")
      assert_equal(tm.closeString, "</first>")
      
    end
    
    test "TagManager, name is void " do
      tm =  TagManager.new
      tm.name = ""
      assert_raise{
        tm.openString
      }
      
    end

    test "name and id add" do
      tm =  TagManager.new()
      tm.name = "p"
      tm.tagAttribute.add_id ("test")
      assert_equal(tm.openString, "<p id=\"test\">")
      
    end
    test "tagAttr, id add, chain method" do
      tm =  TagManager.new()
      tm.name = "p"
      tm.tagAttr("id","test").tagAttr("cls","test")
      assert_equal(tm.openString, "<p id=\"test\" class=\"test\">")
      
    end

    test "tagAttr, id add" do
      tm =  TagManager.new()
      tm.name = "p"
      tm.tagAttr("id","test")
      assert_equal(tm.openString, "<p id=\"test\">")
      
    end

    
    test "id add, symbol use" do
      tm =  TagManager.new()
      tm.name = "p"
      tm.tagAttr(:id,"test")

      assert_equal(tm.openString, "<p id=\"test\">")
      
    end

    test "id and name add" do
      tm =  TagManager.new()
      tm.tagAttr(:id,"test")
      tm.name = "sample"

      assert_equal(tm.openString,"<sample id=\"test\">" )
      
    end

    test "class  add" do
      tm =  TagManager.new()
      tm.name = "p"           
      tm.tagAttr(:cls,"test")
      
      assert_equal(tm.openString, "<p class=\"test\">")
      
    end

    test "class, id , name  add" do
      tm =  TagManager.new()
      tm.tagAttr(:cls,"test").tagAttr(:id, "test")
      tm.name = "sample"

      assert_equal(tm.openString, "<sample class=\"test\" id=\"test\">" )
      assert_equal(tm.tagAttribute.cls, "test")
    end

    
    test "not br tag " do
      tm = TagManager.new
      tm.name = "b"    
      assert_equal(tm.openString, "<b>")
      assert_equal(tm.closeString, "</b>")
    end

    test "tag attribute lang add" do
      tm = TagManager.new
      tm.name = "a"
      tm.tagAttr(:lang, "jp")
      assert_equal(tm.openString, "<a lang=\"jp\">")
    end

    test "tag attribute lang call" do
      tm = TagManager.new
      tm.name = "a"
      tm.tagAttr(:lang, "jp")
      assert_equal(tm.tagAttribute.lang, "jp")
    end

    test "openString replace" do
      tm = TagManager.new
      tm.tempOpenString = "aaa"
      tm.openStringReplace("a","b")
      assert_equal(tm.tempOpenString,"bbb")
    end

    test "closeString replace" do
      tm = TagManager.new
      tm.tempCloseString = "aaa"
      tm.closeStringReplace("a","b")
      assert_equal(tm.tempCloseString,"bbb")
    end
    
    
       
    
  end
end
