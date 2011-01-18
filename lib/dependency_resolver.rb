require 'resolv'

class DependencyResolver
  attr_reader :root
  def initialize(root)
    @root = root
  end
  def dependencies(name, version)
    fqdn = "#{version.reverse}.#{name}.#{root}"
    dependencies = []
    resolver = Resolv::DNS.new
    resolver.each_resource(fqdn, Resolv::DNS::Resource::IN::ANY) do |res|
      if res.is_a?(Resolv::DNS::Resource::PTR)
        fqdn = res.name.to_s
        parts = fqdn.gsub(".#{root}", '').split('.')
        parts = parts.reverse
        dependencies << "#{parts.shift}-#{parts.join(".")}"
      end
    end
    dependencies.sort
  end
end
