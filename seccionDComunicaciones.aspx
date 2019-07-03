<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="seccionDComunicaciones.aspx.cs" Inherits="SistemaGestionRedes.seccionDComunicaciones" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
   
 
</head>
<body  >
    <form id="form1" runat="server">
    <div class="leftDivWhite">
           <asp:Menu ID="menuSegundoNivel" runat="server" CssClass="menu" EnableViewState="true"
                IncludeStyleBlock="false" Orientation="Vertical">
                <Items>
                    <asp:MenuItem NavigateUrl="~/PagesCommunications/ActualCommunications.aspx" Text=" <%$ Resources:TextItemComunicaciones %> " target="content"/>
                    <asp:MenuItem NavigateUrl="~/PagesCommunications/FwtConnectionsState.aspx" Text=" <%$ Resources:TextItemFwtComunicaciones %> " target="content"/>
                    <asp:MenuItem NavigateUrl="~/PagesCommunications/FwtAvailability.aspx" Text=" <%$ Resources:TextItemFwtAvailability %> " target="content"/>
                </Items>
            </asp:Menu>
    </div>
    </form>
</body>
</html>
