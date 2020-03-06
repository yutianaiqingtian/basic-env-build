对于平时的练习使用，使用伪分布式是够用了的，做了一个 Docker 镜像，供大家学习使用.

![官网单节点集群搭建教程](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html)

```bash
docker run -it -p 8088:8088 -p 9870:9870  5200710/hadoop:3.2.1-preudo
```

1. 启动后的NameNode Web 界面 [http://localhost:8088](http://localhost:8088)
2. 启动后的ResourceManager Web 界面 [http://localhost:9870](http://localhost:9870)

对于完全分布式，有一个很好地 Repository，可以参考 [https://github.com/big-data-europe/docker-hadoop](https://github.com/big-data-europe/docker-hadoop)

