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
- Master通信节点默认的端口为 7077
- Slave节点的默认Web Ui 端口为 8081

容器启动命令如下:

```
docker run --rm -it -e ROOT_PASSWORD='admin' 5200710/spark:spark-standalone-2.4.5 bash
```

说明：

1. 'ROOT_PASSWORD=admin' 表明是否启用root账户的ssh密码登录方式（默认是支持publishkey的连接）
2. 可以通过挂载 '/root/.ssh/id_rsa' 和 '/root/.ssh/id_rsa.pub'的方式，使容器使用自己提供的PublishKey和PrivateKey

## 集群模式

下载 Cluster目录下docker-compose.yml 文件，根据需求扩展spark-worker节点

```bash
docker-compose up --scale spark-worker=3
```

其中 spark-master 节点支持启动ssh服务，通过自定义生成密钥对可以实现无密码远程访问spark-master节点。

```
/etc/ssh/ssh_host_rsa_key
/etc/ssh/ssh_host_rsa_key.pub
```

在Github 也找到一个很好地非常好的 Docker 镜像。感兴趣的点击链接获取更多详细信息[docker-spark-cluster/Dockerfile](https://github.com/mvillarrealb/docker-spark-cluster/blob/master/README.md)。

## Reference

1. [big-data-europe/docker-spark: Apache Spark docker image](https://github.com/big-data-europe/docker-spark)
2. [Creating a Spark Standalone Cluster with Docker and docker-compose](https://medium.com/@marcovillarreal_40011/creating-a-spark-standalone-cluster-with-docker-and-docker-compose-ba9d743a157f)
3. [mvillarrealb/docker-spark-cluster: A simple spark standalone cluster for your testing environment purposses](https://github.com/mvillarrealb/docker-spark-cluster)