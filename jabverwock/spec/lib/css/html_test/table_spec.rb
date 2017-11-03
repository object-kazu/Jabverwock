require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'table test' do
    
    it "caption confirm" do
      c = TableCaption.new
      expect(c.tgStr).to eq  "<caption></caption>"
    end

    it 'caption title' do
      c = TableCaption.new.contentIs 'test'
      expect(c.tgStr).to eq  '<caption>test</caption>'
    end

    it "table row confirm" do
      c = TableRow.new
      expect(c.tgStr).to eq  "<tr>\n</tr>"
    end

    it "table header confirm" do
      c = TableHeader.new
      expect(c.tgStr).to eq  "<th></th>"
    end
    
    ## table Data tag ##
    it "table Data" do
      td = TableData.new
      expect(td.tgStr).to eq  "<td></td>"
    end

    it "table data content" do
      td = TableData.new
      td.content = "test"
      expect(td.tgStr).to eq  "<td>test</td>"
      
    end
    
    #     ## table ##
    it "table" do
      t = JWTable.new
      expect(t.tgStr).to eq  "<table>\n</table>"
    end

    it "table with id" do
      t = JWTable.new.attr(:id__sample)
      expect(t.tgStr).to eq  "<table id=\"sample\">\n</table>"
    end
    
    
    it "add caption" do
      t = JWTable.new
      t.caption "test"
      expect(t.tgStr).to eq  "<table>\n<caption>test</caption>\n</table>"
      
    end

    it "add header"do
      t = JWTable.new
      t.caption "test"
      t.headerList ["name", "address", "tel"]
      ans = t.tgStr
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      lend="</table>"

      expect(ans).to eq l1 + l2 + l3 + lend
    end

    it "add data).to eq  simply" do
      t = JWTable.new
      t.caption "test"
      t.addRows ["line1", "shi", "tokyo", "03000000"]
      ans = t.tgStr
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>\n"
      lend="</table>"
      
      expect(ans).to eq  l1 + l2 + l3 + lend
    end

    
    it "add data" do
      t = JWTable.new
      t.caption "test"
      t.headerList ["name", "address", "tel"]
      t.addRows ["line1",  "shi",  "tokyo",  "03000000"]
      ans = t.tgStr
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4="<tr>\n<td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>\n"
      lend="</table>"
      
      expect(ans).to eq (l1 + l2 + l3 + l4 + lend)      
    end

    it "add data ,  case addRows use" do
      t = JWTable.new.caption "test"
      t.headerList ["name", "address", "tel"]
      
      t.addRows (["line1",  "shi",  "tokyo",  "03000000"])
      ans = t.tgStr
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4="<tr>\n<td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>\n"
      lend="</table>"
      expect(ans).to eq (l1 + l2 + l3 + l4 + lend)      
    end


    
    it "addRows case 1" do
      t = JWTable.new.caption "test"
      t.headerList ["name", "address", "tel"]
      
      list1 = %w(line1 shi tokyo 03000000)
      
      t.addRows list1
      expect(t.rows).to eq  [list1]
    end

    it "addRows case 2" do
      t = JWTable.new
      t.caption "test"
      t.headerList ["name", "address", "tel"]
      
      list1 = ["line1",  "shi",  "tokyo",  "03000000"]
      
      t.addRows list1
      expect(t.rows).to eq  [list1]
    end
    
    it "addRows case 3" do
      t = JWTable.new
      t.caption "test"
      t.headerList ["name", "address", "tel"]
      
      list1 = ["line1",  "shi",  "tokyo",  "03000000"]
      list2 = ["line2",  "shi2",  "tokyo2",  "030000002"]
      
      
      t.addRows ["line1",  "shi",  "tokyo",  "03000000"]
      t.addRows ["line2",  "shi2",  "tokyo2",  "030000002"]
      expect(t.rows).to eq  [ list1, list2 ]
    end

    it "addRows case 4" do
      t = JWTable.new.caption "test"

      h  = %w(name address tel)
      l1 = %w(line1 shi tokyo 03000000)
      l2 = %w(line2 shi2 tokyo2 030000002)
      
      t.headerList h
      t.addRows l1,l2
      expect(t.rows).to eq  [ l1,l2 ]
    end

    it "isDoubleArray ,  false" do
      t = JWTable.new
      list = ["a", "b"]
      expect(KSUtil.isDoubleArray(list)).to eq false 
      
    end
    
    it "isDoubleArray,  true" do
      t = JWTable.new
      list = ["a", "b"]
      lista = ["a", "b"]
      listb = [list, lista]
      expect(KSUtil.isDoubleArray listb).to eq true
      
    end

    it "dataTreatment, false" do
      t = JWTable.new
      expect(t.dataTreatment).to eq false
      
    end

    it "dataTreatment,  false case 2" do
      t = JWTable.new
      list1 = ["line1", "shi",  "tokyo",  "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
      
      t.addRows list1
      expect(t.dataTreatment).to eq true
    end
    
    it "dataTreatment).to eq  true" do
      t = JWTable.new
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
      
      t.addRows list1,list2
      expect(t.dataTreatment).to eq true
    end

    it "addTableDataList case 1" do
      t = JWTable.new
      list1 = ["line1",  "shi",  "tokyo",  "03000000"]
      list2 = ["line2",  "shi2",  "tokyo2",  "030000002"]
      
      t.addTableDataList list1
      
    end
    
    it "addTableDataList case 2" do
      t = JWTable.new
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
      
      t.addTableDataList [list1, list2]

    end
    
    it "addTableDataList case 4" do
      t = JWTable.new
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
      list3 = ["line1", "shi", "tokyo", "03000000"]
      
      t.addTableDataList [list1, list2, list3]
      p t.tgStr
    end
    
    it "add rows case" do
      t = JWTable.new
      t.addRows ["line1", "shi", "tokyo", "03000000"]
      t.addRows ["line2", "shi2", "tokyo2", "030000002"]
      t.addRows ["line1", "shi", "tokyo", "03000000"]
      
      p "rows is"
      p t.dataTreatment
    end

    
    it "addTableDataList case 3" do
      t = JWTable.new
      t.headerList ["name", "address", "tel"]
      
      list1 = ["line1",  "shi",  "tokyo",  "03000000"]
      list2 = ["line2",  "shi2",  "tokyo2",  "030000002"]
      t.addRows list1, list2
      
      
      t.addTableDataList t.rows
      p t.childStringArray
    end

    it "add data case 2" do
      t = JWTable.new.caption "test"
      t.headerList ["name", "address", "tel"]
      t.addRows ["line1",  "shi",  "tokyo",  "03000000"]
      t.addRows ["line2",  "shi2",  "tokyo2",  "030000002"]
      
      ans = t.tgStr
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4="<tr>\n<td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>\n"
      l5="<tr>\n<td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"

      lend="</table>"
      expect(ans).to eq (l1 + l2 + l3 + l4 + l5 + lend)      
    end

    it "add data case brank" do
      t = JWTable.new
      t.caption "test"
      t.headerList ["name", "address", "tel"]
      t.addRows ["line1",  "shi",  "tokyo",  "03000000"]
      t.addRows [$BR,  "shi2",  "tokyo2",  "030000002"]
      
      ans = t.tgStr
      
      l1 = "<table>\n"
      l2 = "<caption>test</caption>\n"
      l3 = "<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4 = "<tr>\n<td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>\n"
      l5 = "<tr>\n<td><br></td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"
      lend = "</table>"
      expect(ans).to eq  (l1 + l2 + l3 + l4 + l5 + lend)      
    end

    it "add rowSpan" do
      t = JWTable.new
      t.caption "test"
      hl = %w(name address tel)
      
      t.headerList hl
      t.addRows ["line1".rowSpan(2), "shi", "tokyo", "03000000"]
      t.addRows ["line2", "shi2", "tokyo2", "030000002"]
      
      ans = t.tgStr
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4="<tr>\n<td rowspan=\"2\">line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>\n"
      l5="<tr>\n<td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"
      lend="</table>"
      expect(ans).to eq (l1 + l2 + l3 + l4 + l5 + lend)      
      
    end

    it "check adding row order" do
      t = JWTable.new
      t.caption "test"
      hl = %w(name address tel)
      
      t.headerList hl
      t.addRows ["line2",  "shi2",  "tokyo2",  "030000002"]
      t.addRows %w{line3 shi3 tokyo3 111}
      ans = t.tgStr
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4="<tr>\n<td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"
      l5 = "<tr>\n<td>line3</td><td>shi3</td><td>tokyo3</td><td>111</td>\n</tr>\n"
      
      lend="</table>"
      expect(ans).to eq (l1 + l2 + l3 + l4 + l5 + lend)

      
    end


    it "no headerList" do
      t = JWTable.new
      t.caption "test"

      t.addRows ["line2", "shi2", "tokyo2", "030000002"]
      t.addRows ["line22", "shi22", "tokyo22", "0300000022"]

      ans = t.tgStr
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"      
      l4="<tr>\n<td>line22</td><td>shi22</td><td>tokyo22</td><td>0300000022</td>\n</tr>\n"      
      lend="</table>"

      expect(ans).to eq (l1 + l2 + l3 + l4 + lend) 
      
      
    end

    it "add row x3" do
      t = JWTable.new
      t.caption "test"

      t.addRows ["line2", "shi2", "tokyo2", "030000002"]
      t.addRows ["line22", "shi22", "tokyo22", "0300000022"]
      t.addRows ["line22", "shi22", "tokyo22", "0300000022"]
      
      ans = t.tgStr

      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"      
      l4="<tr>\n<td>line22</td><td>shi22</td><td>tokyo22</td><td>0300000022</td>\n</tr>\n"      
      lend="</table>"

      expect(ans).to eq (l1 + l2 + l3 + l4 + l4 + lend) 
      
      
    end
    
    
  end
end
