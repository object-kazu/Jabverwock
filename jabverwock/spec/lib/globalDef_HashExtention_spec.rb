require 'spec_helper'
require_relative '../lib/paths'

using ArrayExtension
module Jabverwock
  
  RSpec.describe 'hash extension' do
    it 'first key' do
      expect(KSHash::FIRST_KEY).to eq :js1  
    end

    it 'first hash value' do
      a = {}
      a.update KSHash.seqHash('a',1)
      a.update KSHash.seqHash('b',2)
      a.update KSHash.seqHash('c',3)

      expect(KSHash.firstHashValue(a)).to eq "a"
    end

    it 'last hash vallue' do
      a = {}
      a.update KSHash.seqHash('a',1)
      a.update KSHash.seqHash('b',2)
      a.update KSHash.seqHash('c',3)

      expect(KSHash.lastHashValue(a)).to eq "c"
      
    end

    it 'hashValue' do
      a = {}
      a.update KSHash.seqHash('a',1)
      a.update KSHash.seqHash('b',2)
      a.update KSHash.seqHash('c',3)

      expect(KSHash.hashValues(a)).to eq ['a','b','c']
      
    end

    it 'compareKeys, case true' do
      expect(KSHash.compareKeys(:js22, :js2)).to eq true
    end

    it 'compareKeys, case false' do
      expect(KSHash.compareKeys(:js1,:js22)).to eq false
    end

    it 'remove Prefix' do
      txt = "#{$JS_UNITS_PREFIX}1"
      ans = KSHash.removePrefix txt
      expect(ans).to eq 1
    end
    
    it 'remove last hash'do
      a = {}
      a.update KSHash.seqHash('a',1)
      a.update KSHash.seqHash('b',2)
      a.update KSHash.seqHash('c',3)

      KSHash.removeLastHashValue(a)
      expect(KSHash.hashValues(a)).to eq ['a','b']
    end

    it 'lastHashKey' do
      a = {js1: 'a', js2: 'v', js11: 'dd', js3:'ee', js20: 'tt', js10: 'zz'}
      expect(KSHash.lastHashKey(a)).to eq :js20
    end
    
  end
end


