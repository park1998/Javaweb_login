<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/14
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" %>

<html>
<head>
    <title>分页查询</title>
</head>
<body>
<div align="center"><span class="style1">分页显示记录</span><BR>
</div>
<BR>
<table border=2 bordercolor="#FF0000" align="center">
    <tr>
        <td>sno</td>
        <td>sname</td>
        <td>ssex</td>
        <td>sbirthday</td>
        <td>sage</td>
    </tr>
    <% Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3307/school?characterEncoding=UTF-8";
//school为你的数据库
        String user = "root";
        String password = "123";
        Connection conn = DriverManager.getConnection(url, user, password);
        int intPageSize; //一页显示的记录数
        int intRowCount; //记录总数
        int intPageCount; //总页数
        int intPage; //待显示页码
        java.lang.String strPage;
        int i;
        intPageSize = 2; //设置一页显示的记录数
        strPage = request.getParameter("page");  //取得待显示页码
        if (strPage == null) {
//表明在QueryString中没有page这一个参数，此时显示第一页数据
            intPage = 1;
        } else {
//将字符串转换成整型
            intPage = java.lang.Integer.parseInt(strPage);
            if (intPage < 1) intPage = 1;
        }
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        String sql = "select   *  from  student";
        ResultSet rs = stmt.executeQuery(sql);
        rs.last(); //光标指向查询结果集中最后一条记录
        intRowCount = rs.getRow();  //获取记录总数
        intPageCount = (intRowCount + intPageSize - 1) / intPageSize; //记算总页数
        if (intPage > intPageCount)
            intPage = intPageCount;//调整待显示的页码
        if (intPageCount > 0) {
            rs.absolute((intPage - 1) * intPageSize + 1);
            //将记录指针定位到待显示页的第一条记录上
//显示数据
            i = 0;
            while (i < intPageSize && !rs.isAfterLast()) {%>
    <tr>
        <td><%=rs.getString("sno")%>
        </td>
        <td><%=rs.getString("sname")%>
        </td>
        <td><%=rs.getString("ssex")%>
        </td>
        <td><%=rs.getDate("sbirthday")%>
        </td>
        <td><%=rs.getInt("sage")%>
        </td>
    </tr>
    <% rs.next();
        i++;
    }
    }
    %>
</table>
<hr color="#999999">
<div align="center">第<%=intPage%>页 共<%=intPageCount%>页
    <%if (intPage < intPageCount) {%>
    <a href="fenye.jsp?page=<%=intPage+1%>">下一页</a>
    <%}%>
    <%if (intPage > 1) {%>
    <a href="fenye.jsp?page=<%=intPage-1%>">上一页</a>
    <%}%>
    <%
        rs.close();
        stmt.close();
        conn.close();
    %>
</div>

</body>
</html>
