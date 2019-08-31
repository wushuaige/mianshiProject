# mianshiProject

- repostory name
- 这是自己的介绍，都会打包成jar都会丢到web工程里面，但是我用了一个词，聚合，聚合工程是那个manager
有pom文件的那个，所以tomcat要配在这个manager里面，不是web里面，配置tomcat插件，首先需要安装，先把
parent给maven-install一下，然后common再install一下，如果没有通过聚合工程的一个一个装很麻烦，直接聚
合工程install，它会自动按照顺序给你装好，确定开发工具配置的完整正确，运行tomcat插件的run-war，显示访问
路径http://localhost:8080/  不行就执行clean，有时下载jar会出错，工程搭建暂时okay

# 一些页面错误显示

- 200(OK) 成功HTTP请求的准响应
- 201(CREATED) 成功创建项目
- 204(NO CONTENT)响应正文中没有任何内容被返回
- 400(BAD REQUEST) 由于请求语法错误，大小过大或其他饥饿护短错误，无法处理该请求
- 403(FORBIDDEN) 客户端没有权限访问该资源
- 404(NOT FOUND) 此时无法找到该资源。它可能被删除或不存在
- 500(INTERNAL SERVER ERROR) 若无更多可用信息，则通过答案意外失败

# ebuyparent

- 简历项目
- pom父工程只做管理，不做依赖

# ebuycommon

# ebuymanager

- 也是pom管理工程

## ebuymanagerpojo

- pojo class

## ebuymanagerdao

- dao
- dao depends on mybatis and mysql and connection pool and pojo module.

## ebuymanagerinterface

- service interface and implementation class separation
- depends on pojo module.
- 只依赖pojo就可以了，知只是接口而已

## ebuymanagerservice

- service interface and implementation class separation.
- The first one is dependent on dao.
- 因为依赖了dao层就依赖了pojo了
- Also depends on spring and interface module.

## ebuymanagerweb

- first depends on service,soa is separared after dependency in. 

# 总共八个工程

# 下整SSM

- mybatis的逆向工程generatorSqlmapCustom
- 无论是逆向工程GeneratorSqlMap.java类还是generatorConfig.xml文件
- 其中都要用到绝对路径，不然就找不到位置，有些不明白，https://blog.csdn.net/weixin_42215286/article/details/86765076
- 这个逆向工程，只是简单java项目，你想怎么样就怎么样啦，都可以，相对应包与类生成就可以
- 将生辰的包copy到我们maven项目的dao的类里面
- 到这里数据库整理完毕

## 思路

- 将mybatis整合到spring
- 通过spring创建数据库连接池
- spring管理SqlSessionFactory、mapper代理对象

### Dao层

- Dao层第一个需要创建SqlMapperConfig.xml这个在mybatis交给spring之后就用不到了，但是得有，可以是空的，spring会加载该文件
- spring配置applicationContext-dao.xml(名字可以不一样，但是记住有这些配置文件)

### Service层

- spring配置applicationContext-service.xml
- 事务配置：applicationContext-trans.xml

### View表现层

- springMVC框架配置
- springMVC三大组件
- 所有配置文件放在web中，because其他的项目会打包到web
- web中需要json数据格式解析依赖，这里使用jackson

#### 最后配置web.xml

- 配置前端控制器(dispatcher 调度器)
- 加载spring容器的监听器
- post请求的字符处理(tomcat7的get请求是有乱码的，要自己解决，8没有)
- configuration completed 就写一些简单的业务来测试一下

## 实现功能

### 根据商品id查看商品信息，返回json数据格式

- 一般是先写dao，在写service在写什么什么，现在不这么干
- 文档写的url是这样的：/item/{itemId} 参数是itemId，是携带在url中的
- @SuppressWarnings("ALL")是抑制你看到的警告，告诉你看警告，确定没问题，让它抑制，使看不到警告
- 1.创建controller
- 2.编写handler
- 3.添加service接口和实现类
- service添加注解时只有一个，但是加了dubbo以后，还会多一个service
- 4.实现业务
- 因为这个是单表查询，so，底层使用的逆向工程
- 这里用了注释模板，自行设置，IDEA与eclipse有些区别
- 接口加注释模板描述，开发规定吧
- 使用了Example，然后将service注入到mvc，平时是不用的，使用soa分离后直接调用接口
- 写好业务逻辑等等后，需要把工程install一下，才可以跑，我们都要装接口，或者一起装一下也可以

#### 另外記錄

- spring事務配置：https://www.cnblogs.com/liujia1990/p/9045910.html

#### Example

