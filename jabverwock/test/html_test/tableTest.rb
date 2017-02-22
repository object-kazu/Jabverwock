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
      assert_equal(c.tgStr, "<tr></tr>")
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
    
    ## table ##
    test "table" do
      t = JWTable.new
      assert_equal(t.pressDefault, "<table>\n</table>")
    end
    
    test "add caption" do
      t = JWTable.new
      t.caption = "test"
      assert_equal(t.pressDefault, "<table>\n\t<caption>test</caption>\n</table>")
      
#         /* answer
#          <table>
#             <captiom>test</caption>
#          </table>
         
#          */
      
     end

    test "add header"do
      t = JWTable.new
      t.caption = "test"
      t.headerList = ["name","address","tel"]
      ans = t.pressDefault
      l1= "<table>"
      l2="<caption>test</caption>"
      l3="<tr><th></th><th>name</th><th>address</th><th>tel</th></tr>"
      l4= "<tr></tr>"
      lend="</table>"

      assert_equal(ans,l1 + "\n\t"+ l2 + "\n\t"+ l3 + "\n\t" + l4 + "\n" + lend)      
    end

    test "add data" do
      t = JWTable.new
      t.caption = "test"
      t.headerList = ["name","address","tel"]
      t.dataList = ["line1", "shi", "tokyo", "03000000"]
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="\t<caption>test</caption>\n"
      l3="\t<tr><th></th><th>name</th><th>address</th><th>tel</th></tr>\n"
      l4="\t<tr><td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td></tr>\n"
      lend="</table>"
      assert_equal(ans,l1 + l2 + l3 + l4 + lend)      
    end

    test "add data , case addRow use" do
      t = JWTable.new
      t.caption = "test"
      t.headerList = ["name","address","tel"]
      
      t.addRow (["line1", "shi", "tokyo", "03000000"])
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="\t<caption>test</caption>\n"
      l3="\t<tr><th></th><th>name</th><th>address</th><th>tel</th></tr>\n"
      l4="\t<tr><td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td></tr>\n"
      lend="</table>"
      assert_equal(ans,l1 + l2 + l3 + l4 + lend)      
    end


    
    test "addRow case 1" do
      t = JWTable.new
      t.caption = "test"
      t.headerList = ["name","address","tel"]
      
      list1 = ["line1", "shi", "tokyo", "03000000"]
      
      t.addRow list1
      assert_equal(t.dataList, list1)
    end

    test "addRow case 2" do
      t = JWTable.new
      t.caption = "test"
      t.headerList = ["name","address","tel"]
      
      list1 = ["line1", "shi", "tokyo", "03000000"]
      
      t.dataList = list1
      assert_equal(t.dataList, list1)
    end
    

    
    test "addRow case 3" do
      t = JWTable.new
      t.caption = "test"
      t.headerList = ["name","address","tel"]
      
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
    
      
      t.dataList = ["line1", "shi", "tokyo", "03000000"]
      t.addRow ["line2", "shi2", "tokyo2", "030000002"]
      assert_equal(t.dataList, [ list1, list2 ])
    end

    test "addRow case 4" do
      t = JWTable.new
      t.caption = "test"
      t.headerList = ["name","address","tel"]
      
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
    
      t.addRow([list1, list2])
      assert_equal(t.dataList, [ list1, list2 ])
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
      assert_false t.dataTreatment
      
    end

    test "dataTreatment, false" do
      t = JWTable.new
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
    
      t.addRow list1
      assert_false t.dataTreatment
    end
    
    test "dataTreatment, true" do
      t = JWTable.new
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
    
      t.addRow([list1,list2])
      assert_true t.dataTreatment
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

    test "addTableDataList case 3" do
      t = JWTable.new
      t.headerList = ["name","address","tel"]
      
      list1 = ["line1", "shi", "tokyo", "03000000"]
      list2 = ["line2", "shi2", "tokyo2", "030000002"]
      t.addRow [list1,list2]
      
      
      t.addTableDataList t.dataList
      p t.childStringArray
    end

    
    test "add data case 2" do
      t = JWTable.new
      t.caption = "test"
      t.headerList = ["name","address","tel"]
      t.dataList = ["line1", "shi", "tokyo", "03000000"]
      t.addRow ["line2", "shi2", "tokyo2", "030000002"]
      
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="\t<caption>test</caption>\n"
      l3="\t<tr><th></th><th>name</th><th>address</th><th>tel</th></tr>\n"
      l4="\t<tr><td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td></tr>\n"
      l5="\t<tr><td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td></tr>\n"

      lend="</table>"
      assert_equal(ans,l1 + l2 + l3 + l4 + l5 + lend)      
    end

    test "add data case brank" do
      t = JWTable.new
      t.caption = "test"
      t.headerList = ["name","address","tel"]
      t.dataList = ["line1", "shi", "tokyo", "03000000"]
      t.addRow [$BLA, "shi2", "tokyo2", "030000002"]
      
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="\t<caption>test</caption>\n"
      l3="\t<tr><th></th><th>name</th><th>address</th><th>tel</th></tr>\n"
      l4="\t<tr><td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td></tr>\n"
      l5="\t<tr><td><br></td><td>shi2</td><td>tokyo2</td><td>030000002</td></tr>\n"

      lend="</table>"
      assert_equal(ans,l1 + l2 + l3 + l4 + l5 + lend)      
    end

    test "add rowSpan" do
      t = JWTable.new
      t.caption = "test"
      hl = %w(name address tel)
            
      t.headerList = hl
      t.dataList = ["line1".rowSpan(2), "shi", "tokyo", "03000000"]
      t.addRow ["line2", "shi2", "tokyo2", "030000002"]
      
      ans = t.pressDefault
      
      l1= "<table>\n"
      l2="\t<caption>test</caption>\n"
      l3="\t<tr><th></th><th>name</th><th>address</th><th>tel</th></tr>\n"
      l4="\t<tr><td rowspan=\"2\">line1</td><td>shi</td><td>tokyo</td><td>03000000</td></tr>\n"
      l5="\t<tr><td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td></tr>\n"

      lend="</table>"
      assert_equal(ans,l1 + l2 + l3 + l4 + l5 + lend)      
      
      
    end
    
    
  end
end

