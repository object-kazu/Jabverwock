require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jwComment basic test' do
    subject(:jwc) { COMMENT.new }    
    it 'is name' do
      expect(jwc.name).to eq 'comment' 
    end

    it 'is test for tagManager func isComment'do
      expect(jwc.tagManager.name).to eq "comment"
    end

    it 'add comment ' do
      jwc.contentIs "test"
      expect(jwc.tgStr).to eq "<!-- test -->"
    end
    
  end

  
end   
