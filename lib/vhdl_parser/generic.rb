module VHDL_Parser
  class Generic
    attr_accessor :name, :value, :type, :size, :left, :right, :size_dir, :comment

    def initialize
      @left = 0
      @right = 0
      @size_dir = "downto"
    end

    def to_s
      name.ljust(15) + "\t" +
      type + " " + 
      size + "\t:= " + 
      value + "\t" +
      comment +
      "\n"
    end

    def size
      unless @left.nil?
        "(#{@left} #{@size_dir} #{@right})"
      else
        ""
      end
    end
  end
end
