<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
    java.sql.Statement stmt = null;
    java.sql.ResultSet rs = null;
    
    Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
    Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@129.100.250.30:1521:webdb","httsmall","gift1234");
//    Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.138:1521:devweb","httsmall_new","gift12345");

    String ymd = request.getParameter("yyyymmdd");
    
    StringBuffer sb = new StringBuffer();
    int index = 0;
    String sql = "";
    sql = sql + "select HHMISS      ";
    sql = sql + "     , LPINFO      ";
    sql = sql + "     , ID          ";
    sql = sql + "     , NAME        ";
    sql = sql + "     , ORDER_CODE  ";
    sql = sql + "     , PRODUCT_CODE";
    sql = sql + "     , ITEM_COUNT  ";
    sql = sql + "     , PRICE       ";
    sql = sql + "     , CATEGORY_CODE   ";
    sql = sql + "     , PRODUCT_NAME    ";
    sql = sql + "     , REMOTE_ADDR     ";
    sql = sql + "  from TB_LINKPRICE    ";
    sql = sql + " where YYYYMMDD = '" + ymd + "'"; 
    
    
    try {
        stmt = conn.createStatement();
        stmt.executeQuery(sql);
        rs = stmt.getResultSet();

        while (rs.next())
        {
            sb = new StringBuffer();
            if (index > 0)	sb.append("\r\n");

            sb.append(rs.getString("HHMISS") + "\t");
            sb.append(rs.getString("LPINFO") + "\t");
            sb.append(rs.getString("ID") + "(" + rs.getString("NAME") + ")" + "\t");
            sb.append(rs.getString("ORDER_CODE") + "\t");
            sb.append(rs.getString("PRODUCT_CODE") + "\t");
            sb.append(rs.getString("ITEM_COUNT") + "\t");
            sb.append(rs.getString("PRICE") + "\t");
            sb.append(rs.getString("CATEGORY_CODE") + "\t\t");
            sb.append(rs.getString("PRODUCT_NAME") + "\t");
            sb.append(rs.getString("REMOTE_ADDR"));
            out.print (sb.toString());
            index++;
        }
    }
    catch(Exception e)
    {
        out.println (e.getMessage());
    }
    finally
    {
        if (rs != null) try {rs.close();} catch (Exception e) {}
        if (stmt != null) try {stmt.close();} catch (Exception e) {}
        if (conn != null)
        {
            try	{conn.close();}	catch (Exception e)	{}
        }
    }
%>