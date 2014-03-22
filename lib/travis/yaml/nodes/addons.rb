module Travis::Yaml
  module Nodes
    class Addons < Mapping
      class Addon < Mapping
        def self.[](*keys)
          Class.new(self) { map(*keys, to: Scalar[:str, :secure])}
        end

        def visit_scalar(visitor, type, value, implicit = true)
          return super unless type == :bool
        end
      end

      class CovertyScan < Addon
        class Project < Mapping
          map :name, to: Scalar[:str, :secure], required: true
          auto_prefix :name
        end

        map :project, to: Project
        map :build_script_url, :branch_pattern, :notification_email, :build_command,
          :build_command_prepend, to: Scalar[:str, :secure]
      end

      map :code_climate,  to: Addon[:repo_token], drop_empty: false
      map :coverty_scan,  to: CovertyScan
      map :firefox,       to: Version
      map :hosts,         to: Sequence
      map :postgresql,    to: Version
      map :sauce_connect, to: Addon[:username, :access_key], drop_empty: false
    end
  end
end