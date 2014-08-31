describe Travis::Yaml::Matrix do
  let(:matrix) { config.to_matrix }
  let(:entries) { matrix.entries }
  let(:matrix_attributes) { entries.first.matrix_attributes }

  context 'no matrix' do
    let(:config) { Travis::Yaml.load(language: "ruby") }
    specify { expect(matrix.size)           .to be == 1                                     }
    specify { expect(entries.first.to_ruby) .to be == {"language"=>"ruby", "os"=>["linux"]} }
    specify { expect(config.to_ruby)        .to be == {"language"=>"ruby", "os"=>["linux"]} }
    specify { expect(entries.first)         .to be_a(Travis::Yaml::Matrix::Entry)           }
    specify { expect(matrix_attributes)     .to be_empty                                    }
    specify { expect(matrix.axes)           .to be_empty                                    }
  end

  context 'simple matrix' do
    let(:config) { Travis::Yaml.load(ruby: ["ruby", "jruby"]) }
    specify { expect(matrix.size)           .to be == 2                                                                }
    specify { expect(entries.first.to_ruby) .to be == {"language"=>"ruby", "os"=>["linux"], "ruby"=>"ruby"}            }
    specify { expect(config.to_ruby)        .to be == {"language"=>"ruby", "os"=>["linux"], "ruby"=>["ruby", "jruby"]} }
    specify { expect(entries.first)         .to be_a(Travis::Yaml::Matrix::Entry)                                      }
    specify { expect(matrix_attributes)     .to be == { ruby: "ruby"}                                                  }
    specify { expect(matrix.axes)           .to be == [:ruby]                                                          }
  end

  context 'two dimensional matrix' do
    let(:config) { Travis::Yaml.load(ruby: ["ruby", "jruby"], os: ["linux", "osx"]) }
    specify { expect(matrix.size)           .to be == 4                                                                       }
    specify { expect(entries.first.to_ruby) .to be == {"language"=>"ruby", "os"=>"linux",          "ruby"=>"ruby"}            }
    specify { expect(config.to_ruby)        .to be == {"language"=>"ruby", "os"=>["linux", "osx"], "ruby"=>["ruby", "jruby"]} }
    specify { expect(entries.first)         .to be_a(Travis::Yaml::Matrix::Entry)                                             }
    specify { expect(matrix_attributes)     .to be == { ruby: "ruby", os: "linux" }                                           }
    specify { expect(matrix.axes)           .to be == [:ruby, :os]                                                            }
  end

  context 'matrix env, no global env' do
    let(:config) { Travis::Yaml.load(env: ['a', 'b']) }
    specify { expect(matrix.size)           .to be == 2                                                                    }
    specify { expect(entries.first.to_ruby) .to be == {"env"=>{"global"=>["a"]}, "language"=>"ruby", "os"=>["linux"]}      }
    specify { expect(entries.last.to_ruby)  .to be == {"env"=>{"global"=>["b"]}, "language"=>"ruby", "os"=>["linux"]}      }
    specify { expect(config.to_ruby)        .to be == {"env"=>{"matrix"=>["a", "b"]}, "language"=>"ruby", "os"=>["linux"]} }
    specify { expect(entries.first)         .to be_a(Travis::Yaml::Matrix::Entry)                                          }
    specify { expect(matrix_attributes)     .to be == { env: "a" }                                                         }
    specify { expect(matrix.axes)           .to be == [:env]                                                               }
  end

  context 'matrix env, global env' do
    let(:config) { Travis::Yaml.load(env: { matrix: ['a', 'b'], global: ['x'] }) }
    specify { expect(matrix.size)           .to be == 2                                                                                     }
    specify { expect(entries.first.to_ruby) .to be == {"env"=>{"global"=>["x", "a"]}, "language"=>"ruby", "os"=>["linux"]}                  }
    specify { expect(entries.last.to_ruby)  .to be == {"env"=>{"global"=>["x", "b"]}, "language"=>"ruby", "os"=>["linux"]}                  }
    specify { expect(config.to_ruby)        .to be == {"env"=>{"matrix"=>["a", "b"], "global"=>["x"]}, "language"=>"ruby", "os"=>["linux"]} }
    specify { expect(entries.first)         .to be_a(Travis::Yaml::Matrix::Entry)                                                           }
    specify { expect(matrix_attributes)     .to be == { env: "a" }                                                                          }
    specify { expect(matrix.axes)           .to be == [:env]                                                                                }
  end
end