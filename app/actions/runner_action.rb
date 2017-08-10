class RunnerAction
  def initialize(params)
    @params = params
    @msg = decode(params[:Msg][:Content])
    @user_params = decode(params[:UserParams])
    @from_sub = params[:FromSub]
    @session_params = decode(params[:SessionParams])
  end

  def run
    directives = []
    speech_synthesizer = SpeechSynthesizer.new(@msg, @user_params,
      @from_sub, @session_params, @params)
    if speech_synthesizer.valid?
      directives << speech_synthesizer.directive
    else
      ring = Ring.new(@msg, @user_params, @from_sub, @session_params, @params)
      directives << ring.directive
    end
    Register.modules.each do |cls|
      obj = cls.new(@msg, @user_params, @from_sub, @session_params, @params)
      directives << obj.directive if obj.valid?
    end
    directives
  end

  def as_json(**args)
    run
  end

  private
  def decode(str)
    return nil if str.blank?
    JSON.parse Base64.decode64(str)
  end
end