## The `.travis.yml` Format
Here is a list of all the options understood by travis-yaml.

Note that stricitly speaking Travis CI might not have the same understanding of these as travis-yaml has at the moment, since travis-yaml is not yet being used.

### Available Options
#### `after_deploy`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `after_failure`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `after_result`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `after_script`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `after_success`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `before_deploy`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `before_install`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `before_script`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `bundler_args`
**Expected format:** String.

#### `compiler`
**Expected format:** List of strings; or a single string.

#### `deploy`
**Expected format:** List of key value mappings; or a single key value mapping.

#### `deploy[]`
**Expected format:** Key value mapping.

#### `deploy[].on`
**Expected format:** Key value mapping.

#### `deploy[].provider`
**This setting is required!**

**Expected format:** String.

#### `env`
**Expected format:** Key value mapping.

#### `env.global`
**Expected format:** List of strings or  encrypted strings; or a single string or  encrypted string.

#### `env.matrix`
**Expected format:** List of strings or  encrypted strings; or a single string or  encrypted string.

#### `gemfile`
**Expected format:** List of strings; or a single string.

#### `ghc`
**Expected format:** List of strings; or a single string.

#### `git`
**Expected format:** Key value mapping.

#### `git.depth`
**Expected format:** Integer value.

#### `git.strategy`
Value has to be `clone` or  `tarball`. Setting is case sensitive.

**Expected format:** String.

#### `git.submodules`
**Expected format:** Boolean value.

#### `go`
**Expected format:** List of strings; or a single string.

#### `gobuild_args`
**Expected format:** String.

#### `install`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `jdk`
**Expected format:** List of strings; or a single string.

#### `language`
**This setting is required!**

Value has to be `c`, `cpp`, `clojure`, `erlang`, `go`, `groovy`, `haskell`, `java`, `node_js`, `objective-c`, `ruby` (default), `python`, `perl`, `php` or  `scala`; or one of the known aliases: `jvm` for `java`, `javascript` for `node_js`, `node` for `node_js`, `nodejs` for `node_js`, `golang` for `go`, `objective_c` for `objective-c`, `obj_c` for `objective-c`, `objc` for `objective-c`, `c++` for `cpp`, `node.js` for `node_js` or  `obj-c` for `objective-c`. Setting is not case sensitive.

**Expected format:** String.

#### `lein`
**Expected format:** List of strings; or a single string.

#### `matrix`
**Expected format:** Key value mapping.

#### `matrix.allow_failures`
**Expected format:** List of key value mappings; or a single key value mapping.

#### `matrix.allow_failures[]`
**Expected format:** Key value mapping.

#### `matrix.allow_failures[].env`
**Expected format:** String or  encrypted string.

#### `matrix.allow_failures[].gemfile`
**Expected format:** String.

#### `matrix.allow_failures[].ghc`
**Expected format:** String.

#### `matrix.allow_failures[].go`
**Expected format:** String.

#### `matrix.allow_failures[].jdk`
**Expected format:** String.

#### `matrix.allow_failures[].lein`
**Expected format:** String.

