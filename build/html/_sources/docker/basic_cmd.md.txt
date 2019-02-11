# 基本操作

## 镜像

### 构建

```
sudo docker build -t <image_name>:<image_tag> <docker_file_path>

说明:
* image_name: 镜像名称，例如: photon/probe。如果关联镜像仓库，需要带上仓库地址，例如: http://harbor.yitu.com/photon/probe。
* image_tag: 镜像tag，用于区分不同的使用场景或者版本等。默认是 latest，不过强制要求以产品版本号设置tag。在使用基础镜像构建产品镜像时，不要使用 latest。
* docker_file_path: Dockerfile路径，可以使用 . 表示当前路径。在构建Docker镜像时，再详细说明。
```

### 拉取镜像

```
sudo docker pull <image_name>:<image_tag>
```

> 说明:
> * image_name: 镜像名称，如果是非docker默认仓库(https://index.docker.io/v1/)的镜像，需要带上镜像仓库地址。
> * image_tag: 镜像tag，默认是 latest，强烈要求使用明确的tag，不要使用 latest。

例如:
```
sudo docker pull hello-world
```

### 查看镜像列表

```
sudo docker images
```

### 查看特定镜像

```
sudo docker images <image_name>
```

例如:
```
sudo docker images hello-world
```

### 查看镜像详情

```
sudo docker inspect <image_name>:<image_tag>
```

or

```
sudo docker inspect <image_id>
```

例如:

```
sudo docker inspect hello-world
sudo docker inspect fce289e99eb9
```

> 说明: 镜像和容器本地操作中，使用<image_name>:<image_tag>的地方，均可以使用 <image_id> 替代。

### 删除镜像

```
sudo docker rmi <image_name>:<image_tag>
```

or

```
sudo docker rmi <image_id>
```

例如:

```
sudo docker rmi hello-world
sudo docker rmi fce289e99eb9
```

> 注意: 删除镜像时，不能有该镜像运行的容器，否则会报错:
> Error response from daemon: conflict: unable to delete fce289e99eb9 (must be forced) - image is being used by stopped container 3bd9945585b7

### 导出镜像

可以将镜像导出为tar包。

```
sudo docker save -o <image_tar_file> <image_name>:<image_tag>
```

or

使用重定向:
```
sudo docker save <image_name>:<image_tag> > <image_tar_file>
```

> 说明:
> * image_tar_file: 保存的tar文件名称
> * image_name: 镜像名称
> * image_tag: 镜像tag

例如:
```
sudo docker save -o hello.tar hello-world
sudo docker save hello-world > hello.tar
```

> 说明: 亦可使用 <iamge_id> 替代 <image_name>:<image_tag>，但在导入镜像时会丢失tag信息，不建议。

### 导入镜像

可以将导出的tar包，导入到本地镜像仓库。

```
sudo docker load -i <image_tar_file>
```

or

```
sudo docker load < <image_tar_file>
```

> 说明:
> * image_tar_file: 导出的镜像tar文件路径

例如:

```
sudo docker load -i hello.tar
sudo docker load < hello.tar
```

## 容器

### 启动容器

可以使用镜像，启动容器。

```
sudo docker run -d --rm -p <host_port1>:<container_port1> -p <host_port2>:<container_port2> -v <host_volume1>:<container_volume1> -v <host_volume2>:<container_volume2>  -e KEY1=VALUE1 -e KEY2=VALUE2 --name <container_name> <image_name>:<image_tag> <args>
```

> 说明:
> * 启动的主命令是 `sudo docker run`
> * `-d`是让容器以守护态运行。相对应的，`-ti`是以交互方式运行，即进入容器内部，可以在容器内操作命令。其中，-t 选项让Docker分配一个伪终端（pseudo-tty）并绑定到容器的标准输入上， -i 则让容器的标准输入保持打开。
> * `--rm` 是指在停止容器时(`sudo docker stop`)，停止成功时，自动删除容器，释放资源。注意: 如果带上该参数，在容器启动失败时，会自动删除失败的容器。如果需要定位问题，将该参数移除。
> * `-p` 参数指定了主机和容器间的端口映射关系，完整的格式应该是 `<host_ip>:<host_port>:<container_port>/<protocol>`。其中，`host_ip`为主机上端口绑定IP，默认为`0.0.0.0`；`host_port`为主机上映射的端口，即可在主机上访问容器服务的端口；`container_port`为容器中服务暴露的端口；`protocol`为端口协议，TCP或者UDP，默认为TCP。注意: 如果要将容器内的端口与主机端口映射，需要在容器中，将端口绑定在`0.0.0.0`上，否则，网络不可达。
> * `-p`参数可以指定多个，即容器中有多个端口需要与主机映射。注意主机上端口冲突。
> * `-v`参数指定了主机和容器间的数据卷挂载，其中，`host_volume`是主机上的文件/目录路径(注意，需是绝对路径)；`container_volume`是容器中的文件/目录。挂载的主机目录的默认权限是`读写`。通过数据卷的方式，可以做到数据持久化，在容器销毁时，挂载的数据卷依然保留。另一方面，可以通过数据卷的方式，定制化配置文件。
> * `-e`参数指定了容器运行时的环境变量。对于可变配置，也可以通过环境变量的方式传入。
> * `--name`指定了容器运行的名称，默认容器以随机的方式生成名称。注意: 容器名称要保持唯一，否则会报错。
> * `<image_name>:<image_tag>`: 容器使用的镜像，亦可以用 `<image_id>`。
> * `args`启动容器时，传入的参数列表，可选。后续介绍镜像构建时，再做详细介绍。

###  查看容器列表

查询所有状态的容器:
```
sudo docker ps -a
```

例如:
```
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                      NAMES
505877bce603        mongo               "docker-entrypoint..."   32 minutes ago      Up 32 minutes       0.0.0.0:27017->27017/tcp   cmdb-mongo
d617d6ecfcbc        redis               "docker-entrypoint..."   32 minutes ago      Up 32 minutes       0.0.0.0:6379->6379/tcp     cmdb-redis
```

> 说明:
> * STATUS: 容器运行状态，`Up`表示正常运行，`Exit`表示退出，根据退出码判断是否异常退出。
> * PORTS: 端口映射关系。

查询正在运行的容器:
```
sudo docker ps
```

### 启动容器

在容器停止或者异常退出后，可以启动容器。

```
sudo docker start <container_id>
```

or

```
sudo docker start <container_name>
```

> 说明:
> * container_id: 容器id
> * container_name: 容器名称

###  查看日志

容器启动后，可以通过查看容器日志。

```
sudo docker logs <container_id>
```

or 

```
sudo docker logs <container_name>
```

> 注意: logs查看的是控制台(stdout/stderr)日志。

如果需要持续输出日志(类似 `tail -f`):
```
sudo docker logs -f <container_id>
```

### 停止容器

```
sudo docker stop <container_id>
```

or
 
```
sudo docker stop <container_name>
```

### 执行命令

可以在运行中的容器中执行命令。

```
sudo docker exec <container_id> <cmd_line>
```

or

```
sudo docker exec <container_name> <cmd_line>
```

> 说明:
> * 容器必须是正常运行
> * `cmd_line`: 命令行

例如:
```
sudo docker exec d617d6ecfcbc cat /usr/local/etc/redis/redis.conf
```

### 拷贝容器文件

```
sudo docker cp <container_id>:<container_file_path> <host_file_path>
```

or

```
sudo docker cp <container_name>:<container_file_path> <host_file_path>
```

### 查看容器详情

```
sudo docker inspect <container_id>
```

or

```
sudo docker inspect <container_name>
```

## 仓库

使用公司内[仓库](https://harbor.yitu-inc.com/harbor/projects)。

在镜像构建时，再介绍仓库的交互。