module Travis::Yaml
  module Patch
    module Config
      class Dist < Struct.new(:config)
        def apply
          config.dist = 'trusty'  if trusty?
          config.dist = 'osx'     if osx? || objective_c? && config.dist.value.nil?
          config.dist = 'precise' unless config.dist
          config
        end

        private

          def trusty?
            services.include?('docker')
          end

          def osx?
            os == 'osx'
          end

          def objective_c?
            language == "objective-c"
          end

          def language
            config.language
          end

          def os
            config.os
          end

          def services
            config.services || []
          end
      end
    end
  end
end
