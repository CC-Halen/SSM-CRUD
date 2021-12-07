package com.cdw.controller;

import com.cdw.dao.EmployeeMapper;
import com.cdw.domain.Employee;
import com.cdw.domain.Msg;
import com.cdw.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.naming.Binding;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @author: cdw
 * @date: 2021/12/5 21:41
 * @description:
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;


    @ResponseBody
    @RequestMapping(value = "/emp/{empIds}", method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("empIds") String ids) {
        if (ids.contains("-")) {
            String[] split = ids.split("-");
            List<Integer> list = new ArrayList<>();
            for (String id : split) {
                list.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(list);
        } else {
            employeeService.deleteEmp(Integer.parseInt(ids));
        }
        return Msg.success();
    }


//    @ResponseBody
//    @RequestMapping(value = "/emp/{id}", method = RequestMethod.DELETE)
//    public Msg deleteEmpById(@PathVariable("id") Integer id) {
////        System.out.println(id);
//        employeeService.deleteEmp(id);
//        return Msg.success();
//    }


    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee) {
//        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();

    }

    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败
            HashMap<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                System.out.println("错误的字段名：" + error.getField());
                System.out.println("错误信息：" + error.getDefaultMessage());
                map.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检查用户名是否可用
     *
     * @param empName
     * @return
     */
    @RequestMapping(value = "/checkUser", method = RequestMethod.POST)
    @ResponseBody
    public Msg CheckUser(String empName) {
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail();
        }
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 6);
        List<Employee> employees = employeeService.getAll();

        PageInfo<Employee> pageInfo = new PageInfo<>(employees, 5);

        return Msg.success().add("pageInfo", pageInfo);

    }


    /**
     * 员工信息的查询
     *
     * @return
     */
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //使用分页插件，传入页码以及每页的条数
        PageHelper.startPage(pn, 6);
        List<Employee> employees = employeeService.getAll();

        //封装详细的分页信息
        PageInfo<Employee> page = new PageInfo<>(employees, 5);
        model.addAttribute("pageInfo", page);

        return "list";
    }

}
