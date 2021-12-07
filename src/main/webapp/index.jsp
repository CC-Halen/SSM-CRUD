<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: cdw
  Date: 2021/12/5
  Time: 21:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.4.1.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.js"></script>
</head>
<body>

<%--修改员工信息的模态框--%>
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">修改员工</h4>
            </div>
            <div class="modal-body">
                <%--添加表单--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@xx.xxx">
                            <%--                            <span class="help-block"></span>--%>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M"
                                       checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F">
                                女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>

<%--新增员工的模态框--%>
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <%--添加表单--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@xx.xxx">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M"
                                       checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F">
                                女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--搭建显示页面--%>
<div class="container">
    <%--biaoti--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-9">
            <button class="btn btn-primary btn-sm" id="emp_add_model">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;&nbsp;新增
            </button>
            <button class="btn btn-danger btn-sm" id="emp_delete_all_btn">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;&nbsp;删除
            </button>
        </div>
    </div>
    <%--显示数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emp_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"></th>
                    <th>empId</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <div class="col-md-6" id="page_info_area">
        </div>
        <div class="col-md-6" id="page_nav_area">

        </div>

    </div>
</div>

<script type="text/javascript">


    let totalRecord, currentPage;
    <%--页面加载完成之后，直接发送ajax请求，取到分页数据--%>
    $(function () {
        toPage(1);
    });


    function toPage(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                // console.log(result);
                //解析json数据并显示
                build_emps_table(result);

                build_page_info(result);

                build_page_nav(result);

            }
        })
    }

    //解析分页数据
    function build_emps_table(result) {
        $("#emp_table tbody").empty();
        let emps = result.data.pageInfo.list;
        $.each(emps, function (index, item) {
            let checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>");
            let empIdTd = $("<td></td>").append(item.empId);
            let empNameTd = $("<td></td>").append(item.empName);
            let genderTd = $("<td></td>").append(item.gender === "M" ? "男" : "女");
            let emailTd = $("<td></td>").append(item.email);
            let deptNameTd = $("<td></td>").append(item.department.deptName);
            let editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit-id", item.empId);
            let delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("del-id", item.empId);

            let btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emp_table tbody");
        })
    }


    //解析分页条的数据
    function build_page_info(result) {
        $("#page_info_area").empty();
        let pageInfo = result.data.pageInfo;
        $("#page_info_area").append("当前第" + pageInfo.pageNum + "页，共" + pageInfo.pages + "页，总共" + pageInfo.total + "条记录")

        totalRecord = pageInfo.total;
        currentPage = pageInfo.pageNum;
    }


    function build_page_nav(result) {
        $("#page_nav_area").empty();
        let pageInfo = result.data.pageInfo;

        let ul = $("<ul></ul>").addClass("pagination");
        let firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        let nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        let prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (pageInfo.hasPreviousPage === false) {
            prePageLi.addClass("disabled");
            firstPageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                toPage(1);
            })
            prePageLi.click(function () {
                toPage(pageInfo.pageNum - 1);
            })
        }
        let lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));

        if (pageInfo.hasNextPage === false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            lastPageLi.click(function () {
                toPage(pageInfo.pages);
            })
            nextPageLi.click(function () {
                toPage(pageInfo.pageNum + 1);
            })
        }

        ul.append(firstPageLi).append(prePageLi);

        $.each(pageInfo.navigatepageNums, function (index, item) {
            let numLi = $("<li></li>").append($("<a></a>").append(item));
            if (pageInfo.pageNum === item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                toPage(item);
            })
            ul.append(numLi);
        })

        ul.append(nextPageLi).append(lastPageLi);

        let navEle = $("<nav></nav>").append(ul);

        $("#page_nav_area").append(navEle);
    }

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮，弹出模态框
    $("#emp_add_model").click(function () {

        //清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#empAddModel form");
        //s$("")[0].reset();
        //发出ajax请求，查出部门信息，显示在下拉列表
        getDepts("#empAddModel select");

        $("#empAddModel").modal({
            backdrop: "static"
        });
    });

    function getDepts(ele) {
        //清空下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "get",
            success: function (result) {
                // console.log(result);
                // $("#dept_add_select").append("")
                $.each(result.data.depts, function () {
                    let optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        })

    }

    //校验
    function validate_add_form() {
        let empName = $("#empName_add_input").val();
        let regName = /(^[a-zA-Z0-9_-]{3,12}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        ;

        let email = $("#email_add_input").val();
        let regEmail = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            /* $("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确"); */
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }

        return true;

    }

    //显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" === status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" === status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }


    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        let empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkUser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code === 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", "用户名不可用");
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });

    $("#emp_save_btn").click(function () {
        //先校验
        if (!validate_add_form()) {
            return false;
        }
        ;


        if ($(this).attr("ajax-va") === "error") {
            return false;
        }

        //发送ajax请求保存
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModel form").serialize(),
            success: function (result) {
                if (result.code === 100) {
                    // alert(result.msg);
                    //关闭模态框
                    $("#empAddModel").modal("hide");
                    //去最后一页显示数据
                    toPage(totalRecord);
                } else {
                    //显示失败信息
                    // console.log(result);
                    if (result.data.errorFields.email !== undefined) {
                        show_validate_msg("#email_add_input", "error", result.data.errorFields.email);
                    }
                    if (result.data.errorFields.empName !== undefined) {
                        show_validate_msg("#empName_add_input", "error", result.data.errorFields.empName);
                    }
                }

            }
        })

    })


    $(document).on("click", ".edit_btn", function () {
        // alert("edit");
        //查出员工信息
        getEmp($(this).attr("edit-id"));

        // 查询部门信息
        getDepts("#empUpdateModel select");

        //把员工id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empUpdateModel").modal({
            backdrop: "static"
        });
    })


    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                // console.log(result);
                let empData = result.data.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModel input[name=gender]").val([empData.gender]);
                $("#empUpdateModel select").val([empData.dId]);
            }
        });

    }

    $("#emp_update_btn").click(function () {
        //邮箱验证
        let email = $("#email_update_input").val();
        let regEmail = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            /* $("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确"); */
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "格式正确");
        }

        //发送ajax请求，保存修改后的信息
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModel form").serialize(),
            success: function (result) {
                if (result.code === 100) {
                    //处理成功
                    $("#empUpdateModel").modal("hide");

                    toPage(currentPage);
                } else {

                }

            }
        });


    });


    $(document).on("click", ".delete_btn", function () {
        let delete_name = $(this).parents("tr").find("td:eq(1)").text();
        let empId = $(this).attr("del-id");
        if (confirm("确定删除【" + delete_name + "】吗？")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    if (result.code === 100) {
                        alert(result.msg);
                        toPage(currentPage);
                    }
                }
            })
        }
    })


    function deleteEmp(empId) {
        $.ajax({
            url: "${APP_PATH}/emp/" + empId,
            type: "DELETE"
        })
    }


    $("#check_all").click(function () {
        // alert($(this).prop("checked"));
        $(".check_item").prop("checked", $(this).prop("checked"));

    });

    $(document).on("click", ".check_item", function () {
        let flag = $(".check_item:checked").length === $(".check_item").length;
        $("#check_all").prop("checked", flag);

    });

    $("#emp_delete_all_btn").click(function () {
        // alert($(".check_item:checked"))
        // $(".check_item:checked")

        let empName = "";
        let empIds = "";
        $.each($(".check_item:checked"), function () {
            empName += $(this).parents("tr").find("td:eq(2)").text() + ",";
            empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
            // let delete_empId = $(this).parents("tr").find("td:eq(1)").text();
            // deleteEmp(delete_empId);
            // toPage(currentPage);
        });
        empName = empName.substring(0, empName.length - 1);
        empIds = empIds.substring(0, empIds.length - 1);
        if (confirm("确定要删除【" + empName + "】吗？")) {

            /*
            方法一：
                 $.each($(".check_item:checked"),function () {
                 let delete_empId = $(this).parents("tr").find("td:eq(1)").text();
                 deleteEmp(delete_empId);
                 toPage(currentPage);
             })*/

            //方法二
            $.ajax({
                url:"${APP_PATH}/emp/"+empIds,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    toPage(currentPage);

                }
            })


        }

    })


</script>

</body>
</html>
