require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jj class initial test' do
    
    it 'test' do
      p1 = JJ.p "content is test"
      expect(p1.tgStr).to eq "<p>content is test</p>"
    end

    it 'second test' do
      div1 = JJ.DIV
      expect(div1.tgStr).to eq "<div>\n</div>"
    end
        
  end
  
end   

