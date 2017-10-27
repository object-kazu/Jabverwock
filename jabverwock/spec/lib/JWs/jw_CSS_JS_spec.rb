require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:jwcssjs) { JW_CSS_JS.new }

    it "isExistScriptTagAtTempleteString, script tag exist " do
      j = JW_CSS_JS.new
      text = "<script></script>"
      j.templeteString = text
      expect( j.isExistScriptTagAtTempleteString).to eq true
    end
    
    it "isExistScriptTagAtTempleteString, script content not exist " do
      j = JW_CSS_JS.new
      text = "<script></script>"
      j.templeteString = text
      expect( j.isExistScriptContentAtTempleteString).to eq false
    end
    
    it "isExistScriptTagAtTempleteString, script content not exist case 2" do
      j = JW_CSS_JS.new
      j.assemble
      
      expect( j.isExistScriptContentAtTempleteString).to eq false
    end
    
    it "isExistScriptTagAtTempleteString, script content exist " do
      j = JW_CSS_JS.new
      j.js.doc.write("test")
      j.assemble
      
      expect( j.isExistScriptContentAtTempleteString).to eq true
    end
   
    
  end  
    

end
