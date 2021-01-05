<%
/******************************************************************************
*
*	@ SYSTEM NAME		: �������� ����ϴ� include ����
*	@ PROGRAM NAME		: incMerchant.jsp
*	@ MAKER				:
*	@ MAKE DATE			: 2010.10.10
*	@ PROGRAM CONTENTS	: �������� ����ϴ� include ����
*
************************** �� �� �� �� *****************************************
* ��ȣ	�۾���		�۾���				���泻��
*	1	NICEPAY		2010.10.10			�������� ����ϴ� include ����
*-----  --------    ----------------    ----------------------------------------
*******************************************************************************/
%>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="org.apache.commons.codec.binary.Base64" %>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%!
/**
 * ���س�¥���� ���� ��,���� ��¥�� ���Ѵ�.
 * @param	sourceTS	���س�¥
 * @param	day			������ �ϼ�
 * @return	���س�¥���� �Է��� �ϼ��� ����� ��¥
 */
public static Timestamp getTimestampWithSpan(Timestamp sourceTS, long day) throws Exception {
	Timestamp targetTS = null;

	if (sourceTS != null) {
		targetTS = new Timestamp(sourceTS.getTime() + (day * 1000 * 60 * 60 * 24));
	}

	return targetTS;
}

/**
 * ���糯¥�� YYYYMMDDHHMMSS�� ����
 */
public final synchronized String getyyyyMMddHHmmss(){
	/** yyyyMMddHHmmss Date Format */
	SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");

	return yyyyMMddHHmmss.format(new Date());
}


public class DataEncrypt {
 MessageDigest md;
 String strSRCData = "";
 String strENCData = "";
 String strOUTData = "";


 public DataEncrypt() {}



public String encrypt(String strData) { // ��ȣȭ ��ų ������
  try {
   MessageDigest md = MessageDigest.getInstance("MD5"); // "MD5 �������� ��ȣȭ"
   md.reset();
   //byte[] bytData = strData.getBytes();
   //md.update(bytData);
   md.update(strData.getBytes());
    byte[] digest = md.digest();

  StringBuffer hashedpasswd = new StringBuffer();
    String hx;

    for (int i=0;i<digest.length;i++){
    	hx =  Integer.toHexString(0xFF & digest[i]);
    	//0x03 is equal to 0x3, but we need 0x03 for our md5sum
    	if(hx.length() == 1){hx = "0" + hx;}
    	hashedpasswd.append(hx);

    }
    strOUTData = hashedpasswd.toString();
    byte[] raw = strOUTData.getBytes();
    byte[] encodedBytes = Base64.encodeBase64(raw);
    strOUTData = new String(encodedBytes);
   }
   catch (NoSuchAlgorithmException e) {
   System.out.print("��ȣȭ ����" + e.toString());
  }


  return strOUTData;  // ��ȣȭ�� �����͸� ����...
 }

 public String SHA256(String strData) { // ��ȣȭ ��ų ������
  String SHA = "";
	try{
		MessageDigest sh = MessageDigest.getInstance("SHA-256");
		sh.update(strData.getBytes());
		byte byteData[] = sh.digest();
		StringBuffer sb = new StringBuffer();
		for(int i = 0 ; i < byteData.length ; i++){
			sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));

		}
		SHA = sb.toString();
		byte[] raw = SHA.getBytes();
    byte[] encodedBytes = Base64.encodeBase64(raw);
    SHA = new String(encodedBytes);
	}catch(NoSuchAlgorithmException e){
		e.printStackTrace();
		SHA = null;
	}
	return SHA;
	}


} // end class

public String SHA256Salt(String strData, String salt) { 
	  String SHA = "";
	  
	try {
		MessageDigest sh = MessageDigest.getInstance("SHA-256");
		sh.reset();
		sh.update(salt.getBytes());
		byte byteData[] = sh.digest(strData.getBytes());
		
		//Hardening against the attacker's attack
		sh.reset();
		byteData = sh.digest(byteData);
		
		StringBuffer sb = new StringBuffer();
		for(int i = 0 ; i < byteData.length ; i++){
			sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));

		}
		
		SHA = sb.toString();
		byte[] raw = SHA.getBytes();
		byte[] encodedBytes = Base64.encodeBase64(raw);
		SHA = new String(encodedBytes);
	} catch(NoSuchAlgorithmException e) {
		e.printStackTrace();
		SHA = null;
	}
	
	return SHA;
}

%>