package com.igeek.ebuy.service.impl;

import com.igeek.ebuy.manager.mapper.TbItemMapper;
import com.igeek.ebuy.pojo.TbItem;
import com.igeek.ebuy.pojo.TbItemExample;
import com.igeek.ebuy.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author www.igeekhome.com
 * @description TODO
 * <p>
 * Created by DELL on 2019/8/12 11:57
 */
@SuppressWarnings("ALL")
@Service
public class ItemServiceImpl implements ItemService {

    @Autowired
    private TbItemMapper itemMapper;

    public TbItem queryById(long itemId) {
//        return itemMapper.selectByPrimaryKey(itemId);
//        return null;
//        还有一种方式Example

        TbItemExample example = new TbItemExample();
        //设置条件
        TbItemExample.Criteria criteria = example.createCriteria();
        criteria.andIdEqualTo(itemId);
        //ctrl+alt+v
        List<TbItem> items = itemMapper.selectByExample(example);
        //通过id查出来的肯定是一个啊
        if (items!=null && items.size() == 1){
            return items.get(0);
        }
        return null;
    }
}
