require 'test/unit'
require '../../lib/global/globalDef'  
require '../../lib/css/css'

require '../../lib/global/globalDef'  
require '../../lib/global/jw'  
require "../../lib/global/jwMulti"
require "../../lib/global/jwOneTag"
require "../../lib/global/jwSingle"
require "../../lib/global/jwTable"
require "../../lib/global/jw_CSS"
require "../../lib/global/jw_CSS_JS"
require "../../lib/global/press"


module Jabverwock
  using StringExtension
  
  class Css_Boarder_Test < Test::Unit::TestCase
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
       @css= CSS.new "t"
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

    # test "css first test, for print debug " do
    #   #p @css
      
    # end
    
  
    test "property border" do
      @css.name = "head"
      @css.border = "10px solid"
      @css.border_left = "1px solid"
      assert_equal(@css.str, "head {\nborder: 10px solid;\nborder-left: 1px solid;\n}")
    end

    test 'property border width' do
      @css.name = "head"
      @css.border_width = "1px solid"
      assert_equal(@css.str, "head {\nborder-width: 1px solid;\n}")      
    end

    test 'property border top-width' do
      @css.name = 'head'
      @css.border_top_width = '2px'
      assert_equal(@css.str, "head {\nborder-top-width: 2px;\n}")      
    end


    test 'property border style' do
      @css.name = 'head'
      @css.border_style = STYLE.NONE
      assert_equal @css.str, "head {\nborder-style: none;\n}"
    end
    
    test 'property border style case 2' do
      @css.name = 'head'
      @css.border_style = STYLE.DOTTED
      assert_equal @css.str, "head {\nborder-style: dotted;\n}"
    end

    test 'property border color' do
      @css.name = 'head'
      @css.border_color = "red blue red green"
      assert_equal @css.str, "head {\nborder-color: red blue red green;\n}"
    end
    
    
    
  end

end
