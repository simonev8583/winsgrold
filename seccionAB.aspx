<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="seccionAB.aspx.cs" Inherits="SistemaGestionRedes.seccionAB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Use IE7 mode -->
    <%--<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />--%>
    <link href="/Styles/Site.css" rel="stylesheet" type="text/css" />
    <title></title>
    
 </head>
<body class="bodyColorSeccionAB">
    <form id="form1" runat="server">
    <div class ="centerDivHeader">
      <!-- Seccion B Menu Primer Nivel -->
        <div class="leftColumn">
            <asp:Menu ID="menuPrimerNivel" runat="server" 
                EnableViewState="true" IncludeStyleBlock="false" Orientation="Horizontal" 
                CssClass="menu" >
                          
                <Items>
                    <asp:MenuItem NavigateUrl="~/EquiposFrames.htm" Text="<%$ Resources:TextEquipos %>"   Target="middle" />
                    <%--Ojo, la siguiente opcion se elimina en el CodeBehind de esta página...--%>
                    <asp:MenuItem NavigateUrl="~/ConfiguracionesFrames.htm" Text="<%$ Resources:TextConfiguracion %>" Target="middle" />
                    <asp:MenuItem NavigateUrl="~/ReportesFrames.htm" Text="<%$ Resources:TextReportes %>" Target="middle" />
                    <%--<asp:MenuItem Text="Reportes">
                        <asp:MenuItem Text="Historial Alarmas FCI/SIX" Value="Historial Alarmas FCI/SIX"></asp:MenuItem>
                        <asp:MenuItem Text="Estadisticas FCI" Value="Estadisticas FCI"></asp:MenuItem>
                        <asp:MenuItem Text="Estadisticas SIX" Value="Estadisticas SIX"></asp:MenuItem>
                    </asp:MenuItem>--%>
                    <asp:MenuItem NavigateUrl="~/ComunicacionesFrames.htm" Text="<%$ Resources:TextComunicaciones %>" Target="middle"/>
                    <asp:MenuItem NavigateUrl="~/ActualizacionesFrames.htm" Text="<%$ Resources:TextActualizaciones %>" Target="middle"/>
                    <asp:MenuItem NavigateUrl="~/SeguridadFrames.htm" Text="<%$ Resources:TextSeguridad %>" Target="middle"/>
                </Items>
            </asp:Menu>
          
        </div >

   
        <div class="rightColumn">
             
         <table border="0" cellpadding="5" cellspacing="1">
             <tr>
                 <td valign="middle" >
                     <asp:LoginStatus ID="LoginStSalir" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small" Font-Underline="False" 
                         LogoutAction="RedirectToLoginPage" LogoutText="<%$ Resources:TextCerrarSesion %>"
                         Font-Bold="True" ForeColor="Black" />
                 </td>
             </tr>
         </table>
           
        
             </div>
   
   
    </div>
    </form>
</body>
</html>
