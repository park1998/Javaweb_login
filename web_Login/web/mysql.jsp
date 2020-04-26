<%@ page import="java.sql.*" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/7
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JDBC for MySQL</title>
</head>
<body>
        <%!   // 全局 %!
            // 1、驱动名称
            String driverName = "com.mysql.jdbc.Driver";
            // 2、数据库连接地址
            String url = "jdbc:mysql://localhost:3307/login_jdbc";
            Connection conn;
            PreparedStatement ps;
            ResultSet re;
        %>
        <%
            request.setCharacterEncoding("utf-8");
            String form_username = new String(request.getParameter("username")) ;
            String form_password = new String(request.getParameter("password")) ;
        %>
        <%
            // 3、加载驱动
            Class.forName(driverName);
            // 4、获取数据库连接
            try {
                conn = DriverManager.getConnection(url, "root", "123");
                //out.print("数据库连接成功！<br>");
                ps = conn.prepareStatement("SELECT * FROM user where username=?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                ps.setString(1, form_username);
                re = ps.executeQuery(); //建立ResultSet(结果集)对象，并执行SQL语句
                re.last();  // 移至最后一条记录

            }catch (ClassCastException e){
                out.print("数据库连接失败~");
                e.printStackTrace();
            }
        %>
        <%
            int getRow = re.getRow();   // 查询到数据库多少条数据
            if(getRow == 0){
                out.print("无此用户 <a href=\"index.jsp\"> 返回登录</a>");
            }
            else if(form_password.equals(re.getString("password"))){
                out.print("欢迎您 "+form_username + "<a href=\"index.jsp\"> 返回登录</a>");
            }
            else {
                out.print("登录失败，账号或密码错误 <a href=\"index.jsp\"> 返回登录</a>");
            }
        %>

        <%
            re.close();//关闭ResultSet对象
            ps.close();//关闭Statement对象
            conn.close(); // 关闭数据库连接
        %>
</body>
</html>
