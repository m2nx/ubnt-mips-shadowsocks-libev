# Shadowsocks-erx

Cross complie shadowsocks for erx based on mipsel

## 说明

由于 erx 存储空间不足，无法直接在机器上编译，但是可以运行基于 mipsel 已编译的程序，所以可以在其他机器上先交叉编译完成在上传到 erx 上执行。

## 使用方法

1. Docker  
使用 Dockerfile build 构建依赖环境镜像，在 docker run 的时候执行 shell 脚本执行编译。 docker 化的目的是只在容器中进行编译，不影响当前操作系统，编译完成后映射到主机文件夹，可以直接使用我构建好的上传到 dockerhub 上的镜像或者自己使用 Dockerfile build。
* 克隆仓库：
```
 git clone https://github.com/imMMX/shadowsocks-erx.git
```
* 进入文件夹
```
cd shadowsocks-erx
```

* 使用现有镜像：
```
docker run -it -v $(pwd):/usr/local/ss immmx/shadowsocks-erx
```
等待编译完成后会自动退出容器，在当前目录下生成名为 erx 的文件夹，其中 bin 文件夹中的就是所需要的二进制文件。

当然，你也可以自己使用 Dockerfile 直接 build 镜像
```
docker build --tag shadowsocks-erx .
docker run -it -v $(pwd):/usr/local/ss shadowsocks-erx
```


2. shell

如果不在意对当前系统的影响，可以直接执行脚本编译。脚本基于 ubuntu 16.04 测试，运行方法：

```
chmod +x build_ss.sh
sh build_ss.sh
```


