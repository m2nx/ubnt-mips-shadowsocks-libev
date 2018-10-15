# ubnt-mips-shadowsocks-libev
为基于 mipsel, mips64 的 Ubiquiti EdgeMax(ER-X, ER-4), UniFi Security Gateway(USG) 等交叉编译 shadowsocks-libev 

Cross complie shadowsocks for UBNT devices based on mipsel or mips64  

Ci: [![Build Status](https://travis-ci.org/imMMX/ubnt-mips-shadowsocks-libev.svg?branch=master)](https://travis-ci.org/imMMX/ubnt-mips-shadowsocks-libev)  
## 说明

为 mips 设备交叉编译  
mips  `mipsel-linux-gnu`   
mips64  `mips64-linux-gnuabi64`

## 使用方法  
1. 安装 Docker  
  ```curl -sSL https://get.docker.com/ | sh ```
2. 克隆仓库  
  ```git clone https://github.com/imMMX/ubnt-mips-shadowsocks-libev.git```  
3. build 镜像   
  ```docker build --tag ubnt-mips-shadowsocks-libev .```  
4. 启动容器  
  ```docker run -it ubnt-mips-shadowsocks-libev```



