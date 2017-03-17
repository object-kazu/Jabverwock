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
   
    
    # test "sample case 2" do
    #   t = "a{b}"
    #   @st.structing t
    #   assert_equal @st.showResult, "a.addChild(b)\n"
      
    # end

    # test "sample case 3" do
    #   t = "a{b,c}"
    #   @st.structing t
    #   assert_equal @st.showResult, "b.addMember(c)\na.addChild(b)\n"
            
    # end

    # test "sample case 4" do
    #   t = "a{b,c},d"
    #   @st.structing t
    #   assert_equal @st.showResult, "a.addMember(d)\nb.addMember(c)\na.addChild(b)\n"
            
    # end

    # test "sample case 5" do
    #   t = "a{b{c}},d"
    #   @st.structing t
    #   assert_equal @st.showResult, "a.addMember(d)\nb.addChild(c)\na.addChild(b)\n"
            
    # end

    
    # test "prep long version " do
    #   b = <<-MEM2
    #       doctype {d1{d2}
    #             }
    #       head {h1{h2}
    #         h3
    #        } 
      
    #   MEM2
      
    #   assert_equal(prep(b), " doctype{d1{d2} } head{h1{h2} h3 } ")
    # end

    
  end

end


    ############## model case ###############

    # , member
    # {} child
    
    # doctype {d1{d2,d3}
    #                 },
    # head {h1{h2},
    #             h3
    #            }

    # <<~ME

    # doctype {
    #          meta,
    #           memo       
    # },
    # header {
    #         title,
    #         meta,
    #         script,
    #         p {
    #           test,
    #           sample,
    #         },
    #         div {
    #           des,
    #           h1,
    #         }

    # },
    # body{

    # },
    # footer{

    # }


    # ME
      

  
    
