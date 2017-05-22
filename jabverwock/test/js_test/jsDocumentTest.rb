require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsDocument'

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  class JsDocumentTest < Test::Unit::TestCase
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
      @jsd = JsDocument.new
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

    # test "jsDocument first test, for print debug " do
    #   p @jsd
    # end

    
    ### find element ###

    test "select by id" do
      @jsd.id = "test"
      assert_equal(@jsd.byID.element, "document.getElementById('test');")
    end
    
    test "select by id, no rec" do
      @jsd.id = "test"
      assert_equal(@jsd.orders[0], nil)
    end

    
    test "select by id and rec" do
      @jsd.id = "test"
      @jsd.byID.rec
      assert_equal(@jsd.orders[0] , "document.getElementById('test');")
    end
    
   
    test "select by class" do
      @jsd.updateSelector "id__koko", "cls__p"
      assert_equal(@jsd.byID.element, "document.getElementById('koko');")
      assert_equal(@jsd.byClassName.element, "document.getElementByClassName('p');")
    end

    test "select by class and rec" do
      @jsd.updateSelector "id__koko", "cls__p"
      @jsd.byID.rec
      @jsd.byClassName.rec
      assert_equal(@jsd.orders[0], "document.getElementById('koko');")
      assert_equal(@jsd.orders[1], "document.getElementByClassName('p');")
    end

    
    test "select by class case 2" do
      @jsd.updateSelector :id__koko, :cls__p
      assert_equal(@jsd.byID.element, "document.getElementById('koko');")
      assert_equal(@jsd.byClassName.element, "document.getElementByClassName('p');")
    end
    
    test "select by TagName" do
      @jsd.updateSelector "id__koko","cls__p","name__popo"
      assert_equal(@jsd.byID.element, "document.getElementById('koko');")
      assert_equal(@jsd.byClassName.element, "document.getElementByClassName('p');")
      assert_equal(@jsd.byTagName.element, "document.getElementByTagName('popo');")
    end
    
    test "select by TagName case 2" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      assert_equal(@jsd.byID.element, "document.getElementById('koko');")
      assert_equal(@jsd.byClassName.element, "document.getElementByClassName('p');")
      assert_equal(@jsd.byTagName.element, "document.getElementByTagName('popo');")
    end
    
    
    # # # # # ### add and delete element ###
    test "createElement" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.createElement("koko").rec
      assert_equal(@jsd.orders[0], "document.createElement('koko');")

    end
    
    test "createElement orders count" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.createElement("koko").rec
      assert_equal(@jsd.orders.count, 1)

    end
    
    test "removeChild" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.removeChild("aaa").rec
      assert_equal(@jsd.orders[0], "document.removeChild(aaa);")

    end
    
    
    test "document write, do not need rec" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.write("koko")
      assert_equal(@jsd.orders[0], "document.write('koko');")
    end
    
    # # # ### change element ###
    
    test "innerHTML, no rec" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID.innerHTML "aaa"
      assert_equal(@jsd.orders[0], "document.getElementById('koko').innerHTML=\"aaa\";")
    end

        
    test "innerHTML, rec case 2" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID
      a.innerHTML("aaa")
      assert_equal(@jsd.orders[0], "document.getElementById('koko').innerHTML=\"aaa\";")
    end
     
    test "innerHTML, rec case 3" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID
      a.innerHTML("aaa")
      a.innerHTML("bbb")
      assert_equal(@jsd.orders[0], "document.getElementById('koko').innerHTML=\"aaa\";")
      assert_equal(@jsd.orders[1], "document.getElementById('koko').innerHTML=\"bbb\";")
    end
    
    test "innerHTML, rec case 4" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID.innerHTML("aaa")      
      
      # if you want to write a.innerHTML "bbb",
      # write following code
      # a = @jsd.byID
      # a.innerHTML("aaa")
      # a.innerHTML("bbb")

      assert_raise{
        a.innerHTML "bbb"
        
      }

    end

        
    test "attribute case 1 (rec do not call)" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.attribute "aaa"
      assert_equal(@jsd.orders[0], "document.getElementById('koko').attribute=\"aaa\";")
    end
    
    test "attribute, call rec" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      assert_raise {
        @jsd.byID.attribute ("aaa").rec
      }
    end

    # ### setAttribute ###
    
    test "setAttribute case 1" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.setAttribute(btn:"red")
      assert_equal(@jsd.orders[0], "document.getElementById('koko').setAttribute(\"btn\",\"red\");")

    end
    
    test "setAttribute, case 2" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.setAttribute(btn:"red")
      @jsd.byID.setAttribute(btn:"blue")
      assert_equal(@jsd.orders[0], "document.getElementById('koko').setAttribute(\"btn\",\"red\");")
      assert_equal(@jsd.orders[1], "document.getElementById('koko').setAttribute(\"btn\",\"blue\");")
    end
    
    test "setAttribute, rec case 3" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.setAttribute(btn:"red", btn_:"blue")
      assert_equal(@jsd.orders[0], "document.getElementById('koko').setAttribute(\"btn\",\"red\");")
      assert_equal(@jsd.orders[1], "document.getElementById('koko').setAttribute(\"btn\",\"blue\");")
    end

    
    # ### style ####
    
    test "style, rec" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.style(backgroundColor:"red")
      @jsd.byID.style(color:"red")
      assert_equal(@jsd.orders[0], "document.getElementById('koko').style.backgroundColor='red';")
      assert_equal(@jsd.orders[1], "document.getElementById('koko').style.color='red';")
    end

    test "style, rec case 2" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID
      a.style(backgroundColor:"red",color:"red")
      assert_equal(@jsd.orders[0], "document.getElementById('koko').style.backgroundColor='red';")
      assert_equal(@jsd.orders[1], "document.getElementById('koko').style.color='red';")
    end
    
    # ### index ###
    test "index" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.index(0).innerHTML("aaa")
      assert_equal(@jsd.orders[0],"document.getElementById('koko')[0].innerHTML=\"aaa\";")

    end
    
    test "index case 2" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.index(0).innerHTML("aaa")
      @jsd.byID.index(1).innerHTML("bbb")
      assert_equal(@jsd.orders[1],"document.getElementById('koko')[1].innerHTML=\"bbb\";")

    end

    test "index element" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID.index(0).element
      assert_equal(a,"document.getElementById('koko')[0];")

    end
    
    test "index element case 2" do  
      @jsd.updateSelector :id__koko
      a = @jsd.byID.index(0).element
      assert_equal(a,"document.getElementById('koko')[0];")

    end


    # ### addEventListener #####
    test "addEventListener case 1" do
      @jsd.byID.addEventListener(click:"myFunction()")
      assert_equal @jsd.orders.first, "document.getElementById('').addEventListener(\"click\",'myFunction()');"
            
    end

    test "addEventListener case 2" do
      @jsd.byID.addEventListener(click:"ksFunc",onclick:"muFinc()")
      
      assert_equal @jsd.orders.first, "document.getElementById('').addEventListener(\"click\",'ksFunc');"
      assert_equal @jsd.orders.last, "document.getElementById('').addEventListener(\"onclick\",'muFinc()');"
    end

    
    
    test "addEventListener case same event" do
      @jsd.byID.addEventListener(click:"ksFunc",click_:"muFinc()")
      
      assert_equal @jsd.orders.first, "document.getElementById('').addEventListener(\"click\",'ksFunc');"
      assert_equal @jsd.orders.last, "document.getElementById('').addEventListener(\"click\",'muFinc()');"
    end

    test "addEventListenerUseCapture case 1" do
      @jsd.byID.addEventListenerUseCapture(click:"myFunc")
      assert_equal @jsd.orders.first, "document.getElementById('').addEventListener(\"click\",'myFunc',true);"
      
    end

    test "addEventListenerUseCapture case same event" do
      @jsd.byID.addEventListenerUseCapture(click:"myFunc", click_:"ksFunc")
      assert_equal @jsd.orders.first, "document.getElementById('').addEventListener(\"click\",'myFunc',true);"
      assert_equal @jsd.orders.last, "document.getElementById('').addEventListener(\"click\",'ksFunc',true);"      
    end


    ### node ###
    test "first node" do
      
      @jsd.byID.firstChild("type")
      assert_equal @jsd.orders.first, "document.getElementById('').firstChild.nodeType;"
      
    end

    test "first node value" do
      v = @jsd.byID.firstChild("type").record
      assert_equal v, "document.getElementById('').firstChild.nodeType;"
      
    end

    
    test "first node case symbol" do
      
      @jsd.byID.firstChild(:name)
      assert_equal @jsd.orders.first, "document.getElementById('').firstChild.nodeName;"  
    end
    
    test "first node no type" do
      
      @jsd.byID.firstChild ""
      assert_equal @jsd.orders.first, "document.getElementById('').firstChild;"
      
    end
    
    test "first node ommit type" do
      
      @jsd.byID.firstChild
      assert_equal @jsd.orders.first, "document.getElementById('').firstChild;"
      
    end

    
    
    test "last node case symbol"do
      @jsd.byID.lastChild :name
      assert_equal @jsd.orders.first, "document.getElementById('').lastChild.nodeName;"
    end

    test "last node case symbol value"do
      v = @jsd.byID.lastChild(:name).record
      assert_equal v, "document.getElementById('').lastChild.nodeName;"
    end


    test "last node case ommit type" do
      @jsd.byID.lastChild
      assert_equal @jsd.orders.first, "document.getElementById('').lastChild;"
    end

    
    
    test "parent node case symbol" do
      @jsd.byID.parentNode :type
      assert_equal @jsd.orders.first, "document.getElementById('').parentNode.nodeType;"
    end

    test "parentNode ommit type" do
      @jsd.byID.parentNode
      assert_equal @jsd.orders.first, "document.getElementById('').parentNode;"
    end
    
    
    test "nextSibling" do
      @jsd.byID.nextSibling
      assert_equal @jsd.orders.first, "document.getElementById('').nextSibling;"
    end

    
    test "previousSibling" do
      @jsd.byID.previousSibling
      assert_equal @jsd.orders.first, "document.getElementById('').previousSibling;"
    end
    
    test "childNodes case 1" do
      @jsd.byID.childNodes(0,:type)
      assert_equal @jsd.orders.first, "document.getElementById('').childNodes[0].nodeType;"
    end

    test "childNodes case ommit type" do
      @jsd.byID.childNodes(1)
      assert_equal @jsd.orders.first, "document.getElementById('').childNodes[1];"
    end


    ### is_var ###
    test "is_var first test" do
      @jsd.byID.firstChild(:name).is_var(:test)
      # p @jsd.records
      assert_equal @jsd.record, "var test = document.getElementById('').firstChild.nodeName;"
    end

    test "is_var childNodes case ommit type" do
      @jsd.byID.childNodes(1).is_var(:test)
      assert_equal @jsd.orders.first, "var test = document.getElementById('').childNodes[1];"
    end
    
    test "is_var childNodes case ommit type case 2" do
      @jsd.byID.childNodes(1).is_var(:test)
      assert_equal @jsd.record, "var test = document.getElementById('').childNodes[1];"
    end


    test "is_var childNodes case ommit type case 3" do
      @jsd.byID.childNodes(0)
      @jsd.byID.childNodes(1).is_var(:test)
      
      # p @jsd.records
      assert_equal @jsd.records[1], "var test = document.getElementById('').childNodes[1];"
    end

    test "is_var childNodes case ommit type case 4" do
      
      @jsd.byID.childNodes(0).is_var(:sample)
      @jsd.byID.childNodes(1).is_var(:test)
      
      # p @jsd.records
      assert_equal @jsd.records[0], "var sample = document.getElementById('').childNodes[0];"
      assert_equal @jsd.records[1], "var test = document.getElementById('').childNodes[1];"
      
    end
    
  end
end
