name 'redis'
description 'Redis server for apps'
run_list "role[base]", "recipe[redisio::default]", "recipe[redisio::enable]"
