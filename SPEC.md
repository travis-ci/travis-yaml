## The `.travis.yml` Format
Here is a list of all the options understood by travis-yaml.

Note that stricitly speaking Travis CI might not have the same understanding of these as travis-yaml has at the moment, since travis-yaml is not yet being used.

### Available Options
#### `addons`
**Expected format:** Key value mapping.

#### `addons.code_climate`
**Expected format:** Key value mapping.

#### `addons.code_climate.repo_token`
**Expected format:** String or encrypted string.

#### `addons.coverty_scan`
**Expected format:** Key value mapping.

#### `addons.coverty_scan.branch_pattern`
**Expected format:** String or encrypted string.

#### `addons.coverty_scan.build_command`
**Expected format:** String or encrypted string.

#### `addons.coverty_scan.build_command_prepend`
**Expected format:** String or encrypted string.

#### `addons.coverty_scan.build_script_url`
**Expected format:** String or encrypted string.

#### `addons.coverty_scan.notification_email`
**Expected format:** String or encrypted string.

#### `addons.coverty_scan.project`
**Expected format:** Key value mapping.

#### `addons.coverty_scan.project.name`
**This setting is required!**

**Expected format:** String or encrypted string.

#### `addons.firefox`
`firefox` version to use.

**Expected format:** String.

#### `addons.hosts`
**Expected format:** List of strings; or a single string.

#### `addons.postgresql`
`postgresql` version to use.

**Expected format:** String.

#### `addons.sauce_connect`
**Expected format:** Key value mapping.

#### `addons.sauce_connect.access_key`
**Expected format:** String or encrypted string.

#### `addons.sauce_connect.username`
**Expected format:** String or encrypted string.

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

#### `branches`
**Expected format:** Key value mapping, or list of strings or regular expressions.

#### `branches.except`
**Expected format:** List of strings or regular expressions; or a single string or regular expression.

#### `branches.only`
**Expected format:** List of strings or regular expressions; or a single string or regular expression.

