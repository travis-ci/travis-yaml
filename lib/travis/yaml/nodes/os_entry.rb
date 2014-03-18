module Travis::Yaml
  module Nodes
    class OSEntry < FixedValue
      OSX = %w[objective-c ruby c cpp]

      ignore_case
      default :linux
      value :linux, ubuntu: :linux
      value :osx, mac: :osx, macos: :osx

      def supports_language?(language)
        case value
        when 'linux' then language != 'objective-c'
        when 'osx'   then OSX.include? language
        end
      end
    end
  end
end