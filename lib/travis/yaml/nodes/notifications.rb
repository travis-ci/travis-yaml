module Travis::Yaml
  module Nodes
    class Notifications < Mapping
      Callbacks ||= FixedValue[:always, :never, :change]

      class List < Sequence
        type Scalar[:str, :secure]
      end

      class Notification < Mapping
        map :enabled, :disabled, to: Scalar[:bool]
        map :on_success, :on_failure, :on_start, to: Callbacks

        def self.[](name)
          Class.new(self) { list(name) }
        end

        def self.list(name)
          map name, to: List
          prefix_sequence name
          prefix_scalar name, :str, :secure
        end

        def visit_scalar(visitor, type, value, implicit = true)
          return super unless type == :bool
          visit_key_value(visitor, :enabled, value)
        end

        def enabled?
          @mapping.fetch('enabled', !@mapping['disabled'])
        end

        def disabled?
          !enabled?
        end
      end

      class Template < Sequence
        VARIABLES = %w[repository_slug repository_name repository build_number branch commit author message duration compare_url build_url]

        def verify
          super
          @children.each do |child|
            child.to_s.scan(/%{([^}]+)}/) do |match|
              next if VARIABLES.include? match.first
              warning 'unknown "template" variable %p', match.first
            end
          end
        end
      end

      class WithTemplate < Notification
        map :template, :template_success, :template_failure, :template_error, to: Template
      end

      class IRC < WithTemplate
        list :channels
        map :channel_key, :password, :nickserv_password, :nick, to: Scalar[:str, :secure]
        map :use_notice, :skip_join, to: Scalar[:bool]
      end

      class Hipchat < WithTemplate
        map :format, to: FixedValue[:html, :text]
        list :rooms
      end

      class Flowdoc < Notification
        map :api_token, to: Scalar[:str, :secure]
        prefix_scalar name, :str, :secure
      end

      map :webhooks,                    to: Notification[:urls]
      map :email,                       to: Notification[:recipients]
      map :sqwiggle, :slack, :campfire, to: WithTemplate[:rooms]
      map :flowdoc,                     to: Flowdoc
      map :hipchat,                     to: Hipchat
      map :irc,                         to: IRC
      map :webhook,                     to: :webhooks
    end
  end
end