- 逆向工程里面还有一个挺讨厌的查询方式selectByExample()
- 这是哪个mapper里面有个resultMap的id为BaseResultMap这里都对应的起来，它不光生成了一个实体类还为每一个实体类生成了一个Example
- 这里它主要是帮助你添加各种查询条件的，它给你提供了一个API叫selectByExample，然后你传一个example对象进来
- 每一个mapper所使用的example是不一样的，上面用的是TbItemExample(类名后跟Example)
- 这里面有一个对象，是一个静态内部类Criterion，这是根据每一种类别添加各种查询条件的然后通过查询条件方便去查询
- 大家要知道的，这是每一个表对应的一个实体类，都有各自的Example，这里需要创建local variable Example，直接new一个空的就行了
- 根据这个条件获得返回值，如查询的是用户列表，IDEA快捷键是ctrl+alt+v,返回的就是个List<TbItem>这个对象
- 然后if判断这个对象是否为空并且.size()是否等于1，等于直接return 对象名.get(0);
- 在这之前需要设置条件，example.createCriteria();快捷键创建这个内部类的对象,创建好通过这个criteria对象添加条件
- 什么.andId....还有.andTitle....什么的条件，而且条件还可以任意组合，加in之后它就可以帮你按条件组合查询
- 逆向工程的缺点，只能单表查询，想多表查询需要自己扩展，后边会说如何在逆向工程实现的代码里面去扩展，或者说我不去改逆向工程的代码
- 一定记得工具或什么帮你生成的代码尽量不要去改变，表更改，逆向工程重新生成，改的就白改了，想加功能就扩展它
- 就是写个类去继承逆向工程生成的mapper，然后同时写一个配置文件去继承Example，这个当然会不能继承的后面会将具体怎么去扩展的，不急
- 这里再次提交我新建了一个firstTransactionBranch分支，因为上次运行第一个根据id查询的任务时会出现一个500异常，是Mapper绑定异常
- 其中异常显示Invalid bound statement (not found): com.igeek.ebuy.manager.mapper.TbItemMapper.selectByExample
- 问题解决：maven里面有资源文件是放在resource里面的，但是在main/java下面有一堆mapper文件
- 但是maven打包的时候不会吧java下面的这些资源文件打包到里面，所以一打包运行就会出错，没有打进去
- 跑itemMapper的时候会发现没有对应的配置文件，没有对应的就叫映射文件吧，这时候我们的做法是告诉maven
- 打包的时候把java下面的文件也打进去，在dao的pom文件中添加一个下面这样的节点
- 这个节点<build>下面的<resources>下面的<resource>下面的一些标签内内容怎么填有的是不一样的自己百度找
- 有好多方法添加节点，使用maven插件
- 上面这个问题解决后如果是SOA的话，还会有另外一个问题

## SVN管理，GIT也可以，随意

- 下载TortoiseSVN(小乌龟)下载链接https://osdn.net/projects/tortoisesvn/storage/1.12.2/Application/TortoiseSVN-1.12.2.28653-x64-svn-1.12.2.msi/
- 另外教程：https://blog.csdn.net/zwj1030711290/article/details/80687365
- 配置路径到你的bin目录下的svn.exe就可以了，IDEA在VSC菜单选项中checkout.....选项中的subversion中输入连接SVN中的url
- 那个TortoiseSVN类似于IDEA的SVN插件，可以添加项目的url进行管理，在IDEA里面操作svn，类似于IDEAsvn Manager插件
- 这都是使用IDEA，eclipse更简单，右击项目，Subversion会有多种选项，下面网址对这些选项进行了详细介绍：https://blog.csdn.net/hello__word__/article/details/81773815
- 我不得不说还是git好用，这个svn后边可能就不用了

# ebuy项目

## 理解soa，dubbo

### 项目修改成soa架构，通过dubbo

- 首先需要虚拟机VMWare,等等都可以，win10专业版的Hyper-V啊等
- 第一步把service层与服务层分开
- 两个系统之间相互通信有多重方式
- 第一种WebService，基于soap协议，效率不高。项目中不推荐使用
- restful形式，http+json。
- 使用dubbo，使用rpc协议进行远程调用，直接使用socket通信。效率高，并可统计出系统之间的调用关系、调用次数。
- 

#### dubbo

