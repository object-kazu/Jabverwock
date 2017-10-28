require 'test/unit'
#require "global/jwSingle"

require '../../lib/global/globalDef'
require '../../lib/global/jwOneTag'
require '../../lib/global/jw_CSS_JS'



module Jabverwock
  using StringExtension
  class JwSingleTest < Test::Unit::TestCase
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
      @t = JWOneTag.new
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
    test "single List" do
      s = INPUT.new
      assert_equal(s.name , "input")
    end

    # it "JWOneTag first test" do
    #   ans = @t.pressDefault
    #   expect(ans).to eq "<jwonetag>"

    # end
        
    # it "content add" do
    #   @t.name="j"
    #   @t.content = "test"
    #   ans = @t.pressDefault
    #   ans2 = @t.pressVal.showTempleteString
      
    #   expect(ans).to eq "<j>test"
    #   expect(ans).to eq ans2
    # end

    # it "add contentIs" do
    #   a = INPUT.new.contentIs "this is test"
    #   expect(a.pressDefault).to eq "<input>this is test"
    # end
    
        
    
  end
end
