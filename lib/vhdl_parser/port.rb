module VHDL_Parser
  # Defines an input or output on the Entity
  class Port
    # The name of the Port
    # @return [String]
    attr_accessor :name

    # The direction of the port. 
    # I.e. "in", "out", "inout"
    # @return [String]
    attr_accessor :direction

    # Any inline comment on the Port
    # @return [String]
    attr_accessor :comment

    # The type of the Port
    # @return [String]
    attr_accessor :type

    # String representation of the size, 
    # e.g. "(7 downto 0)"
    # @return [String]
    attr_accessor :size

    # Left part of the size, e.g. "7"
    # @return [String]
    attr_accessor :left

    # Right part of the size, e.g. "0"
    # @return [String]
    attr_accessor :right

    # Left part of the size, e.g. "downto"
    # @return [String]
    attr_accessor :size_dir

    def initialize
      @left = 0
      @right = 0
      @size_dir = "downto"
    end

    # @return [String]
    def to_s
      name.ljust(15) + "\t" +
      direction + "\t" + 
      type + " " + 
      size + "\t" + 
      comment + "\n"
    end

    # Returns a string based on the left, right, and size_dir attributes.
    # @return [String] The size formatted as a String.
    def size
      unless @left.nil?
        "(#{@left} #{@size_dir} #{@right})"
      else
        ""
      end
    end
  end
end
