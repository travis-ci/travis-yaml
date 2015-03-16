describe Travis::Yaml do
  context 'from ruby' do
    specify 'valid versions' do
      config = Travis::Yaml.parse(node_js: ['0.10', '0.8.0', 'iojs', 'iojs-v1.0', 'iojs-v1.0.0'], language: 'node.js')
      expect(config.node_js).to be == ['0.10', '0.8.0', 'iojs', 'iojs-v1.0', 'iojs-v1.0.0']
    end

    specify 'invalid versions' do
      config = Travis::Yaml.parse(node_js: ['0.10.x', '0.8.0'], language: 'node.js')
      expect(config.node_js).to be == ['0.8.0']
      expect(config.nested_warnings).to include([['node_js'], 'value "0.10.x" is not a valid version'])

      iojs_config = Travis::Yaml.parse(node_js: ['iojs', 'iojs-v', 'iojs-v1.x', 'iojs-v1.0.x'], language: 'node.js')
      expect(iojs_config.node_js).to be == ['iojs']
      expect(iojs_config.nested_warnings).to include([['node_js'], 'value "iojs-v" is not a valid version'])
      expect(iojs_config.nested_warnings).to include([['node_js'], 'value "iojs-v1.x" is not a valid version'])
      expect(iojs_config.nested_warnings).to include([['node_js'], 'value "iojs-v1.0.x" is not a valid version'])
    end
  end
end