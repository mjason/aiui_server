class RegisterBase
  class << self
    def reg(subclass)
      @modules ||= []
      @modules << subclass
    end

    def modules
      @modules
    end
  end
end