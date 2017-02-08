require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/property'


module Jabverwock
  using StringExtension
  
  class PropertyTest < Test::Unit::TestCase
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
     # p "test".variable
       @f = Property.new
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

    test "property first test, for print debug " do
      @f.font_size = 10
      @f.background_color = "red"
      p @f.str
      
    end

    test "set property font" do
      @f.font = "Helvetica".modifyDoubleQuo
      assert_equal(@f.str, "font: \"Helvetica\";")
    end
    
    test "set property font-size" do
      @f.font_size = "12px"
      assert_equal(@f.str, "font-size: 12px;")
    end

    test "set property font-size, font-style" do
      @f.font_style = "bold"
      @f.font_size = "12px"
      assert_equal(@f.str, "font-size: 12px;\nfont-style: bold;")
    end

    test "set property confirm property order" do
      # following code is same result
      # property order depend on Property class
      # @f.font_style = "bold"
      # @f.font_size = "12px"
      
      @f.font_size = "12px"
      @f.font_style = "bold"
      assert_equal(@f.str, "font-size: 12px;\nfont-style: bold;")

    end

    
  end

end
