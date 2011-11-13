# encoding: UTF-8

class SubtitleShifter
  attr_reader :subtitles

  def initialize(file)
    @sub_file = file
  end

  def parse
    raw_text       = IO.read(@sub_file)
    subtitle_parts = raw_text.split('\r\n\r\n')
    @subtitles     = []

    subtitle_parts.each do |subtitle|
      @subtitles << extract_sub_data(subtitle)
    end
  end

  private

  def extract_sub_data(subtitle)
    s = subtitle.split("\n")
    times = s[1].split(' --> ')
    extracted_sub = {
      index: s[0].to_i,
      start: times[0],
      end: times[1],
      subtitle: s[2..-1].join
    }


    binding.pry
    extracted_sub

  end

end
