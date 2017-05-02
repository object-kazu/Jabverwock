require 'test/unit'

require "./path"

# require '../../lib/global/globalDef'  
# require '../../lib/css/css'
# require "../../lib/global/jw_CSS_JS"
# require "../../lib/js/jsObject"
# require "../../lib/js/jsDocument"


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  class AttrAndSelectorTest < Test::Unit::TestCase
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
      @jwjs = JW_CSS_JS.new
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

    # test "jwCssJs first test, for print debug " do
    #   p @jwjs
    # end

    # test "dot" do
    #   assert_equal("a.a", "a".dot("a"))
    # end

    # test "js cmd end" do
    #   assert_equal("a" << $JS_CMD_END, "a;")
     
    # end
    
    ##### ByID ###########
    test "document.getElementById case 1" do
      img = IMG.new.attr(:id__MyImage, :src, "simple.gif")      
      img.js.doc.byID.src("landscape.jpg").rec
      
      ans = "document.getElementById('MyImage').src=\"landscape.jpg\";"
      assert_equal ans, img.js.orders[0]
      
    end
    
    test "document.getElementById case 2" do
      img = IMG.new.attr(:id,"MyImage").attr(:src, "simple.gif")
      img.js.doc.byID.src("landscape.jpg").rec
      
      ans = "document.getElementById('MyImage').src=\"landscape.jpg\";"
      assert_equal ans, img.js.orders[0]
      
    end
    
    test "document.getElementById case 3" do
      img = IMG.new.attr(:id__MyImage).attr(:src, "simple.gif")
      
      img.js.doc.byID.src("landscape.jpg").rec
      
      ans = "document.getElementById('MyImage').src=\"landscape.jpg\";"
      assert_equal ans, img.js.orders[0]
      
    end
    
    ##### ByClass ###########
    test "document.getElementByClass case 1" do
      img = IMG.new.attr(:cls__MyImage, :src, "simple.gif")      
      img.js.doc.byClassName.src("landscape.jpg").rec
      
      ans = "document.getElementByClassName('MyImage').src=\"landscape.jpg\";"
      assert_equal ans, img.js.orders[0]
      
    end
    
    test "document.getElementByCls case 2" do
      img = IMG.new.attr(:cls,"sample").attr(:src, "simple.gif")
      img.js.doc.byClassName.src("landscape.jpg").rec
      
      ans = "document.getElementByClassName('sample').src=\"landscape.jpg\";"
      assert_equal ans, img.js.orders[0]
      
    end
    
    

  end
end
