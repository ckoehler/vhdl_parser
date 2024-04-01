lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name = "vhdl_parser"
  s.version = 0.5

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christoph Koehler"]
  s.date = "#{Time.now.strftime("%Y-%m-%d")}"
  s.summary = %q{VHDL Entity Parser}
  s.description = %q{VHDL Parser parses an VHDL entity and provides a Ruby
  interface to access all its information.}
  s.email = %q{christoph@zerodeviation.net}
  
  # = MANIFEST =
  s.files = Dir.glob("lib/**/*")
  
  
  # = MANIFEST =
  s.homepage = %q{http://rubygems.org/gems/vhdl_parser}
  s.require_paths = ["lib"]
  
  #s.add_dependency 'rat'

  s.post_install_message = ""
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3
  end
end

