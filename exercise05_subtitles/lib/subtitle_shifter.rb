# encoding: UTF-8

class SubtitleShifter
  attr_reader :subtitles, :parsed_ok

  TIME_SEPERATOR = '-->'

  def initialize(file, linebreak = "\r\n")
    @sub_file  = file
    @linebreak = linebreak
  end

  def parse
    raw_text       = IO.read(@sub_file)
    subtitle_parts = raw_text.split("#{@linebreak}#{@linebreak}")
    @subtitles     = {}

    subtitle_parts.each do |subtitle|
      @subtitles.update extract_sub_data(subtitle)
    end

    @parsed_ok = true # Not very useful, but will help when error checking is added
  end

  private

  def extract_sub_data(subtitle)
    s     = subtitle.split(@linebreak)
    times = s[1].split(" #{TIME_SEPERATOR} ")

    {s[0].to_i => {
      start:    srt_time_to_ms(times[0]),
      end:      srt_time_to_ms(times[1]),
      subtitle: s[2..-1].join(@linebreak)
      }
    }
  end

  def srt_time_to_ms (srt_time)
    time_parts = parse_srt_time(srt_time)

    hours_ms = time_parts[:hours] * 60 * 60 * 1000
    mins_ms  = time_parts[:mins]  * 60 * 1000
    secs_ms  = time_parts[:secs]  * 1000

    hours_ms + mins_ms + secs_ms + time_parts[:ms]
  end

  def parse_srt_time (srt_time)
    # Time looks like: hh:mm:ss,ms
    #              ... 10:09:08,756
    /^(\d+):(\d+):(\d+),(\d+)$/ =~ srt_time

    {hours: $1.to_i,
     mins:  $2.to_i,
     secs:  $3.to_i,
     ms:    $4.to_i
    }
  end
end
