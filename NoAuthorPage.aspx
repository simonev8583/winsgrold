<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoAuthorPage.aspx.cs" Inherits="SistemaGestionRedes.ErrorPages.NoAuthorPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        <table width="100%">
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblMensajeError" runat="server" Font-Bold="True" 
                        Font-Names="Microsoft Sans Serif" Font-Size="14px" 
                        Text="<%$ Resources:TextNoPermitido %>"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
    
    </div>
    </form>
</body>
</html>
