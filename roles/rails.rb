name 'rails'
description 'This role configures a Rails stack using Unicorn'
run_list(
  "role[base]",
  "recipe[bluepill]",
  "recipe[packages]",
  "recipe[rails]",
  "recipe[ruby_build]",
  "recipe[rbenv]",
  "recipe[git]",
  "recipe[postfix]"
)

default_attributes(
  "nginx" => { "server_tokens" => "off" },
  "rbenv" => {
    "group_users" => ['deploy']
  },
  "deploy_users" => [
        "deploy"
  ]
)
