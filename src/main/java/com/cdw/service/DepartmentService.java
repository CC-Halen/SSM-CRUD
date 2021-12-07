package com.cdw.service;

import com.cdw.dao.DepartmentMapper;
import com.cdw.domain.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: cdw
 * @date: 2021/12/6 16:17
 * @description:
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
