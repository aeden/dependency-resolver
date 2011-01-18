require 'dependency_resolver'

describe DependencyResolver do
  it "provides a direct dependency list" do
    dependencies = DependencyResolver.new.dependencies('example', '1.0.0')
    dependencies.should eq([
      'dependency-2.1.0',
      'another-0.9.9',
      'yet-another-3.4.0'
    ])
  end
end
