class GemName
  attr_reader :name, :version, :children
  def initialize(name, version)
    @name = name
    @version = version
    @children = []
  end

  def to_s
    s = "(#{fqn}" 
    s << "#{children.map(&:to_s).join(",")}" unless children.empty?
    "#{s})"
  end

  def <=>(o)
    [name, version] <=> [o.name, o.version]
  end

  def ==(o)
    [name, version] == [o.name, o.version]
  end

  def [](name)
    children.find { |child| child == name }
  end

  def <<(child)
    children << child
  end

  def fqn
    "#{name}-#{version}"
  end

  def self.from_fqdn(fqdn, root)
    parts = fqdn.gsub(".#{root}", '').split('.')
    parts = parts.reverse
    name = parts.shift
    version = parts.join(".")
    new(name, version)
  end
end