#### `matrix.allow_failures[].node`
Alias for [`matrix.allow_failures.[].node_js`](#matrix.allow_failures.[].node_js).
#### `matrix.allow_failures[].node_js`
**Expected format:** String.

#### `matrix.allow_failures[].os`
Value has to be `linux` (default) or  `osx`; or one of the known aliases: `ubuntu` for `linux`, `mac` for `osx` or  `macos` for `osx`. Setting is not case sensitive.

**Expected format:** String.

#### `matrix.allow_failures[].otp`
Alias for [`matrix.allow_failures.[].otp_release`](#matrix.allow_failures.[].otp_release).
#### `matrix.allow_failures[].otp_release`
**Expected format:** String.

#### `matrix.allow_failures[].perl`
**Expected format:** String.

#### `matrix.allow_failures[].php`
**Expected format:** String.

#### `matrix.allow_failures[].python`
**Expected format:** String.

#### `matrix.allow_failures[].ruby`
**Expected format:** String.

#### `matrix.allow_failures[].rvm`
Alias for [`matrix.allow_failures.[].ruby`](#matrix.allow_failures.[].ruby).
#### `matrix.allow_failures[].xcode_scheme`
**Expected format:** String.

#### `matrix.allow_failures[].xcode_sdk`
**Expected format:** String.

#### `matrix.exclude`
**Expected format:** List of key value mappings; or a single key value mapping.

#### `matrix.exclude[]`
**Expected format:** Key value mapping.

#### `matrix.exclude[].env`
**Expected format:** String or  encrypted string.

#### `matrix.exclude[].gemfile`
**Expected format:** String.

#### `matrix.exclude[].ghc`
**Expected format:** String.

#### `matrix.exclude[].go`
**Expected format:** String.

#### `matrix.exclude[].jdk`
**Expected format:** String.

#### `matrix.exclude[].lein`
**Expected format:** String.

#### `matrix.exclude[].node`
Alias for [`matrix.exclude.[].node_js`](#matrix.exclude.[].node_js).
#### `matrix.exclude[].node_js`
**Expected format:** String.

#### `matrix.exclude[].os`
Value has to be `linux` (default) or  `osx`; or one of the known aliases: `ubuntu` for `linux`, `mac` for `osx` or  `macos` for `osx`. Setting is not case sensitive.

**Expected format:** String.

#### `matrix.exclude[].otp`
Alias for [`matrix.exclude.[].otp_release`](#matrix.exclude.[].otp_release).
#### `matrix.exclude[].otp_release`
**Expected format:** String.

#### `matrix.exclude[].perl`
**Expected format:** String.

#### `matrix.exclude[].php`
**Expected format:** String.

#### `matrix.exclude[].python`
**Expected format:** String.

#### `matrix.exclude[].ruby`
**Expected format:** String.

#### `matrix.exclude[].rvm`
Alias for [`matrix.exclude.[].ruby`](#matrix.exclude.[].ruby).
#### `matrix.exclude[].xcode_scheme`
**Expected format:** String.

#### `matrix.exclude[].xcode_sdk`
**Expected format:** String.

#### `matrix.fast_finish`
**Expected format:** Boolean value.

#### `matrix.include`
**Expected format:** List of key value mappings; or a single key value mapping.

#### `matrix.include[]`
**Expected format:** Key value mapping.

#### `matrix.include[].env`
**Expected format:** String or  encrypted string.

#### `matrix.include[].gemfile`
**Expected format:** String.

#### `matrix.include[].ghc`
**Expected format:** String.

#### `matrix.include[].go`
**Expected format:** String.

#### `matrix.include[].jdk`
**Expected format:** String.

#### `matrix.include[].lein`
**Expected format:** String.

#### `matrix.include[].node`
Alias for [`matrix.include.[].node_js`](#matrix.include.[].node_js).
#### `matrix.include[].node_js`
**Expected format:** String.

#### `matrix.include[].os`
Value has to be `linux` (default) or  `osx`; or one of the known aliases: `ubuntu` for `linux`, `mac` for `osx` or  `macos` for `osx`. Setting is not case sensitive.

**Expected format:** String.

#### `matrix.include[].otp`
Alias for [`matrix.include.[].otp_release`](#matrix.include.[].otp_release).
#### `matrix.include[].otp_release`
**Expected format:** String.

#### `matrix.include[].perl`
**Expected format:** String.

#### `matrix.include[].php`
**Expected format:** String.

#### `matrix.include[].python`
**Expected format:** String.

#### `matrix.include[].ruby`
**Expected format:** String.

#### `matrix.include[].rvm`
Alias for [`matrix.include.[].ruby`](#matrix.include.[].ruby).
#### `matrix.include[].xcode_scheme`
**Expected format:** String.

#### `matrix.include[].xcode_sdk`
**Expected format:** String.

#### `node`
Alias for [`node_js`](#node_js).
#### `node_js`
**Expected format:** List of strings; or a single string.

#### `notifications`
**Expected format:** Key value mapping.

#### `notifications.campfire`
**Expected format:** Key value mapping.

#### `notifications.campfire.disabled`
**Expected format:** Boolean value.

#### `notifications.campfire.enabled`
**Expected format:** Boolean value.

#### `notifications.campfire.on_failure`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.campfire.on_start`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.campfire.on_success`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.campfire.rooms`
**Expected format:** List of strings; or a single string.

#### `notifications.campfire.template`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.email`
**Expected format:** Key value mapping.

#### `notifications.email.disabled`
**Expected format:** Boolean value.

#### `notifications.email.enabled`
**Expected format:** Boolean value.

#### `notifications.email.on_failure`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.email.on_start`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.email.on_success`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.email.recipients`
**Expected format:** List of strings; or a single string.

#### `notifications.flowdoc`
**Expected format:** Key value mapping.

#### `notifications.flowdoc.api_token`
**Expected format:** String or  encrypted string.

#### `notifications.flowdoc.disabled`
**Expected format:** Boolean value.

#### `notifications.flowdoc.enabled`
**Expected format:** Boolean value.

#### `notifications.flowdoc.on_failure`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.flowdoc.on_start`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.flowdoc.on_success`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.hipchat`
**Expected format:** Key value mapping.

#### `notifications.hipchat.disabled`
**Expected format:** Boolean value.

#### `notifications.hipchat.enabled`
**Expected format:** Boolean value.

#### `notifications.hipchat.format`
Value has to be `html` or  `text`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.hipchat.on_failure`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.hipchat.on_start`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.hipchat.on_success`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.hipchat.rooms`
**Expected format:** List of strings; or a single string.

#### `notifications.hipchat.template`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.irc`
**Expected format:** Key value mapping.

#### `notifications.irc.channel_key`
**Expected format:** String or  encrypted string.

#### `notifications.irc.channels`
**Expected format:** List of strings; or a single string.

#### `notifications.irc.disabled`
**Expected format:** Boolean value.

#### `notifications.irc.enabled`
**Expected format:** Boolean value.

#### `notifications.irc.nick`
**Expected format:** String or  encrypted string.

#### `notifications.irc.nickserv_password`
**Expected format:** String or  encrypted string.

#### `notifications.irc.on_failure`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.irc.on_start`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.irc.on_success`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.irc.password`
**Expected format:** String or  encrypted string.

#### `notifications.irc.skip_join`
**Expected format:** Boolean value.

#### `notifications.irc.template`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.irc.use_notice`
**Expected format:** Boolean value.

#### `notifications.slack`
**Expected format:** Key value mapping.

#### `notifications.slack.disabled`
**Expected format:** Boolean value.

#### `notifications.slack.enabled`
**Expected format:** Boolean value.

#### `notifications.slack.on_failure`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.slack.on_start`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.slack.on_success`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.slack.rooms`
**Expected format:** List of strings; or a single string.

#### `notifications.slack.template`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.sqwiggle`
**Expected format:** Key value mapping.

#### `notifications.sqwiggle.disabled`
**Expected format:** Boolean value.

#### `notifications.sqwiggle.enabled`
**Expected format:** Boolean value.

#### `notifications.sqwiggle.on_failure`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.sqwiggle.on_start`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.sqwiggle.on_success`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.sqwiggle.rooms`
**Expected format:** List of strings; or a single string.

#### `notifications.sqwiggle.template`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.webhook`
**Expected format:** Key value mapping.

#### `notifications.webhook.disabled`
**Expected format:** Boolean value.

#### `notifications.webhook.enabled`
**Expected format:** Boolean value.

#### `notifications.webhook.on_failure`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.webhook.on_start`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.webhook.on_success`
Value has to be `always`, `never` or  `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.webhook.urls`
**Expected format:** List of strings; or a single string.

#### `os`
**Expected format:** List of strings; or a single string.

#### `osx_image`
**This setting is experimental and might be removed!**

**Expected format:** String.

#### `otp`
Alias for [`otp_release`](#otp_release).
#### `otp_release`
**Expected format:** List of strings; or a single string.

#### `perl`
**Expected format:** List of strings; or a single string.

#### `php`
**Expected format:** List of strings; or a single string.

#### `python`
**Expected format:** List of strings; or a single string.

#### `ruby`
**Expected format:** List of strings; or a single string.

#### `rvm`
Alias for [`ruby`](#ruby).
#### `script`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `services`
**Expected format:** List of strings; or a single string.

#### `virtual_env`
Alias for [`virtualenv`](#virtualenv).
#### `virtualenv`
**Expected format:** Key value mapping.

#### `virtualenv.system_site_packages`
**Expected format:** Boolean value.

#### `xcode_project`
**Expected format:** String.

#### `xcode_scheme`
**Expected format:** List of strings; or a single string.

#### `xcode_sdk`
**Expected format:** List of strings; or a single string.

#### `xcode_workspace`
**Expected format:** String.

#### `xctool_args`
**Expected format:** String.

## Generating the Specification

This file is generated. You currently update it by running `play/spec.rb`.
