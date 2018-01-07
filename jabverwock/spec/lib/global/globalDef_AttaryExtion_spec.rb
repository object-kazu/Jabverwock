require 'spec_helper'
require_relative '../../lib/paths'


using ArrayExtension

RSpec.describe 'global?' do
  it 'is test for global' do
    a = $SPC + 'good'
    expect(a).to eq ' good'    
  end

  it 'append val' do
    a = [2,3,4]
    a.append 5
    expect(a).to eq [2,3,4,5]
  end

  it 'append val case 2'do
      a = [2,3,4]
      a.append [5]
      expect(a).to eq [2,3,4,5]

  end
  
  it 'appends vals' do
      a = [2,3,4]
      a.appends [5,6]
      expect(a).to eq [2,3,4,5,6]
  end
  
  it 'appends vals case 2' do
      a = [2,3,4]
      a.appends [11,22], [33,33]
      expect(a).to eq [2,3,4,11,22,33,33]
    
  end
    
end
