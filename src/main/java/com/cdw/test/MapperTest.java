package com.cdw.test;

import com.cdw.dao.DepartmentMapper;
import com.cdw.dao.EmployeeMapper;
import com.cdw.domain.Department;
import com.cdw.domain.DepartmentExample;
import com.cdw.domain.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author: cdw
 * @date: 2021/12/5 20:52
 * @description:
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;


    @Test
    public void TestCRUD() {
        /*ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        DepartmentExample departmentExample = context.getBean(DepartmentExample.class);*/

        System.out.println(departmentMapper);

//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));

        System.out.println(employeeMapper);

//        employeeMapper.insertSelective(new Employee(null,"赵四","M","zs@qq.com",1));

        //批量插入
        System.out.println(sqlSession);

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5);
            if (i % 3 == 0)
                mapper.insertSelective(new Employee(null, uid, "F", uid+"@gmail.com", 2));
            else
                mapper.insertSelective(new Employee(null, uid, "M", uid+"@gmail.com", 1));

        }


    }

}
