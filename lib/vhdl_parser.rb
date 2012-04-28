require 'vhdl_parser/entity'
require 'vhdl_parser/port'
require 'vhdl_parser/generic'

module VHDL_Parser

  class << self
  end

  def self.parse(vhdl_string)
    info = vhdl_string.match /entity\s+(.*)\s+is\s+(?:generic\s*\((.*)\);)?\s*port\s*\((.*)\);\s*end\s*\1;/im

    generics =  info[2].split("\n").compact.delete_if { |s| s.strip.empty? }
    generics.map! { |s| s.strip!}
    generics.delete_if { |l| l.match /^--/}

    ports =  info[3].split("\n").compact.delete_if { |s| s.strip.empty? }
    ports.map! { |s| s.strip!}
    ports.delete_if { |l| l.match /^--/}
    
    @entity = Entity.new
    @entity.name = info[1]

    
    self.parse_generics(generics)
    self.parse_ports(ports)

    return @entity
  end

  private

  def self.parse_generics(generic_array)
    generic_array.each do |g|
      names = self.extract_name(g)
      names.each do |n|
        generic = Generic.new
        generic.name = n
        generic.type = self.extract_type(g)

        if generic.type == "integer"
          sizes = self.extract_range(g)
        else
          sizes = self.extract_size(g)
        end

        unless sizes.nil?
          generic.left = sizes[1]
          generic.size_dir = sizes[2]
          generic.right = sizes[3]
        end

        generic.comment = self.extract_comment(g)

        @entity.generics.push generic
      end
    end
  end

  def self.parse_ports(port_array)
    port_array.each do |l|
      names = self.extract_name(l)
      names.each do |n|
        port = Port.new
        port.name = n
        port.direction = self.extract_direction(l)
        port.type = self.extract_type(l)
        if port.type == "integer"
          sizes = self.extract_range(l)
        else
          sizes = self.extract_size(l)
        end

        unless sizes.nil?
          port.left = sizes[1]
          port.size_dir = sizes[2]
          port.right = sizes[3]
        end
        port.comment = self.extract_comment(l)
        @entity.ports.push(port)
      end
    end
  end

  def self.extract_name(string)
    names = string.split(":").map! { |e| e.strip}
    names[0].split(/\s*,\s*/)
  end

  def self.extract_direction(string)
    res = string.match(/:\s*(in|out|inout)/)
    if res[1]
      return res[1]
    end
    ""
  end

  def self.extract_type(string)
    res =  string.match(/:\s*(?:in|out|inout)?\s+(\w+)/i)
    if res[1]
      return res[1]
    end
    ""
  end

  def self.extract_size(string)
    res = string.match(/\((.*?)\s+(downto|to)\s+(.+?)\)/i)
    if res 
      return res
    end
    ""
  end

  def self.extract_range(string)
    res = string.match(/range\s+(.*?)\s+(downto|to)\s+([-a-z0-9_]*)/i)
    if res 
      return res
    end
    ""
  end

  def self.extract_comment(string)
    res = string.match(/--(.*)$/)
    if res && res[0]
      return res[0]
    end
    ""
  end

end
