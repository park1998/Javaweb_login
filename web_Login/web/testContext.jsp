<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/13
  Time: 23:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<html>
<head>
    <title>数据库连接池测试</title>
</head>
<body>
<%
    try{
        // 获取上下文对象
        Context initCtx=new InitialContext();
        // 通过上下文对象查找 相关数据源
        // java:comp/env 代表查找系统javaee的资源
        Context ctx=(Context) initCtx.lookup("java:comp/env");
        // 获取javaee资源后，查找context.xml文件
        Object obj=(Object)ctx.lookup("jdbc/TestDB");
        // 再把context.xml转换为数据库源
        javax.sql.DataSource ds=(javax.sql.DataSource)obj;
        // 从转换的数据库源上  获取数据库连接对象
        Connection conn=ds.getConnection();
        // 通过数据库连接对象，创建eStatement
        Statement stmt=conn.createStatement();
        // 通过statement执行sql语句
        out.print("数据库连接测试成功！<br>");
        ResultSet rs=stmt.executeQuery("select * from course");
        while(rs.next()){
            String cName=rs.getString(2);  // 显示第二个数据段
            out.println(cName+"<br>");
        }
        rs.close();
        stmt.close();
        conn.close();
    }
    catch(Exception ex){
        out.print(ex);
    }
%>
    </body>
</html>
