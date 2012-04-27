require 'vhdl_parser/entity'
require 'vhdl_parser/port'

module VHDL_Parser

  class << self
  end

  def self.parse(vhdl_string)
    ports = vhdl_string.match /entity\s*(.*)\s*is\s*port\s*\(([\s\S]*)\);\s*end\s*\1;/
    
    lines =  ports[2].split("\n").compact.delete_if { |s| s.strip.empty? }
    lines.map! { |s| s.strip!}

    @entity = Entity.new
    @entity.name = ports[1]

    
    self.parse_ports(lines)

    return @entity
  end


  def self.parse_ports(port_array)
    port_array.each do |l|
      p = l.split(":").map! { |e| e.strip!}
      name = p[0].split(",")
      name.each do |n|
        port = Port.new
        port.name = n.strip
        port.direction = p[1].match(/^(in|out)/)[0]
        port.type = p[1].match(/(std_logic_vector|std_logic|unsigned|signed|integer)/)[0]
        sizes = p[1].match /\((\d+)\s+(downto|to)\s+(\d+)\)/
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
