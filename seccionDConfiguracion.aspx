<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="seccionDConfiguracion.aspx.cs" Inherits="SistemaGestionRedes.seccionDConfiguracion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
                    <asp:MenuItem NavigateUrl="~/PagesConfiguration/NewTemplateFWT.aspx" Text="Nueva Plantilla Concentrador" Target="content" />
                    <asp:MenuItem NavigateUrl="~/PagesConfiguration/NewTemplateFCI.aspx" Text="Nueva Plantilla FCI" Target="content" />
                    <asp:MenuItem NavigateUrl="~/PagesConfiguration/TemplatesFWT.aspx" Text="Plantillas Concentrador" Target="content"  />
                    <asp:MenuItem NavigateUrl="~/PagesConfiguration/TemplatesFCI.aspx" Text="Plantillas FCI" Target="content" />
                    <asp:MenuItem NavigateUrl="~/PagesConfiguration/Alarms.aspx" Text="Configuración Alarmas" Target="content" />
                 
                    
                </Items>
            </asp:Menu>
    </div>
    </form>
</body>
</html>
