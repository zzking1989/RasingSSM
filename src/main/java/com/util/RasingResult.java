package com.util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RasingResult {
    // 响应业务状态
    private Integer code;

    // 响应消息
    private String name;

    // 响应中的数据
    private Object data;
}
