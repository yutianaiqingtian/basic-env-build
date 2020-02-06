通过 sdkman 工具安装 spark，该工具非常强大，详见官网. [Available SDKs - SDKMAN! the Software Development Kit Manager](https://sdkman.io/sdks#spark)

spark 程序的在容器内的路径通过``ln`命令已经连接到了`/spark`目录下

```bash
ln -s /root/.sdkman/candidates/spark/current spark
```

镜像标签 `5200710/data:spark-sdk-standalone`

