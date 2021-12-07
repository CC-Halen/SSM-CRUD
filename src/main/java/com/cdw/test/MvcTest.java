package com.cdw.test;

import com.cdw.domain.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author: cdw
 * @date: 2021/12/5 21:58
 * @description:
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:dispatcherServlet.xml"})
public class MvcTest {

    @Autowired
    WebApplicationContext context;

    //虚拟mvc请求，获取处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();

        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");

        System.out.println(pageInfo.getPageNum());
        System.out.println(pageInfo.getPages());
        System.out.println(pageInfo.getTotal());
        System.out.println("需要连续显示的页码：");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int i : nums)
            System.out.println(" " + i);

        //员工数据
        List<Employee> list = pageInfo.getList();
        list.forEach(System.out::println);

    }

}
