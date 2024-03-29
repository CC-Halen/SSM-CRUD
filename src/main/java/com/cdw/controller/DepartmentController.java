package com.cdw.controller;

import com.cdw.domain.Department;
import com.cdw.domain.Msg;
import com.cdw.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


/**
 * @author: cdw
 * @date: 2021/12/6 16:15
 * @description:
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> departments = departmentService.getDepts();
        return Msg.success().add("depts",departments);
    }

}
