package com.igeek.ebuy.manager;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

/**
 * @author www.igeekhome.com
 * @description TODO
 * <p>
 * Created by DELL on 2019/8/28 19:15
 */
@SpringBootApplication
@EnableEurekaClient
public class MemberApp {
    public static void main (String [] a){
        SpringApplication.run(MemberApp.class,a);
    }
}
