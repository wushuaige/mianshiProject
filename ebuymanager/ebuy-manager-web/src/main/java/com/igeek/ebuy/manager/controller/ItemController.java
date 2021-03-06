package com.igeek.ebuy.manager.controller;

import com.igeek.ebuy.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.igeek.ebuy.pojo.TbItem;

//  如何使用注释模板：输入模本的简称Abbreviation，然后使用自己设置的enter或者tab的方式点击，直接出现
// IDEA的参数设置@Date $date$ ，在variables里选择expression
// 这里可以设置/*使用的方式，也可以设置创建类是直接生成的方式，我两种都实现了

/**
 * @author www.igeekhome.com
 *
 * @description TODO
 *
 * @Date 2019/8/12 11:34
 */

@SuppressWarnings("ALL")
@Controller
public class ItemController {

    //注入
    @Autowired
    private ItemService itemService;

    @RequestMapping("/item/{itemId}")
    //    需要返回json格式数据，so,它会自己使用jcason将查出的对象转为json
    @ResponseBody
//    参数是从路径中获取的，so
    public TbItem queryById(@PathVariable long itemId){
        //springMVC会自动将对象转换为json，因为配置了@ReponseBody  不走视图解析器
        return itemService.queryById(itemId);
    }



}
