require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsFunction'

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  class JsFunctionTest < Test::Unit::TestCase
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
      @jsf = JsFunction.new
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

    # test "jsDocument first test, for print debug " do
    #   p @jsf
    # end

    
    
    ### function ###
    test "function no arg" do
      
      @jsf.define "test", "code is dead;"
      assert_equal @jsf.orders[0], "function test(){
      code is dead;
      }"
      
    end

    test "function with arg" do
      
      @jsf.define "test", "code is dead;", "name" , "age"
      assert_equal @jsf.orders[0], "function test(name, age){
      code is dead;
      }"
      
    end
    
    test "function with arg as symbol" do
      
      @jsf.define :test, "code is dead;", :name , :age
      assert_equal @jsf.orders[0], "function test(name, age){
      code is dead;
      }"
      
    end


  end
end
