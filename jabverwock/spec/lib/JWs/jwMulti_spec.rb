require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic it' do
    subject(:multi) { JWMulti.new }

    it "addChildString, without RET" do
      multi.childStringArray = ["a","b"]
      multi.addChildString "c"
      expect(multi.childStringArray).to eq ["a","b","c"]
    end

    it "addChildString with RET" do
      multi.childStringArray = ["a","b"]
      multi.addChildString "\nc"
      expect(multi.childStringArray).to eq ["a","b","\nc"]
    end

    it "addchild, class check, asert raise" do
      expect{multi.addChild "a"}.to raise_error StandardError
    end
    
    it "addchild, class check, pass" do
      a = JW.new
      expect{
        multi.addChild a
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
    
    it "addchild, multi class check, pass" do
      a = HEAD.new
      multi.addChild a
    
      expect(multi.tgStr).to eq "<jwmulti>\n<head>\n</head>\n</jwmulti>"
    end
    
    it "addchildren" do
      b = BODY.new
      c = HEAD.new
      multi.addChildren [b, c]
      
      # same result
      # multi.addChildren b, c
      
      expect(multi.tgStr).to eq "<jwmulti>\n<body>\n</body>\n<head>\n</head>\n</jwmulti>"
    end
    
  end      
end

