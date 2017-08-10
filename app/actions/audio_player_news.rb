class AudioPlayerNews < ActionBase
  namespace :AudioPlayer

  def valid?
    service_name == "news"
  end

  def name
    :Play
  end

  def payload
    {
      playBehavior: :REPLACE_ALL,
      audioItem: {
        audioItemId: url.hash,
        stream: {
          url: url,
          streamFormat: :AUDIO_MP3,
          expiryTime: (Time.now + 4.hours).to_i
        }
      }
    }
  end

  def exp
    {
      type: :news,
      content: result["result"],
      title: result["title"],
      publishDateTime: Time.parse(result["publishDateTime"]).to_i
    }
  end

  def url
    result["url"]
  end

  def result
    @result ||= @msg["intent"]["data"]["result"].sample
  end

end