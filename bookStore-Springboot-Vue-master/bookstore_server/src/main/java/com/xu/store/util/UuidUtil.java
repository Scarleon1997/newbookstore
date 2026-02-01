package com.xu.store.util;

import java.util.UUID;

/**
 * @author: 许瑞仕
 * @date: 2025522 9:52
 * @description: UUID工具类
 */
public final class UuidUtil {
    private UuidUtil(){}
    public static String getUuid(){
        return UUID.randomUUID().toString().replace("-","");
    }
}
