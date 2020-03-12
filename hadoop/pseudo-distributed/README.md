对于平时的hadoop练习使用，使用伪分布式是够用了的，基于[官网单节点集群搭建教程](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html)做了一个 Docker 镜像，供大家学习使用.

**1. 直接启动**：

```bash
docker run -it -p 8088:8088 -p 9870:9870 -p 8042:8042 5200710/hadoop:3.2.1-pseudo bash
```

**2. 利用Docker-compose来启动**

```yml
version: "3"
services:
  hadoop:
    image: 5200710/hadoop:3.2.1-pseudo
    ports:
      - 9870:9870
      - 8088:8088
      - 8042:8042
```

运行 `docker-compose up -d` 即可启动hadoop服务

进入刚启动的容器

```bash
docker exec -it `docker ps -l -q` su hadoop
```

容器内通过 `jps` 来查看Java进程运行状态。

```bash
root@530d73ef475f:/# jps
272 NameNode
1794 Jps
1282 NodeManager
409 DataNode
681 SecondaryNameNode
1131 ResourceManager
```

正常启动后，可以在宿主主机上访问如下界面：

1. 启动后的NameNode Web 界面 [http://localhost:8088](http://localhost:8088)
2. 启动后的ResourceManager Web 界面 [http://localhost:9870](http://localhost:9870)
3. Node Specific Info: [http://localhost:8042/](http://localhost:8042/)

如果想基于Docker启动一个完全分布式hadoop集群，有一个很好地 Repository，可以参考 [https://github.com/big-data-europe/docker-hadoop](https://github.com/big-data-europe/docker-hadoop)

