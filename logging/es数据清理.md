#### ES旧数据清理方案

##### 使用 [Elasticsearch Curator](https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html) + crontab定时清理

``` shell
# 以下操作都在192.168.150.55这台机器上执行

# 查看索引数据命令
curator_cli --host 192.168.150.51 --port 9200 show_indices --verbose --header

# 手动执行操作命令
cd /root/elasticsearch
curator --config curator.yml actions.yml

# crontab定时命令(每天0时0分执行清理脚本)
0 0 * * * /root/elasticsearch/auto.sh
```

curator.yml(ES服务连接信息配置文件)
``` yaml
client:
  hosts:
    - 192.168.150.51
  port: 9200
  url_prefix:
  use_ssl: False
  certificate:
  client_cert:
  client_key:
  ssl_no_validate: False
  http_auth:
  timeout: 30
  master_only: False

logging:
  loglevel: INFO
  logfile:
  logformat: default
  blacklist: ['elasticsearch', 'urllib3']
```

actions.yml(执行的操作)
``` yaml
actions:
  1:
    action: delete_indices
    description: >-
      删除超过7天的索引（基于索引名称），用于logs*
    options:
      ignore_empty_list: True
      disable_action: False
    filters:
    - filtertype: pattern
      kind: prefix
      value: logs
    - filtertype: age
      source: name
      direction: older
      timestring: '%Y.%m.%d'
      unit: days
      unit_count: 7
```

auto.sh
``` shell
#!/bin/sh
/usr/bin/curator --config /root/elasticsearch/curator.yml /root/elasticsearch/actions.yml
echo "delete index success"
```

