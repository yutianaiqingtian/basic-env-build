本仓库镜像基于 Hadoop 3.2.1 版本构建而来

基础镜像 5200710/ubuntu:18.04-163,(基于163的国内软件源加速，也可以使用官网正版提供的)

参考的安装步骤：[installing-hadoop-on-mac](https://medium.com/beeranddiapers/installing-hadoop-on-mac-a9a3649dbc4d)

对外提供的Web访问接口有:

1. Resource Manager: http://localhost:9870
2. JobTracker: http://localhost:8088/
3. Node Specific Info: http://localhost:8042/

镜像启动命令如下：

```bash
➜  ~ docker run -d -p 9870:9870 -p 8088:8088 -p 8042:8042 5200710/hadoop:3.2.1
```

启动之后稍等一会（单机集群启动需要一段时间），可通过 `docker logs` 命令来查看日志信息。

```bash
 ~ docker ps
CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS              PORTS                                                                    NAMES
8acc07a1e5da        5200710/hadoop:3.2.1   "/bin/sh -c 'service…"   2 minutes ago       Up 2 minutes        0.0.0.0:8042->8042/tcp, 0.0.0.0:8088->8088/tcp, 0.0.0.0:9870->9870/tcp   hungry_yonath

~ docker logs -f 8acc07a1e5da
```

### Hadoop 完全分布式安装与部署

Hadoop 的安装版本为 2.7.7。静态IP分配策略如下表

| 主机名   | IP           | 预备分配服务                                 |
| -------- | ------------ | -------------------------------------------- |
| Master   | 172.17.0.100 | `DataNode` `NodeManager` `NameNode`          |
| worker-1 | 172.17.0.101 | `DataNode` `NodeManager` `SecondaryNameNode` |
| worker-2 | 172.17.0.102 | `DataNode` `NodeManager` `ResourceManager`   |
| worker-3 | 172.17.0.103 | `DataNode` `NodeManager` `HistoryServer`     |

