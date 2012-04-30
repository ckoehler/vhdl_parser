VHDL Parser
===========

VHDL Parser is an VHDL entity parser. It's not a full grammar but simply
extracts port and generic information from a VHDL entity for further use
inside Ruby, e.g. visualization or automation.

Classes
=======
VHDL Parser provides four different classes 

* VHDL\_Parser::Entity
* VHDL\_Parser::Port
* VHDL\_Parser::Generic
* VHDL\_Parser::Package

Module methods
--------------
    VHDL_Parser.parse(vhdl_string) # returns Entity
    VHDL_Parser.parse_file(path_to_file) # returns Entity
    VHDL_Parser.parse_package(vhdl_string) # returns Package
    VHDL_Parser.parse_package_file(path_to_file) # returns Package

Entity methods
--------------
    my_entity.to_s # returns a very basic string representation

    # evaluate package constants in the entity, e.g. input size or generics that
    # rely on a constant defined in a package. It will replace a size like
    # "(MY_SIZE-1 downto 0)" with "(7 downto 0)", if MY_SIZE=8 in the package.
    my_entity.merge_package(package) 

Port methods
------------
    my_port.name # name of the port
    my_port.direction # direction of the port, one of (in|out|inout)
    my_port.type # type of the port, e.g. std_logic, unsigned, ...
    my_port.left # left part of the size, e.g. "7" if it's "(7 downto 0)"
    my_port.right # right part of the size, e.g. "0" if it's "(7 downto 0)"
    my_port.size_dir # direction of the size, e.g. "downto" if it's "(7 downto 0)"
    my_port.size # a string made up of the previous three values, e.g. "(7 downto 0)"
    my_port.comment # an inline comment, if there is one
    my_port.to_s # a basic string representation of the port

Generic methods
---------------
Same as above, plus:
      
    my_generic.value # the default value of the generic

Package methods
---------------
A package is really just a container of a Hash with the constant name as the
key and the value as the value. You can access it like so:

    my_package.constants # Hash of constants. You can also add your own there.

