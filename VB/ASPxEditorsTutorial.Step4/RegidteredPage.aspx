﻿<%@ Page Language="vb" AutoEventWireup="true" CodeBehind="RegidteredPage.aspx.vb"
	Inherits="ASPxEditorsTutorial.RegidteredPage" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
</head>
<body>
	<form id="form1" runat="server">
	<div style="text-align: center">
		<h1>You have been registered successfully!</h1>
		<dx:ASPxHyperLink ID="hyperLinkUsersPage" runat="server" Text="Check users list"
			NavigateUrl="UsersList.aspx">
		</dx:ASPxHyperLink>
		<br />
		<dx:ASPxHyperLink ID="hyperLinkRegForm" runat="server" Text="Try again" NavigateUrl="RegistrationForm.aspx">
		</dx:ASPxHyperLink>
	</div>
	</form>
</body>
</html>