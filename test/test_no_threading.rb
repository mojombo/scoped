require File.dirname(__FILE__) + '/test_helper.rb'

class TestNoThreading < Test::Unit::TestCase
  def test_one_scope
    a = Service.new('a')
    
    a.connection do
      assert_equal 'a', Hit.find
    end
  end
  
  def test_two_scopes
    a = Service.new('a')
    b = Service.new('b')
    
    a.connection do
      assert_equal 'a', Hit.find
    end

    b.connection do
      assert_equal 'b', Hit.find
    end
  end
end