- 解决两个工程之间的通信
- container容器(spring)，provider服务提供者(180的姑娘)，registory(交友中心)，consumer(相亲人员)，monitor(中国移动)
- 上面是以一个形象化的方式解说，提出要求，中心正好有返回手机号码那个，平台归平台，只是获得了相应的总归是两个系统沟通的
- invoke两个之间通信，使用手机通信，这个手机才是dubbo，解决工程之间沟通，注册中心什么的跟dubbo没有关系
- 注册中心不管是用redis还是zookeeper都可以实现，主要是发布信息，dubbo也会把信息发布上去，但dubbo主要的....
- 所以说为什么说有个monitor是中国移动，就是工程之间怎么调用的这个monitor都知道，qq安全吗，不公安局弄个正就可以调你全部信息，都是存储的
- dubbo是怎么做的呢，这里面对应的container是spring，provider是service对象，service把对外提供的端口、地址发在register注册中心
- consumer客户端消费者，去找对应的接口服务然后注册中心就把对应的ip地址给你，就可以通信了。
- 这里的monitor是监控中心，dubbo官方提供的监控中心，你就用来监控各个服务之间的情况
- 详细：provider：暴露服务的服务提供方
- consumer：调用远程服务的服务消费方
- registory：服务注册与发现注册中心
- monitor：统计服务的调用次数和调用时间的监控中心
- container：服务运行容器
- 调用关系：
- 0 服务容器负责启动，加载，运行服务提供者
- 1 服务提供者在启动时，向注册中心注册自己提供的服务
- 2 服务消费者在启动时，想注册中心订阅自己所需的服务
- 3 注册中心返回服务提供者地址列表给消费者，如果有变更，注册中心将基于长连接推送变更数据给消费者
- 4 服务消费者，从提供者地址列表中，基于软负载均衡算法，选一台提供者进行调用，如果调用失败，再选另一台调用。
- 5 服务消费者和提供者，在内存中累计调用次数和调用时间，定时每分钟发送一次统计数据到监控中心。

##### dubbo使用
- 采用全spring配置，透明化接入应用，对应用没有任何API侵入
- 只需要spring加载dubbo配置即可，基于schema扩展进行加载
- https://www.cnblogs.com/lilixin/p/5724976.html
- https://blog.csdn.net/u014740338/article/details/80278289
- https://blog.csdn.net/JzCm__/article/details/84794825

#### 注册中心

- 搭建起来，阿里官方建议使用zookeeper注册中心
- 负责服务地址注册与查找

## 注册中心zookeeper

- 搭建注册中心，使用zookeeper

##### zookeeper

- 可参考网址解压包位置：https://www.cnblogs.com/liangqihui/p/7154407.html
- https://zhidao.baidu.com/question/504775293.html
- 复制路径：http://c.biancheng.net/view/746.html
- 安装环境：centos，jdk
- 这里牵扯到了linux系统会写入常用命令
- `tail -f ../logs/catalina.out` 这是当tomcat服务运行时查看运行状态
- `systemctl start firewalld`   开启防火墙
- `firewall-cmd --zone=public --add-port=1935/tcp --permanent` 永久开放指定端口
- `firewall-cmd --reload`   刷新防火墙
- `netstat -ntulp |grep 1935`   查看开放端口的使用情况
- 在解压目录创建data文件夹，修改zoo_sample.cfg 为zoo.cfg，这不是集群，一个zookeeper就可以了
- 修改配置文件里的dataDir=你的data文件所在的目录
- ./zkServer.sh start启动zookeeper(./zkServer.sh stop停止，status状态)
- service iptables stop 临时关闭防护墙
- chkconfig iptables off 修改配置，开机不启动防火墙
- lsof -i:22 检测22端口是否开放，用来使用Xshell
- 永久开放端口：https://www.cnblogs.com/blackhumour2018/p/9648390.html，通過這個開放的端口號，losf -i是查詢不到什麽的
- xftp是连接直接传送文件，给虚拟机

## 实现商品列表功能

- 將表現層獨立出來，這個工程web層與服務端實在一個工程裏邊的
- web獨立出來，原有ebuy-manager改成dao、interface、pojo、service(打包方式改爲war)
- 不一定改成war，只是爲了方便部署，我們最終是希望能啓動spring容器，最簡單的方式就是把工程丟到tomcat上面，運行自動加載，也可以main方法把spring容器加載起來
- 啓動原理https://www.cnblogs.com/CLAYJJ/p/5967284.html
- 容器：https://www.cnblogs.com/ysy6233/p/7811211.html
- manager中pom文件刪除web，web文件移動到manager同級，service修改打包方式
- service工程添加web.xml配置文件，web工程的配置文件複製到service中，刪除springmvc.xml，web.xml中只配置spring容器，刪除前端控制器
- service中添加dubbo依賴的jar包，zookeeper一系列依赖
- 然后虚拟机开启注册中心，运行dubbo监控中心
- 成功后会有检测到服务，不过会出一个TBItem序列化的错误
- socket对象流，网络编程，发对象的时候对象必须实现序列化这个接口
- 我们这里出错是因为没有实现,在那个pojo类里面implements实现序列化接口serializable
- 这里发现通过逆向工程实现的东西有放错地方的
- 错误记录关于找不到什么返回值类型转换的什么玩意：http://www.it1352.com/951690.html
- dubbo提供者ip不对：https://www.cnblogs.com/zhangcybb/p/4962873.html
- 遇到的问题与下面类似：http://www.mamicode.com/info-detail-1320961.html





