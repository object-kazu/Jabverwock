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

    it "test temp code" do
      
      head = HEAD.new
      p1 = P.new.contentIs "test"
      p1.css.background_color("good")
      a = JWS.build [head,[p1]]
      ans = "<head>\n<p>test</p>\n<style>\np {\nbackground-color: good;\n}\n</style>\n</head>"
      expect(a.tgStr).to eq ans 
    end

    it "test build code 2" do
      
      head = HEAD.new
      p1 = P.new.contentIs "test"
      p1.css.background_color("good")
      a = JWS.build [head,p1]
      ans = "<head>\n<style>\np {\nbackground-color: good;\n}\n</style>\n</head>\n<p>test</p>\n"
      expect(a.tgStr).to eq ans 
    end

    it "test build code " do
      
      head = HEAD.new
      p1 = P.new.contentIs "test"
      p1.css.background_color("good")
      div = DIV.new
      
      a = JWS.build [head,div,[p1]]
      ans = "<head>\n<style>\np {\nbackground-color: good;\n}\n</style>\n</head>\n<div>\n<p>test</p>\n</div>\n"
      expect(a.tgStr).to eq ans 
    end
    
  end  
end   

