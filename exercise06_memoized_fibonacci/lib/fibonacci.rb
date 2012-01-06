class Fibonacci
  
  class << self; attr_accessor :fibs end
  @fibs = {}
  
  def self.fib(n)
    return n       if n <= 1
    return fibs[n] if fibs.has_key? n

    fibs[n] = fib(n - 1) + fib(n - 2)
  end
    
end
