require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  RSpec.describe 'jsObject test' do
    subject(:jso){JsObject.new}
    
    # ############## jsFunction ###############
    it "JsFunction " do
      jso.func.define "test", "name", "age", "code is dead;"      
      expect(jso.orders[0]).to eq "function test(name, age){
      code is dead;
      }"
    end
    
    
    it "JsFunction use symbol" do
      jso.func.define :test, :name, :age, "code is dead;"
      expect(jso.orders[0]).to eq  "function test(name, age){
      code is dead;
      }"
    end

    
    # # ############## jsDocument ###############
    it "document confirm, correct id setting" do
      jso.updateSelector :id__koko
      jso.doc.byID.rec
      # a = jso.doc.orders[0]
      a = jso.doc.record
      expect(a).to eq ("document.getElementById('koko');")
    end

    it "document confirm, correct id setting case 2" do
      jso = JsObject.new("id__koko","cls__opop","name__iii")
      jso.doc.byID.rec
      a = jso.doc.record
      expect(a).to eq  "document.getElementById('koko');"
    end
    
    it "document confirm, correct id setting case 3" do
      jso.updateSelector(:id__koko).doc.byID.rec
      
      a = jso.doc.orders[0]      
      expect(a).to eq  "document.getElementById('koko');"
    end
    
    it "document confirm, correct id setting case 4" do
      jso.updateSelector(:id__koko).doc.byID.rec      
      expect(jso.doc.orders.count ).to eq  1
    end

    it "jsObject extract from jsObject" do
      jso.updateSelector(:id__koko).doc.byID.rec
      expect(jso.orders[0]).to eq  "document.getElementById('koko');"
    end

    
    
    it "jsObject, check orders" do
      jso.doc.createElement(:p).is_var :para
      jso.doc.createTextNode('This is new.'.sQuo).is_var :node
      jso.doc.appendChild(:para, :node)
      
      # deplicated method "var" used
      # jso.doc.var(:element){|t| t.byID}
      jso.doc.byID.is_var :element
      jso.doc.insertBefore "element", "para"

      # deplicated method "var" used
      # jso.doc.var(:title3Node){ |t| t.byID }
      jso.doc.byID.is_var :title3Node
      
      jso.doc.selfy{ |t|
        t.createElement(:div).is_var :newNode
        t.createTextNode('CSS').is_var :textNode
        t.appendChild(:newNode, :textNode)
      }
      
      jso.doc.equal "newNode.id", "title2".sQuo
      jso.doc.insertBefore "title3Node", "newNode"

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
      
      expect( jso.orders[0]).to eq  a
      expect( jso.orders[1]).to eq  b
      expect( jso.orders[2]).to eq  c
      expect( jso.orders[3]).to eq  d
      expect( jso.orders[4]).to eq  e
      
      expect( jso.orders[5]).to eq  f
      expect( jso.orders[6]).to eq  g
      expect( jso.orders[7]).to eq  h
      expect( jso.orders[8]).to eq  i
      expect( jso.orders[9]).to eq  j
      expect( jso.orders[10]).to eq  k
      
    end

    ########## jsReader ##########
    it "jsFileReader, readIn, path error check" do
      jso.readIn "./spec/lib/jsTests/sample.js"
      
    end
    
    it "jsFileReader, orders" do
      jso.readIn "./spec/lib/jsTests/sample.js"
      
      l0 = "var myCollection = document.getElementsByTagName(\"p\");"
      l1 ="var i;"
      l2 = "for (i = 0; i < myCollection.length; i++) {"
      l3 = "    myCollection[i].style.backgroundColor = \"red\";"
      l4 = "}"
      arr = [l0,l1,l2,l3,l4]
      
      (0..4).each do |index| 
        expect(jso.orders[index]).to eq arr[index]
      end      
    end
    
    
    
  end
end
