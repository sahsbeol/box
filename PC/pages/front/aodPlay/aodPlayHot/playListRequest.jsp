<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %> 
<%
	String strMyUrl = "http://dev.front.hottracks.co.kr";
	String referer = "http://dev.front.hottracks.co.kr";//request.getHeader("referer");
	
	String strBarCode = "";
	String strMusicCd = "";
	String strCdNo = "";
	String strTrackNo = "";
	
	String PLurl = "";
	
	if(request.getParameter("barcode") != null)
		strBarCode = request.getParameter("barcode");
	if(request.getParameter("musicCd") != null)
		strMusicCd = request.getParameter("musicCd");
	if(request.getParameter("cdNo") != null)
	{
		if(!request.getParameter("cdNo").equals(""))
		{
			strCdNo = request.getParameter("cdNo");
			if(strCdNo.trim().length() == 1)
			{
				strCdNo = "00" + strCdNo;
			}else if(strCdNo.trim().length() == 2)
			{
				strCdNo = "0" + strCdNo;
			}
		}
	}
	if(request.getParameter("trackNo") != null)
	{
		if(!request.getParameter("trackNo").equals(""))
		{
			strTrackNo = request.getParameter("trackNo");
			if(strTrackNo.trim().length() == 1)
			{
				strTrackNo = "0" + strTrackNo;
			}
		}
	}
	
	PLurl = "/ht/track/aodPlay/playListHot?musicCd="+strMusicCd.trim()+"&cdNo="+strCdNo.trim()+"&trackNo="+strTrackNo.trim();
	
	String result = java.net.URLEncoder.encode(PLurl);
	System.out.println("++++++++++++++++++++++++++++"+PLurl);
%>
<?xml version="1.0" encoding="utf-8"?>
<%	
	if(referer != null && referer.startsWith(strMyUrl) )
	{
%>
<response><%=result%></response>
<%
	}
	else
	{
%>
<response>null</response>
<%
	}
%>