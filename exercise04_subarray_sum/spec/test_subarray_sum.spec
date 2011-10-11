#!/usr/bin/env ruby

require 'minitest/spec'
require 'minitest/autorun'

require './subarray_sum'

describe SubArraySum do
  it "should have a subarray_sum method" do
    SubArraySum.must_respond_to('biggest_subarray')
  end

  describe "calculations" do
    it "should find 6 for this array" do
      #[−2, 1, −3, 4, −1, 2, 1, −5, 4]
      answer = SubArraySum.biggest_subarray [-2, 1, -3, 4, -1, 2, 1, -5, 4]

      answer.must_be_instance_of Array
      answer[0].must_equal 6
      answer[1].must_equal [4, -1, 2, 1]
    end

    it "should find 5 for this array" do
      #[-4, 4, -1, -1, 3, -6, -1, 3]
      answer = SubArraySum.biggest_subarray [-4, 4, -1, -1, 3, -6, -1, 3]

      answer.must_be_instance_of Array
      answer[0].must_equal 5
      answer[1].must_equal [4, -1, -1, 3]
    end

    it "should return nil when it finds no usable answer" do
      answer = SubArraySum.biggest_subarray [-1, -2, -3]

      answer.must_be_nil
    end
  end
end
