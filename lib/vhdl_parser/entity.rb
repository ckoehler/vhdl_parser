module VHDL_Parser
  class Entity

    attr_accessor :name
    attr_reader :ports, :generics

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
