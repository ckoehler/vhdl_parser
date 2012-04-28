require 'vhdl_parser/entity'
require 'vhdl_parser/port'

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
    
  end

  def self.parse_ports(port_array)
    port_array.each do |l|
      p = l.split(":").map! { |e| e.strip}
      name = p[0].split(/\s*,\s*/)
      name.each do |n|
        port = Port.new
        port.name = n.strip
        port.direction = p[1].match(/^(in|out)/)[0]
        port.type = p[1].match(/(std_logic_vector|std_logic|unsigned|signed|integer)/)[0]
        if port.type == "integer"
          sizes = p[1].match /range\s+(\d+)\s+(downto|to)\s+(\d+)/
        else
          sizes = p[1].match /\((\d+)\s+(downto|to)\s+(\d+)\)/
        end

        unless sizes.nil?
          port.left = sizes[1]
          port.size_dir = sizes[2]
          port.right = sizes[3]
        end
        comment = p[1].match(/--.*$/)
        port.comment = comment ? comment[0] : ""
        @entity.ports.push(port)
      end
    end
  end

end
