<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="seccionDReportes.aspx.cs" Inherits="SistemaGestionRedes.seccionDReportes" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
  
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
</head>
<body  >
    <form id="form1" runat="server">
    <div class="leftDivWhite">
             <asp:Menu ID="menuSegundoNivel" runat="server" CssClass="menu" EnableViewState="false"
                IncludeStyleBlock="false" Orientation="Vertical">
                <Items>
                    <asp:MenuItem NavigateUrl="~/PagesReportes/Historial.aspx" Text="" Target="content"/>
                    <asp:MenuItem NavigateUrl="~/PagesReportes/Statistics.aspx" Text="<%$ Resources:TextFCIStatistics %>" Target="content"/>
                    <asp:MenuItem NavigateUrl="~/PagesReportes/StatisticsSix.aspx" Text="<%$ Resources:TextSIXStatistics %>" Target="content" />
                    <asp:MenuItem NavigateUrl="~/PagesReportes/CurrentStatistics.aspx" Text="<%$ Resources:TextLogCorrientesFCI %>" Target="content"/>
                    <asp:MenuItem NavigateUrl="~/PagesReportes/CurrentStatisticsSix.aspx" Text="<%$ Resources:TextLogCorrientesSIX %>" Target="content"/>
                    <asp:MenuItem NavigateUrl="~/PagesReportes/CurrentStatisticsArix.aspx" Text="<%$ Resources:TextLogCorrientesARIX %>" Target="content"/>
                    <asp:MenuItem NavigateUrl="~/PagesReportes/HistorialFWT.aspx" Text="<%$ Resources:TextHistorialFallasFWT %>" Target="content"/>
                    <asp:MenuItem NavigateUrl="~/PagesReportes/HistorialStateFWT.aspx" Text="<%$ Resources:TextEstadosFWT %>" Target="content"/>
                    <asp:MenuItem NavigateUrl="~/PagesReportes/InfoHardwareArix.aspx" Text="<%$ Resources:TextInfoHardware %>" Target="content"/>
                    <asp:MenuItem NavigateUrl="~/PagesReportes/ArixEvent.aspx" Text="<%$ Resources:TextArixEvent %>" Target="content"/>
                </Items>
            </asp:Menu>
    </div>
    </form>
</body>
</html>
