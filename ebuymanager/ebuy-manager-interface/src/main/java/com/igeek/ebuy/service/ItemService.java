package com.igeek.ebuy.service;


import com.igeek.ebuy.pojo.TbItem;

/**
 * @author www.igeekhome.com
 *
 * @description TODO
 *
 * @Date 2019/8/12 11:45
 */
@SuppressWarnings("ALL")
public interface ItemService {
    /**
     * 通过ID返回商品信息
     * @param itemId
     * @return
     */
    public TbItem queryById(long itemId);

}
