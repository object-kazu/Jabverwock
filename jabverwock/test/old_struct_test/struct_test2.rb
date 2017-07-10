require "./path"
require 'test/unit'


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  class PrepTest < Test::Unit::TestCase
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

    # test "path " do
    #   p @st
    # end
        
    
    test "sample case 1-1" do
      
      jw = HEAD.new
      jww = BODY.new
      
      StructDescript.new.expr("jw, jww").each{ |s| eval s }
      
      jw.testPress "struct"
    end

    test "sample case 1-2" do
      
      jw = HEAD.new
      jww = BODY.new
      
      StructDescript.new.expr("jw{jww}").each{ |s| eval s }
      
      jw.testPress "struct2"
    end
   
    
    test "sample case 2" do
      a = HTML.new
      b = BODY.new
      c = HEADING.new(1).contentIs "test"

      t=<<-TEXT
        a,b{c}
      TEXT

      StructDescript.new.expr(t).each{ |s|eval s }

      a.testPress "struct3"
      
    end

    test "sample case 3" do
      a = HTML.new
      b = BODY.new
      c = HEADING.new(1).contentIs "test"
      d = FOOTER.new
      
      t=<<-TEXT
        a,b{c},d
      TEXT

      StructDescript.new.expr(t).each{ |s|eval s }
      a.testPress "struct4"
            
    end


    
  end

end
      

  
    
