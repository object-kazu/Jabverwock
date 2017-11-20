require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    it "Heading defualt test" do
      a = HEADING.new()
      expect(a.tgStr).to eq "<h1></h1>"
    end
    
   it "Heading level 2 test" do
      a = HEADING.new(2)
      expect(a.tgStr).to eq "<h2></h2>"
    end
 
    it "Heading add content" do
      a = HEADING.new().contentIs "test"
      expect(a.tgStr ).to eq "<h1>test</h1>"
    end
    

    it "tagName check" do
      a = HEADING.new.contentIs "test"
      # expect(para.js.doc.byTagName.element).to eq "document.getElementByTagName('p');"

      ans = a.js.doc.byTagName.style(color: "red").record
      expect(ans).to eq "document.getElementByTagName('h1').style.color='red';"
    end
    
  end
end
