require 'test/unit' 

# require "global/globalDef"
# require "global/jwTable"
# require "global/jwSingle"
# require "global/jwMulti"

#gem uninstall version
require "../../lib/global/globalDef"
require "../../lib/global/jwTable"
require "../../lib/global/jwSingle"
require "../../lib/global/jwMulti"


module Jabverwock
  using StringExtension
  
  class TableV2Test < Test::Unit::TestCase
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
      @td = TableData.new
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
    #   p ">>>"
    #   p @td.pressDefault
    # end
    
  
    ## table Data tag ##
    test "table Data" do
      td = TableData.new
      assert_equal(td.tgStr, "<td></td>")
    end
    
    test "table Data add content" do
      td = TableData.new
      td.content = "test"
      assert_equal(td.tgStr, "<td>test</td>")
    end
    test "table Data add content, rowSpan" do
      td = TableData.new
      td.content = "test"
      td.setRowSpan(2)
      assert_equal(td.tgStr, "<td rowspan=\"2\">test</td>")
    end

    
    
  end
end


    
    

#     func test_add_data () {
#         let t = TABLE()
#         t.setCaption(cap: "test")
#         let hl = ["name", "address", "tel"]
#         t.setHeadList(header: hl)
        
#         //add data
        
#         let data = ["line1", "shi", "tokyo", "03000000"]
#         t.setData(d: [data])
        
#         t.press()
        
#         /* answer
#          <table>
#          <captiom>test</caption>
#          <tr><th></th><th>name</th><th>address</th><th>tel</th></tr>
#          <tr><td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td></tr>
#          </table>
#          */
        
#     }
#     func test_add_data2 () {
#         let t = TABLE()
#         t.setCaption(cap: "test")
#         let hl = ["name", "address", "tel"]
#         t.setHeadList(header: hl)
        
#         //add data
        
#         let data = ["line1", "shi", "tokyo", "03000000"]
#         let data2 = ["line2", "shi2", "tokyo2", "030000002"]
#         t.setData(d: [data, data2])
        
#         t.press()
        
#         /* answer
#          <table>
#          <captiom>test</caption>
#          <tr><th></th><th>name</th><th>address</th><th>tel</th></tr>
#          <tr><td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td></tr>
#          <tr><td >line2</td><td >shi2</td><td >tokyo2</td><td >030000002</td></tr>
#          </table>
#          */
        
#     }
    
#     func test_add_blank () {
#         let t = TABLE()
#         t.setCaption(cap: "test")
#         let hl = ["name", "address", "tel"]
#         t.setHeadList(header: hl)
        
#         //add data
        
#         let data = ["line1", "shi", "tokyo", "03000000"]
#         let data2 = [BLA, "shi2", "tokyo2", "030000002"]
#         t.setData(d: [data, data2])
        
#         t.press()
        
#         /* answer
#          <table>
#          <captiom>test</caption>
#          <tr><th></th><th>name</th><th>address</th><th>tel</th></tr>
#          <tr><td >line1</td><td >shi</td><td >tokyo</td><td >03000000</td></tr>
#          <tr><td ><br></td><td >shi2</td><td >tokyo2</td><td >030000002</td></tr>
#          </table>
#          */
        
#     }

#     func test_add_rowSpan () {
#         let t = TABLE()
#         t.setCaption(cap: "test")
#         let hl = ["name", "address", "tel"]
#         t.setHeadList(header: hl)
        
#         //add data
        
#         /*
#          insert span
         
#          "line2, ROW_SPAN11, COL_SPAN22"
#          */
        
#         let data = ["line1", "shi", "tokyo", "03000000"]
#         let data2 = ["line2," + ROW_SPAN + "10", "shi2", "tokyo2", "030000002"]
#         t.setData(d: [data, data2])
        
#         t.press()
        
#         /* answer
#          <table>
#             <captiom>test</caption>
#             <tr><th></th><th>name</th><th>address</th><th>tel</th></tr>
#             <tr><td >line1</td><td >shi</td><td >tokyo</td><td >03000000</td></tr>
#             <tr><td rowspan=10 >line2</td><td >shi2</td><td >tokyo2</td><td >030000002</td></tr>
#          </table>
#          */
        
#     }

# }

