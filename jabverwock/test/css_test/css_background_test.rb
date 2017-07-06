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
  
  class Css_Background_Test < Test::Unit::TestCase
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
    
  
    test "property background_color" do
      @css.name = "head"
      @css.background_color = "red"
      assert_equal(@css.str, "head {\nbackground-color: red;\n}")
    end

    test 'property background_image' do

      @css.name = 'head'
      @css.background_image = URL.url 'paper.gif'.dQuo
       assert_equal @css.str, "head {\nbackground-image: url(\"paper.gif\");\n}"
    end

    test 'property background_repeat, repeat' do
      @css.name = 'head'
      @css.background_repeat = REPEAT.Yes.val
      assert_equal @css.str, "head {\nbackground-repeat: repeat;\n}"
      
    end

    test 'property background_repeat, repeat-x, repeat-y' do
      @css.name = 'head'
      @css.background_repeat = REPEAT.X.Y.val
      assert_equal @css.str, "head {\nbackground-repeat: repeat-x repeat-y;\n}"  
    end

    
    test 'property background_attachment' do
      @css.name = 'head'
      @css.background_attachment = ATTATCHMENT.SCROLL
       assert_equal @css.str, "head {\nbackground-attachment: scroll;\n}"
      
    end

    test 'property background_attachment local' do
      @css.name = 'head'
      @css.background_attachment = ATTATCHMENT.LOCAL
       assert_equal @css.str, "head {\nbackground-attachment: local;\n}"
      
    end

    test 'property background_position' do
      @css.name = 'head'
      @css.background_position = "left"
      assert_equal @css.str, "head {\nbackground-position: left;\n}"
      
    end

    test 'property background_origin' do
      @css.name = 'head'
      @css.background_origin = ORIGIN.BORDER
      assert_equal @css.str, "head {\nbackground-origin: border-box;\n}"
    end

    test 'property background_size' do
      @css.name = 'head'
      @css.background_size = "50px 50px"
      assert_equal @css.str, "head {\nbackground-size: 50px 50px;\n}"      
    end
    
  end

end
