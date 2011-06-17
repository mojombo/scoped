require File.dirname(__FILE__) + '/test_helper.rb'

class TestInternalThreading < Test::Unit::TestCase
  def test_internal_threading
    a = Service.new('a')
    b = Service.new('b')

    a.connection do
      Hit.go { assert_equal 'a', Hit.find }
    end

    b.connection do
      Hit.go { assert_equal 'b', Hit.find }
    end
  end
end