#### `bundler_args`
**This setting is only relevant if [`language`](#language) is set to `ruby` (default).**

**Expected format:** String.

#### `cache`
**Expected format:** Key value mapping.

#### `cache.apt`
**Expected format:** Boolean value.

#### `cache.bundler`
**Expected format:** Boolean value.

#### `cache.directories`
**Expected format:** List of strings; or a single string.

#### `cache.edge`
**This setting is experimental and might be removed!**

**Expected format:** Boolean value.

#### `compiler`
**This setting is only relevant if [`language`](#language) is set to `c` or `cpp`.**

**Expected format:** List of strings; or a single string.

#### `compiler[]`
Value has to be `gcc` (default) or `clang`; or one of the known aliases: `g++` for `gcc` or `clang++` for `clang`. Setting is not case sensitive.

**Expected format:** String.

#### `composer_args`
**This setting is only relevant if [`language`](#language) is set to `php`.**

**Expected format:** String.

#### `deploy`
**Expected format:** List of key value mappings, or strings; or a single key value mapping, or string.

#### `deploy[]`
**Expected format:** Key value mapping, or string.

#### `deploy[].*`
**Expected format:** Key value mapping, or string or encrypted string.

#### `deploy[].*.*`
**Expected format:** String or encrypted string.

#### `deploy[].edge`
**This setting is experimental and might be removed!**

**Expected format:** Boolean value.

#### `deploy[].on`
**Expected format:** Key value mapping, or string.

#### `deploy[].on.all_branches`
**Expected format:** Boolean value.

#### `deploy[].on.branch`
**Expected format:** String.

#### `deploy[].on.condition`
**Expected format:** String.

#### `deploy[].on.jdk`
**This setting is only relevant if [`language`](#language) is set to `clojure`, `groovy`, `java`, `ruby` (default), `scala` or `android`.**

`jdk` version to use.

**Expected format:** String.

#### `deploy[].on.node`
`node` version to use.

**Expected format:** String.

#### `deploy[].on.perl`
**This setting is only relevant if [`language`](#language) is set to `perl`.**

`perl` version to use.

**Expected format:** String.

#### `deploy[].on.php`
**This setting is only relevant if [`language`](#language) is set to `php`.**

`php` version to use.

**Expected format:** String.

#### `deploy[].on.python`
**This setting is only relevant if [`language`](#language) is set to `python`.**

`python` version to use.

**Expected format:** String.

#### `deploy[].on.repo`
**Expected format:** String.

#### `deploy[].on.ruby`
**This setting is only relevant if [`language`](#language) is set to `ruby` (default) or `objective-c`.**

`ruby` version to use.

**Expected format:** String.

#### `deploy[].on.rvm`
Alias for [`deploy[].on.ruby`](#deployonruby).

#### `deploy[].on.scala`
`scala` version to use.

**Expected format:** String.

#### `deploy[].on.tags`
**Expected format:** Boolean value.

#### `deploy[].provider`
**This setting is required!**

**Expected format:** String.

#### `env`
**Expected format:** Key value mapping, or list of strings or encrypted strings.

#### `env.global`
**Expected format:** List of strings or encrypted strings; or a single string or encrypted string.

#### `env.matrix`
**Expected format:** List of strings or encrypted strings; or a single string or encrypted string.

#### `gemfile`
**This setting is only relevant if [`language`](#language) is set to `ruby` (default) or `objective-c`.**

Gemfile(s) to use.

**Expected format:** List of strings; or a single string.

#### `ghc`
**This setting is only relevant if [`language`](#language) is set to `haskell`.**

List of `ghc` versions to use.

**Expected format:** List of strings; or a single string.

#### `git`
**Expected format:** Key value mapping.

#### `git.depth`
**Expected format:** Integer value.

#### `git.strategy`
Value has to be `clone` or `tarball`. Setting is case sensitive.

**Expected format:** String.

#### `git.submodules`
**Expected format:** Boolean value.

#### `go`
**This setting is only relevant if [`language`](#language) is set to `go`.**

List of `go` versions to use.

**Expected format:** List of strings; or a single string.

#### `gobuild_args`
**This setting is only relevant if [`language`](#language) is set to `go`.**

**Expected format:** String.

#### `install`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `jdk`
**This setting is only relevant if [`language`](#language) is set to `clojure`, `groovy`, `java`, `ruby` (default), `scala` or `android`.**

List of `jdk` versions to use.

**Expected format:** List of strings; or a single string.

#### `language`
**This setting is required!**

Value has to be `c`, `cpp`, `clojure`, `erlang`, `go`, `groovy`, `haskell`, `java`, `node_js`, `objective-c`, `ruby` (default), `python`, `perl`, `php`, `scala` or `android`; or one of the known aliases: `jvm` for `java`, `javascript` for `node_js`, `node` for `node_js`, `nodejs` for `node_js`, `golang` for `go`, `objective_c` for `objective-c`, `obj_c` for `objective-c`, `objc` for `objective-c`, `c++` for `cpp`, `node.js` for `node_js` or `obj-c` for `objective-c`. Setting is not case sensitive.

**Expected format:** String.

#### `lein`
**This setting is only relevant if [`language`](#language) is set to `clojure`.**

List of `lein` versions to use.

**Expected format:** List of strings; or a single string.

#### `matrix`
**Expected format:** Key value mapping.

#### `matrix.allow_failures`
**Expected format:** List of key value mappings; or a single key value mapping.

#### `matrix.allow_failures[]`
**Expected format:** Key value mapping.

#### `matrix.allow_failures[].compiler`
**This setting is only relevant if [`language`](#language) is set to `c` or `cpp`.**

Value has to be `gcc` (default) or `clang`; or one of the known aliases: `g++` for `gcc` or `clang++` for `clang`. Setting is not case sensitive.

**Expected format:** String.

#### `matrix.allow_failures[].env`
**Expected format:** String or encrypted string.

#### `matrix.allow_failures[].gemfile`
**This setting is only relevant if [`language`](#language) is set to `ruby` (default) or `objective-c`.**

Gemfile to use.

**Expected format:** String.

#### `matrix.allow_failures[].ghc`
**This setting is only relevant if [`language`](#language) is set to `haskell`.**

`ghc` version to use.

**Expected format:** String.

#### `matrix.allow_failures[].go`
**This setting is only relevant if [`language`](#language) is set to `go`.**

`go` version to use.

**Expected format:** String.

#### `matrix.allow_failures[].jdk`
**This setting is only relevant if [`language`](#language) is set to `clojure`, `groovy`, `java`, `ruby` (default), `scala` or `android`.**

`jdk` version to use.

**Expected format:** String.

#### `matrix.allow_failures[].lein`
**This setting is only relevant if [`language`](#language) is set to `clojure`.**

`lein` version to use.

**Expected format:** String.

#### `matrix.allow_failures[].node`
Alias for [`matrix.allow_failures[].node_js`](#matrixallow_failuresnode_js).

#### `matrix.allow_failures[].node_js`
**This setting is only relevant if [`language`](#language) is set to `node_js`.**

`node_js` version to use.

**Expected format:** String.

#### `matrix.allow_failures[].os`
Value has to be `linux` (default) or `osx`; or one of the known aliases: `ubuntu` for `linux`, `mac` for `osx` or `macos` for `osx`. Setting is not case sensitive.

**Expected format:** String.

#### `matrix.allow_failures[].otp`
Alias for [`matrix.allow_failures[].otp_release`](#matrixallow_failuresotp_release).

#### `matrix.allow_failures[].otp_release`
**This setting is only relevant if [`language`](#language) is set to `erlang`.**

`otp_release` version to use.

**Expected format:** String.

#### `matrix.allow_failures[].perl`
**This setting is only relevant if [`language`](#language) is set to `perl`.**

`perl` version to use.

**Expected format:** String.

#### `matrix.allow_failures[].php`
**This setting is only relevant if [`language`](#language) is set to `php`.**

`php` version to use.

**Expected format:** String.

#### `matrix.allow_failures[].python`
**This setting is only relevant if [`language`](#language) is set to `python`.**

`python` version to use.

**Expected format:** String.

#### `matrix.allow_failures[].ruby`
**This setting is only relevant if [`language`](#language) is set to `ruby` (default) or `objective-c`.**

`ruby` version to use.

**Expected format:** String.

#### `matrix.allow_failures[].rvm`
Alias for [`matrix.allow_failures[].ruby`](#matrixallow_failuresruby).

#### `matrix.allow_failures[].xcode_scheme`
**This setting is only relevant if [`language`](#language) is set to `objective-c`.**

`xcode_scheme` version to use.

**Expected format:** String.

#### `matrix.allow_failures[].xcode_sdk`
**This setting is only relevant if [`language`](#language) is set to `objective-c`.**

`xcode_sdk` version to use.

**Expected format:** String.

#### `matrix.exclude`
**Expected format:** List of key value mappings; or a single key value mapping.

#### `matrix.exclude[]`
**Expected format:** Key value mapping.

#### `matrix.exclude[].compiler`
**This setting is only relevant if [`language`](#language) is set to `c` or `cpp`.**

Value has to be `gcc` (default) or `clang`; or one of the known aliases: `g++` for `gcc` or `clang++` for `clang`. Setting is not case sensitive.

**Expected format:** String.

#### `matrix.exclude[].env`
**Expected format:** String or encrypted string.

#### `matrix.exclude[].gemfile`
**This setting is only relevant if [`language`](#language) is set to `ruby` (default) or `objective-c`.**

Gemfile to use.

**Expected format:** String.

#### `matrix.exclude[].ghc`
**This setting is only relevant if [`language`](#language) is set to `haskell`.**

`ghc` version to use.

**Expected format:** String.

#### `matrix.exclude[].go`
**This setting is only relevant if [`language`](#language) is set to `go`.**

`go` version to use.

**Expected format:** String.

#### `matrix.exclude[].jdk`
**This setting is only relevant if [`language`](#language) is set to `clojure`, `groovy`, `java`, `ruby` (default), `scala` or `android`.**

`jdk` version to use.

**Expected format:** String.

#### `matrix.exclude[].lein`
**This setting is only relevant if [`language`](#language) is set to `clojure`.**

`lein` version to use.

**Expected format:** String.

#### `matrix.exclude[].node`
Alias for [`matrix.exclude[].node_js`](#matrixexcludenode_js).

#### `matrix.exclude[].node_js`
**This setting is only relevant if [`language`](#language) is set to `node_js`.**

`node_js` version to use.

**Expected format:** String.

#### `matrix.exclude[].os`
Value has to be `linux` (default) or `osx`; or one of the known aliases: `ubuntu` for `linux`, `mac` for `osx` or `macos` for `osx`. Setting is not case sensitive.

**Expected format:** String.

#### `matrix.exclude[].otp`
Alias for [`matrix.exclude[].otp_release`](#matrixexcludeotp_release).

#### `matrix.exclude[].otp_release`
**This setting is only relevant if [`language`](#language) is set to `erlang`.**

`otp_release` version to use.

**Expected format:** String.

#### `matrix.exclude[].perl`
**This setting is only relevant if [`language`](#language) is set to `perl`.**

`perl` version to use.

**Expected format:** String.

#### `matrix.exclude[].php`
**This setting is only relevant if [`language`](#language) is set to `php`.**

`php` version to use.

**Expected format:** String.

#### `matrix.exclude[].python`
**This setting is only relevant if [`language`](#language) is set to `python`.**

`python` version to use.

**Expected format:** String.

#### `matrix.exclude[].ruby`
**This setting is only relevant if [`language`](#language) is set to `ruby` (default) or `objective-c`.**

`ruby` version to use.

**Expected format:** String.

#### `matrix.exclude[].rvm`
Alias for [`matrix.exclude[].ruby`](#matrixexcluderuby).

#### `matrix.exclude[].xcode_scheme`
**This setting is only relevant if [`language`](#language) is set to `objective-c`.**

`xcode_scheme` version to use.

**Expected format:** String.

#### `matrix.exclude[].xcode_sdk`
**This setting is only relevant if [`language`](#language) is set to `objective-c`.**

`xcode_sdk` version to use.

**Expected format:** String.

#### `matrix.fast_finish`
**Expected format:** Boolean value.

#### `matrix.include`
**Expected format:** List of key value mappings; or a single key value mapping.

#### `matrix.include[]`
**Expected format:** Key value mapping.

#### `matrix.include[].compiler`
**This setting is only relevant if [`language`](#language) is set to `c` or `cpp`.**

Value has to be `gcc` (default) or `clang`; or one of the known aliases: `g++` for `gcc` or `clang++` for `clang`. Setting is not case sensitive.

**Expected format:** String.

#### `matrix.include[].env`
**Expected format:** String or encrypted string.

#### `matrix.include[].gemfile`
**This setting is only relevant if [`language`](#language) is set to `ruby` (default) or `objective-c`.**

Gemfile to use.

**Expected format:** String.

#### `matrix.include[].ghc`
**This setting is only relevant if [`language`](#language) is set to `haskell`.**

`ghc` version to use.

**Expected format:** String.

#### `matrix.include[].go`
**This setting is only relevant if [`language`](#language) is set to `go`.**

`go` version to use.

**Expected format:** String.

#### `matrix.include[].jdk`
**This setting is only relevant if [`language`](#language) is set to `clojure`, `groovy`, `java`, `ruby` (default), `scala` or `android`.**

`jdk` version to use.

**Expected format:** String.

#### `matrix.include[].lein`
**This setting is only relevant if [`language`](#language) is set to `clojure`.**

`lein` version to use.

**Expected format:** String.

#### `matrix.include[].node`
Alias for [`matrix.include[].node_js`](#matrixincludenode_js).

#### `matrix.include[].node_js`
**This setting is only relevant if [`language`](#language) is set to `node_js`.**

`node_js` version to use.

**Expected format:** String.

#### `matrix.include[].os`
Value has to be `linux` (default) or `osx`; or one of the known aliases: `ubuntu` for `linux`, `mac` for `osx` or `macos` for `osx`. Setting is not case sensitive.

**Expected format:** String.

#### `matrix.include[].otp`
Alias for [`matrix.include[].otp_release`](#matrixincludeotp_release).

#### `matrix.include[].otp_release`
**This setting is only relevant if [`language`](#language) is set to `erlang`.**

`otp_release` version to use.

**Expected format:** String.

#### `matrix.include[].perl`
**This setting is only relevant if [`language`](#language) is set to `perl`.**

`perl` version to use.

**Expected format:** String.

#### `matrix.include[].php`
**This setting is only relevant if [`language`](#language) is set to `php`.**

`php` version to use.

**Expected format:** String.

#### `matrix.include[].python`
**This setting is only relevant if [`language`](#language) is set to `python`.**

`python` version to use.

**Expected format:** String.

#### `matrix.include[].ruby`
**This setting is only relevant if [`language`](#language) is set to `ruby` (default) or `objective-c`.**

`ruby` version to use.

**Expected format:** String.

#### `matrix.include[].rvm`
Alias for [`matrix.include[].ruby`](#matrixincluderuby).

#### `matrix.include[].xcode_scheme`
**This setting is only relevant if [`language`](#language) is set to `objective-c`.**

`xcode_scheme` version to use.

**Expected format:** String.

#### `matrix.include[].xcode_sdk`
**This setting is only relevant if [`language`](#language) is set to `objective-c`.**

`xcode_sdk` version to use.

**Expected format:** String.

#### `node`
Alias for [`node_js`](#node_js).

#### `node_js`
**This setting is only relevant if [`language`](#language) is set to `node_js`.**

List of `node_js` versions to use.

**Expected format:** List of strings; or a single string.

#### `notifications`
**Expected format:** Key value mapping.

#### `notifications.campfire`
**Expected format:** Key value mapping, or list of strings or encrypted strings, or boolean value.

#### `notifications.campfire.disabled`
**Expected format:** Boolean value.

#### `notifications.campfire.enabled`
**Expected format:** Boolean value.

#### `notifications.campfire.on_failure`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.campfire.on_start`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.campfire.on_success`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.campfire.rooms`
**Expected format:** List of strings or encrypted strings; or a single string or encrypted string.

#### `notifications.campfire.template`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.campfire.template_error`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.campfire.template_failure`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.campfire.template_success`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.email`
**Expected format:** Key value mapping, or list of strings or encrypted strings, or boolean value.

#### `notifications.email.disabled`
**Expected format:** Boolean value.

#### `notifications.email.enabled`
**Expected format:** Boolean value.

#### `notifications.email.on_failure`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.email.on_start`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.email.on_success`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.email.recipients`
**Expected format:** List of strings or encrypted strings; or a single string or encrypted string.

#### `notifications.flowdoc`
**Expected format:** Key value mapping, or string, encrypted string, or boolean value.

#### `notifications.flowdoc.api_token`
**Expected format:** String or encrypted string.

#### `notifications.flowdoc.disabled`
**Expected format:** Boolean value.

#### `notifications.flowdoc.enabled`
**Expected format:** Boolean value.

#### `notifications.flowdoc.on_failure`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.flowdoc.on_start`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.flowdoc.on_success`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.hipchat`
**Expected format:** Key value mapping, or list of strings or encrypted strings, or boolean value.

#### `notifications.hipchat.disabled`
**Expected format:** Boolean value.

#### `notifications.hipchat.enabled`
**Expected format:** Boolean value.

#### `notifications.hipchat.format`
Value has to be `html` or `text`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.hipchat.on_failure`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.hipchat.on_start`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.hipchat.on_success`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.hipchat.rooms`
**Expected format:** List of strings or encrypted strings; or a single string or encrypted string.

#### `notifications.hipchat.template`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.hipchat.template_error`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.hipchat.template_failure`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.hipchat.template_success`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.irc`
**Expected format:** Key value mapping, or list of strings or encrypted strings, or boolean value.

#### `notifications.irc.channel_key`
**Expected format:** String or encrypted string.

#### `notifications.irc.channels`
**Expected format:** List of strings or encrypted strings; or a single string or encrypted string.

#### `notifications.irc.disabled`
**Expected format:** Boolean value.

#### `notifications.irc.enabled`
**Expected format:** Boolean value.

#### `notifications.irc.nick`
**Expected format:** String or encrypted string.

#### `notifications.irc.nickserv_password`
**Expected format:** String or encrypted string.

#### `notifications.irc.on_failure`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.irc.on_start`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.irc.on_success`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.irc.password`
**Expected format:** String or encrypted string.

#### `notifications.irc.skip_join`
**Expected format:** Boolean value.

#### `notifications.irc.template`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.irc.template_error`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.irc.template_failure`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.irc.template_success`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.irc.use_notice`
**Expected format:** Boolean value.

#### `notifications.slack`
**Expected format:** Key value mapping, or list of strings or encrypted strings, or boolean value.

#### `notifications.slack.disabled`
**Expected format:** Boolean value.

#### `notifications.slack.enabled`
**Expected format:** Boolean value.

#### `notifications.slack.on_failure`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.slack.on_start`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.slack.on_success`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.slack.rooms`
**Expected format:** List of strings or encrypted strings; or a single string or encrypted string.

#### `notifications.slack.template`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.slack.template_error`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.slack.template_failure`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.slack.template_success`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.sqwiggle`
**Expected format:** Key value mapping, or list of strings or encrypted strings, or boolean value.

#### `notifications.sqwiggle.disabled`
**Expected format:** Boolean value.

#### `notifications.sqwiggle.enabled`
**Expected format:** Boolean value.

#### `notifications.sqwiggle.on_failure`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.sqwiggle.on_start`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.sqwiggle.on_success`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.sqwiggle.rooms`
**Expected format:** List of strings or encrypted strings; or a single string or encrypted string.

#### `notifications.sqwiggle.template`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.sqwiggle.template_error`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.sqwiggle.template_failure`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.sqwiggle.template_success`
Strings will be interpolated. Available variables: `%{repository_slug}`, `%{repository_name}`, `%{repository}`, `%{build_number}`, `%{branch}`, `%{commit}`, `%{author}`, `%{message}`, `%{duration}`, `%{compare_url}`, `%{build_url}`.

**Expected format:** List of strings; or a single string.

#### `notifications.webhook`
Alias for [`notifications.webhooks`](#notificationswebhooks).

#### `notifications.webhooks`
**Expected format:** Key value mapping, or list of strings or encrypted strings, or boolean value.

#### `notifications.webhooks.disabled`
**Expected format:** Boolean value.

#### `notifications.webhooks.enabled`
**Expected format:** Boolean value.

#### `notifications.webhooks.on_failure`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.webhooks.on_start`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.webhooks.on_success`
Value has to be `always`, `never` or `change`. Setting is case sensitive.

**Expected format:** String.

#### `notifications.webhooks.urls`
**Expected format:** List of strings or encrypted strings; or a single string or encrypted string.

#### `npm_args`
**This setting is only relevant if [`language`](#language) is set to `node_js`.**

**Expected format:** String.

#### `os`
**Expected format:** List of strings; or a single string.

#### `os[]`
Value has to be `linux` (default) or `osx`; or one of the known aliases: `ubuntu` for `linux`, `mac` for `osx` or `macos` for `osx`. Setting is not case sensitive.

**Expected format:** String.

#### `osx_image`
**This setting is experimental and might be removed!**

`osx_image` version to use.

**Expected format:** String.

#### `otp`
Alias for [`otp_release`](#otp_release).

#### `otp_release`
**This setting is only relevant if [`language`](#language) is set to `erlang`.**

List of `otp_release` versions to use.

**Expected format:** List of strings; or a single string.

#### `perl`
**This setting is only relevant if [`language`](#language) is set to `perl`.**

List of `perl` versions to use.

**Expected format:** List of strings; or a single string.

#### `php`
**This setting is only relevant if [`language`](#language) is set to `php`.**

List of `php` versions to use.

**Expected format:** List of strings; or a single string.

#### `python`
**This setting is only relevant if [`language`](#language) is set to `python`.**

List of `python` versions to use.

**Expected format:** List of strings; or a single string.

#### `ruby`
**This setting is only relevant if [`language`](#language) is set to `ruby` (default) or `objective-c`.**

List of `ruby` versions to use.

**Expected format:** List of strings; or a single string.

#### `rvm`
Alias for [`ruby`](#ruby).

#### `script`
Commands that will be run on the VM.

**Expected format:** List of strings; or a single string.

#### `sdk_components`
**This setting is only relevant if [`language`](#language) is set to `android`.**

**Expected format:** List of strings; or a single string.

#### `services`
List of `services` versions to use.

**Expected format:** List of strings; or a single string.

#### `source_key`
**Expected format:** String or encrypted string.

#### `virtual_env`
Alias for [`virtualenv`](#virtualenv).

#### `virtualenv`
**This setting is only relevant if [`language`](#language) is set to `python`.**

**Expected format:** Key value mapping.

#### `virtualenv.system_site_packages`
**Expected format:** Boolean value.

#### `xcode_project`
**This setting is only relevant if [`language`](#language) is set to `objective-c`.**

**Expected format:** String.

#### `xcode_scheme`
**This setting is only relevant if [`language`](#language) is set to `objective-c`.**

List of `xcode_scheme` versions to use.

**Expected format:** List of strings; or a single string.

#### `xcode_sdk`
**This setting is only relevant if [`language`](#language) is set to `objective-c`.**

List of `xcode_sdk` versions to use.

**Expected format:** List of strings; or a single string.

#### `xcode_workspace`
**This setting is only relevant if [`language`](#language) is set to `objective-c`.**

**Expected format:** String.

#### `xctool_args`
**This setting is only relevant if [`language`](#language) is set to `objective-c`.**

**Expected format:** String.

## Generating the Specification

This file is generated. You currently update it by running `play/spec.rb`.
