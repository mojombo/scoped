class Scoped
  @@singleton = nil
  
  def initialize
    # handle singleton
    if @@singleton == nil
      # first instantiation of a scopable object, remember as a singleton
      @@singleton = self
    elsif @@singleton
      # second instantiation of a scopable object, don't allow singleton access anymore
      @@singleton = false
    elsif @@singleton == false
      # more than one instantiation has ocurred, do nothing
    end
    
    @@scope_table ||= {}
  end
  
  def scoped_register(thread)
    Thread.critical = true
      raise ScopeError.new('Scoped operation already running on this thread') if @@scope_table[thread]
      @@scope_table[thread] = self
    Thread.critical = false
  end
  
  def scoped_unregister(thread)
    @@scope_table[thread] = nil
  end
  
  def self.scoped
    if scoped = (@@scope_table[Thread.current] || @@singleton)
      scoped
    else
      raise ScopeError.new('No singleton or scoped object is available')
    end
  end
  
  class ScopeError < Exception; end
end