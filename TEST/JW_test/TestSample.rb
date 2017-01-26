#!/usr/bin/env ruby
require 'test/unit'

class TestSample < Test::Unit::TestCase
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

  def test_foo
    p 'test_foo'
    assert_true(1 == 1)
  end

  def test_bar
    p 'test_bar'
    assert_equal(1, 1)
  end

  def test_dedede
    p 'test_va'

    assert_not_equal(1,2)
  end

  test "ddddd" do
    p 'test dddd'
    assert_equal(1,1)
  end

  
end


__END__

reference page address
https://test-unit.github.io/test-unit/ja/Test/Unit/Assertions.html

assertion ref


- (void) add_assertion
Called whenever an assertion is made.
- (Object) assert(object = NOT_SPECIFIED, message = nil, &block)
- (Object) assert_alias_method(object, alias_name, original_name, message = nil)
Passes if +object+#+alias_name+ is an alias method of +object+#+original_name+.
- (Object) assert_block(message = "assert_block failed.")
The assertion upon which all other assertions are based.
- (Object) assert_boolean(actual, message = nil)
Passes if +actual+ is a boolean value.
- (Object) assert_compare(expected, operator, actual, message = nil)
Passes if expression “+expected+ +operator+ +actual+” is true.
- (Object) assert_const_defined(object, constant_name, message = nil)
Passes if +object+.const_defined?(+constant_name+).
- (Object) assert_empty(object, message = nil)
Passes if +object+ is empty.
- (Object) assert_equal(expected, actual, message = nil)
Passes if +expected+ == +actual+.
- (Object) assert_fail_assertion(message = nil)
Passes if assertion is failed in block.
- (Object) assert_false(actual, message = nil)
Passes if +actual+ is false.
- (Object) assert_in_delta(expected_float, actual_float, delta = 0.001, message = "")
Passes if +expected_float+ and +actual_float+ are equal within +delta+ tolerance.
- (Object) assert_in_epsilon(expected_float, actual_float, epsilon = 0.001, message = "")
Passes if +expected_float+ and +actual_float+ are equal within +epsilon+ relative error of +expected_float+.
- (Object) assert_include(collection, object, message = nil) (also: #assert_includes)
Passes if +collection+ includes +object+.
- (Object) assert_instance_of(klass, object, message = "")
Passes if +object+.instance_of?(+klass+).
- (Object) assert_kind_of(klass, object, message = "")
Passes if +object+.kind_of?(+klass+).
- (Object) assert_match(pattern, string, message = "")
Passes if +pattern+ =~ +string+.
- (Object) assert_nil(object, message = "")
Passes if +object+ is nil.
- (Object) assert_no_match(regexp, string, message = "")
Deprecated.
- (Object) assert_not_const_defined(object, constant_name, message = nil)
Passes if !+object+.const_defined?(+constant_name+).
- (Object) assert_not_empty(object, message = nil) (also: #refute_empty)
Passes if +object+ is not empty.
- (Object) assert_not_equal(expected, actual, message = "") (also: #refute_equal)
Passes if +expected+ != +actual+.
- (Object) assert_not_in_delta(expected_float, actual_float, delta = 0.001, message = "") (also: #refute_in_delta)
Passes if +expected_float+ and +actual_float+ are not equal within +delta+ tolerance.
- (Object) assert_not_in_epsilon(expected_float, actual_float, epsilon = 0.001, message = "") (also: #refute_in_epsilon)
Passes if +expected_float+ and +actual_float+ are not equal within +epsilon+ relative error of +expected_float+.
- (Object) assert_not_include(collection, object, message = nil) (also: #assert_not_includes, #refute_includes)
Passes if +collection+ doesn’t include +object+.
- (Object) assert_not_instance_of(klass, object, message = "") (also: #refute_instance_of)
Passes if +object+.instance_of?(+klass+) does not hold.
- (Object) assert_not_kind_of(klass, object, message = "") (also: #refute_kind_of)
Passes if +object+.kind_of?(+klass+) does not hold.
- (Object) assert_not_match(regexp, string, message = "") (also: #refute_match)
Passes if +regexp+ !~ +string+.
- (Object) assert_not_nil(object, message = "") (also: #refute_nil)
Passes if ! +object+ .nil?.
- (Object) assert_not_operator(object1, operator, object2, message = "") (also: #refute_operator)
Compares the +object1+ with +object2+ using +operator+.
- (Object) assert_not_predicate(object, predicate, message = nil) (also: #refute_predicate)
Passes if +object+.+predicate+ is not true.
- (Object) assert_not_respond_to(object, method, message = "") (also: #refute_respond_to)
Passes if +object+ does not .respond_to? +method+.
- (Object) assert_not_same(expected, actual, message = "") (also: #refute_same)
Passes if ! +actual+ .equal? +expected+.
- (Object) assert_not_send(send_array, message = nil)
Passes if the method send doesn’t return a true value.
- (Object) assert_nothing_raised(*args)
Passes if block does not raise an exception.
- (Object) assert_nothing_thrown(message = "", &proc)
Passes if block does not throw anything.
- (Object) assert_operator(object1, operator, object2, message = "")
Compares the +object1+ with +object2+ using +operator+.
- (Object) assert_path_exist(path, message = nil)
Passes if +path+ exists.
- (Object) assert_path_not_exist(path, message = nil)
Passes if +path+ doesn’t exist.
- (Object) assert_predicate(object, predicate, message = nil)
Passes if +object+.+predicate+ is true.
- (Object) assert_raise(*args, &block) (also: #assert_raises)
Passes if the block raises one of the expected exceptions.
- (Object) assert_raise_kind_of(*args, &block)
Passes if the block raises one of the given exceptions or sub exceptions of the given exceptions.
- (Object) assert_raise_message(expected, message = nil)
Passes if an exception is raised in block and its message is +expected+.
- (Object) assert_respond_to(object, method, message = "")
Passes if +object+ .respond_to? +method+.
- (Object) assert_same(expected, actual, message = "")
Passes if +actual+ .equal? +expected+ (i.e. they are the same instance).
- (Object) assert_send(send_array, message = nil)
Passes if the method send returns a true value.
- (Object) assert_throw(expected_object, message = "", &proc) (also: #assert_throws)
Passes if the block throws +expected_object+.
- (Object) assert_true(actual, message = nil)
Passes if +actual+ is true.
- (Object) build_message(head, template = nil, *arguments)
Builds a failure message.
- (Object) flunk(message = "Flunked")
Flunk always fails.
- (void) refute(object, message = nil)
Asserts that +object+ is false or nil.
