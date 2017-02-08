require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/css'
require '../../lib/css/property'


module Jabverwock
  using StringExtension
  
  class CssTest < Test::Unit::TestCase
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
       @css= CSS.new
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

    test "css first test, for print debug " do
       @css.property = Property.new
      
    end

    test "set property" do
      p = Property.new
      p.font_size = 10
      @css.name = "head"
      @css.property = p
      p @css.str
      assert_equal(@css.str, "head {\nfont-size: 10;\n}")
    end

    
  end

end
