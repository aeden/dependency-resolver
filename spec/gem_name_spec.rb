require 'gem_name'

describe GemName do
  let(:gem_name) { GemName.new('example', '1.2.3') }
  it "converts to a string" do
    gem_name.to_s.should eq('(example-1.2.3)')
  end
  it "converts to a fully-qualified name string" do
    gem_name.fqn.should eq('example-1.2.3')
  end
  it "is comparable" do
    (gem_name <=> GemName.new('a', '0.0.2')).should eq(1)
    (gem_name <=> GemName.new('z', '0.0.2')).should eq(-1)
    (gem_name <=> GemName.new('example', '1.2.3')).should eq(0)
    (gem_name <=> GemName.new('example', '0.0.2')).should eq(1)
    (gem_name <=> GemName.new('example', '2.3.4')).should eq(-1)
  end
  it "is equal" do
    (gem_name == GemName.new('example', '1.2.3')).should be_true
    (gem_name == GemName.new('example', '0.2.3')).should be_false
  end
  it "has children" do
    gem_name << GemName.new('child', '1.0.1')
    gem_name[GemName.new('child', '1.0.1')].should_not be_nil
  end
  it "can be created from a fully-qualified domain name" do
    n = GemName.from_fqdn('3.2.1.example.root', 'root')
    n.should_not be_nil
    n.name.should eq('example')
    n.version.should eq('1.2.3')
  end
end
