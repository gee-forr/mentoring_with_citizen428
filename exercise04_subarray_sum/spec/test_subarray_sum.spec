#!/usr/bin/env ruby

require 'minitest/spec'
require 'minitest/autorun'

require './subarray_sum'

describe SubArraySum do
  it "should have a subarray_sum method" do
    SubArraySum.must_respond_to('biggest_subarray')
  end

  it "should find 6 for this array" do
    #([−2, 1, −3, 4, −1, 2, 1, −5, 4])
    answer = SubArraySum.biggest_subarray [-2, 1, -3, 4, -1, 2, 1, -5, 4]

    answer.must_be_instance_of Array
    answer[0].must_equal 6
    answer[1].must_equal [4, -1, 2, 1]
  end
end
