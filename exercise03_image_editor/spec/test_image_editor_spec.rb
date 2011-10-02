#!/usr/bin/env ruby

require 'minitest/spec'
require 'minitest/autorun'

require './lib/image_editor'

describe ImageEditor do
  before(:each) do
    @grid       = ImageEditor.new(5, 4)
    @clear_grid = "OOOOO\nOOOOO\nOOOOO\nOOOOO\n"
  end

  it "should be an ImageEditor object" do
      @grid.must_be_instance_of(ImageEditor)
  end

  it "should print a grid of O's" do
      @grid.to_s.must_equal @clear_grid
  end

  it "should have a grid method that is an array of arrays" do
      @grid.grid.must_equal [['O', 'O', 'O', 'O', 'O'],
                             ['O', 'O', 'O', 'O', 'O'],
                             ['O', 'O', 'O', 'O', 'O'],
                             ['O', 'O', 'O', 'O', 'O']]
  end

  describe "editing features" do
      it "should be able to fill a single pixel" do
          @grid.colour_pixel(3, 2, "X")
          @grid.to_s.must_equal "OOOOO\nOOOOO\nOXOOO\nOOOOO\n"
      end

      it "should be able to clear the grid" do
          @grid.clear
          @grid.to_s.must_equal @clear_grid
      end
  end
end
