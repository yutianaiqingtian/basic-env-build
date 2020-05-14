官网提供了 [aws_cli 2 版本的 Docker 镜像](https://hub.docker.com/r/amazon/aws-cli)，但是没有提供1的，本镜像就是提供了一个aws cli 1 版本的补充。

## Docker CLI usage

The AWS CLI can be executed from the Docker CLI with the `docker run` command:

```bash
$ docker run --rm -it 5200710/aws-cli:v1 aws --version
```

This command will print out the version of the AWS CLI being used in the container. 

For any AWS CLI command, you can run its `help` command to get help information about the command:

```bash
$ docker run --rm -it 5200710/aws-cli:v1 aws help
```

In order to run a command that makes an AWS API call, credentials and configuration may need to be shared from the host system to the container. Assuming credentials and configuration are being set in the `~/.aws/credentials` and `~/.aws/config` file on the host system, they can be shared by mounting the `~/.aws` directory to the `/root/.aws` directory of the container:

```bash
$ docker run --rm -it -v ~/.aws:/root/.aws 5200710/aws-cli:v1 aws s3 ls
```

For some AWS CLI v2 commands, you'll want to either read files from the host system in the container or write files from the container to the host system. This can be accomplished by mounting to the container's `/aws` directory:

```bash
$ docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws 5200710/aws-cli:v1 aws s3 cp s3://aws-cli-docker-demo/hello .
```

The `/aws` directory is the working directory for the image and is reserved for the user. See [notes on interfaces](https://hub.docker.com/r/amazon/aws-cli#notes-on-interfaces-and-backwards-compatibility-of-docker-image) for more information.

In order to shorten the length of `docker` commands, you can add the following alias:

```bash
$ alias aws='docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws 5200710/aws-cli:v1 aws'
```

This will allow you to run the AWS CLI v1 from within a Docker container as if it was installed on the host system:

```
$ aws --version
```

## General AWS CLI usage

For information on general usage of the AWS CLI, please refer to the:

- [AWS CLI user guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
- [AWS CLI reference guide](https://docs.aws.amazon.com/cli/latest/reference/)

## Source code

The source code for the AWS CLI v1 can be found at its [GitHub repository](https://github.com/yutianaiqingtian/basic-env-build/aws_cli). The Docker image is built using the [Docker pyehon alpine image](https://hub.docker.com/_/python?tab=tags&page=1&name=2.7) as base image.

## Feedback

To file any feature requests or report any issues related to this Docker image, please open an issue on the [GitHub repository](https://github.com/aws/aws-cli) for the AWS CLI.