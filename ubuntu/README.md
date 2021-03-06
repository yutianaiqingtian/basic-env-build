该 `Ubuntu` 下存在很多的基于Ubuntu系统的一些工具的安装打包而成的Docker

### repo.dockerfile

主要是创建国内软件源的Ubuntu镜像容器，加速安装包的安装。默认的软件源地址为 <http://archive.ubuntu.com/ubuntu/>

> 如果不想采用更改软件源加速，Docker hub 官网提供了一个教育资源。可以每次免费使用4小时，快速构建容器。[Play with Docker](https://labs.play-with-docker.com/)

不同的Tag后缀表示采用不同的软件源

#### 5200710/ubuntu:18.04-163 

163的软件源前缀： <http://mirrors.163.com/ubuntu/>

#### 5200710/ubuntu:18.04-aliyun 

阿里的软件源前缀： <http://mirrors.aliyun.com/ubuntu/>

#### 5200710/ubuntu:18.04-ustc 

中科大的软件源前缀： <http://mirrors.aliyun.com/ubuntu/>

#### 5200710/ubuntu:18.04-tuna 

清华的软件源前缀： <https://mirrors.tuna.tsinghua.edu.cn/ubuntu/>

### ssh.dockerfile

该镜像下面包含了常见的ssh客户端和服务端

### sdk.dockerfile

该镜像下安装了 sdkman工具。该工具可以非常方便的安装和管理 Gradle、Maven、Java、Scala、Spark、SpringBoot等版本。简直不能太好用~，工具的完整SDK详见[Available SDKs - SDKMAN! the Software Development Kit Manager](https://sdkman.io/sdks)。