require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    subject(:link){LINK.new}
    
    it "single List" do
      expect(link.name ).to eq "link"
    end

    it "A tag" do
      ans = link.press
      expect(ans).to eq "<link>"
    end
    
    it "content add, ignore" do
      
      link.content = "test"
      ans = link.press
      expect(ans).to eq "<link>test"

    end
    
    
    it "add label case: ignore content with variable" do

      link.content = "test" + "a".variable
      ans = link.press
      
      expect(ans).to eq "<link>test"
    end

    
    it "href add" do
      link.tagManager .tagAttr(:href, "http://www")
      ans = link.press
      expect(ans).to eq"<link href=\"http://www\">"
      
    end
    
    it "src add case 2" do
      link.tagManager .tagAttr(:src, "http://www")
      ans = link.press
      expect(ans).to eq"<link src=\"http://www\">"
      
    end
    
    
    

  end
end
