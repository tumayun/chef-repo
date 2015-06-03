name 'monit'
description 'Monit for apps'
run_list "role[base]", "recipe[monit::default]"
