#!/usr/bin/env ruby
# encoding: UTF-8

require 'minitest/spec'
require 'minitest/autorun'

require './lib/subtitle_shifter'

describe SubtitleShifter do
  it "should have a new method" do
    SubtitleShifter.must_respond_to('new')
  end

  describe "parsing a subtitle file" do
    srt = SubtitleShifter.new('./spec/The.Big.Bang.Theory.srt')
    srt.parse

    it "should work with utf-8 files" do
      srt.parsed_ok.must_equal true
    end

    it "should have some parsed data" do
      first_sub = srt.subtitles[46]
      first_sub.must_be_instance_of Hash

      first_sub[:subtitle].must_equal  "♪ Our whole universe\r\nwas in a hot, dense state ♪"
      first_sub[:start].must_equal     173610
      first_sub[:end].must_equal       177196
    end
  end

  describe "shifting subtitles" do
    before(:each) do
      @srt = SubtitleShifter.new('./spec/The.Big.Bang.Theory.srt')
      @srt.parse
    end

    describe "forward" do
      it "should shift subtitles forward from an index" do
        @srt.must_respond_to('shift')

        shift = 2500
        start = @srt.subtitles[50][:start]
        fin   = @srt.subtitles[50][:end]

        @srt.shift(:index => 50, :time => shift)
        @srt.subtitles[50][:start].must_equal start+shift
        @srt.subtitles[50][:end].must_equal   fin+shift
      end

      it "should affect all indexes till the end" do
        # start = @srt
        # 53 - s - 191962 e - 192710
        @srt.shift(:index => 50, :time => 2500)
        @srt.subtitles[53][:start].must_equal 194462
        @srt.subtitles[53][:end].must_equal   195210
      end
    end

    describe "backward" do
      it "should shift subtitles backward from an index" do
        @srt.must_respond_to('shift')

        # Test start of shift
        @srt.shift(:index => 50, :time => -2500)
        @srt.subtitles[50][:start].must_equal 182238
        @srt.subtitles[50][:end].must_equal   184872
      end

      it "should affect all indexes till the end" do
        # start = @srt
        # 53 - s - 191962 e - 192710
        @srt.shift(:index => 50, :time => -2500)
        @srt.subtitles[53][:start].must_equal 189462
        @srt.subtitles[53][:end].must_equal   190210
      end
    end
  end
end
