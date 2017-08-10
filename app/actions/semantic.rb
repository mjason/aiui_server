module Semantic
  def semantic
    @semantic ||= Semantic.new(msg["intent"]["semantic"][0])
  end

  class Semantic
    attr_reader :info, :intent, :slots
    def initialize(info)
      @info = info
      @intent ||= info['intent']
      @slots ||= info['slots']
    end
  end
end