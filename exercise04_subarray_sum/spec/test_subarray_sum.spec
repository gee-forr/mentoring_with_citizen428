#!/usr/bin/env ruby

require 'minitest/spec'
require 'minitest/autorun'

require './subarray_sum'

describe Array do
  it "should have a subarray_sum method" do
    Array.new.must_respond_to('biggest_subarray')
  end

  describe "calculations" do
    it "should find 6 for this array" do
      #[−2, 1, −3, 4, −1, 2, 1, −5, 4]
      answer = [-2, 1, -3, 4, -1, 2, 1, -5, 4].biggest_subarray

      answer.must_be_instance_of Array
      answer[0].must_equal 6
      answer[1].must_equal [4, -1, 2, 1]
    end

    it "should find 5 for this array" do
      #[-4, 4, -1, -1, 3, -6, -1, 3]
      answer = [-4, 4, -1, -1, 3, -6, -1, 3].biggest_subarray

      answer.must_be_instance_of Array
      answer[0].must_equal 5
      answer[1].must_equal [4, -1, -1, 3]
    end
  end

  describe "error conditions" do
    it "should raise an exception when there are no positive numbers" do
      proc do
        [-1, -2, -3].biggest_subarray
      end.must_raise RuntimeError
    end
  end
end
