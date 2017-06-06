require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/css/css'
require "../../lib/global/jw_CSS_JS"
require "../../lib/js/jsObject"
require "../../lib/js/jsDocument"


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  class JWCssJsTest < Test::Unit::TestCase
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
    
    ##### doc ###########

    test "alias of js.doc" do
      # jdoc == js.doc
      @jwjs.jdoc.write("a")
      assert_equal(@jwjs.js.doc.orders[0], "document.write('a');")
    end
    
    test "document write case 1" do
      @jwjs.js.doc.write("a")
      assert_equal(@jwjs.js.doc.orders[0], "document.write('a');")
    end
    
    test "document write case 2" do
      @jwjs.js.doc.write("a")
      assert_equal(@jwjs.js.orders[0], "document.write('a');")
    end
    
    test "document write case 2-2" do
      a = @jwjs.js.doc.write("a")
      assert_equal(@jwjs.js.orders[0], "document.write('a');")
    end
    
    test "document write case 3" do
      a = @jwjs.js.doc.write("a")
      assert_equal(@jwjs.orders[0], "document.write('a');")
    end

    test "document write case 4" do
      @jwjs.js.doc.updateSelector :id__sample
      a = @jwjs.js.doc.write("a")
      @jwjs.js.doc.byID.innerHTML("aa".dQuo)
      
      assert_equal(@jwjs.orders[1], "document.getElementById('sample').innerHTML=\"aa\";")
    end

    test "when set jwjs class id, js id set at the same time" do
      @jwjs.attr :id__sample
      a = @jwjs.js.doc.byID.export
      assert_equal a, "document.getElementById('sample');"
    end
    
    # #### add member ####

    test "add jsArray to js.orders case 1" do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      assert_equal parent.jsArray.count, 0
    end
    
    test "add jsArray to js.orders case 2" do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")

      # this is expression for test of assembleJS
      # this mean self.js.orders convert to self.jsArray
      #parent.jsArray.append parent.js.orders
      parent.self_JsOrders_add_to_self_jsArray
      
      assert_equal parent.jsArray.count, 1
    end

    
    
    test "add member " do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
          
      parent.addMember child
      
      assert_equal parent.jsArray, child.orders
    end
    
    test "add member case 2 " do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
      child.js.doc.write("child again")
      
      parent.addMember child
      
      assert_equal parent.jsArray.count, 2 # child and child again
    end
    
    test "add member case 3 " do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
      child.js.doc.write("child again")
      
      parent.addMember child
      parent.self_JsOrders_add_to_self_jsArray
      assert_equal parent.jsArray.count, 3 # parent, child and child again
    end

    test "assembleJS, show JS Result" do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
      child.js.doc.write("child again")
      
      parent.addMember child
      parent.assembleJS
      p parent.showJsResult

      p parent.applyJS
     
    end
    
    test "assembleHTML test" do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
      child.js.doc.write("child again")
      
      parent.addMember child
      parent.assemble
    end


    #### file read ####
    test "file read" do
      jwCssJs = JW_CSS_JS.new
      jwCssJs.jsRead "./sample.js"

      assert_equal jwCssJs.orders[0], "var myCollection = document.getElementsByTagName(\"p\");"
      assert_equal jwCssJs.orders.last, "}"

    end
    
  end
end
