require 'test/unit'
#require "global/jwSingle"


require '../../lib/global/jwSingle'
require '../../lib/global/jwMulti'

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  class HeadTest < Test::Unit::TestCase
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
    # test "Head first test" do
    #   a = HEAD.new
    #   assert_equal(a.tgStr , "<head>\n</head>")
    # end

    test "head and script" do
      h = HEAD.new

      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
      child.js.doc.write("child again")
      
      h.addMember parent
      h.addMember child
      
      p h.tgStr
    end
    
    # test "js doc firstChild and is_var" do
    #   h1 = HEAD.new().attr(:id__id01).contentIs "My First Page"
    #   h1.js.doc.byID.firstChild(:value)
    #   h1.js.doc.byID.firstChild(:value).is_var(:myHead).record

    # end

    
    
    
    
    
  end
end
