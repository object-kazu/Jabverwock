require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    subject(:jsd){JsDocument.new}
    ### find element ###
    
    it 'select by id' do
      jsd.id = 'test'
      ans = jsd.byID
      expect(jsd.orders[0]).to eq "document.getElementById('test');"
    end
    
     it 'select by id, no rec' do
      jsd.id = 'test'
      expect(jsd.orders[0]).to eq nil
    end

    
    it 'select by id and rec' do
      jsd.id = 'test'
      jsd.byID
      expect(jsd.orders[0] ).to eq "document.getElementById('test');"
      expect(jsd.orders[1] ).to eq nil
    end
    
    
    it 'select by class and rec' do
      jsd.updateSelector 'id__koko', 'cls__p'
      jsd.byID
      jsd.byClassName
      expect(jsd.orders[0]).to eq "document.getElementById('koko');"
      expect(jsd.orders[1]).to eq "document.getElementByClassName('p');"
      expect(jsd.orders[2]).to eq nil
    end

    
    it 'select by class case 2' do
      jsd.updateSelector :id__koko, :cls__p, :name__popo
      jsd.byID
      jsd.byClassName
      jsd.byTagName
      expect(jsd.orders[0]).to eq "document.getElementById('koko');"
      expect(jsd.orders[1]).to eq "document.getElementByClassName('p');"
      expect(jsd.orders[2]).to eq "document.getElementByTagName('popo');"
      expect(jsd.orders[3]).to eq nil
    end
    
    
    
    
 # # #    # # # # # ### add and delete element ###
    it 'createElement' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.createElement('koko')
      expect(jsd.orders[0]).to eq "document.createElement('koko');"
      expect(jsd.orders[1]).to eq nil
    end
    

    it 'createElement units ,symbol' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.createElement :koko
      expect(jsd.orders[0]).to eq"document.createElement('koko');" 
      expect(jsd.orders[1]).to eq nil
      
    end

    it 'createElement is_var, unit is nil' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.createElement(:koko).is_var(:mm)
      expect(jsd.units.first).to eq nil
    end
    
    it 'createElement is_var, equality is available' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.createElement(:koko).is_var(:mm)
      expect(jsd.lastEqualityValue).to eq "var mm = document.createElement('koko');"
    end

    it 'createTextNode, units is nil, equality is available' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.createElement(:koko).is_var(:mm)
      jsd.createTextNode('this is new.'.sQuo).is_var(:new)
      
      expect(jsd.equalities[0]).to eq "var mm = document.createElement('koko');"
      expect(jsd.equalities[1]).to eq "var new = document.createTextNode('this is new.');"

      expect(jsd.units[0]).to eq nil
      expect(jsd.docRecords[0]).to eq nil
    end

    it 'createTextNode, show orders' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.createElement(:koko).is_var(:mm)
      jsd.createTextNode('this is new.'.sQuo).is_var(:new)
      
      expect(jsd.equalities[0]).to eq jsd.orders[0]
      expect(jsd.equalities[1]).to eq jsd.orders[1]
      
      expect(jsd.units[0]).to eq nil
      expect(jsd.docRecords[0]).to eq nil
      
    end

    
    it 'createTextNode and addChild, which save at equality, not units!' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.createElement(:koko).is_var(:mm)
      jsd.createTextNode('this is new'.sQuo).is_var(:nn)
      jsd.appendChild(:mm, :nn)
      
      expect(jsd.equalities[0]).to eq "var mm = document.createElement('koko');"
      expect(jsd.equalities[1]).to eq "var nn = document.createTextNode('this is new');"
      expect(jsd.equalities[2]).to eq 'mm.appendChild(nn);'
      
    end    
    
    
    it 'var with element' do
      jsd.byID.is_var :mm

      expect(jsd.equalities[0]).to eq "var mm = document.getElementById('');"
    end
    
    
    it 'var wich case 2' do
      jsd.createElement(:p).is_var :para
      jsd.createTextNode('this is new'.sQuo).is_var :nn
      expect(jsd.equalities[0]).to eq "var para = document.createElement('p');"
      expect(jsd.equalities[1]).to eq "var nn = document.createTextNode('this is new');"
    end


    it 'ideal expression, createTextNode, byID and addChild' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      
      jsd.createElement(:koko).is_var(:mm)
      jsd.createTextNode('this is new'.sQuo).is_var(:nn)
      jsd.byID.is_var :para
      
      expect(jsd.equalities[0]).to eq "var mm = document.createElement('koko');"     
      expect(jsd.equalities[1]).to eq "var nn = document.createTextNode('this is new');"
      expect(jsd.equalities[2]).to eq "var para = document.getElementById('koko');"               
      
    end    
        
    it 'good expression, createTextNode, byID and addChild' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      
      jsd.createElement(:koko).is_var(:mm)                # => equalities 0 
      jsd.createTextNode('this is new'.sQuo).is_var(:nn)  # => equalities 1
      jsd.appendChild :mm, :nn                            # => equalities 2
      
      jsd.byID.is_var :aa                       # => equalities 3
      
      
      expect(jsd.equalities[1]).to eq "var nn = document.createTextNode('this is new');"
      expect(jsd.equalities[2]).to eq 'mm.appendChild(nn);'

    end    

    
    it 'removeChild' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.removeChild(:para, 'aaa')
      expect(jsd.orders[0]).to eq 'para.removeChild(aaa);'

    end


    it 'replaceChild' do
      jsd.replaceChild :para, :a, :b
      expect(jsd.orders[0]).to eq 'para.replaceChild(a, b)'
    end
    
    it 'document write, do not need rec' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      
      jsd.createElement(:koko).is_var(:mm) #0
      jsd.createTextNode('this is new'.sQuo).is_var(:nn) #1
      jsd.appendChild(:mm, :nn) #2
      jsd.write('koko') #3
      
      expect(jsd.orders[3]).to eq "document.write('koko');"

    end
    
 # # #    # # # ### change element ###
    
    it 'innerHTML, no rec' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = jsd.byID.innerHTML 'aaa'.dQuo
      expect(jsd.orders[0]).to eq "document.getElementById('koko').innerHTML = \"aaa\";"
      expect(jsd.orders[1]).to eq nil
    end

        
    it 'innerHTML, rec case 2' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = jsd.byID
      a.innerHTML('aaa'.dQuo)
      expect(jsd.orders[0]).to eq "document.getElementById('koko').innerHTML = \"aaa\";"
    end
     
    it 'innerHTML, rec case 3' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = jsd.byID
      a.innerHTML('aaa'.dQuo)
      a.innerHTML('bbb'.dQuo)
      expect(jsd.orders[0]).to eq "document.getElementById('koko').innerHTML = \"aaa\";"
      expect(jsd.orders[1]).to eq "document.getElementById('koko').innerHTML = \"bbb\";"
      expect(jsd.orders[2]).to eq nil
    end
    
    it 'innerHTML, rec case 4' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = jsd.byID.innerHTML('aaa'.dQuo)      
      a.innerHTML 'bbb'.dQuo

      expect(jsd.orders[0]).to eq "document.getElementById('koko').innerHTML = \"aaa\";"
      expect(jsd.orders[1]).to eq "document.getElementById('koko').innerHTML = \"bbb\";"
      expect(jsd.orders[2]).to eq nil
      
    end
        
    it 'attribute case 1 (rec do not call)' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.byID.attribute 'aaa'.dQuo
      expect(jsd.orders[0]).to eq "document.getElementById('koko').attribute = \"aaa\";"
    end
    
    it 'attribute, call rec' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      expect{
        jsd.byID.attribute ('aaa').rec
      }.to raise_error StandardError
    end

 #    # ### setAttribute ###
    
    it 'setAttribute case 1' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.byID.setAttribute(btn:'red')
      expect(jsd.orders[0]).to eq "document.getElementById('koko').setAttribute(\"btn\",\"red\");"

    end
    
    it 'setAttribute, case 2' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.byID.setAttribute(btn:'red')
      jsd.byID.setAttribute(btn:'blue')
      expect(jsd.orders[0]).to eq "document.getElementById('koko').setAttribute(\"btn\",\"red\");"
      expect(jsd.orders[1]).to eq "document.getElementById('koko').setAttribute(\"btn\",\"blue\");"
    end
    
    it 'setAttribute, rec case 3' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.byID.setAttribute(btn:'red', btn_:'blue')
      expect(jsd.orders[0]).to eq "document.getElementById('koko').setAttribute(\"btn\",\"red\");"
      expect(jsd.orders[1]).to eq "document.getElementById('koko').setAttribute(\"btn\",\"blue\");"
    end

    
 #    # ### style ####
    
    it 'style, rec' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.byID.style(backgroundColor:'red')
      jsd.byID.style(color:'red')
      expect(jsd.orders[0]).to eq "document.getElementById('koko').style.backgroundColor='red';"
      expect(jsd.orders[1]).to eq "document.getElementById('koko').style.color='red';"
    end

    it 'style, rec case 2' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = jsd.byID
      a.style(backgroundColor:'red',color:'red')
      expect(jsd.orders[0]).to eq "document.getElementById('koko').style.backgroundColor='red';"
      expect(jsd.orders[1]).to eq "document.getElementById('koko').style.color='red';"
    end
    
    # ### index ###
    it 'index' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.byID.index(0).innerHTML('aaa'.dQuo)
      expect(jsd.orders[0]).to eq"document.getElementById('koko')[0].innerHTML = \"aaa\";"

    end
    
    it 'index case 2' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.byID.index(0).innerHTML('aaa'.dQuo)
      jsd.byID.index(1).innerHTML('bbb'.dQuo)
      expect(jsd.orders[1]).to eq"document.getElementById('koko')[1].innerHTML = \"bbb\";"

    end

    it 'index element' do
      jsd.updateSelector :id__koko, :cls__p,:name__popo
      jsd.byID.index(0)
      expect(jsd.orders[0]).to eq"document.getElementById('koko')[0];"

    end
    
    it 'index element case 2, nil check' do  
      jsd.updateSelector :id__koko
      jsd.byID.index(0)
      expect(jsd.orders[0]).to eq"document.getElementById('koko')[0];"      
      expect(jsd.orders[1]).to eq nil

    end
    
    
 #    # ### addEventListener #####
    it 'addEventListener case 1' do
      jsd.byID.addEventListener(click:'myFunction()')
      expect(jsd.orders.first).to eq "document.getElementById('').addEventListener(\"click\",myFunction());"
            
    end

    it 'addEventListener case 2' do
      jsd.byID.addEventListener(click:'ksFunc',onclick:'muFinc()')
      
      expect(jsd.orders.first).to eq "document.getElementById('').addEventListener(\"click\",ksFunc);"
      expect(jsd.orders.last).to eq "document.getElementById('').addEventListener(\"onclick\",muFinc());"
    end
    
    
    it 'addEventListener case same event' do
      jsd.byID.addEventListener(click:'ksFunc',click_:'muFinc()')
      
      expect(jsd.orders.first).to eq "document.getElementById('').addEventListener(\"click\",ksFunc);"
      expect(jsd.orders.last).to eq "document.getElementById('').addEventListener(\"click\",muFinc());"
    end

    it 'addEventListenerUseCapture case 1' do
      jsd.byID.addEventListenerUseCapture(click:'myFunc')
      expect(jsd.orders.first).to eq "document.getElementById('').addEventListener(\"click\",myFunc,true);"
      
    end

    it 'addEventListenerUseCapture case same event' do
      jsd.byID.addEventListenerUseCapture(click:'myFunc', click_:'ksFunc')
      expect(jsd.orders.first).to eq "document.getElementById('').addEventListener(\"click\",myFunc,true);"
      expect(jsd.orders.last).to eq "document.getElementById('').addEventListener(\"click\",ksFunc,true);"      
    end


 #    ### node ###
    it 'first node' do
      
      jsd.byID.firstChild('type')
      expect(jsd.orders.first).to eq "document.getElementById('').firstChild.nodeType;"
      
    end
    
    it 'first node call twice' do
      
      jsd.byID.firstChild('type')
      jsd.byID.firstChild(:type)
      expect(jsd.orders.first).to eq "document.getElementById('').firstChild.nodeType;"
      expect(jsd.records[1]).to eq "document.getElementById('').firstChild.nodeType;"
      
    end
    
    it 'first node value' do
      v = jsd.byID.firstChild('type').record
      expect(v).to eq "document.getElementById('').firstChild.nodeType;"
      
    end
    
    it 'first node case symbol' do
      
      jsd.byID.firstChild(:name)
      expect(jsd.orders.first).to eq "document.getElementById('').firstChild.nodeName;"  
    end
    
    it 'first node no type' do
      
      jsd.byID.firstChild ''
      expect(jsd.orders.first).to eq "document.getElementById('').firstChild;"
      
    end
    
    it 'first node ommit type' do
      
      jsd.byID.firstChild
      expect(jsd.orders.first).to eq "document.getElementById('').firstChild;"
      
    end
    
    it 'last node case symbol'do
      jsd.byID.lastChild :name
      expect(jsd.orders.first).to eq "document.getElementById('').lastChild.nodeName;"
    end

    it 'last node case symbol value'do
      v = jsd.byID.lastChild(:name).record
      expect(v).to eq "document.getElementById('').lastChild.nodeName;"
    end

    it 'last node case ommit type' do
      jsd.byID.lastChild
      expect(jsd.orders.first).to eq "document.getElementById('').lastChild;"
    end
    
    it 'parent node case symbol' do
      jsd.byID.parentNode :type
      # expect(jsd.units.first).to eq "document.getElementById('').parentNode.nodeType;"
      expect(jsd.record).to eq "document.getElementById('').parentNode.nodeType;"
    end

    it 'parentNode ommit type' do
      jsd.byID.parentNode
      # expect(jsd.units.first, "document.getElementById('').parentNode;"
      expect(jsd.record).to eq "document.getElementById('').parentNode;"
    end
    
    
    it 'nextSibling' do
      jsd.byID.nextSibling
      # expect(jsd.units.first, "document.getElementById('').nextSibling;"
      expect(jsd.record).to eq "document.getElementById('').nextSibling;"
    end

    
    it 'previousSibling' do
      jsd.byID.previousSibling
      # expect(jsd.units.first, "document.getElementById('').previousSibling;"
      expect(jsd.record).to eq "document.getElementById('').previousSibling;"
    end
    
    it 'childNodes case 1' do
      jsd.byID.childNodes(0,:type)
      # expect(jsd.units.first, "document.getElementById('').childNodes[0].nodeType;"
      expect(jsd.record).to eq "document.getElementById('').childNodes[0].nodeType;"
    end

    it 'childNodes case ommit type' do
      jsd.byID.childNodes(1)
      # expect(jsd.units.first, "document.getElementById('').childNodes[1];"
      expect(jsd.record).to eq "document.getElementById('').childNodes[1];"
    end

 #    ### is_var ###
    it 'is_var first test' do
      jsd.byID.firstChild(:name).is_var(:test)
      expect(jsd.equalities.first).to eq "var test = document.getElementById('').firstChild.nodeName;"
    end

    it 'is_var document.getElementById' do
      jsd.byID.is_var(:test)
      expect(jsd.equalities.first).to eq "var test = document.getElementById('');"
    end
    
    it 'is_var document.getElementById and getElementByName' do
      jsd.byID.is_var(:test)
      jsd.byClassName.is_var :sample
      
      expect(jsd.orders[0]).to eq "var test = document.getElementById('');"
      expect(jsd.orders[1]).to eq "var sample = document.getElementByClassName('');"
      
    end
    
    it 'is_var childNodes case ommit type' do
      jsd.byID.childNodes(1).is_var(:test)
      expect(jsd.equalities.first).to eq "var test = document.getElementById('').childNodes[1];"
    end
    
    it 'is_var childNodes case ommit type case 2' do
      jsd.byID.childNodes(1).is_var(:test)
      expect(jsd.equalities.first).to eq "var test = document.getElementById('').childNodes[1];"
    end

    it 'is_var childNodes case ommit type case 3' do
      jsd.byID.childNodes(0)               # ----> record
      jsd.byID.childNodes(1).is_var(:test) # ----> equality[0]
      
      expect(jsd.record).to eq "document.getElementById('').childNodes[0];"
      expect(jsd.equalities[0]).to eq "var test = document.getElementById('').childNodes[1];"
    end

    it 'is_var childNodes case ommit type case 4' do
      
      jsd.byID.childNodes(0).is_var(:sample)
      jsd.byID.childNodes(1).is_var(:test)
      
      # p jsd.records
      expect(jsd.equalities[0]).to eq "var sample = document.getElementById('').childNodes[0];"
      expect(jsd.equalities[1]).to eq "var test = document.getElementById('').childNodes[1];"

    end


 # #    ### insertBefore ####
    it 'insertBefore' do
     jsd.insertBefore 'aaa', 'bbb'
     expect(jsd.orders.first ).to eq "aaa.parentNode.insertBefore(bbb,aaa);"
    end


 #    ### equal ###
    it 'equal case 1' do
      jsd.equal 'test.id', 'title2'.sQuo
      expect(jsd.record).to eq "test.id = 'title2';"
    end
    
    it 'equal case 2' do
      jsd.equal 'test.id', 'title1'.sQuo
      jsd.equal 'sample.id', 'title2'.sQuo

      jsd.equal 'test.id', 'title1'.sQuo
      jsd.equal 'sample.id', 'title2'.sQuo

      jsd.equal 'test.id', 'title1'.sQuo
      jsd.equal 'sample.id', 'title2'.sQuo

      jsd.equal 'test.id', 'title1'.sQuo
      jsd.equal 'sample.id', 'title2'.sQuo

      jsd.equal 'test.id', 'title1'.sQuo
      jsd.equal 'sample.id', 'title2'.sQuo

      expect(jsd.orders[0]).to eq "test.id = 'title1';"
      expect(jsd.orders[1]).to eq "sample.id = 'title2';"

      expect(jsd.orders[2]).to eq "test.id = 'title1';"
      expect(jsd.orders[3]).to eq "sample.id = 'title2';"

      expect(jsd.orders[4]).to eq "test.id = 'title1';"
      expect(jsd.orders[5]).to eq "sample.id = 'title2';"

    end

    it 'equal case symbol can not use' do
      expect{
        jsd.equal :test, 'title2'
      }.to raise_error StandardError
     end

    # ### cut ###
    it 'cut, case ByID' do
      a = jsd.byID.cut
      expect(a).to eq "document.getElementById('')"
    end

    it 'cut, case innerHTML' do
      a = jsd.byID.innerHTML('aa'.sQuo).cut
      expect(a).to eq "document.getElementById('').innerHTML = 'aa'"
    end

    it 'cut, case setAttribute' do
      a = jsd.byID.setAttribute(btn:'red').cut
      b = jsd.byID.setAttribute(btn:'blue').cut
      expect(a).to eq "document.getElementById('').setAttribute(\"btn\",\"red\")"
      expect(b).to eq "document.getElementById('').setAttribute(\"btn\",\"blue\")"

      expect(jsd.orders[0]).to eq nil
      expect(jsd.orders[1]).to eq nil
     
    end

    it 'cut, case attribute'do
      a = jsd.byID.attribute('aaa'.dQuo).cut
      expect(a).to eq "document.getElementById('').attribute = \"aaa\""
      expect(jsd.orders[0]).to eq nil
    end

    it 'cut, case addEventListener' do
      a = jsd.byID.addEventListener(click:'myFunction()').cut
      expect(a).to eq "document.getElementById('').addEventListener(\"click\",myFunction())"
    end
    
    it 'cut, case addEventListener case 2' do
      a = jsd.byID.addEventListener(click:'myFunc', click_:'ksFunc').cut
      expect(a).to eq "document.getElementById('').addEventListener(\"click\",ksFunc)"
      
    end

    it 'cut, case style' do
      a = jsd.byID.style(backgroundColor:'red',color:'red').cut
      expect(a).to eq "document.getElementById('').style.color='red'"
    
    end

    it 'cut, case child node' do
      a = jsd.byID.childNodes(0).cut
      expect(a).to eq  "document.getElementById('').childNodes[0]"
    end
    
    ### cuts ####
    
    it 'cuts, case addEventListener' do
      a = jsd.byID.addEventListener(click:'myFunc', click_:'ksFunc').cuts
      expect(a[0]).to eq "document.getElementById('').addEventListener(\"click\",myFunc)"
      expect(a[1]).to eq "document.getElementById('').addEventListener(\"click\",ksFunc)"
      expect(a[2]).to eq nil
      
    end
    
    it 'cuts, case style' do
      a = jsd.byID.style(backgroundColor:'red',color:'red').cuts
      expect(a[0]).to eq "document.getElementById('').style.backgroundColor='red'"
      expect(a[1]).to eq "document.getElementById('').style.color='red'"

      # unitsHash dose not exist
      expect(jsd.orders[0]).to eq nil
      
    end
    
    it 'cuts, case style case other docHash and unitsHash do not influence' do
      jsd.byID.style(backgroundColor:'red',color:'red')
      a = jsd.byID.style(backgroundColor:'blue',color:'blue').cuts
      
      # last arg == 2
      expect(a[0]).to eq "document.getElementById('').style.backgroundColor='blue'"
      expect(a[1]).to eq "document.getElementById('').style.color='blue'"
      expect(a[2]).to eq nil

      # unitsHash remain
      expect(jsd.orders[0]).to eq "document.getElementById('').style.backgroundColor='red';"
      expect(jsd.orders[1]).to eq "document.getElementById('').style.color='red';"
    end

    
    ### selfy ###
    it 'selfy, basical use' do
      jsd.selfy{ |t|
        t.createElement :p
        t.createTextNode 'this ss'
      }

      expect(jsd.orders.first).to eq "document.createElement('p');"
      expect(jsd.orders[1]).to eq "document.createTextNode(this ss);"
    end

    
    it 'orders check' do

      jsd.selfy{ |t|
        t.createElement(:p).is_var :para
        t.createTextNode('This is new.'.sQuo).is_var :node
        t.appendChild(:para, :node)
        t.byID.is_var :element
      }
      
      jsd.equal 'newNode.id', 'title2'.sQuo
      jsd.insertBefore 'title3Node', 'newNode'

      expect(jsd.orders.first).to eq "var para = document.createElement('p');"
      expect(jsd.orders[1]).to eq "var node = document.createTextNode('This is new.');"
      expect(jsd.orders[2]).to eq "para.appendChild(node);"
      expect(jsd.orders[3]).to eq "var element = document.getElementById('');"
      expect(jsd.orders[4]).to eq "newNode.id = 'title2';"
      expect(jsd.orders[5]).to eq 'title3Node.parentNode.insertBefore(newNode,title3Node);'
    end
    
    
   
  end
end
