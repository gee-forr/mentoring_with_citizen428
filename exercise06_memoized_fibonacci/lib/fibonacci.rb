class Fibonacci
  
  @@fibs = {}

  def self.fib(n)
    return n         if n <= 1
    return @@fibs[n] if @@fibs.has_key? n

    return fib(n - 1) + fib(n - 2)
  end
end
