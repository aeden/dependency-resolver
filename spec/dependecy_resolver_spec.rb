require 'dependency_resolver'

describe DependencyResolver do
  let(:resolver) { DependencyResolver.new('index.dnsimple.org') }
  it "provides a direct dependency list" do
    dependencies = resolver.dependencies('example', '1.0.0')
    dependencies.should eq([
      'dependency-2.1.0',
      'another-0.9.9',
      'yet-another-3.4.0'
    ].sort)
  end
end
