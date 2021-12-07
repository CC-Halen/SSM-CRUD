package com.cdw.service;

import com.cdw.dao.EmployeeMapper;
import com.cdw.domain.Employee;
import com.cdw.domain.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: cdw
 * @date: 2021/12/5 21:44
 * @description:
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     *
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }


    /**
     * 返回true表示可用
     *
     * @param empName
     * @return
     */
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }


    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新员工信息
     *
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();

        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);

    }
}
