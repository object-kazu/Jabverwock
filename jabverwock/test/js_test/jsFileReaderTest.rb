require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsFileReader'

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  class JsFileReaderTest < Test::Unit::TestCase
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
      @jsf = JsFileReader.new
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

    # test "jsDocumentVar first test, for print debug " do
    #   p @jsf
    # end

    
    
    
  end
end
