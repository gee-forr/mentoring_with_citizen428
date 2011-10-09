#!/usr/bin/env ruby

require 'minitest/spec'
require 'minitest/autorun'

require './lib/image_editor'

describe ImageEditor do
  before(:each) do
    @image       = ImageEditor.new(5, 4)
    @clear_grid = "OOOOO\nOOOOO\nOOOOO\nOOOOO\n"
  end

  it "should be an ImageEditor object" do
      @image.must_be_instance_of(ImageEditor)
  end

  it "should print a grid of O's" do
      @image.to_s.must_equal @clear_grid
  end

  it "should have a grid method that is an array of arrays" do
      @image.grid.must_equal [['O', 'O', 'O', 'O', 'O'],
                              ['O', 'O', 'O', 'O', 'O'],
                              ['O', 'O', 'O', 'O', 'O'],
                              ['O', 'O', 'O', 'O', 'O']]
  end
  
  it "should be able to tell when a pixel is out of bounds" do
    @image.pixel_in_bounds?(1, 1).must_equal   true
    @image.pixel_in_bounds?(10, 10).wont_equal true
    @image.pixel_in_bounds?(4, 10).wont_equal  true
    @image.pixel_in_bounds?(10, 5).wont_equal  true
  end

  describe "editing features" do
      it "should be able to fill a single pixel" do
          @image.colour_pixel(3, 2, "X")
          @image.to_s.must_equal "OOOOO\nOOOOO\nOXOOO\nOOOOO\n"
      end

      it "should be able to clear the grid" do
          @image.clear
          @image.to_s.must_equal @clear_grid
      end

      it "should be able to fill a sub-row with a colour" do
          @image.horizontal_segment(3, 2, 4, "H")
          @image.to_s.must_equal "OOOOO\nOOOOO\nOHHHO\nOOOOO\n"
      end

      it "should be able to fill a sub-column with a colour" do
          @image.vertical_segment(3, 2, 4, "V")
          @image.to_s.must_equal "OOOOO\nOOVOO\nOOVOO\nOOVOO\n"
      end

      it "should be able to fill an area with a colour" do
          @image.horizontal_segment(1, 1, 5, 'X')
          @image.vertical_segment(3, 1, 3, 'X')
          @image.fill(2, 1, 'S')

          @image.to_s.must_equal "XXXXX\nSSXSS\nSSXSS\nSSSSS\n"
      end

  end
end
