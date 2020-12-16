var MadownObj = "";
MadownObj = MadownObj + "<OBJECT ";
MadownObj = MadownObj + "ID=\"Downloader\" ";
MadownObj = MadownObj + "CLASSID=\"CLSID:6FD1645E-19A2-4F4D-A721-535D2CD3F64A\" ";
MadownObj = MadownObj + "codebase=\"http://dev.front.hottracks.co.kr:80/cab/MAMEinsDownload.cab#version=1,2,2009,119\" ";
MadownObj = MadownObj + "width=\"0\" height=\"0\"></Object>";

function Set_MadownOCX()
{
	document.writeln(MadownObj);
}