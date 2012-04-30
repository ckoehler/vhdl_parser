module VHDL_Parser
  class Package

    attr_accessor :constants

    def initialize
      @constants = Hash.new
    end

    def to_s
      @constants.to_s
    end

    def process
      @constants.each do |k,v|
        @constants.each do |k2,v2|
          @constants[k2] = Utility.sub_constants(v2, k, v)
        end
      end
    end
  end
end
