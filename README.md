# ubnt-mips-shadowsocks-libev
为基于 mipsel, mips64 的 Ubiquiti EdgeMax(ER-X, ER-4), UniFi Security Gateway(USG) 等交叉编译 shadowsocks-libev  

Cross complie shadowsocks for UBNT devices based on mipsel or mips64  

Ci: [![Build Status](https://travis-ci.org/imMMX/ubnt-mips-shadowsocks-libev.svg?branch=master)](https://travis-ci.org/imMMX/ubnt-mips-shadowsocks-libev)  

## 样例  
* mips64  
![mips64](https://github.com/imMMX/ubnt-mips-shadowsocks-libev/blob/master/screenshot/mips64.jpeg)  
* mips  
![mips64](https://github.com/imMMX/ubnt-mips-shadowsocks-libev/blob/master/screenshot/mips.jpeg)

## 使用方法  
1. 安装 Docker  
  ```curl -sSL https://get.docker.com/ | sh ```
2. 克隆仓库  
  ```git clone https://github.com/imMMX/ubnt-mips-shadowsocks-libev.git```  
3. build 镜像   
  ```docker build --tag ubnt-mips-shadowsocks-libev .```  
4. 启动容器  
  ```docker run -idt --name ubnt-mips-shadowsocks-libev ubnt-mips-shadowsocks-libev```
5. 从容器中拷贝
  ```docker cp ubnt-mips-shadowsocks-libev:/opt/ss-mips/ss-bin .```
  
## mips 与 mips64
由 ENV 参数 ARCHITECH 判断，默认生成 mips，需要 mips64 在第 4 步的时候替换成下面的命令  

  ```docker run -idt --name ubnt-mips-shadowsocks-libev -e ARCHITECH="mips64" ubnt-mips-shadowsocks-libev```


