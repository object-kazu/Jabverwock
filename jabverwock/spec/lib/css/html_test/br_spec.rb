require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'br test' do
    subject(:br){BR.new}
    
    ## class BR it
    it "single List" do
      expect(br.name ).to eq  "br"
    end
    
    it "tag Str" do
      expect(br.tgStr ).to eq  "<br>"
    end
    
    it "br basically" do
      br.content = "this is test"
      expect(br.tgStr).to eq  "this is test<br>"
    end

    it "class br with p tag" do
      br.content = "this is test"
      pp = P.new
      pp.content = br.tgStr
      expect(pp.tgStr).to eq "<p>this is test<br></p>"
      
    end

    
    it "add br tag after other tag" do
      pp = P.new.contentIs "test"
      pp.addMember(br)
      expect(pp.tgStr).to eq  "<p>test</p>\n<br>\n"
      
    end
    
    
    ### Constant BR it
    it "new test BR" do
      expect($BR).to eq  "<br>"
    end

    it "constant br with p tag" do
      pp = P.new.contentIs "this is test).to eq #{$BR} for you "
      expect(pp.tgStr).to eq  "<p>this is test).to eq <br> for you </p>"
    end

    it "withBreak" do
      pp = P.new.contentIs "test"
      pp.withBreak
      expect(pp.tgStr).to eq  "<p>test</p><br>"
    end

    it "not withBreak" do
      pp = P.new.contentIs "test"
      expect(pp.tgStr).to eq  "<p>test</p>"
      
    end
    

  end
end
