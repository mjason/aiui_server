class SpeechSynthesizer < ActionBase
  namespace :SpeechSynthesizer

  def init
    @answer = msg['intent']['answer']["text"]
  rescue NoMethodError
    @answer = nil
  end

  def name
    :Speak
  end

  def payload
    {
      text: @answer
    }
  end

  def valid?
    !@answer.blank?
  end

end