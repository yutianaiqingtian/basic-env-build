本文档主要配置一些基于Docker的基础环境的搭建工作。

> 所有的操作请都在进入项目子目录下执行

## Dockerfiles

### sshd_ubuntu

```
├── Dockerfile
├── build.sh
└── run_in_host.sh
```

通过 `. ./build.sh` 可以构建支持SSH登录的Ubuntu镜像。 通过 `. ./run_in_host.sh` 可以启动一个 666 端口的sshd_ubuntu容器。

## Composes

### kafka

```
├── docker-compose.yml
└── pre_set_env.sh
```

- `docker-compose.yml` 中定义了最基础的Kafka环境，只启动了 zookeeper 和 kafka 所有的配置都按照默认来进行。（可用于Demo练习）启动之前，你需要先运行`. ./pre_set_env.sh` 脚本设置`DOCKER_HOST_IP`环境变量（Mac环境下）
