# Shadowsocks-erx

Cross complie shadowsocks for erx based on mipsel

## 说明

由于 erx 存储空间不足，无法直接在机器上编译，但是可以运行基于 mipsel 已编译的程序，所以可以在其他机器上先交叉编译完成在上传到 erx 上执行。

### Docker

dockerfile 以 ubuntu 16.04 为基础镜像，自动执行编译， docker 的目的是只在虚拟镜像中进行编译，不影响当前操作系统，编译完成后映射到主机文件夹，执行方法：

进入 dockerfile 所在文件夹

```
docker build --tag shadowsocks-erx .
docker run -v .:/usr/local/ss/shadowsocks-libev
```


### shell

如果不在意对当前系统的影响，可以直接执行脚本内的文件，同样基于 ubuntu 16.04 测试，运行方法：

```
chmod +x build_ss.sh
sh build_ss.sh
```
