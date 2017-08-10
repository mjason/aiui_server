class AudioPlayerMusic < ActionBase
  include Semantic

  namespace :AudioPlayer

  def valid?
    service_name == "musicX"
  end

  def name
    case semantic.intent
    when "PLAY"
      :SearchAndPlay
    when "INSTRUCTION"
      control_play(semantic.slots.first)
    else
      :SearchAndPlay
    end
  end

  def payload
    if name == :SearchAndPlay
      {
        artist: song_info.artist,
        song: song_info.song
      }
    else
      {}
    end
  end

  def exp
    {
      type: :music,
    }
  end

  def song_info
    @song_info ||= OpenStruct.new get_song_info(@msg)
  end

  private
  def get_song_info(msg)
    slots = semantic.slots
    info = slots.reduce({}) do |rt, meta|
      rt.merge({
        meta["name"] => meta["value"]
      })
    end
    {artist: nil, song: nil}.merge(info)
  end

  def control_play(slot)
    case slot["value"]
    when "next"
      :NextCommandIssued
    when "pause"
      :PauseCommandIssued
    when "replay"
      :ResumeCommandIssued
    when "past"
      :PreviousCommandIssued
    end
  end

end