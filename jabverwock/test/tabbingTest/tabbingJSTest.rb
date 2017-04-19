require 'test/unit' 
require '../..//lib/tabbing/tabbingJS'


module Jabverwock

  class TabbingJSTest < Test::Unit::TestCase
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

      @tj = TabbingJS.new
      
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
    #   p @tj
    #  end

    test "mainloop"do
      l1="<script>\n"
      l2="document.write(\"hello world\")\n"
      l3="</script>"
      ll = l1 << l2 << l3
      @tj.readLine ll

      p ">>>"
      p @tj.tabbedTxt

      p @tj.tabbedArr
    end

    
    
  end
end
