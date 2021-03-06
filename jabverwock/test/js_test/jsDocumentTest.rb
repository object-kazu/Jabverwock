require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsDocument'

# require 'opal'

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  class JsDocumentTest < Test::Unit::TestCase
    class << self
      # テスト群の実行前に呼ばれる．変な初期化トリックがいらなくなる
      def startup
#        p :_startup
      
      end

      # テスト群の実行後に呼ばれる
      def shutdown
 #       p :_shutdown
      end
    end

    # 毎回テスト実行前に呼ばれる
    def setup
  #    p :setup
      @jsd = JsDocument.new
    end

    # テストがpassedになっている場合に，テスト実行後に呼ばれる．テスト後の状態確認とかに使える
    def cleanup
   #   p :cleanup
    end

    # 毎回テスト実行後に呼ばれる
    def teardown
    #  p :treadown
    end

    ############## test ###############

    # test "jsDocument first test, for print debug " do
    #   p @jsd
    # end

    
    ### find element ###

    test 'select by id' do
      @jsd.id = 'test'
      ans = @jsd.byID
      assert_equal(@jsd.orders[0], "document.getElementById('test');")
    end
    
     test 'select by id, no rec' do
      @jsd.id = 'test'
      assert_equal(@jsd.orders[0], nil)
    end

    
    test 'select by id and rec' do
      @jsd.id = 'test'
      @jsd.byID
      assert_equal(@jsd.orders[0] , "document.getElementById('test');")
      assert_equal(@jsd.orders[1] , nil)
    end
    
    
    test 'select by class and rec' do
      @jsd.updateSelector 'id__koko', 'cls__p'
      @jsd.byID
      @jsd.byClassName
      assert_equal(@jsd.orders[0], "document.getElementById('koko');")
      assert_equal(@jsd.orders[1], "document.getElementByClassName('p');")
      assert_equal(@jsd.orders[2], nil)
    end

    
    test 'select by class case 2' do
      @jsd.updateSelector :id__koko, :cls__p, :name__popo
      @jsd.byID
      @jsd.byClassName
      @jsd.byTagName
      assert_equal(@jsd.orders[0], "document.getElementById('koko');")
      assert_equal(@jsd.orders[1], "document.getElementByClassName('p');")
      assert_equal(@jsd.orders[2], "document.getElementByTagName('popo');")
      assert_equal(@jsd.orders[3], nil)
    end
    
    
    
    
 # # #    # # # # # ### add and delete element ###
    test 'createElement' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.createElement('koko')
      assert_equal(@jsd.orders[0], "document.createElement('koko');")
      assert_equal @jsd.orders[1], nil
    end
    

    test 'createElement units ,symbol' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.createElement :koko
      assert_equal @jsd.orders[0],"document.createElement('koko');" 
      assert_equal @jsd.orders[1], nil
      
    end

    test 'createElement is_var, unit is nil' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.createElement(:koko).is_var(:mm)
      assert_equal(@jsd.units.first, nil)
    end
    
    test 'createElement is_var, equality is available' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.createElement(:koko).is_var(:mm)
      assert_equal(@jsd.lastEqualityValue, "var mm = document.createElement('koko');")
    end

    test 'createTextNode, units is nil, equality is available' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.createElement(:koko).is_var(:mm)
      @jsd.createTextNode('this is new.'.sQuo).is_var(:new)
      
      assert_equal(@jsd.equalities[0], "var mm = document.createElement('koko');")
      assert_equal(@jsd.equalities[1], "var new = document.createTextNode('this is new.');")

      assert_equal(@jsd.units[0], nil)
      assert_equal @jsd.docRecords[0], nil
    end

    test 'createTextNode, show orders' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.createElement(:koko).is_var(:mm)
      @jsd.createTextNode('this is new.'.sQuo).is_var(:new)
      
      assert_equal(@jsd.equalities[0], @jsd.orders[0])
      assert_equal(@jsd.equalities[1], @jsd.orders[1])
      
      assert_equal @jsd.units[0], nil
      assert_equal @jsd.docRecords[0], nil
      
    end

    
    test 'createTextNode and addChild, which save at equality, not units!' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.createElement(:koko).is_var(:mm)
      @jsd.createTextNode('this is new'.sQuo).is_var(:nn)
      @jsd.appendChild(:mm, :nn)
      
      assert_equal(@jsd.equalities[0], "var mm = document.createElement('koko');")
      assert_equal(@jsd.equalities[1], "var nn = document.createTextNode('this is new');")      
      assert_equal(@jsd.equalities[2], 'mm.appendChild(nn);')
      
    end    
    
    
    test 'var with element' do
      @jsd.byID.is_var :mm

      assert_equal(@jsd.equalities[0], "var mm = document.getElementById('');")
    end
    
    
    test 'var wich case 2' do
      @jsd.createElement(:p).is_var :para
      @jsd.createTextNode('this is new'.sQuo).is_var :nn
      assert_equal(@jsd.equalities[0], "var para = document.createElement('p');")
      assert_equal(@jsd.equalities[1], "var nn = document.createTextNode('this is new');")      
    end


    test 'ideal expression, createTextNode, byID and addChild' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      
      @jsd.createElement(:koko).is_var(:mm)
      @jsd.createTextNode('this is new'.sQuo).is_var(:nn)
      @jsd.byID.is_var :para
      
      assert_equal(@jsd.equalities[0], "var mm = document.createElement('koko');")            
      assert_equal(@jsd.equalities[1], "var nn = document.createTextNode('this is new');")            
      assert_equal(@jsd.equalities[2], "var para = document.getElementById('koko');")                   
      
    end    
        
    test 'good expression, createTextNode, byID and addChild' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      
      @jsd.createElement(:koko).is_var(:mm)                # => equalities 0 
      @jsd.createTextNode('this is new'.sQuo).is_var(:nn)  # => equalities 1
      @jsd.appendChild :mm, :nn                            # => equalities 2
      
      @jsd.byID.is_var :aa                       # => equalities 3
      
      
      assert_equal(@jsd.equalities[1], "var nn = document.createTextNode('this is new');")      
      assert_equal(@jsd.equalities[2], 'mm.appendChild(nn);')      

    end    

    
    test 'removeChild' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.removeChild(:para, 'aaa')
      assert_equal(@jsd.orders[0], 'para.removeChild(aaa);')

    end


    test 'replaceChild' do
      @jsd.replaceChild :para, :a, :b
      assert_equal @jsd.orders[0], 'para.replaceChild(a, b)'
    end
    
    test 'document write, do not need rec' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      
      @jsd.createElement(:koko).is_var(:mm) #0
      @jsd.createTextNode('this is new'.sQuo).is_var(:nn) #1
      @jsd.appendChild(:mm, :nn) #2
      @jsd.write('koko') #3
      
      assert_equal(@jsd.orders[3], "document.write('koko');")

    end
    
 # # #    # # # ### change element ###
    
    test 'innerHTML, no rec' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID.innerHTML 'aaa'.dQuo
      assert_equal(@jsd.orders[0], "document.getElementById('koko').innerHTML = \"aaa\";")
      assert_equal @jsd.orders[1], nil
    end

        
    test 'innerHTML, rec case 2' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID
      a.innerHTML('aaa'.dQuo)
      assert_equal(@jsd.orders[0], "document.getElementById('koko').innerHTML = \"aaa\";")
    end
     
    test 'innerHTML, rec case 3' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID
      a.innerHTML('aaa'.dQuo)
      a.innerHTML('bbb'.dQuo)
      assert_equal(@jsd.orders[0], "document.getElementById('koko').innerHTML = \"aaa\";")
      assert_equal(@jsd.orders[1], "document.getElementById('koko').innerHTML = \"bbb\";")
      assert_equal @jsd.orders[2], nil
    end
    
    test 'innerHTML, rec case 4' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID.innerHTML('aaa'.dQuo)      
      a.innerHTML 'bbb'.dQuo

      assert_equal(@jsd.orders[0], "document.getElementById('koko').innerHTML = \"aaa\";")
      assert_equal(@jsd.orders[1], "document.getElementById('koko').innerHTML = \"bbb\";")
      assert_equal @jsd.orders[2], nil
      
    end
        
    test 'attribute case 1 (rec do not call)' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.attribute 'aaa'.dQuo
      assert_equal(@jsd.orders[0], "document.getElementById('koko').attribute = \"aaa\";")
    end
    
    test 'attribute, call rec' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      assert_raise {
        @jsd.byID.attribute ('aaa').rec
      }
    end

 #    # ### setAttribute ###
    
    test 'setAttribute case 1' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.setAttribute(btn:'red')
      assert_equal(@jsd.orders[0], "document.getElementById('koko').setAttribute(\"btn\",\"red\");")

    end
    
    test 'setAttribute, case 2' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.setAttribute(btn:'red')
      @jsd.byID.setAttribute(btn:'blue')
      assert_equal(@jsd.orders[0], "document.getElementById('koko').setAttribute(\"btn\",\"red\");")
      assert_equal(@jsd.orders[1], "document.getElementById('koko').setAttribute(\"btn\",\"blue\");")
    end
    
    test 'setAttribute, rec case 3' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.setAttribute(btn:'red', btn_:'blue')
      assert_equal(@jsd.orders[0], "document.getElementById('koko').setAttribute(\"btn\",\"red\");")
      assert_equal(@jsd.orders[1], "document.getElementById('koko').setAttribute(\"btn\",\"blue\");")
    end

    
 #    # ### style ####
    
    test 'style, rec' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.style(backgroundColor:'red')
      @jsd.byID.style(color:'red')
      assert_equal(@jsd.orders[0], "document.getElementById('koko').style.backgroundColor='red';")
      assert_equal(@jsd.orders[1], "document.getElementById('koko').style.color='red';")
    end

    test 'style, rec case 2' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID
      a.style(backgroundColor:'red',color:'red')
      assert_equal(@jsd.orders[0], "document.getElementById('koko').style.backgroundColor='red';")
      assert_equal(@jsd.orders[1], "document.getElementById('koko').style.color='red';")
    end
    
    # ### index ###
    test 'index' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.index(0).innerHTML('aaa'.dQuo)
      assert_equal(@jsd.orders[0],"document.getElementById('koko')[0].innerHTML = \"aaa\";")

    end
    
    test 'index case 2' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.index(0).innerHTML('aaa'.dQuo)
      @jsd.byID.index(1).innerHTML('bbb'.dQuo)
      assert_equal(@jsd.orders[1],"document.getElementById('koko')[1].innerHTML = \"bbb\";")

    end

    test 'index element' do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      @jsd.byID.index(0)
      assert_equal(@jsd.orders[0],"document.getElementById('koko')[0];")

    end
    
    test 'index element case 2, nil check' do  
      @jsd.updateSelector :id__koko
      @jsd.byID.index(0)
      assert_equal(@jsd.orders[0],"document.getElementById('koko')[0];")      
      assert_equal @jsd.orders[1], nil

    end
    
    
 #    # ### addEventListener #####
    test 'addEventListener case 1' do
      @jsd.byID.addEventListener(click:'myFunction()')
      assert_equal @jsd.orders.first, "document.getElementById('').addEventListener(\"click\",myFunction());"
            
    end

    test 'addEventListener case 2' do
      @jsd.byID.addEventListener(click:'ksFunc',onclick:'muFinc()')
      
      assert_equal @jsd.orders.first, "document.getElementById('').addEventListener(\"click\",ksFunc);"
      assert_equal @jsd.orders.last, "document.getElementById('').addEventListener(\"onclick\",muFinc());"
    end
    
    
    test 'addEventListener case same event' do
      @jsd.byID.addEventListener(click:'ksFunc',click_:'muFinc()')
      
      assert_equal @jsd.orders.first, "document.getElementById('').addEventListener(\"click\",ksFunc);"
      assert_equal @jsd.orders.last, "document.getElementById('').addEventListener(\"click\",muFinc());"
    end

    test 'addEventListenerUseCapture case 1' do
      @jsd.byID.addEventListenerUseCapture(click:'myFunc')
      assert_equal @jsd.orders.first, "document.getElementById('').addEventListener(\"click\",myFunc,true);"
      
    end

    test 'addEventListenerUseCapture case same event' do
      @jsd.byID.addEventListenerUseCapture(click:'myFunc', click_:'ksFunc')
      assert_equal @jsd.orders.first, "document.getElementById('').addEventListener(\"click\",myFunc,true);"
      assert_equal @jsd.orders.last, "document.getElementById('').addEventListener(\"click\",ksFunc,true);"      
    end


 #    ### node ###
    test 'first node' do
      
      @jsd.byID.firstChild('type')
      assert_equal @jsd.orders.first, "document.getElementById('').firstChild.nodeType;"
      
    end
    
    test 'first node call twice' do
      
      @jsd.byID.firstChild('type')
      @jsd.byID.firstChild(:type)
      assert_equal @jsd.orders.first, "document.getElementById('').firstChild.nodeType;"
      assert_equal @jsd.records[1], "document.getElementById('').firstChild.nodeType;"
      
    end
    
    test 'first node value' do
      v = @jsd.byID.firstChild('type').record
      assert_equal v, "document.getElementById('').firstChild.nodeType;"
      
    end
    
    test 'first node case symbol' do
      
      @jsd.byID.firstChild(:name)
      assert_equal @jsd.orders.first, "document.getElementById('').firstChild.nodeName;"  
    end
    
    test 'first node no type' do
      
      @jsd.byID.firstChild ''
      assert_equal @jsd.orders.first, "document.getElementById('').firstChild;"
      
    end
    
    test 'first node ommit type' do
      
      @jsd.byID.firstChild
      assert_equal @jsd.orders.first, "document.getElementById('').firstChild;"
      
    end
    
    test 'last node case symbol'do
      @jsd.byID.lastChild :name
      assert_equal @jsd.orders.first, "document.getElementById('').lastChild.nodeName;"
    end

    test 'last node case symbol value'do
      v = @jsd.byID.lastChild(:name).record
      assert_equal v, "document.getElementById('').lastChild.nodeName;"
    end

    test 'last node case ommit type' do
      @jsd.byID.lastChild
      assert_equal @jsd.orders.first, "document.getElementById('').lastChild;"
    end
    
    test 'parent node case symbol' do
      @jsd.byID.parentNode :type
      # assert_equal @jsd.units.first, "document.getElementById('').parentNode.nodeType;"
      assert_equal @jsd.record, "document.getElementById('').parentNode.nodeType;"
    end

    test 'parentNode ommit type' do
      @jsd.byID.parentNode
      # assert_equal @jsd.units.first, "document.getElementById('').parentNode;"
      assert_equal @jsd.record, "document.getElementById('').parentNode;"
    end
    
    
    test 'nextSibling' do
      @jsd.byID.nextSibling
      # assert_equal @jsd.units.first, "document.getElementById('').nextSibling;"
      assert_equal @jsd.record, "document.getElementById('').nextSibling;"
    end

    
    test 'previousSibling' do
      @jsd.byID.previousSibling
      # assert_equal @jsd.units.first, "document.getElementById('').previousSibling;"
      assert_equal @jsd.record, "document.getElementById('').previousSibling;"
    end
    
    test 'childNodes case 1' do
      @jsd.byID.childNodes(0,:type)
      # assert_equal @jsd.units.first, "document.getElementById('').childNodes[0].nodeType;"
      assert_equal @jsd.record, "document.getElementById('').childNodes[0].nodeType;"
    end

    test 'childNodes case ommit type' do
      @jsd.byID.childNodes(1)
      # assert_equal @jsd.units.first, "document.getElementById('').childNodes[1];"
      assert_equal @jsd.record, "document.getElementById('').childNodes[1];"
    end

 #    ### is_var ###
    test 'is_var first test' do
      @jsd.byID.firstChild(:name).is_var(:test)
      assert_equal @jsd.equalities.first, "var test = document.getElementById('').firstChild.nodeName;"
    end

    test 'is_var document.getElementById' do
      @jsd.byID.is_var(:test)
      assert_equal @jsd.equalities.first, "var test = document.getElementById('');"
    end
    
    test 'is_var document.getElementById and getElementByName' do
      @jsd.byID.is_var(:test)
      @jsd.byClassName.is_var :sample
      
      assert_equal @jsd.orders[0], "var test = document.getElementById('');"
      assert_equal @jsd.orders[1], "var sample = document.getElementByClassName('');"
      
    end
    
    test 'is_var childNodes case ommit type' do
      @jsd.byID.childNodes(1).is_var(:test)
      assert_equal @jsd.equalities.first, "var test = document.getElementById('').childNodes[1];"
    end
    
    test 'is_var childNodes case ommit type case 2' do
      @jsd.byID.childNodes(1).is_var(:test)
      assert_equal @jsd.equalities.first, "var test = document.getElementById('').childNodes[1];"
    end

    test 'is_var childNodes case ommit type case 3' do
      @jsd.byID.childNodes(0)               # ----> record
      @jsd.byID.childNodes(1).is_var(:test) # ----> equality[0]
      
      assert_equal @jsd.record, "document.getElementById('').childNodes[0];"
      assert_equal @jsd.equalities[0], "var test = document.getElementById('').childNodes[1];"
    end

    test 'is_var childNodes case ommit type case 4' do
      
      @jsd.byID.childNodes(0).is_var(:sample)
      @jsd.byID.childNodes(1).is_var(:test)
      
      # p @jsd.records
      assert_equal @jsd.equalities[0], "var sample = document.getElementById('').childNodes[0];"
      assert_equal @jsd.equalities[1], "var test = document.getElementById('').childNodes[1];"

    end


 # #    ### insertBefore ####
    test 'insertBefore' do
     @jsd.insertBefore 'aaa', 'bbb'
     assert_equal @jsd.orders.first , "aaa.parentNode.insertBefore(bbb,aaa);"
    end


 #    ### equal ###
    test 'equal case 1' do
      @jsd.equal 'test.id', 'title2'.sQuo
      assert_equal @jsd.record, "test.id = 'title2';"
    end
    
    test 'equal case 2' do
      @jsd.equal 'test.id', 'title1'.sQuo
      @jsd.equal 'sample.id', 'title2'.sQuo

      @jsd.equal 'test.id', 'title1'.sQuo
      @jsd.equal 'sample.id', 'title2'.sQuo

      @jsd.equal 'test.id', 'title1'.sQuo
      @jsd.equal 'sample.id', 'title2'.sQuo

      @jsd.equal 'test.id', 'title1'.sQuo
      @jsd.equal 'sample.id', 'title2'.sQuo

      @jsd.equal 'test.id', 'title1'.sQuo
      @jsd.equal 'sample.id', 'title2'.sQuo

      assert_equal @jsd.orders[0], "test.id = 'title1';"
      assert_equal @jsd.orders[1], "sample.id = 'title2';"

      assert_equal @jsd.orders[2], "test.id = 'title1';"
      assert_equal @jsd.orders[3], "sample.id = 'title2';"

      assert_equal @jsd.orders[4], "test.id = 'title1';"
      assert_equal @jsd.orders[5], "sample.id = 'title2';"

    end

    test 'equal case symbol can not use' do
      assert_raise{
        @jsd.equal :test, 'title2'
      }
     end

    # ### cut ###
    test 'cut, case ByID' do
      a = @jsd.byID.cut
      assert_equal a, "document.getElementById('')"
    end

    test 'cut, case innerHTML' do
      a = @jsd.byID.innerHTML('aa'.sQuo).cut
      assert_equal a, "document.getElementById('').innerHTML = 'aa'"
    end

    test 'cut, case setAttribute' do
      a = @jsd.byID.setAttribute(btn:'red').cut
      b = @jsd.byID.setAttribute(btn:'blue').cut
      assert_equal a, "document.getElementById('').setAttribute(\"btn\",\"red\")"
      assert_equal b, "document.getElementById('').setAttribute(\"btn\",\"blue\")"

      assert_equal @jsd.orders[0], nil
      assert_equal @jsd.orders[1], nil
     
    end

    test 'cut, case attribute'do
      a = @jsd.byID.attribute('aaa'.dQuo).cut
      assert_equal a, "document.getElementById('').attribute = \"aaa\""
      assert_equal @jsd.orders[0], nil
    end

    test 'cut, case addEventListener' do
      a = @jsd.byID.addEventListener(click:'myFunction()').cut
      assert_equal a, "document.getElementById('').addEventListener(\"click\",myFunction())"
    end
    
    test 'cut, case addEventListener case 2' do
      a = @jsd.byID.addEventListener(click:'myFunc', click_:'ksFunc').cut
      assert_equal a, "document.getElementById('').addEventListener(\"click\",ksFunc)"
      
    end

    test 'cut, case style' do
      a = @jsd.byID.style(backgroundColor:'red',color:'red').cut
      assert_equal a, "document.getElementById('').style.color='red'"
    
    end

    test 'cut, case child node' do
      a = @jsd.byID.childNodes(0).cut
      assert_equal a,  "document.getElementById('').childNodes[0]"
    end
    
    ### cuts ####
    
    test 'cuts, case addEventListener' do
      a = @jsd.byID.addEventListener(click:'myFunc', click_:'ksFunc').cuts
      assert_equal a[0], "document.getElementById('').addEventListener(\"click\",myFunc)"
      assert_equal a[1], "document.getElementById('').addEventListener(\"click\",ksFunc)"
      assert_equal a[2], nil
      
    end
    
    test 'cuts, case style' do
      a = @jsd.byID.style(backgroundColor:'red',color:'red').cuts
      assert_equal(a[0], "document.getElementById('').style.backgroundColor='red'")
      assert_equal(a[1], "document.getElementById('').style.color='red'")

      # unitsHash dose not exist
      assert_equal @jsd.orders[0], nil
      
    end
    
    test 'cuts, case style case other docHash and unitsHash do not influence' do
      @jsd.byID.style(backgroundColor:'red',color:'red')
      a = @jsd.byID.style(backgroundColor:'blue',color:'blue').cuts
      
      # last arg == 2
      assert_equal(a[0], "document.getElementById('').style.backgroundColor='blue'")
      assert_equal(a[1], "document.getElementById('').style.color='blue'")
      assert_equal a[2], nil

      # unitsHash remain
      assert_equal @jsd.orders[0], "document.getElementById('').style.backgroundColor='red';"
      assert_equal @jsd.orders[1], "document.getElementById('').style.color='red';"
    end

    
    ### selfy ###
    test 'selfy, basical use' do
      @jsd.selfy{ |t|
        t.createElement :p
        t.createTextNode 'this ss'
      }

      assert_equal @jsd.orders.first, "document.createElement('p');"
      assert_equal @jsd.orders[1], "document.createTextNode(this ss);"
    end

    
    test 'orders check' do

      @jsd.selfy{ |t|
        t.createElement(:p).is_var :para
        t.createTextNode('This is new.'.sQuo).is_var :node
        t.appendChild(:para, :node)
        t.byID.is_var :element
      }
      
      @jsd.equal 'newNode.id', 'title2'.sQuo
      @jsd.insertBefore 'title3Node', 'newNode'

      assert_equal @jsd.orders.first, "var para = document.createElement('p');"
      assert_equal @jsd.orders[1], "var node = document.createTextNode('This is new.');"
      assert_equal @jsd.orders[2], "para.appendChild(node);"
      assert_equal @jsd.orders[3], "var element = document.getElementById('');"
      assert_equal @jsd.orders[4], "newNode.id = 'title2';"
      assert_equal @jsd.orders[5], 'title3Node.parentNode.insertBefore(newNode,title3Node);'
    end

  end
end
