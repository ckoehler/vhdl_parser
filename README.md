VHDL Parser
===========

VHDL Parser is an VHDL entity parser. It's not a full grammar but simply
extracts port and generic information from a VHDL entity for further use
inside Ruby, e.g. visualization or automation.

Classes
=======
VHDL Parser provides four different classes:

* VHDL\_Parser::Entity
* VHDL\_Parser::Port
* VHDL\_Parser::Generic
* VHDL\_Parser::Package

See http://rubydoc.info/gems/vhdl_parser/ for documentation.

Basic Example
=============
Most basically,  you'll want to get an Entity from a VHDL file. Just do this:
    filename = "my_file.vhd"
    my_entity = VHDL_Parser.parse_file(filename)
    puts my_entity

Sometimes the entity declaration will depend on constants defined in a package.
Just create a Package and merge it into the Entity:

    package_file = "my_package.vhd"
    my_package = VHDL_Parser.parse_package_file(package_file)
    my_entity.merge_package(my_package)
    puts my_entity

Once you have a complete Entity, you can access its Generics or Ports:

    my_ports = my_entity.ports
    my_generics = my_entity.generics

See the RubyDoc docs for attributes on those classes.


Contact
=======
The best way to get a hold of me for improvements/bugs/ideas is the Github
repo at https://github.com/ckoehler/vhdl_parser
