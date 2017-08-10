class Ring < ActionBase
  namespace :Ring

  def name
    :OK
  end

  def payload
    {
      RingId: 0
    }
  end

  def valid?
    true
  end

end