lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name = "vhdl_parser"
  s.version = 0.0

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christoph Koehler"]
  s.date = "#{Time.now.strftime("%Y-%m-%d")}"
  #s.default_executable = %q{tpm}
  s.description = %q{VHDL Parser gem}
  s.email = %q{christoph@zerodeviation.net}
  #s.executables = ["tpm", "sched_tpm"]
  
  # = MANIFEST =
  s.files = Dir.glob("lib/**/*")
  
  
  # = MANIFEST =
  s.homepage = %q{http://zerodeviation.net}
  s.require_paths = ["lib"]
  s.summary = %q{VHDL Parser}
  
  #s.add_dependency 'rat'

  s.post_install_message = "Hi there"
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3
  end
end

