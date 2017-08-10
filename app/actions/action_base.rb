class ActionBase
  attr_reader :msg, :user_params, :from_sub, :session_params, :params

  def initialize(msg, user_params, from_sub, session_params, params)
    @params = params
    @msg = msg
    @user_params = user_params
    @from_sub = from_sub
    @session_params = session_params
    init
  end

  ##
  # 模块初始化
  def init
  end

  def service_name
    @service_name ||= msg["intent"]["service"]
  end

  def valid?
    raise "必须继承覆写"
  end

  def directive
    {
      header: {
        namespace: self.class.meta[:namespace],
        name: name,
        timestamp: timestamp,
        messageId: params["MsgId"]
      },
      payload: payload,
      exp: exp
    }
  end

  def name
    raise "name is overwrite"
  end

  def exp
    nil
  end

  def payload
    raise "payload is overwrite"
  end

  def timestamp
    Time.now.to_i
  end

  class << self
    def namespace name
      @meta = {namespace: name, auto: true}
    end

    def meta
      @meta
    end
  end

end