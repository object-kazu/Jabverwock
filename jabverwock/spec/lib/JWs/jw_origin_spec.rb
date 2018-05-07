require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic it' do
    subject(:ori) { JWOrigin.new }

    # it "JWOrigin first test" do
    #   p ori
    # end
    
    it "JWOrigin, multi, addChild" do
      pp = P.new
      ori.addChild pp
      
      expect(ori.tgStr).to eq "<jworigin>\n<p></p>\n</jworigin>"
    end

    it "JWOrigin, single, do not use addChild" do
      pp = P.new
      single = JWOrigin.new($SINGLE)

      expect{
        single.addChild pp
      }.to raise_error RuntimeError
    end

    # case1 : single 
    # case2 : multi 

    it "case 1; single, check isMulti" do
      pp = JWOrigin.new($SINGLE)
      expect(pp.isMulti).to eq false
    end
    
    it "case 1: single " do      
      pp = JWOrigin.new($SINGLE).contentIs "this multi tag"
      expect(pp.tgStr).to eq "<jworigin>this multi tag</jworigin>"
    end
    
    it "case 2; multi, check isMulti" do
      pp = JWOrigin.new($MULTI)
      expect(pp.isMulti).to eq true
    end
    
    it "case 2: multi " do      
      pp = JWOrigin.new($MULTI).contentIs "this multi tag"
      expect(pp.tgStr).to eq "<jworigin>\nthis multi tag\n</jworigin>"
    end
    
    
    # case3 : single -> single
    # case4 : single -> multi
    # case5 : multi -> single
    # case6 : multi -> multi

    it "case 3: single -> single " do
      html = P.new().contentIs "this multi p tag"
      expect(html.tgStr).to eq "<p>this multi p tag</p>"
    end
    
    it "case 4: single -> multi " do
      html = P.new($MULTI).contentIs "this multi p tag"
      expect(html.tgStr).to eq "<p>\nthis multi p tag\n</p>"
    end

    it 'case 5: multi -> single' do
      html = HTML.new($SINGLE).contentIs "this multi tag"
      expect(html.tgStr).to eq "<html>this multi tag</html>"
    end

    it 'case 6: multi -> multi' do
      html = HTML.new().contentIs "this multi tag"
      expect(html.tgStr).to eq "<html>\nthis multi tag\n</html>"
    end
    
    #OneTag
    it 'case one tag, do not permit multi style' do
      one = DOCTYPE.new().contentIs "this is single"
      expect(one.tgStr).not_to eq "<!DOCTYPE html>this is single"
      expect(one.tgStr).to eq "<!DOCTYPE html>"
    end
    it 'case one tag, multi, do not permit multi style' do
      one = DOCTYPE.new($MULTI).contentIs "this is single"
      expect(one.tgStr).not_to eq "<!DOCTYPE html>this is single"
      expect(one.tgStr).to eq "<!DOCTYPE html>"
    end
    
    
    
    #### ###### confirm super class of jworigin is  jwMulti class #############
    it "addChildString with RET" do
      ori.childStringArray = ["a","b"]
      ori.addChildString "\nc"
      expect(ori.childStringArray).to eq ["a","b","\nc"]
    end

    it "addchild, class check, asert raise" do
      expect{ori.addChild "a"}.to raise_error StandardError
    end
    
    it "addchild, class check, pass" do
      a = JW.new
      expect{
        ori.addChild a
        }.to raise_error StandardError

    end


    it "body check before add child" do
      b = BODY.new
      expect(b.tgStr).to eq "<body>\n</body>"
    end

    it "body addchildString string" do
      b = BODY.new
      bc = "dd"
      b.addChildString bc
      expect(b.tgStr).to eq "<body>\ndd\n</body>"
    end
    
    it "body addChildStrings" do
      b = BODY.new
      bc = "dd"
      b.addChildString bc
      b.addChildString bc
      b.addChildString bc
      
      expect(b.tgStr).to eq "<body>\ndd\ndd\ndd\n</body>"
    end

    it "head confirm, because script tag add after treatment" do
      a = HEAD.new
      expect(a.tgStr).to eq "<head>\n</head>"
    end
    
    it "addchild, ori class check, pass" do
      a = HEAD.new
      ori.addChild a
    
      expect(ori.tgStr).to eq "<jworigin>\n<head>\n</head>\n</jworigin>"
    end
    
    it "addchildren" do
      b = BODY.new
      c = HEAD.new
      ori.addChildren [b, c]
      
      # same result
      # ori.addChildren b, c
      
      expect(ori.tgStr).to eq "<jworigin>\n<body>\n</body>\n<head>\n</head>\n</jworigin>"
    end
    
  end      
end

