require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/font'

module Jabverwock
  using StringExtension
  
  class FontTest < Test::Unit::TestCase
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
      @a = Font.new
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

    test "nothing set property" do
      assert_equal(@a.str, "")
    end

    test "set property font" do
      @a.font = "Helvetica".modifyDoubleQuo
      assert_equal(@a.str, "font: \"Helvetica\";")
    end
    
    test "set property font-size" do
      @a.font_size = "12px"
      assert_equal(@a.str, "font-size: 12px;")
    end

    test "set property font-size, font-style" do
      @a.font_style = "bold"
      @a.font_size = "12px"
      assert_equal(@a.str, "font-style: bold;\nfont-size: 12px;")
    end

    test "set property confirm property order" do
      # following code is same result
      # @a.font_style = "bold"
      # @a.font_size = "12px"
      
      @a.font_size = "12px"
      @a.font_style = "bold"
      assert_equal(@a.str, "font-style: bold;\nfont-size: 12px;")
    end

    
  end

end
