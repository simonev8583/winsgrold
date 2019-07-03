<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeccionDActualizaciones.aspx.cs" Inherits="SistemaGestionRedes.SeccionDActualizaciones" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
   
    
</head>
<body >
    <form id="form1" runat="server">
    <div class="leftDivConf">
            <asp:Menu ID="menuSegundoNivel" runat="server"
             CssClass="menu" EnableViewState="true" IncludeStyleBlock="false" Orientation="Vertical">
                <Items>
                     <asp:MenuItem NavigateUrl="~/PagesUpdates/FWTFirmwareUpdating.aspx" Text=" <%$ Resources:TextActualizacionFw %>" Target="content"  />
                     <asp:MenuItem NavigateUrl="~/PagesUpdates/FirmwareStateReport.aspx" Text="Estado Actualización" Target="content"  />                    
                </Items>
            </asp:Menu>
    </div>
    </form>
</body>
</html>