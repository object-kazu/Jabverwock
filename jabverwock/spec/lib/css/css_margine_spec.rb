require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:css){CSS.new "t"}
    
    it "property border" do
      css.name = "head"
      css.margin = "10px"
      css.margin_left = "1px"
      expect(css.str).to eq "head {\nmargin: 10px;\nmargin-left: 1px;\n}"
    end
    
    
  end  
end
