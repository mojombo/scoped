require 'test/unit'
require File.dirname(__FILE__) + '/../lib/scoped'

def sleepy
  sleep(rand / 10)
end

class Service < Scoped
  attr_reader :name
  
  def initialize(name)
    super()
    
    @name = name
  end
  
  def connection(&block)
    scoped_register(Thread.current)
    yield
    scoped_unregister(Thread.current)
  end
end

class Hit
  def self.find
    Service.scoped.name
  end
  
  def self.go(&block)
    3.times do
      sleepy
      scoped = Service.scoped
      t = Thread.new do
        scoped.scoped_register(Thread.current)
        yield
        scoped.scoped_unregister(Thread.current)
      end
      t.join
    end
  end
end