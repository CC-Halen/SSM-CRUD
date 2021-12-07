package com.cdw.domain;

import java.util.HashMap;
import java.util.Map;

/**
 * @author: cdw
 * @date: 2021/12/6 12:52
 * @description:
 */
public class Msg {
    private Integer code;
    private String msg;
    private Map<String, Object> data = new HashMap<>();

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }

    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }

    public Msg add(String key,Object value){
        this.getData().put(key,value);
        return this;
    }
}
