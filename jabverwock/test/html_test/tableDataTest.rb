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

     test "table Data add content, colSpan" do
      td = TableData.new
      td.content = "test"
      td.setColSpan(2)
      assert_equal(td.tgStr, "<td colspan=\"2\">test</td>")
    end


     test "table Data add content, rowSpan case 2" do
       td = TableData.new
       td.content = "test".rowSpan(2)
       assert_equal(td.tgStr, "<td rowspan=\"2\">test</td>")
     end

     test "table Data add content, colSpan case 2" do
       td = TableData.new
       td.content = "test".colSpan(2)
       assert_equal(td.tgStr, "<td colspan=\"2\">test</td>")
     end
     
     test "table Data add content, colSpan and rowspan" do
       td = TableData.new
       td.content = "test".colSpan(2).rowSpan(1)
       assert_equal(td.tgStr, "<td rowspan=\"1\" colspan=\"2\">test</td>")
     end

    
  end
end
