require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:inp) { INPUT.new }
    
    it "single List" do
      expect(inp.name).to eq "input"
    end

    it "doctype" do
      doc = DOCTYPE.new
      expect(doc.name).to eq "doctype"
    end
    
   
    
  end  
    

end
