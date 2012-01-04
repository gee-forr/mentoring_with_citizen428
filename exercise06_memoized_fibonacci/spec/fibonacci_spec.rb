#!/usr/bin/env ruby
# encoding: UTF-8

require 'minitest/spec'
require 'minitest/autorun'

require './lib/fibonacci'

def fib_seq_test_name(n, m)
  # Just so I don't have to type out the whole test title again and again
  "should result in #{n} for fib sequence #{m}"
end

describe Fibonacci do
  it "should have a fib method" do
    Fibonacci.must_respond_to('fib')
  end

  describe "calculations" do
    it fib_seq_test_name(0, 0) do
      Fibonacci.fib(0).must_equal 0
    end

    it fib_seq_test_name(1, 1) do
      Fibonacci.fib(1).must_equal 1
    end

    it fib_seq_test_name(1, 2) do
      Fibonacci.fib(2).must_equal 1
    end

    it fib_seq_test_name(2, 3) do
      Fibonacci.fib(3).must_equal 2
    end

    it fib_seq_test_name(3, 4) do
      Fibonacci.fib(4).must_equal 3
    end
  end
end
