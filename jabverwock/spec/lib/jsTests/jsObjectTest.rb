require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsObject'
require '../../lib/js/jsDocument'

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
      @jso = JsObject.new
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

    # test "jsObject first test, for print debug " do
    #   p @jso.orders
    # end

    # ############## jsFunction ###############
    test "JsFunction " do
      @jso.func.define "test", "name", "age", "code is dead;"      
      assert_equal @jso.orders[0], "function test(name, age){
      code is dead;
      }"
    end
    
    
    test "JsFunction use symbol" do
      @jso.func.define :test, :name, :age, "code is dead;"
      assert_equal @jso.orders[0], "function test(name, age){
      code is dead;
      }"
    end

    
    # # ############## jsDocument ###############
    test "document confirm, correct id setting" do
      @jso.updateSelector :id__koko
      @jso.doc.byID.rec
      # a = @jso.doc.orders[0]
      a = @jso.doc.record
      assert_equal(a, "document.getElementById('koko');")
    end

    test "document confirm, correct id setting case 2" do
      jso = JsObject.new("id__koko","cls__opop","name__iii")
      jso.doc.byID.rec
      a = jso.doc.record
      assert_equal(a, "document.getElementById('koko');")
    end
    
    test "document confirm, correct id setting case 3" do
      @jso.updateSelector(:id__koko).doc.byID.rec
      
      a = @jso.doc.orders[0]      
      assert_equal(a, "document.getElementById('koko');")
    end
    
    test "document confirm, correct id setting case 4" do
      @jso.updateSelector(:id__koko).doc.byID.rec      
      assert_equal(@jso.doc.orders.count , 1)
    end

    test "jsObject extract from jsObject" do
      @jso.updateSelector(:id__koko).doc.byID.rec
      assert_equal(@jso.orders[0], "document.getElementById('koko');")
    end


    
    test "jsObject, check orders" do
      @jso.doc.createElement(:p).is_var :para
      @jso.doc.createTextNode('This is new.'.sQuo).is_var :node
      @jso.doc.appendChild(:para, :node)      
      @jso.doc.var(:element){|t| t.byID}       
      @jso.doc.insertBefore "element", "para"
           
      @jso.doc.var(:title3Node){ |t| t.byID }
      a = "createElement(:div).is_var :newNode"
      b = "createTextNode('CSS').is_var :textNode"
      c = "appendChild(:newNode, :textNode)"
      @jso.doc.selfy a,b,c
      @jso.doc.equal "newNode.id", "title2".sQuo
      @jso.doc.insertBefore "title3Node", "newNode"

      a = "var para = document.createElement('p');"
      b = "var node = document.createTextNode(\'This is new.\');"
      c = "para.appendChild(node);"
      d ="var element = document.getElementById('');"
      e ="element.parentNode.insertBefore(para,element);"
      
      f ="var title3Node = document.getElementById('');"
      g ="var newNode = document.createElement('div');"
      h ="var textNode = document.createTextNode(CSS);"
      i ="newNode.appendChild(textNode);"
      j ="newNode.id = 'title2';"
      k ="title3Node.parentNode.insertBefore(newNode,title3Node);"
      
      assert_equal @jso.orders[0], a
      assert_equal @jso.orders[1], b
      assert_equal @jso.orders[2], c
      assert_equal @jso.orders[3], d
      assert_equal @jso.orders[4], e
      
      assert_equal @jso.orders[5], f
      assert_equal @jso.orders[6], g
      assert_equal @jso.orders[7], h
      assert_equal @jso.orders[8], i
      assert_equal @jso.orders[9], j
      assert_equal @jso.orders[10], k
      
    end

    ########## jsReader ##########
    test "jsFileReader, readIn, path error check" do
      @jso.readIn "./sample.js"
      
    end

    test "jsFileReader, orders" do
      @jso.readIn "./sample.js"
      
      l0 = "var myCollection = document.getElementsByTagName(\"p\");"
      l1 ="var i;"
      l2 = "for (i = 0; i < myCollection.length; i++) {"
      l3 = "    myCollection[i].style.backgroundColor = \"red\";"
      l4 = "}"
      arr = [l0,l1,l2,l3,l4]
      
      (0..4).each do |index| 
        assert_equal @jso.orders[index], arr[index]
      end

      
    end

  end
end
