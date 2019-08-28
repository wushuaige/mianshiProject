package com.ebuy.eureka;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

/**
 * @author www.igeekhome.com
 * @description TODO
 * <p>
 * Created by DELL on 2019/8/28 11:20
 */
@SpringBootApplication
@EnableEurekaServer
public class EurekaApp {
    public static void main(String [] a){
        SpringApplication.run(EurekaApp.class,a);
    }
}
