# Puppet ZSH Environment Module

```ruby
mod "puppetlabs/stdlib", "4.5.1"
mod "maestrodev/wget", "1.5.7"

# dep: puppetlabs/stdlib
# dep: maestrodev/wget
mod "zanloy/ohmyzsh", "1.0.1"

mod "weyforth/mac",
	:git => "https://github.com/weyforth/puppet-mac.git",
	:ref => "master"

mod "weyforth/ubuntu",
	:git => "https://github.com/weyforth/puppet-ubuntu.git",
	:ref => "master"

# dep (optional): weyforth/mac
# dep (optional): weyforth/ubuntu
# dep: zanloy/ohmyzsh
mod "weyforth/zsh_env",
	:git => "https://github.com/weyforth/puppet-zsh_env.git",
	:ref => "master"
```
