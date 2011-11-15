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
    end
  end
end

