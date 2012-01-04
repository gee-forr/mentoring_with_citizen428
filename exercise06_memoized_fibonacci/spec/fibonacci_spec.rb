#!/usr/bin/env ruby
# encoding: UTF-8

require 'minitest/spec'
require 'minitest/autorun'

require './lib/fibonacci'

describe Fibonacci do
  it "should have a fib method" do
    Fibonacci.must_respond_to('fib')
  end

  describe "calculations" do
    it "should result in 0 of fib 0" do
      Fibonacci.fib(0).must_equal 0
    end

    it "should result in 1 of fib 1" do
      Fibonacci.fib(1).must_equal 1
    end
  end
end
