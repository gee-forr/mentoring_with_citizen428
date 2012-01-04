#!/usr/bin/env ruby
# encoding: UTF-8

require 'minitest/spec'
require 'minitest/autorun'

require './lib/fibonacci'

fibs = {
  0  => 0,
  1  => 1,
  2  => 1,
  3  => 2,
  4  => 3,
  5  => 5,
  6  => 8,
  7  => 13,
  8  => 21,
  9  => 34,
  10 => 55,
  11 => 89,
  12 => 144,
  13 => 233,
  14 => 377,
  15 => 610,
  16 => 987,
  17 => 1597,
  18 => 2584,
  19 => 4181,
  20 => 6765
}

def fib_seq_test_name(n, m)
  # Just so I don't have to type out the whole test title again and again
  "should result in #{m} for fib sequence #{n}"
end

describe Fibonacci do
  it "should have a fib method" do
    Fibonacci.must_respond_to('fib')
  end

  describe "calculations" do

    fibs.each do |n, m|
      it fib_seq_test_name(n, m) do
        Fibonacci.fib(n).must_equal m
      end
    end

  end
end
