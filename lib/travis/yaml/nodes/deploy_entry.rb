module Travis::Yaml
  module Nodes
    class DeployEntry < OpenMapping
      class Setting < OpenMapping
        KEY = ''
        prefix_scalar KEY
        default_type Scalar[:str, :secure]

        def ==(other)
          return true if super
          return false unless branch_specific?
          generic == other
        end

        def __getobj__
          branch_specific? ? generic : super
        end

        def inspect
          branch_specific? ? generic.inspect : super
        end

        def branch_specific?
          @mapping.size == 1 and @mapping.include? KEY
        end

        def branches
          @mapping.keys - [KEY]
        end

        def generic
          @mapping[KEY]
        end

        def verify_branch(name)
          branches.each do |branch|
            next if branch.to_s == name.to_s
            warning "branch %p not permitted by deploy condition, dropping", branch
            @mapping.delete(branch)
          end
        end
      end

      default_type Setting
      prefix_scalar :provider
      map :provider, to: Scalar, required: true
      map :edge, to: Scalar[:bool], experimental: true
      map :on, to: DeployConditions

      def verify
        @mapping.each_value { |v| v.verify_branch(on.branch) if v.respond_to? :verify_branch } if on and on.branch
        super
      end
    end
  end
end