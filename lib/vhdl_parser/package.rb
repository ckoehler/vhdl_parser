module VHDL_Parser
  # Represents a VHDL Package
  class Package

    # A Hash of all the constants defined in this Package.
    # @return [Hash]
    attr_accessor :constants

    def initialize
      @constants = Hash.new
    end

    # @return [String]
    def to_s
      @constants.to_s
    end

    # Processes the constants defined in the package. This resolves
    # constants being dependent on other constants in this package.
    # @return [nil] Nothing
    def process
      @constants.each do |k,v|
        @constants.each do |k2,v2|
          @constants[k2] = Utility.sub_constants(v2, k, v)
        end
      end
    end
  end
end
