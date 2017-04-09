require 'test/unit' 

# require "global/globalDef"
# require "global/jwTable"
# require "global/jwSingle"
# require "global/jwMulti"

#gem uninstall version
require "../../lib/global/globalDef"
require "../../lib/global/jwTable"
#require "../../lib/global/jwSingle"
#require "../../lib/global/jwMulti"


module Jabverwock
  using StringExtension
  
  class TableTest < Test::Unit::TestCase
        class << self
      # テスト群の実行前に呼ばれる．変な初期化トリックがいらなくなる
      def startup
        p :_startup
      end

      # テスト群の実行後に呼ばれる
      def shutdown
        p :_shutdown
      end
    end

    # 毎回テスト実行前に呼ばれる
    def setup
      p :setup
#      @table = JWTable.new
    end

    # テストがpassedになっている場合に，テスト実行後に呼ばれる．テスト後の状態確認とかに使える
    def cleanup
      p :cleanup
    end

    # 毎回テスト実行後に呼ばれる
    def teardown
      p :treadown
    end
    
    ############## test ###############

    # test "table confirm" do
    #   p @table
    # end
    
    test "caption confirm" do
      c = TableCaption.new
      assert_equal(c.tgStr, "<caption></caption>")
    end

    test "table row confirm" do
      c = TableRow.new
      assert_equal(c.tgStr, "<tr>\n</tr>")
    end

    test "table header confirm" do
      c = TableHeader.new
      assert_equal(c.tgStr, "<th></th>")
    end
    
    ## table Data tag ##
    test "table Data" do
      td = TableData.new
      assert_equal(td.tgStr, "<td></td>")
    end

    test "table data content" do
      td = TableData.new
      td.content = "test"
      assert_equal(td.tgStr, "<td>test</td>")
      
    end
    
