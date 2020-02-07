Spark部署模式主要有四种：Local模式（单机模式）、Standalone模式（使用Spark自带的简单集群管理器）、YARN模式（使用YARN作为集群管理器）和Mesos模式（使用Mesos作为集群管理器）

通过 sdkman 工具安装 spark 可以减少一些环境部署问题，sdkman 工具非常强大，详见官网. [Available SDKs - SDKMAN! the Software Development Kit Manager](https://sdkman.io/sdks#spark)

## Local 模式

spark 程序的在容器内的路径通过``ln`命令已经连接到了`/spark`目录下

```bash
ln -s /root/.sdkman/candidates/spark/current spark
```

镜像标签 `5200710/data:spark-2.4.4-local`

