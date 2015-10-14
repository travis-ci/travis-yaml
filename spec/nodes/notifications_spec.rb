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

  context :flowdoc do
    example "handles scalar value" do
      config = Travis::Yaml.parse(notifications: { flowdock: "foo" })
      expect(config.notifications.flowdock.api_token).to be == "foo"
    end
  end

  context :pushover do
    example "handles basic setup" do
      config = Travis::Yaml.parse(notifications: { pushover: { api_key: "foo", users: ["bar"] } })
      expect(config.notifications.pushover.api_key).to be == "foo"
      expect(config.notifications.pushover.users).to be == ["bar"]
    end
  end
end