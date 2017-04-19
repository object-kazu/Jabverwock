require 'test/unit' 
require '../..//lib/tabbing/tabbingCSS'


module Jabverwock

  class TabbingCSSTest < Test::Unit::TestCase
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

      @tc = TabbingCSS.new
      
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
    

    # test "path" do
    #   p t = TabbingCSS.new
    #  end

    test "isOpenPara case true" do
      l = "p { \n"
      assert_true @tc.isOpenPara l
    end

    test "isOpenPara case true 2" do
      l = "p .sample { \n"
      assert_true @tc.isOpenPara l
    end
    
    test "isOpenPara case false " do
      l = "p .sample } \n"
      assert_false @tc.isOpenPara l
    end
    
    test "isOpenPara case false 2 " do
      l = "p .sample \n"
      assert_false @tc.isOpenPara l
    end

    test "isClose case true" do
      l = "}"
      assert_true @tc.isClosePara l
    end
    
    test "isClose case true 2" do
      l = "{ sample }"
      assert_true @tc.isClosePara l
    end

    test "isAttList case true" do
      l = "sample is good"
      assert_true @tc.isAttList l
    end

    test "isAttList case false" do
      l = "{sample is good"
      assert_false @tc.isAttList l
    end
    
    test "isAttList case false 2" do
      l = "sample is good}"
      assert_false @tc.isAttList l
    end
    
    test "isAttList case false 3" do
      l = "{sample is good}"
      assert_false @tc.isAttList l
    end

    test "isAttList, style tag case false" do
      l = "<style>"
      assert_false @tc.isAttList l
    end
    
    test "isAttList, style tag case true" do
      l = "<style>"
      assert_true @tc.isStyle l
    end

    test "isCloseStyle case true" do
      l = "</style>"
      assert_true @tc.isCloseStyle l
    end

    test "isCloseStyle case false" do
      l = "<style>"
      assert_false @tc.isCloseStyle l
    end

    
    
    test "main loop" do
      l1 = "<style>\n"
      l2 = "head {\n"
      l3 = "font-size: 10;\n"
      l4 = "}\n"
      l5 = "</style>"
      lt = l1 << l2 << l3 << l4 << l5
      
      @tc.readLine lt

      
      p ">>>"
      p @tc.tabbedTxt
     
    end
    
    
  end
end
