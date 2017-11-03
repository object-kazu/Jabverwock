require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'jsVar test' do
    
    it "jsVar case 1" do
      v = JsVar.new.is :n, "koko"
      expect(v.record).to eq "var n = koko"
    end

    it 'collection case 1' do
      v = JsVar.new
      v.collection :myC,1,"innerHTML"
      expect(v.record).to eq "myC[1].innerHTML"
      
    end

    it 'collection case2' do
      v = JsVar.new
      v.collection :myC,1
      expect(v.record).to eq "myC[1]"
      
    end
    
    it 'collection case 3' do
      v = JsVar.new
      v.collection :myC
      expect(v.record).to eq "myC"
      
    end

    it 'collection length' do
      v = JsVar.new
      v.collectionLength :myC
      expect(v.record).to eq 'myC.length'
    end
    
    

  end
end
