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

