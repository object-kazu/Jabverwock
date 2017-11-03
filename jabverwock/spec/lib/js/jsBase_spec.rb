require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'js base test' do

    it 'id case 1' do
      expect(KSUtil.isID('id')).to eq true
    end
    it 'id case 2' do
      expect( KSUtil.isID('id_s')).to eq true
    end
    it 'id case 3' do
      expect( KSUtil.isID('name')).to eq false
    end
    
    it 'cls' do
      expect( KSUtil.isCls('cls')).to eq true
    end
    it 'cls case 2' do
      expect( KSUtil.isCls('cls_s')).to eq true
    end
    it 'cls case 3' do
      expect( KSUtil.isCls('name')).to eq false
    end
    
    it 'name' do
      expect( KSUtil.isName('name')).to eq true
    end
    it 'name case 2' do
      expect( KSUtil.isName('name_s')).to eq true
    end
    it 'name case 3' do
      expect( KSUtil.isName('cls')).to eq false
    end
    
    
    it'initialize case 1' do
      js = JsBase.new('id__sample')
      expect(js.id).to eq 'sample' 
    end
    
    it'initialize case 2' do
      js = JsBase.new(:id__sample)
      expect(js.id).to eq 'sample' 
    end
    
    it'initialize case 3' do
      js = JsBase.new(:attr__test)
      expect(js.id).to eq ''
    end

    it'initialize case tagName case 1' do
      js = JsBase.new(:name__sample)
      expect(js.name).to eq 'sample'
    end
    
    it'initialize case tagName case 2 ' do
      para = P.new.attr(:name__sample)
      expect(para.js.name).to eq 'sample'
    end

    
    it'initialize case tagName default value is class name  ' do
      para = P.new
      expect(para.js.name).to eq 'p'
    end
    
    it'initialize case tagName default value is class name case 2 ' do
      h = HTML.new
      expect(h.js.name).to eq 'html'
    end
    
    it'initialize case tagName default value is class name case 3 ' do
      h = DOCTYPE.new
      expect(h.js.name).to eq 'doctype'
    end
    
    it'initialize case tagName default value is class name case 4 ' do
      h = TABLE.new
      expect(h.js.name).to eq 'table'
    end

    it 'js.doc.byTagName set by default name' do
      para = P.new
      para.js.doc.byTagName
      expect(para.jdoc.orders[0]).to eq "document.getElementByTagName('p');"
    end
    
    it 'js.doc.byTagName set by default name case 2' do
      para = HTML.new
      para.js.doc.byTagName
      expect(para.jdoc.orders[0]).to eq "document.getElementByTagName('html');"
    end

    #### sequence hash ###
    it 'seqHash init test' do
      jsb = JsBase.new
      a = jsb.seqHash 'shi'
      expect(a).to eq ({ js1: 'shi' })
    end
  
    it 'seqHash twice' do
      jsb = JsBase.new
      jsb.seqHash 'shi'
      a = jsb.seqHash 'gooo'
      expect(a).to eq ({ js2: 'gooo' })
    end

    ### firstHashValue ##
    it 'firstHashValue' do
      jsb= JsBase.new
      jsb.recBy 'shi'
      jsb.recBy 'Goo'
      jsb.recBy 'DDD'
     
      expect(jsb.record).to eq 'shi'
    end

    it 'recordLast' do
      jsb= JsBase.new
      jsb.recBy 'shi'
      jsb.recBy 'Goo'
      jsb.recBy 'DDD'

      expect(jsb.orders[2]).to eq 'DDD'
    end

    ### recBy ####
   
    it 'recBy case 1' do
      jsb = JsBase.new
      jsb.recBy 'shi'
      expect(jsb.orders[0]).to eq 'shi'
     
      expect(jsb.orders).to eq ['shi']
    end
   
    it 'recBy case 2' do
      jsb = JsBase.new
      jsb.recBy 'shi'
      jsb.recBy 'Goo'
      expect(jsb.orders[0]).to eq 'shi'
      expect(jsb.orders[1]).to eq 'Goo'

      expect(jsb.orders).to eq ['shi', 'Goo']
    end

    it 'recBy case 3' do
      jsb = JsBase.new
      jsb.recBy 'shi'
      jsb.recBy 'Goo'
      jsb.recBy 'DDD'
      expect(jsb.orders[0]).to eq 'shi'
      expect(jsb.orders[1]).to eq 'Goo'

      expect(jsb.orders).to eq ['shi', 'Goo', 'DDD']
    end
    
    
  end
end

