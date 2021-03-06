<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeccionDSeguridad.aspx.cs" Inherits="SistemaGestionRedes.SeccionDSeguridad" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
   
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

</head>
<body >
    <form id="form1" runat="server">
    <div class="leftDivConf">
            <asp:Menu ID="menuSegundoNivel" runat="server" CssClass="menu" EnableViewState="false"
                IncludeStyleBlock="false" Orientation="Vertical">
                <Items>
                     <asp:MenuItem NavigateUrl="~/PagesSecurity/ChangePassword.aspx" Text="<%$ Resources:TextCambiarPassword %>" Target="content"  />
                     <asp:MenuItem NavigateUrl="~/PagesNewUsr/NewUser.aspx" Text="<%$ Resources:TextNuevoUsuario %>" Target="content"  />
                     <asp:MenuItem NavigateUrl="~/PagesNewUsr/ModUser.aspx" Text="<%$ Resources:TextModificarUsuario %>" Target="content"  />
                </Items>
            </asp:Menu>
    </div>
    </form>
</body>
</html>