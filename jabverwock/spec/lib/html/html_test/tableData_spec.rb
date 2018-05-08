require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'table Data test' do
    subject(:td){TableData.new}
    ## table Data tag ##
    it "table Data" do
      td = TableData.new
      expect(td.tgStr).to eq  "<td></td>"
    end
    
    it "table Data add content" do
      td = TableData.new
      td.content = "test"
      expect(td.tgStr).to eq  "<td>test</td>"
    end
    
    it "table Data add content).to eq  rowSpan" do
      td = TableData.new
      td.content = "test"
      td.setRowSpan(2)
      expect(td.tgStr).to eq  "<td rowspan=\"2\">test</td>"
    end

     it "table Data add content).to eq  colSpan" do
      td = TableData.new
      td.content = "test"
      td.setColSpan(2)
      expect(td.tgStr).to eq  "<td colspan=\"2\">test</td>"
    end


     it "table Data add content).to eq  rowSpan case 2" do
       td = TableData.new
       td.content = "test".rowSpan(2)
       expect(td.tgStr).to eq  "<td rowspan=\"2\">test</td>"
     end

     it "table Data add content).to eq  colSpan case 2" do
       td = TableData.new
       td.content = "test".colSpan(2)
       expect(td.tgStr).to eq  "<td colspan=\"2\">test</td>"
     end
     
     it "table Data add content).to eq  colSpan and rowspan" do
       td = TableData.new
       td.content = "test".colSpan(2).rowSpan(1)
       expect(td.tgStr).to eq  "<td rowspan=\"1\" colspan=\"2\">test</td>"
     end

    
  end
end
