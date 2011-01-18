require 'resolv'

class DependencyResolver
  attr_reader :root
  def initialize(root="index.dnsimple.org")
    @root = root
  end
  def dependencies(name, version)
    fqdn = "#{version.reverse}.#{name}.#{root}"
    results = []
    resolver = Resolv::DNS.new
    resolver.each_resource(fqdn, Resolv::DNS::Resource::IN::ANY) do |res|
      if res.is_a?(Resolv::DNS::Resource::PTR)
        parts = res.name.to_s.gsub(".#{root}", '').split('.').reverse
        n = parts.shift
        results << [n, parts.join(".")].join("-")
      end
    end
    results
  end
end
