require File.dirname(__FILE__) + '/test_helper.rb'

class TestSingleton < Test::Unit::TestCase
  def test_one_singleton_should_allow_unscoped_behavior
    Service.new('a')
    assert_equal 'a', Hit.find
  end
  
  def test_two_singletons_should_raise
    Service.new('a')
    Service.new('b')
    
    assert_raise(Scoped::ScopeError) do
      Hit.find
    end
  end
end
