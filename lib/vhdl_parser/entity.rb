module VHDL_Parser
  class Entity

    # An array of all the Ports.
    # @return [Array<Port>] An array of all the Ports on this entity.
    attr_reader :ports

    # An array of all the Generics.
    # @return [Array<Generic>] An array of all the Generics on this entity.
    attr_reader :generics

    # The name of the Entity.
    # @return [String] The name of the Entity
    attr_reader :name

    def initialize(name)
      @name = name
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


    # Applies constants from a package to the entity. For example, if 
    # the Entity has an input whose size is defined with a constant, like
    # "std_logic_vector(MY_SIZE-1 downto 0)", and "MY_SIZE" is defined in
    # the package, this method will evaluate the size to a real number.
    #
    # @param [package] Package The package instance to merge.
    # @return [nil] Nothing
    def merge_package(package)
      # TODO: do some type checking
      @generics.each do |g|
        package.constants.each do |k,v|
          unless g.value.nil?
            g.value = Utility.sub_constants(g.value, k, v)
          end

          unless g.left.nil?
            g.left = Utility.sub_constants(g.left, k, v)
          end

          unless g.right.nil?
            g.right = Utility.sub_constants(g.right, k, v)
          end
        end
        nil
      end

      @ports.each do |p|
        package.constants.each do |k,v|
          unless p.left.nil?
            p.left = Utility.sub_constants(p.left, k, v)
          end

          unless p.right.nil?
            p.right = Utility.sub_constants(p.right, k, v)
          end
        end
      end
    end

    # Re-processes Generics. May not be needed, so don't worry about it.
    # @visibility private
    def process_generics
      @ports.each do |p|
        @generics.each do |g|
          unless p.left.nil?
            p.left = Utility.sub_constants(p.left, g.name, g.value)
          end
          unless p.right.nil?
            p.right = Utility.sub_constants(p.right, g.name, g.value)
          end
        end
      end

    end
  end
end
