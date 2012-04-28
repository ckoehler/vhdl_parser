module VHDL_Parser
  class Entity

    attr_accessor :name

    def initialize
      @ports = Array.new
      @generics = Array.new
    end


    def to_s
      out = name + "\n"
      @generics.each { |p| out += "\t" + p.to_s}
      out += "\n\n"
      @ports.each { |p| out += "\t" + p.to_s}
      out
    end

    def ports
      @ports 
    end

    def generics
      @generics 
    end

  end
end
