require 'resolv'
require 'gem_name'

class DependencyResolver
  attr_reader :root
  attr_accessor :resolver

  # The fully-qualified root name, such as index.rubygems.org
  def initialize(root, resolver=Resolv::DNS.new)
    @root = root
    @resolver = resolver
  end

  # Fill out dependencies. Returns a GemName instance
  def dependencies(name, version)
    g = GemName.new(name, version)
    _dependencies(g)
    g
  end

  private
  # Recursive dependency resolver
  def _dependencies(g)
    fqdn = "#{g.version.reverse}.#{g.name}.#{root}"
    resolver.each_resource(fqdn, Resolv::DNS::Resource::IN::ANY) do |res|
      if res.is_a?(Resolv::DNS::Resource::PTR)
        c = GemName.from_fqdn(res.name.to_s, root)
        g << c
        _dependencies(c)
      end
    end
  end

end
