module VHDL_Parser
  class Port
    attr_accessor :name, :direction, :type, :size


    def to_s
      direction + "\t" + 
      name + "\t" +
      type + "\n"
    end

    def size
      
    end
  end
end
