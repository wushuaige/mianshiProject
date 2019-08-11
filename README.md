# mianshiProject

- repostory name
- 这是自己的介绍，都会打包成jar都会丢到web工程里面，但是我用了一个词，聚合，聚合工程是那个manager
有pom文件的那个，所以tomcat要配在这个manager里面，不是web里面，配置tomcat插件，首先需要安装，先把
parent给maven-install一下，然后common再install一下，如果没有通过聚合工程的一个一个装很麻烦，直接聚
合工程install，它会自动按照顺序给你装好，确定开发工具配置的完整正确，运行tomcat插件的run-war，显示访问
路径http://localhost:8080/  不行就执行clean，有时下载jar会出错，工程搭建暂时okay

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



