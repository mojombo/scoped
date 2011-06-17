require File.dirname(__FILE__) + '/test_helper.rb'

class TestExternalThreading < Test::Unit::TestCase
  def test_external_threading
    t1 = Thread.new do
      a = Service.new('a')
      a.connection do
        3.times do
          sleepy
          assert_equal 'a', Hit.find
        end
      end
    end

    t2 = Thread.new do
      b = Service.new('b')
      b.connection do
        3.times do
          sleepy
          assert_equal 'b', Hit.find
        end
      end
    end

    t1.join
    t2.join
  end
end
