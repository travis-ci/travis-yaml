describe Travis::Yaml do
  context 'from ruby' do
    specify 'valid versions' do
      config = Travis::Yaml.parse(node_js: ['0.10', '0.8.0'], language: 'node.js')
      expect(config.node_js).to be == ['0.10', '0.8.0']
    end

    specify 'invalid versions' do
      config = Travis::Yaml.parse(node_js: ['0.10.x', '0.8.0'], language: 'node.js')
      expect(config.node_js).to be == ['0.8.0']
      expect(config.nested_warnings).to include([['node_js'], 'value "0.10.x" is not a valid version'])
    end
  end
end