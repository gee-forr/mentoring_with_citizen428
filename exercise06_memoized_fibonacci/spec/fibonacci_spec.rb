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
  end
end
