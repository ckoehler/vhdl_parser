module VHDL_Parser

  # Describes a VHDL Generic.
  class Generic

    # Name of the Generic.
    # @return [String]
    attr_accessor :name

    # Value of the Generic.
    # @return [String]
    attr_accessor :value

    # Type of the Generic.
    # @return [String]
    attr_accessor :type

    # Size String of the Generic.
    # @return [String]
    attr_accessor :size

    # The left part of the size definition, if there is one.
    # @return [String]
    attr_accessor :left

    # The right part of the size definition, if there is one.
    # @return [String]
    attr_accessor :right

    # The direction of the size, i.e. "to" or "downto"
    # @return [String]
    attr_accessor :size_dir

    # Any inline comments of that Generic.
    # @return [String]
    attr_accessor :comment

    def initialize
      @left = 0
      @right = 0
      @size_dir = "downto"
    end

    # Basic String representation of the Generic
    # @return [String]
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
