require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:inp) { INPUT.new }
    
    it "TagManager, path confirm " do
      tm =  TagManager.new 
      tm.name = "first"

      expect(tm.openString).to eq "<first>"
      expect(tm.closeString).to eq "</first>"
      
    end

       
    it "TagManager, name is void " do
      tm =  TagManager.new
      tm.name = ""
      expect{tm.openString}.to raise_error StandardError
      
    end

    it "name and id add" do
      tm =  TagManager.new()
      tm.name = "p"
      tm.tagAttribute.add_id ("test")
      expect(tm.openString).to eq "<p id=\"test\">"
      
    end
    it "tagAttr, id add, chain method" do
      tm =  TagManager.new()
      tm.name = "p"
      tm.tagAttr("id","test").tagAttr("cls","test")
      expect(tm.openString).to eq "<p id=\"test\" class=\"test\">"
      
    end

    it "tagAttr, id add" do
      tm =  TagManager.new()
      tm.name = "p"
      tm.tagAttr("id","test")
      expect(tm.openString).to eq "<p id=\"test\">"
      
    end

    
    it "id add, symbol use" do
      tm =  TagManager.new()
      tm.name = "p"
      tm.tagAttr(:id,"test")

      expect(tm.openString).to eq "<p id=\"test\">"
      
    end

    it "id and name add" do
      tm =  TagManager.new()
      tm.tagAttr(:id,"test")
      tm.name = "sample"

      expect(tm.openString).to eq "<sample id=\"test\">" 
      
    end

    it "class  add" do
      tm =  TagManager.new()
      tm.name = "p"           
      tm.tagAttr(:cls,"test")
      
      expect(tm.openString).to eq "<p class=\"test\">"
      
    end

    it "class, id , name  add" do
      tm =  TagManager.new()
      tm.tagAttr(:cls,"test").tagAttr(:id, "test")
      tm.name = "sample"

      expect(tm.openString).to eq "<sample class=\"test\" id=\"test\">" 
      expect(tm.tagAttribute.cls).to eq "test"
    end

    
    it "not br tag " do
      tm = TagManager.new
      tm.name = "b"    
      expect(tm.openString).to eq "<b>"
      expect(tm.closeString).to eq "</b>"
    end

    it "tag attribute lang add" do
      tm = TagManager.new
      tm.name = "a"
      tm.tagAttr(:lang, "jp")
      expect(tm.openString).to eq "<a lang=\"jp\">"
    end

    it "tag attribute lang call" do
      tm = TagManager.new
      tm.name = "a"
      tm.tagAttr(:lang, "jp")
      expect(tm.tagAttribute.lang).to eq "jp"
    end

    it "openString replace" do
      tm = TagManager.new
      tm.tempOpenString = "aaa"
      tm.openStringReplace("a","b")
      expect(tm.tempOpenString).to eq"bbb"
    end

    it "closeString replace" do
      tm = TagManager.new
      tm.tempCloseString = "aaa"
      tm.closeStringReplace("a","b")
      expect(tm.tempCloseString).to eq "bbb"
    end

   
    
  end

  RSpec.describe 'comment' do
    subject(:tm) { TagManager.new }
    it 'COMMENT class, tag' do
      tm.name = 'comment'
      expect(tm.isComment).to be true
    end

    it 'JWComment class' do
      jwc = COMMENT.new
      expect(jwc.tagManager.isComment).to be true
    end
  end
    

end
