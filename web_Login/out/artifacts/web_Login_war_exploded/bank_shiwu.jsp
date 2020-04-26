<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/14
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<html>
<head>
    <title>银行转账——数据库事务</title>
</head>
<body>
<%!
    ResultSet rs = null;
    Connection conn = null;
%>
<%
    try {
        // 获取上下文对象
        Context initCtx = new InitialContext();
        // 通过上下文对象查找 相关数据源
        // java:comp/env 代表查找系统javaee的资源
        Context ctx = (Context) initCtx.lookup("java:comp/env");
        // 获取javaee资源后，查找context.xml文件
        Object obj = (Object) ctx.lookup("jdbc/TestDB");
        // 再把context.xml转换为数据库源
        javax.sql.DataSource ds = (javax.sql.DataSource) obj;
        // 从转换的数据库源上  获取数据库连接对象
        conn = ds.getConnection();

        // 关闭自动提交模式
        conn.setAutoCommit(false);
        // 通过数据库连接对象，创建eStatement
        Statement stmt = conn.createStatement();
        // 通过statement执行sql语句
        out.print("数据库连接测试成功！<br>");
        rs = stmt.executeQuery("select userMoney from user where name='A'");
        rs.next();
        double A_Money = rs.getDouble("userMoney");
        rs = stmt.executeQuery("select userMoney from user where name='B'");
        rs.next();
        double B_Money = rs.getDouble("userMoney");
        out.print("当前A用户的钱为：" + A_Money + "<br>");
        out.print("当前B用户的钱为：" + B_Money);

        stmt.executeUpdate("update user set userMoney=userMoney+100.0 where name ='A'");
        stmt.executeUpdate("update user set userMoney=userMoney-100.0 where name ='B'");
        //int a=6/0;  破坏系统用的，提交事务看见就会报错回滚，转不了钱

        // 提交事务，开始处理事务，也就是开始执行sql语句
        conn.commit();

        rs = stmt.executeQuery("SELECT * FROM user WHERE name='A'||name='B'");
        out.println("<br>转账后的情况如下:<br>");
        while (rs.next()) {
            out.print(rs.getString(1) + "	");
            out.print(rs.getString(2));
            out.print("<br>");
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception ex) {
        try {
            conn.rollback();           //撤消事务所做的操作  如果看到int a=6/0 报错就撤销事务——不让转账，就跟系统坏了一样转不了钱
        } catch (SQLException exp) {
            out.print(exp);
        }

        out.print(ex);
    }

%>
</body>
</html>
