require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock

  RSpec.describe 'tabbing it' do
    subject(:tc){TabbingCSS.new}
    
    it "isOpenPara case true" do
      l = "p { \n"
      expect(KSUtil.isOpenPara(l)).to eq true 
    end

    it "isOpenPara case true 2" do
      l = "p .sample { \n"
      expect(KSUtil.isOpenPara(l)).to eq true 
    end
    
    it "isOpenPara case false " do
      l = "p .sample } \n"
      expect(KSUtil.isOpenPara (l)).to eq false 
    end
    
    it "isOpenPara case false 2 " do
      l = "p .sample \n"
      expect(KSUtil.isOpenPara(l)).to eq false
    end

    it "isClose case true" do
      l = "}"
      expect( KSUtil.isClosePara(l)).to eq true
    end
    
    it "isClose case true 2" do
      l = "{ sample }"
      expect( KSUtil.isClosePara(l)).to eq true 
    end

    it "isAttList case true" do
      l = "sample is good"
      expect(tc.isAttList(l)).to eq true 
    end

    it "isAttList case false" do
      l = "{sample is good"
      expect( tc.isAttList (l)).to eq false
    end
    
    it "isAttList case false 2" do
      l = "sample is good}"
      expect(tc.isAttList (l)).to eq false 
    end
    
    it "isAttList case false 3" do
      l = "{sample is good}"
      expect(tc.isAttList (l)).to eq false
    end

    it "isAttList, style tag case false" do
      l = "<style>"
      expect(tc.isAttList(l)).to eq false 
    end
    
    it "isAttList, style tag case true" do
      l = "<style>"
      expect(tc.isStyle (l)).to eq true 
    end

    it "isCloseStyle case true" do
      l = "</style>"
      expect(tc.isCloseStyle(l) ).to eq true 
    end

    it "isCloseStyle case false" do
      l = "<style>"
      expect(tc.isCloseStyle (l)).to eq false 
    end

    
    
    it "main loop" do
      l1 = "<style>\n"
      l2 = "head {\n"
      l3 = "font-size: 10;\n"
      l4 = "}\n"
      l5 = "</style>"
      lt = l1 << l2 << l3 << l4 << l5
      
      tc.readLine lt

      
      p ">>>"
      p tc.tabbedTxt
      
    end
    
  end
end
