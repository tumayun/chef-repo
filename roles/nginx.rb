name 'nginx'
description 'This role configures a nginx'
run_list(
  "recipe[rails::app_nginx]"
)

default_attributes(
  "nginx" => { "server_tokens" => "off" }
)