#     ## table ##
    test "table" do
      t = JWTable.new
      assert_equal(t.pressDefault, "<table>\n</table>")
    end

    test "table with id" do
      t = JWTable.new.attr(:id__sample)
      assert_equal(t.pressDefault, "<table id=\"sample\">\n</table>")
    end
    
    
    test "add caption" do
      t = JWTable.new
      t.caption "test"
      assert_equal(t.pressDefault, "<table>\n<caption>test</caption>\n</table>")
      
     end

    test "add header"do
      t = JWTable.new
      t.caption "test"
      t.headerList = ["name","address","tel"]
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      lend="</table>"

      assert_equal(ans,l1 + l2 + l3 + lend)      
    end

    test "add data" do
      t = JWTable.new
      t.caption "test"
      t.headerList = ["name","address","tel"]
      t.addRows ["line1", "shi", "tokyo", "03000000"]
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4="<tr>\n<td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>\n"
      lend="</table>"
      
      assert_equal(ans,l1 + l2 + l3 + l4 + lend)      
    end

    test "add data , case addRows use" do
      t = JWTable.new.caption "test"
      t.headerList = ["name","address","tel"]
      
      t.addRows (["line1", "shi", "tokyo", "03000000"])
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4="<tr>\n<td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>\n"
      lend="</table>"
      assert_equal(ans,l1 + l2 + l3 + l4 + lend)      
    end


    
    test "addRows case 1" do
      t = JWTable.new.caption "test"
      t.headerList = ["name","address","tel"]
      
      list1 = ["line1", "shi", "tokyo", "03000000"]
      
      t.addRows list1
      assert_equal(t.rows, [list1])
    end

    test "addRows case 2" do
      t = JWTable.new
      t.caption "test"
      t.headerList = ["name","address","tel"]
      
      list1 = ["line1", "shi", "tokyo", "03000000"]
      
      t.addRows list1
      assert_equal(t.rows, [list1])
    end
    
    test "addRows case 3" do
      t = JWTable.new
      t.caption "test"
      t.headerList = ["name","address","tel"]
      
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
    
      
      t.addRows ["line1", "shi", "tokyo", "03000000"]
      t.addRows ["line2", "shi2", "tokyo2", "030000002"]
      assert_equal(t.rows, [ list1, list2 ])
    end

    test "addRows case 4" do
      t = JWTable.new.caption "test"
      t.headerList = ["name","address","tel"]
      
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
    
      t.addRows list1,list2
      assert_equal(t.rows, [ list1, list2 ])
    end

    test "isDoubleArray, false" do
      t = JWTable.new
      list = ["a", "b"]
      assert_false(t.isDoubleArray list)
      
    end
    
    test "isDoubleArray, true" do
      t = JWTable.new
      list = ["a", "b"]
      lista = ["a", "b"]
      listb = [list, lista]
      assert_true(t.isDoubleArray listb)
      
    end

    test "dataTreatment, false" do
      t = JWTable.new
      assert_false(t.dataTreatment)
      
    end

    test "dataTreatment, false case 2" do
      t = JWTable.new
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
    
      t.addRows list1
      assert_true(t.dataTreatment)
    end
    
    test "dataTreatment, true" do
      t = JWTable.new
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
    
      t.addRows list1,list2
      assert_true(t.dataTreatment)
    end

    test "addTableDataList case 1" do
      t = JWTable.new
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
      
      t.addTableDataList list1
      
    end
    
    test "addTableDataList case 2" do
      t = JWTable.new
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
      
      t.addTableDataList [list1, list2]

    end
    
    test "addTableDataList case 4" do
      t = JWTable.new
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
      list3 = ["line1", "shi", "tokyo", "03000000"]
      
      t.addTableDataList [list1, list2, list3]
      p t.tgStr
    end
    
    test "add rows case" do
      t = JWTable.new
      t.addRows ["line1", "shi", "tokyo", "03000000"]
      t.addRows ["line2", "shi2", "tokyo2", "030000002"]
      t.addRows ["line1", "shi", "tokyo", "03000000"]
      
      p "rows is"
      p t.dataTreatment
    end

    
    test "addTableDataList case 3" do
      t = JWTable.new
      t.headerList = ["name","address","tel"]
      
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
      t.addRows list1,list2
      
      
      t.addTableDataList t.rows
      p t.childStringArray
    end

    test "add data case 2" do
      t = JWTable.new.caption "test"
      t.headerList = ["name","address","tel"]
      t.addRows ["line1", "shi", "tokyo", "03000000"]
      t.addRows ["line2", "shi2", "tokyo2", "030000002"]
      
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4="<tr>\n<td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>\n"
      l5="<tr>\n<td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"

      lend="</table>"
      assert_equal(ans,l1 + l2 + l3 + l4 + l5 + lend)      
    end

    test "add data case brank" do
      t = JWTable.new
      t.caption "test"
      t.headerList = ["name","address","tel"]
      t.addRows ["line1", "shi", "tokyo", "03000000"]
      t.addRows [$BR, "shi2", "tokyo2", "030000002"]
      
      ans = t.pressDefault
      
      l1 = "<table>\n"
      l2 = "<caption>test</caption>\n"
      l3 = "<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4 = "<tr>\n<td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>\n"
      l5 = "<tr>\n<td><br></td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"
      lend = "</table>"
      assert_equal(ans, l1 + l2 + l3 + l4 + l5 + lend)      
    end

    test "add rowSpan" do
      t = JWTable.new
      t.caption "test"
      hl = %w(name address tel)
            
      t.headerList = hl
      t.addRows ["line1".rowSpan(2), "shi", "tokyo", "03000000"]
      t.addRows ["line2", "shi2", "tokyo2", "030000002"]
      
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4="<tr>\n<td rowspan=\"2\">line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>\n"
      l5="<tr>\n<td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"
      lend="</table>"
      assert_equal(ans,l1 + l2 + l3 + l4 + l5 + lend)      
            
    end

    test "check adding row order" do
      t = JWTable.new
      t.caption "test"
      hl = %w(name address tel)
            
      t.headerList = hl
      t.addRows ["line2", "shi2", "tokyo2", "030000002"]
      t.addRows %w{line3 shi3 tokyo3 111}
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      l4="<tr>\n<td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"
      l5 = "<tr>\n<td>line3</td><td>shi3</td><td>tokyo3</td><td>111</td>\n</tr>\n"
      
      lend="</table>"
      assert_equal(ans,l1 + l2 + l3 + l4 + l5 + lend)

                        
    end


    test "no headerList" do
      t = JWTable.new
      t.caption "test"

      t.addRows ["line2", "shi2", "tokyo2", "030000002"]
      t.addRows ["line22", "shi22", "tokyo22", "0300000022"]

      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"      
      l4="<tr>\n<td>line22</td><td>shi22</td><td>tokyo22</td><td>0300000022</td>\n</tr>\n"      
      lend="</table>"

      assert_equal(ans,l1 + l2 + l3 + l4 + lend) 
            
            
    end

    test "add row x3" do
      t = JWTable.new
      t.caption "test"

      t.addRows ["line2", "shi2", "tokyo2", "030000002"]
      t.addRows ["line22", "shi22", "tokyo22", "0300000022"]
      t.addRows ["line22", "shi22", "tokyo22", "0300000022"]
      
      ans = t.pressDefault

      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>\n"      
      l4="<tr>\n<td>line22</td><td>shi22</td><td>tokyo22</td><td>0300000022</td>\n</tr>\n"      
      lend="</table>"

      assert_equal(ans,l1 + l2 + l3 + l4 + l4 + lend) 
            
            
    end

    
  end
end

