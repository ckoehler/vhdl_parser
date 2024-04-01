require 'vhdl_parser/magic'
require 'vhdl_parser/utility'
require 'vhdl_parser/extractor'
require 'vhdl_parser/entity'
require 'vhdl_parser/port'
require 'vhdl_parser/generic'
require 'vhdl_parser/package'


# VHDL Parser Module. It parses a given VHDL entity into Ruby objects that can 
# then be used further in code, e.g. for visualization or automation.
module VHDL_Parser

  class << self
  end

  # Parses the given file and returns an Entity object.
  # @param [filename] String the path to the file.
  # @return [Entity] Entity object
  def self.parse_file(filename)
    string = File.read(filename)
    self.parse(string)
  end

  # Parses the given string and returns an Entity object.
  # @param [vhdl_string] String The VHDL entity as a String
  # @return [Entity] Entity object
  def self.parse(vhdl_string)
    info = vhdl_string.match /entity\s+(.*)\s+is\s+(?:generic\s*\((.*)\);)?\s*port\s*\((.*)\);\s*end\s*\1;/im

    unless info[2].nil?
      generics =  info[2].split("\n").compact.delete_if { |s| s.strip.empty? }
      generics.map! { |s| s.strip}
      generics.delete_if { |l| l.match /^--/}
    end

    ports =  info[3].split("\n").compact.delete_if { |s| s.strip.empty? }
    ports.map! { |s| s.strip}
    ports.delete_if { |l| l.match /^\s*--/}
    
    @entity = Entity.new(info[1])

    
    self.parse_generics(generics)
    self.parse_ports(ports)

    @entity.process_generics

    return @entity
  end

  # Parses the given VHDL package file and returns a Package object.
  # @param [filename] String the path to the file.
  # @return [Package] Package object
  def self.parse_package_file(filename)
    string = File.read(filename)
    self.parse_package(string)
  end

  # Parses the given VHDL package string and returns a Package object.
  # @param [string] String The VHDL package as a String
  # @return [Package] Package object
  def self.parse_package(string)
    package = Package.new

    constants = Extractor.extract_package_constants(string)
    constants.each do |c|
      package.constants[c[0]] = c[2]
    end
    package.process
    package
  end

  private

  def self.parse_generics(generic_array)
    return if generic_array.nil?

    generic_array.each do |g|
      names = Extractor.extract_name(g)
      names.each do |n|
        generic = Generic.new
        generic.name = n
        generic.type = Extractor.extract_type(g)

        if generic.type == "integer"
          sizes = Extractor.extract_range(g)
        else
          sizes = Extractor.extract_size(g)
        end

        unless sizes.nil?
          generic.left = sizes[1]
          generic.size_dir = sizes[2]
          generic.right = sizes[3]
        end

        generic.comment = Extractor.extract_comment(g)

        generic.value = Extractor.extract_value(g)

        @entity.generics.push generic
      end
    end
  end

  def self.parse_ports(port_array)
    port_array.each do |l|
      names = Extractor.extract_name(l)
      names.each do |n|
        port = Port.new
        port.name = n
        port.direction = Extractor.extract_direction(l)
        port.type = Extractor.extract_type(l)
        if port.type == "integer"
          sizes = Extractor.extract_range(l)
        else
          sizes = Extractor.extract_size(l)
        end

        unless sizes.nil?
          port.left = sizes[1]
          port.size_dir = sizes[2]
          port.right = sizes[3]
        end
        port.comment = Extractor.extract_comment(l)
        @entity.ports.push(port)
      end
    end
  end

end
