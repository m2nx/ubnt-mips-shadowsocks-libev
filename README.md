# ubnt-mips-shadowsocks-libev
为基于 mipsel, mips64 的 Ubiquiti EdgeMax(ER-X, ER-4), UniFi Security Gateway(USG) 等交叉编译 shadowsocks-libev  

Cross complie shadowsocks for UBNT devices(ER-X ER-4 USG) based on mips or mips64  

Ci: [![Build Status](https://travis-ci.org/imMMX/ubnt-mips-shadowsocks-libev.svg?branch=master)](https://travis-ci.org/imMMX/ubnt-mips-shadowsocks-libev)  

## 下载  Download
编译好的二进制文件请前往 [release](https://github.com/imMMX/ubnt-mips-shadowsocks-libev/releases/tag/3.2.0) 下载  

You can download pre-complied file here

## 样例  Examples
* mips64  
![mips64](https://github.com/imMMX/ubnt-mips-shadowsocks-libev/blob/master/screenshot/mips64.jpeg)  
* mips  
![mips64](https://github.com/imMMX/ubnt-mips-shadowsocks-libev/blob/master/screenshot/mips.jpeg)

配合 dnsmasq 以及 iptables 实现内外分流科学上网。教程[SS脚本部署](https://github.com/imMMX/ubnt-router-shadowsocks) . 
How to set dnsmasq and iptables

## 使用方法  Installation

1. 安装 Docker  Install Docker  
  ```curl -sSL https://get.docker.com/ | sh ``` 
  
2. 克隆仓库   Clone the git repo  
  ```git clone https://github.com/imMMX/ubnt-mips-shadowsocks-libev.git```  
  
3. build 镜像   Build the docker image  
  ```docker build --tag ubnt-mips-shadowsocks-libev .```  
  
4. 启动容器  Start the container  
  ```docker run -idt --name ubnt-mips-shadowsocks-libev ubnt-mips-shadowsocks-libev```
  
5. 从容器中拷贝  Copy from docker container  
  ```docker cp ubnt-mips-shadowsocks-libev:/opt/ss-mips/ss-bin .```
  
## mips 与 mips64
由 ENV 参数 ARCHITECH 判断，默认生成 mips，需要 mips64 在第 4 步的时候替换成下面的命令  

Controlled by ENV ARCHITECH, default build mips, you can set ARCHITECH="mips64" to build mips64 file.

  ```docker run -idt --name ubnt-mips-shadowsocks-libev -e ARCHITECH="mips64" ubnt-mips-shadowsocks-libev```


