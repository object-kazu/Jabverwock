require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsDocumentVar'

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  class JsDocumentVarTest < Test::Unit::TestCase
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
      @jsdv = JsDocumentVar.new
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

    # test "jsDocumentVar first test, for print debug " do
    #   p @jsdv
    # end

    # test "test function call" do
    #  # p @jsdv.call("write('shimizu')")
    #   # p @jsdv.call("record")

    #   # p @jsdv.call("byID.export")

    #   p @jsdv.call("createTextNode('this is new');")
    # end
    
    
    ### appendChild ####
    
    # test "appendChild case 1" do #createElement -> createTextNode -> appendChild
    #   @jsdv.createElement(:p).is_append("createTextNode('this is new');")
      
    #   assert_equal(@jsdv.orders[0], "var vp = document.createElement('p');")
    #   assert_equal(@jsdv.orders[1], "var vc = document.createTextNode('this is new');")      
    #   assert_equal(@jsdv.orders[2], "vp.appendChild(vc);")

    # end
    
    # test "appendChild case 2" do #createElement -> createTextNode -> appendChild

    #   @jsdv.var.byID.append.createElement(:img).setAttribute(id:"js_koneta_01-01".dQuo ,src:"images/js/analysis_back.jpg".dQuo)
      
    #     #    var o = document.createElement("img");
    #     #    o.setAttribute("id", "js_koneta_01-01");
    #     #    o.setAttribute("src", "images/js/analysis_back.jpg");
    #     #    document.getElementById("js_koneta_01").appendChild(o);

    # end

    
    ### JsDocument test copy ###

    # test "select by id" do
    #   @jsdv.id = "test"
    #   ans = @jsdv.byID.export
    #   assert_equal(ans, "document.getElementById('test');")
    # end
    
 #    test "export select by id" do
 #      @jsdv.id = "test"
 #      ans = @jsdv.byID
 #      assert_equal(ans.export, "document.getElementById('test');")
 #    end

 #    test "select by id, no rec" do
 #      @jsdv.id = "test"
 #      assert_equal(@jsdv.orders[0], nil)
 #    end

    
 #    test "select by id and rec" do
 #      @jsdv.id = "test"
 #      @jsdv.byID.rec
 #      assert_equal(@jsdv.orders[0] , "document.getElementById('test');")
 #    end
    
   
 #    test "select by class" do
 #      @jsdv.updateSelector "cls__p", "id__koko"
      
 #      p @jsdv.cls
 #      p @jsdv.id
      
 #      assert_equal(@jsdv.byID.export, "document.getElementById('koko');")
 #      assert_equal(@jsdv.byClassName.export, "document.getElementByClassName('p');")
 #    end

 #    test "select by class and rec" do
 #      @jsdv.updateSelector "id__koko", "cls__p"
 #      @jsdv.byID.rec
 #      @jsdv.byClassName.rec
 #      assert_equal(@jsdv.orders[0], "document.getElementById('koko');")
 #      assert_equal(@jsdv.orders[1], "document.getElementByClassName('p');")
 #    end

    
 #    test "select by class case 2" do
 #      @jsdv.updateSelector :id__koko, :cls__p
 #      assert_equal(@jsdv.byID.export, "document.getElementById('koko');")
 #      assert_equal(@jsdv.byClassName.export, "document.getElementByClassName('p');")
 #    end
    
 #    test "select by TagName" do
 #      @jsdv.updateSelector "id__koko","cls__p","name__popo"
 #      assert_equal(@jsdv.byID.export, "document.getElementById('koko');")
 #      assert_equal(@jsdv.byClassName.export, "document.getElementByClassName('p');")
 #      assert_equal(@jsdv.byTagName.export, "document.getElementByTagName('popo');")
 #    end
    
 #    test "select by TagName case 2" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      assert_equal(@jsdv.byID.export, "document.getElementById('koko');")
 #      assert_equal(@jsdv.byClassName.export, "document.getElementByClassName('p');")
 #      assert_equal(@jsdv.byTagName.export, "document.getElementByTagName('popo');")
 #    end
    
    
 #    # # # # ### add and delete element ###
 #    test "createElement" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.createElement("koko")
 #      assert_equal(@jsdv.orders[0], "document.createElement('koko');")

 #    end
    
 #    test "createElement orders count" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.createElement("koko")
 #      assert_equal(@jsdv.orders.count, 1)

 #    end

 #    test "createElement orders ,symbol" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.createElement :koko
 #      assert_equal(@jsdv.orders.first, "document.createElement('koko');")

 #    end

 #    test "createElement is_var" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.createElement(:koko).is_var(:mm)
 #      assert_equal(@jsdv.orders.first, "var mm = document.createElement('koko');")
 #    end

 #    test "createTextNode" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.createElement(:koko).is_var(:mm)
 #      @jsdv.createTextNode("this is new.".sQuo).is_var(:new)
 #      assert_equal(@jsdv.orders[1], "var new = document.createTextNode('this is new.');")
 #    end

 #    test "createTextNode and addChild" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.createElement(:koko).is_var(:mm)
 #      @jsdv.createTextNode("this is new".sQuo).is_var(:nn)
 #      @jsdv.appendChild(:mm, :nn)
 #      assert_equal(@jsdv.orders[0], "var mm = document.createElement('koko');")
 #      assert_equal(@jsdv.orders[1], "var nn = document.createTextNode('this is new');")      
 #      assert_equal(@jsdv.orders[2], "mm.appendChild(nn);")
      
 #    end

    
    
 #    test "removeChild" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.removeChild("aaa")
 #      assert_equal(@jsdv.orders[0], "document.removeChild(aaa);")

 #    end
    
    
 #    test "document write, do not need rec" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.write("koko")
 #      assert_equal(@jsdv.orders[0], "document.write('koko');")
 #    end
    
 #    # # # ### change element ###
    
 #    test "innerHTML, no rec" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      a = @jsdv.byID.innerHTML "aaa".dQuo
 #      assert_equal(@jsdv.orders[0], "document.getElementById('koko').innerHTML=\"aaa\";")
 #    end

        
 #    test "innerHTML, rec case 2" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      a = @jsdv.byID
 #      a.innerHTML("aaa".dQuo)
 #      assert_equal(@jsdv.orders[0], "document.getElementById('koko').innerHTML=\"aaa\";")
 #    end
     
 #    test "innerHTML, rec case 3" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      a = @jsdv.byID
 #      a.innerHTML("aaa".dQuo)
 #      a.innerHTML("bbb".dQuo)
 #      assert_equal(@jsdv.orders[0], "document.getElementById('koko').innerHTML=\"aaa\";")
 #      assert_equal(@jsdv.orders[1], "document.getElementById('koko').innerHTML=\"bbb\";")
 #    end
    
 #    test "innerHTML, rec case 4" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      a = @jsdv.byID.innerHTML("aaa")      
      
 #      # if you want to write a.innerHTML "bbb",
 #      # write following code
 #      # a = @jsdv.byID
 #      # a.innerHTML("aaa")
 #      # a.innerHTML("bbb")

 #      assert_raise{
 #        a.innerHTML "bbb"
        
 #      }

 #    end
        
 #    test "attribute case 1 (rec do not call)" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.byID.attribute "aaa".dQuo
 #      assert_equal(@jsdv.orders[0], "document.getElementById('koko').attribute=\"aaa\";")
 #    end
    
 #    test "attribute, call rec" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      assert_raise {
 #        @jsdv.byID.attribute ("aaa".dQuo).rec
 #      }
 #    end

 #    # ### setAttribute ###
    
 #    test "setAttribute case 1" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.byID.setAttribute(btn:"red")
 #      assert_equal(@jsdv.orders[0], "document.getElementById('koko').setAttribute(\"btn\",\"red\");")

 #    end
    
 #    test "setAttribute, case 2" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.byID.setAttribute(btn:"red")
 #      @jsdv.byID.setAttribute(btn:"blue")
 #      assert_equal(@jsdv.orders[0], "document.getElementById('koko').setAttribute(\"btn\",\"red\");")
 #      assert_equal(@jsdv.orders[1], "document.getElementById('koko').setAttribute(\"btn\",\"blue\");")
 #    end
    
 #    test "setAttribute, rec case 3" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.byID.setAttribute(btn:"red", btn_:"blue")
 #      assert_equal(@jsdv.orders[0], "document.getElementById('koko').setAttribute(\"btn\",\"red\");")
 #      assert_equal(@jsdv.orders[1], "document.getElementById('koko').setAttribute(\"btn\",\"blue\");")
 #    end

    
 #    # ### style ####
    
 #    test "style, rec" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.byID.style(backgroundColor:"red")
 #      @jsdv.byID.style(color:"red")
 #      assert_equal(@jsdv.orders[0], "document.getElementById('koko').style.backgroundColor='red';")
 #      assert_equal(@jsdv.orders[1], "document.getElementById('koko').style.color='red';")
 #    end

 #    test "style, rec case 2" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      a = @jsdv.byID
 #      a.style(backgroundColor:"red",color:"red")
 #      assert_equal(@jsdv.orders[0], "document.getElementById('koko').style.backgroundColor='red';")
 #      assert_equal(@jsdv.orders[1], "document.getElementById('koko').style.color='red';")
 #    end
    
 #    # ### index ###
 #    test "index" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.byID.index(0).innerHTML("aaa".dQuo)
 #      assert_equal(@jsdv.orders[0],"document.getElementById('koko')[0].innerHTML=\"aaa\";")

 #    end
    
 #    test "index case 2" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      @jsdv.byID.index(0).innerHTML("aaa".dQuo)
 #      @jsdv.byID.index(1).innerHTML("bbb".dQuo)
 #      assert_equal(@jsdv.orders[1],"document.getElementById('koko')[1].innerHTML=\"bbb\";")

 #    end

 #    test "index element" do
 #      @jsdv.updateSelector :id__koko, :cls__p,:name__popo
 #      a = @jsdv.byID.index(0).export
 #      assert_equal(a,"document.getElementById('koko')[0];")

 #    end
    
 #    test "index element case 2" do  
 #      @jsdv.updateSelector :id__koko
 #      a = @jsdv.byID.index(0).export
 #      assert_equal(a,"document.getElementById('koko')[0];")

 #    end


 #    # ### addEventListener #####
 #    test "addEventListener case 1" do
 #      @jsdv.byID.addEventListener(click:"myFunction()")
 #      assert_equal @jsdv.orders.first, "document.getElementById('').addEventListener(\"click\",'myFunction()');"
            
 #    end

 #    test "addEventListener case 2" do
 #      @jsdv.byID.addEventListener(click:"ksFunc",onclick:"muFinc()")
      
 #      assert_equal @jsdv.orders.first, "document.getElementById('').addEventListener(\"click\",'ksFunc');"
 #      assert_equal @jsdv.orders.last, "document.getElementById('').addEventListener(\"onclick\",'muFinc()');"
 #    end

    
    
 #    test "addEventListener case same event" do
 #      @jsdv.byID.addEventListener(click:"ksFunc",click_:"muFinc()")
      
 #      assert_equal @jsdv.orders.first, "document.getElementById('').addEventListener(\"click\",'ksFunc');"
 #      assert_equal @jsdv.orders.last, "document.getElementById('').addEventListener(\"click\",'muFinc()');"
 #    end

 #    test "addEventListenerUseCapture case 1" do
 #      @jsdv.byID.addEventListenerUseCapture(click:"myFunc")
 #      assert_equal @jsdv.orders.first, "document.getElementById('').addEventListener(\"click\",'myFunc',true);"
      
 #    end

 #    test "addEventListenerUseCapture case same event" do
 #      @jsdv.byID.addEventListenerUseCapture(click:"myFunc", click_:"ksFunc")
 #      assert_equal @jsdv.orders.first, "document.getElementById('').addEventListener(\"click\",'myFunc',true);"
 #      assert_equal @jsdv.orders.last, "document.getElementById('').addEventListener(\"click\",'ksFunc',true);"      
 #    end


 #    ### node ###
 #    test "first node" do
      
 #      @jsdv.byID.firstChild("type")
 #      assert_equal @jsdv.orders.first, "document.getElementById('').firstChild.nodeType;"
      
 #    end
    
 #    test "first node call twice" do
      
 #      @jsdv.byID.firstChild("type")
 #      @jsdv.byID.firstChild(:type)
 #      assert_equal @jsdv.orders.first, "document.getElementById('').firstChild.nodeType;"
 #      assert_equal @jsdv.records[1], "document.getElementById('').firstChild.nodeType;"
      
 #    end

        
 #    test "first node value" do
 #      v = @jsdv.byID.firstChild("type").record
 #      assert_equal v, "document.getElementById('').firstChild.nodeType;"
      
 #    end

    
 #    test "first node case symbol" do
      
 #      @jsdv.byID.firstChild(:name)
 #      assert_equal @jsdv.orders.first, "document.getElementById('').firstChild.nodeName;"  
 #    end
    
 #    test "first node no type" do
      
 #      @jsdv.byID.firstChild ""
 #      assert_equal @jsdv.orders.first, "document.getElementById('').firstChild;"
      
 #    end
    
 #    test "first node ommit type" do
      
 #      @jsdv.byID.firstChild
 #      assert_equal @jsdv.orders.first, "document.getElementById('').firstChild;"
      
 #    end

    
    
 #    test "last node case symbol"do
 #      @jsdv.byID.lastChild :name
 #      assert_equal @jsdv.orders.first, "document.getElementById('').lastChild.nodeName;"
 #    end

 #    test "last node case symbol value"do
 #      v = @jsdv.byID.lastChild(:name).record
 #      assert_equal v, "document.getElementById('').lastChild.nodeName;"
 #    end


 #    test "last node case ommit type" do
 #      @jsdv.byID.lastChild
 #      assert_equal @jsdv.orders.first, "document.getElementById('').lastChild;"
 #    end

    
    
 #    test "parent node case symbol" do
 #      @jsdv.byID.parentNode :type
 #      # assert_equal @jsdv.orders.first, "document.getElementById('').parentNode.nodeType;"
 #      assert_equal @jsdv.record, "document.getElementById('').parentNode.nodeType;"
 #    end

 #    test "parentNode ommit type" do
 #      @jsdv.byID.parentNode
 #      # assert_equal @jsdv.orders.first, "document.getElementById('').parentNode;"
 #      assert_equal @jsdv.record, "document.getElementById('').parentNode;"
 #    end
    
    
 #    test "nextSibling" do
 #      @jsdv.byID.nextSibling
 #      # assert_equal @jsdv.orders.first, "document.getElementById('').nextSibling;"
 #      assert_equal @jsdv.record, "document.getElementById('').nextSibling;"
 #    end

    
 #    test "previousSibling" do
 #      @jsdv.byID.previousSibling
 #      # assert_equal @jsdv.orders.first, "document.getElementById('').previousSibling;"
 #      assert_equal @jsdv.record, "document.getElementById('').previousSibling;"
 #    end
    
 #    test "childNodes case 1" do
 #      @jsdv.byID.childNodes(0,:type)
 #      # assert_equal @jsdv.orders.first, "document.getElementById('').childNodes[0].nodeType;"
 #      assert_equal @jsdv.record, "document.getElementById('').childNodes[0].nodeType;"
 #    end

 #    test "childNodes case ommit type" do
 #      @jsdv.byID.childNodes(1)
 #      # assert_equal @jsdv.orders.first, "document.getElementById('').childNodes[1];"
 #      assert_equal @jsdv.record, "document.getElementById('').childNodes[1];"
 #    end


 #    ### is_var ###
 #    test "is_var first test" do
 #      @jsdv.byID.firstChild(:name).is_var(:test)
 #      # p @jsdv.records
 #      assert_equal @jsdv.record, "var test = document.getElementById('').firstChild.nodeName;"
 #    end

 #    test "is_var childNodes case ommit type" do
 #      @jsdv.byID.childNodes(1).is_var(:test)
 # #     assert_equal @jsdv.orders.first, "var test = document.getElementById('').childNodes[1];"
 #      assert_equal @jsdv.record, "var test = document.getElementById('').childNodes[1];"
 #    end
    
 #    test "is_var childNodes case ommit type case 2" do
 #      @jsdv.byID.childNodes(1).is_var(:test)
 #      assert_equal @jsdv.record, "var test = document.getElementById('').childNodes[1];"
 #    end


 #    test "is_var childNodes case ommit type case 3" do
 #      @jsdv.byID.childNodes(0)               # ----> records[0]
 #      @jsdv.byID.childNodes(1).is_var(:test) # ----> records[1]
      
 #      # p @jsdv.records
 #      assert_equal @jsdv.records[1], "var test = document.getElementById('').childNodes[1];"
 #    end

 #    test "is_var childNodes case ommit type case 4" do
      
 #      @jsdv.byID.childNodes(0).is_var(:sample)
 #      @jsdv.byID.childNodes(1).is_var(:test)
      
 #      # p @jsdv.records
 #      assert_equal @jsdv.records[0], "var sample = document.getElementById('').childNodes[0];"
 #      assert_equal @jsdv.records[1], "var test = document.getElementById('').childNodes[1];"
      
 #    end


    ### insert new HTML -- insertbefore ###
    
    
    
  end
end
