require 'dependency_resolver'

describe DependencyResolver do
  let(:resolver) { DependencyResolver.new('index.dnsimple.org') }
  it "resolves dependencies" do
    the_gem = resolver.dependencies('example', '1.0.0')
    the_gem.children.map(&:fqn).sort.should eq([
      'another-0.9.9', 
      'dependency-2.1.0', 
      'yet-another-3.4.0'
    ])
    the_gem['dependency-2.1.0'].children.map(&:fqn).sort.should eq([
      'young-gem-0.0.3'
    ])
  end
end
