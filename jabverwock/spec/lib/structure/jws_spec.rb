require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:jws) { JWS.new }
    it 'is test for global' do
      expect(jws.name).to eq 'jws' 
    end    
  end

  RSpec.describe 'insert variable' do
    subject(:doc){DOCTYPE.new}
    subject(:head){HEAD.new}
    subject(:title){TITLE.new}
    
    
    it 'is a JW class' do
      p1 = P.new.contentIs "this is test1"
      ans = JWS.transrate p1
      expect(ans).to eq "<p>this is test1</p>"
    end

    it 'is not a JW class' do
      ans = JWS.transrate "a"
      expect(ans).to eq "a"
    end

    it 'transrate case 1'do
      p1 = P.new.contentIs "test"
      ans = JWS.transrate p1
      expect(ans).to eq "<p>test</p>"
      
    end

    it 'transrate case 2' do
      body = BODY.new.contentIs "test"
      ans = JWS.transrate body
      expect(ans).to eq "<body>\ntest\n</body>"
      
    end

    it 'addChild case1' do
      body = BODY.new
      p1 = P.new.contentIs "test"
      ans = JWS.addChild body,[p1]
      res = "<body>\n<p>test</p>\n</body>"
      expect(ans).to eq res
    end
    
    it 'build simple' do
      arr = [doc,head,title]
      ans = JWS.build arr
      res = "<!DOCTYPE html>\n<head>\n</head>\n<title></title>"
      expect(ans).to eq res
      
    end
    
    # it 'build case child' do
    #   arr = [doc,head,[title]]
    #   ans = JWS.build arr
    #   res = "<!DOCTYPE html>\n<head>\n<title></title></head>"
    #   expect(ans).to eq res
    # end

    
    # it 'build' do
    #   header = HEADER.new
    #   title = TITLE.new.contentIs "this is test1"
    #   arr =
    #     [
    #       header,
    #       [title],
    #     ]
    #   ans = JWS.build arr
    #   expect(ans).to eq "<header>\t<title>\t\tthis is test1\t</title></header>"
    # end

        
  end
  
end   

