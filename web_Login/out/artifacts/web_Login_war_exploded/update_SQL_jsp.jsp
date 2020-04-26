<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/13
  Time: 21:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" %>
<HTML>
<BODY>
<CENTER>
    <FONT SIZE=4 COLOR=blue>JDBC访问MySql数据库</FONT>
</CENTER>
<HR>
<CENTER>
    <%!
        String driverName = "com.mysql.jdbc.Driver";
        String uri = "jdbc:mysql://localhost:3307/school?characterEncoding=UTF-8";
        String user = "root";
        String password = "123";
        Connection con;
        Statement stmt;
        ResultSet rs;
        int count;
    %>
    <%
        try {
            Class.forName(driverName);
            con = DriverManager.getConnection(uri, user, password);
            out.print("连接成功!");
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            count = stmt.executeUpdate("update course set cname='大学体育' where cno='146-101'");
            rs = stmt.executeQuery("SELECT * FROM course"); //建立ResultSet(结果集)对象，并执行SQL语句
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <br>
    数据表中共有
    <FONT SIZE=4 COLOR=red>
        <!--取得最后一条记录的行数-->
        <% rs.last(); //移至最后一条记录%>
        <%= rs.getRow() %>
    </FONT>
    笔记录
    <br>
    <TABLE border=1 bordercolor="#FF0000" bgcolor=#EFEFEF WIDTH=400>
        <TR bgcolor=CCCCCC ALIGN=CENTER>
            <TD><B>记录条数</B></TD>
            <TD><B>课程号</B></TD>
            <TD><B>课程名</B></TD>
            <TD><B>教师号</B></TD>
        </TR>
        <%
            rs.beforeFirst(); //移至第一条记录之前
//利用while循环配合next方法将数据表中的记录列出
            while (rs.next()) {
        %>
        <TR ALIGN=CENTER>
            <!--利用getRow方法取得记录的位置-->
            <TD><B><%= rs.getRow() %>
            </B></TD>
            <TD><B><%= rs.getString("cno") %>
            </B></TD>
            <TD><B><%= rs.getString("cname") %>
            </B></TD>
            <TD><B><%= rs.getString("tno") %>
            </B></TD>
        </TR>
        <%
            }
        %>
        更新返回值<%= count%>
    </TABLE>
</CENTER>
</BODY>
</HTML>

