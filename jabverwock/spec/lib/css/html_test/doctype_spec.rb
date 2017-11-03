require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'doctype test' do
    subject(:d){DOCTYPE.new}
    
    it "confirm name" do
      expect(d.name ).to eq  "doctype"
    end

    it "press" do
      expect(d.tgStr).to eq  "<!DOCTYPE html>"
    end

    it "add member string" do
      d.addMemberString "my first task"
      ans = d.tgStr
      expect(ans).to eq  "<!DOCTYPE html>\nmy first task\n"
    end

    it "add member" do
      a = A.new
      d.addMember a
      ans = d.tgStr
      expect(ans).to eq  "<!DOCTYPE html>\n<a></a>\n"
    end
    
    it "set doctype" do
      d.doctype = "HTML PUBLIC"
      ans = d.tgStr
      expect(ans).to eq  "<!DOCTYPE HTML PUBLIC>"
      
    end
    
  end
end
