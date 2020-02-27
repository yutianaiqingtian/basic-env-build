Spark部署模式主要有四种：Local模式（单机模式）、Standalone模式（使用Spark自带的简单集群管理器）、YARN模式（使用YARN作为集群管理器）和Mesos模式（使用Mesos作为集群管理器）

通过 sdkman 工具安装 spark 可以减少一些环境部署问题，sdkman 工具非常强大，详见官网. [Available SDKs - SDKMAN! the Software Development Kit Manager](https://sdkman.io/sdks#spark)

## Local 模式

spark 程序的在容器内的路径通过``ln`命令已经连接到了`/spark`目录下

```bash
ln -s /root/.sdkman/candidates/spark/current spark
```

镜像标签 `5200710/data:spark-2.4.4-local`

## standalone 模式

不想过度复杂部署，在spark 的 Local 镜像上，在一个docker容器内，部署了一个Master节点和一个Slave节点。

- Master节点的默认Web UI 端口为 8080
- Slave节点的默认Web Ui 端口为 8081

容器启动命令如下:

```
docker run -it  --rm -p 8080:8080 -p 8081:8081 5200710/spark:2.4.4-standalone
```

在Github 也找到一个很好地非常好的 Docker 镜像。感兴趣的点击链接获取更多详细信息[docker-spark-cluster/Dockerfile](https://github.com/mvillarrealb/docker-spark-cluster/blob/master/README.md)。