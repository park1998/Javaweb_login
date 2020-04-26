<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/7
  Time: 14:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Page</title>
    <style>
        tr{
            height: 30px;
        }
    </style>
</head>
<body>
<form action="mysql.jsp" method="post">
    <table style="margin: 0 auto;">
        <tr>
            <th>
            <td colspan="2">登录界面</td>
            </th>
        </tr>
        <tr>
            <td>账号：</td>
            <td>
                <input type="text" name="username">
            </td>
        </tr>
        <tr>
            <td>密码：</td>
            <td>
                <input type="password" name="password">
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <input type="submit" name="submit" value="登 录">
                <input type="reset" name="reset" value="重 置">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
