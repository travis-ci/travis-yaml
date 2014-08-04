describe Travis::Yaml::Parser::Ruby do
  subject { Travis::Yaml::Parser::Ruby }
  let(:secure_string) { Travis::Yaml::SecureString.new("") }
  let(:input) {{ ruby: ['2.0.0', :jruby, 10, 4.2, Time.now, false, nil, secure_string, Object.new] }}

  describe :parse do
    example do
      result = subject.parse(input)
      expect(result).to be == { rvm: ['2.0.0', 'jruby'], language: 'ruby', os: ['linux'] }
    end
  end

  describe :parses? do
    it { should be_parses(input) }
  end

  describe :cast do
    let(:time) { Time.at(0) }
    subject(:parser) { Travis::Yaml::Parser::Ruby.new({}) }
    specify(:str)    { expect(parser.cast(:str,    "foo"))         .to be == "foo"          }
    specify(:binary) { expect(parser.cast(:binary, "Zm9v"))        .to be == "foo"          }
    specify(:bool)   { expect(parser.cast(:bool,   true))          .to be == true           }
    specify(:float)  { expect(parser.cast(:float,  1))             .to be == 1.0            }
    specify(:int)    { expect(parser.cast(:int,    1))             .to be == 1              }
    specify(:time)   { expect(parser.cast(:time,   time))          .to be == time           }
    specify(:secure) { expect(parser.cast(:secure, secure_string)) .to be == secure_string  }
    specify { expect { parser.cast(:foo, 10) }.to raise_error(ArgumentError) }
  end

  describe :generate_key do
    subject(:parser) { Travis::Yaml::Parser::Ruby.new({}) }
    specify { expect(parser.generate_key(nil, "foo")).to be == "foo" }
    specify { expect(parser.generate_key(nil, :foo )).to be == "foo" }

    specify do
      node = Travis::Yaml::Nodes::Node.new(nil)
      parser.generate_key(node, 10)
      expect(node.errors).to include("expected string as key")
    end
  end
end