describe Travis::Yaml::Nodes::Notifications do
  context :email do
    example "disabled via false" do
      config = Travis::Yaml.parse(notifications: { email: false })
      expect(config.notifications.email).to     be_disabled
      expect(config.notifications.email).not_to be_enabled
    end

    example "disabled via disabled: true" do
      config = Travis::Yaml.parse(notifications: { email: { disabled: true } })
      expect(config.notifications.email).to     be_disabled
      expect(config.notifications.email).not_to be_enabled
    end

    example "disabled via enabled: false" do
      config = Travis::Yaml.parse(notifications: { email: { enabled: false } })
      expect(config.notifications.email).to     be_disabled
      expect(config.notifications.email).not_to be_enabled
    end

    example "enabled by default" do
      config = Travis::Yaml.parse(notifications: { email: { recipients: "example@rkh.im" } })
      expect(config.notifications.email).not_to be_disabled
      expect(config.notifications.email).to     be_enabled
    end

    example "enabled via true" do
      config = Travis::Yaml.parse(notifications: { email: true })
      expect(config.notifications.email).not_to be_disabled
      expect(config.notifications.email).to     be_enabled
    end

    example "disabled via disabled: true" do
      config = Travis::Yaml.parse(notifications: { email: { disabled: false } })
      expect(config.notifications.email).not_to be_disabled
      expect(config.notifications.email).to     be_enabled
    end

    example "disabled via enabled: false" do
      config = Travis::Yaml.parse(notifications: { email: { enabled: true } })
      expect(config.notifications.email).not_to be_disabled
      expect(config.notifications.email).to     be_enabled
    end
  end
end