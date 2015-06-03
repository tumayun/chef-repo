name 'fluentd'
description 'Fluentd server for collecting data'
run_list "role[base]", "recipe[td-agent::default]"
