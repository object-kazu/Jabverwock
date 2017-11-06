require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension


module Jabverwock

  RSpec.describe 'css test' do
    subject(:img){IMG.new}
    
    it "single List" do
      expect(img.name ).to eq "img"
    end

    it "A tag" do
      ans = img.press
      expect(ans).to eq "<img>"
    end
    
    it "content add" do
      
      img.content = "test"
      ans = img.press
      expect(ans).to eq "<img>test"

    end
    
    
    it "add label case: ignore content with variable" do

      img.content = "test" + "a".variable
      ans = img.press
      
      expect(ans).to eq "<img>test"
    end

    
    it "href add" do
      img.tagManager .tagAttr(:href, "http://www")
      ans = img.press
      expect(ans).to eq"<img href=\"http://www\">"
      
    end
    
    it "src add" do
      img.tagManager .tagAttr(:src, "http://www")
      ans = img.press
      expect(ans).to eq"<img src=\"http://www\">"
      
    end
    
  end
end
