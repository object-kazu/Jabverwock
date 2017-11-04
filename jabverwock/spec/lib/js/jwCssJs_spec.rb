require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'jwCssJs test' do
    subject(:jwjs){JW_CSS_JS.new}
    
    it "alias of js.doc" do
      # jdoc == js.doc
      jwjs.jdoc.write("a")
      expect(jwjs.js.doc.orders[0]).to eq "document.write('a');"
    end
    
    it "document write case 1" do
      jwjs.js.doc.write("a")
      expect(jwjs.js.doc.orders[0]).to eq "document.write('a');"
    end
    
    it "document write case 2" do
      jwjs.js.doc.write("a")      
      expect(jwjs.js.orders[0]).to eq "document.write('a');"
    end
    
    it "document write case 2-2" do
      a = jwjs.js.doc.write("a")
      expect(jwjs.js.orders[0]).to eq "document.write('a');"
    end

    it "document write case 2-3).to eq alias" do
      a = jwjs.jdoc.write("a")
      expect(jwjs.js.orders[0]).to eq "document.write('a');"
    end

    
    it "document write case 3" do
      a = jwjs.js.doc.write("a")
      expect(jwjs.orders[0]).to eq "document.write('a');"
    end

    it "document write case 4" do
      jwjs.js.doc.updateSelector :id__sample
      a = jwjs.js.doc.write("a")
      jwjs.js.doc.byID.innerHTML("aa".dQuo)
      
      expect(jwjs.orders[1]).to eq "document.getElementById('sample').innerHTML = \"aa\";"
    end

    it "when set jwjs class id, js id set at the same time" do
      jwjs.attr :id__sample
      jwjs.js.doc.byID
      expect(jwjs.orders[0]).to eq "document.getElementById('sample');"
    end
    
    # #### add member ####

    it "add jsArray to js.units case 1" do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      expect(parent.jsArray.count).to eq 0
    end
    
    it "add jsArray to js.units case 2" do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")

      # this is expression for test of assembleJS
      # this mean self.js.units convert to self.jsArray
      # parent.jsArray.append parent.js.units
      parent.self_JsOrders_add_to_self_jsArray
      expect(parent.jsArray.count).to eq 1
    end

    
    
    it "add member " do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
      
      parent.addMember child
      
      expect(parent.jsArray).to eq child.orders
    end
    
    it "add member case 2 " do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
      child.js.doc.write("child again")
      
      parent.addMember child
      
      expect(parent.jsArray.count).to eq 2 # child and child again
    end
    
    it "add member case 3 " do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
      child.js.doc.write("child again")
      
      parent.addMember child
      parent.self_JsOrders_add_to_self_jsArray
      expect(parent.jsArray.count).to eq 3 # parent, child and child again
    end

    it "assembleJS, show JS Result" do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
      child.js.doc.write("child again")
      
      parent.addMember child
      parent.assembleJS
      # p parent.showJsResult

      # p parent.applyJS
      
    end
    
    it "assembleHTML test" do
      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
      child.js.doc.write("child again")
      
      parent.addMember child
      parent.assemble
    end


    # ## file read ####
    # it "file read" do
    #   jwCssJs = JW_CSS_JS.new
    #   jwCssJs.jsRead "./sample.js"

    #   expect(jwCssJs.orders[0]).to eq "var myCollection = document.getElementsByTagName(\"p\");"
    #   expect(jwCssJs.orders.last).to eq "}"

    # end
    
  end
end
