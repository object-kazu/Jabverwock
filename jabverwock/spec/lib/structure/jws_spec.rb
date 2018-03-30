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


    it 'makeStringFrom array' do
      arr = %w(this is test)
      ans = JWS.makeStringFrom arr
      expect(ans).to eq "this\nis\ntest\n"
      
    end

    it 'addMember' do
      arr = ["a","b"]
      ans = JWS.addMember arr
      expect(ans).to eq "a\nb\n"
    end

    it 'addMember case 2' do
      p1 = P.new.contentIs "test"
      body = BODY.new
      ans = JWS.addMember [body, p1]
      expect(ans).to eq "<body>\n</body>\n<p>test</p>\n"
    end

    it 'addMember case 3' do
      p1 = P.new.contentIs "test"
      body = BODY.new
      ans = JWS.addMember [body, [p1]]
      expect(ans).to eq "<body>\n<p>test</p>\n</body>\n"
    end
    
    it 'addMember case 4' do
      div = DIV.new
      p1 = P.new.contentIs "test"
      body = BODY.new
      ans = JWS.addMember [div,[body, [p1]]]
      expect(ans).to eq "<div>\n<body>\n<p>test</p>\n</body>\n</div>\n"
    end

    it "addMember combine to addMember" do
      div = DIV.new
      p1 = P.new.contentIs "test"
      ans = JWS.addMember [div, [p1]]

      div2 = DIV.new
      body = BODY.new
      ans2 = JWS.addMember [div2,[body]]

      ans3 = JWS.addMember [ans,ans2]
      expect(ans3).to eq "<div>\n<p>test</p>\n</div>\n<div>\n<body>\n</body>\n</div>\n"
    end
    
    
    
        
  end
  
end   

