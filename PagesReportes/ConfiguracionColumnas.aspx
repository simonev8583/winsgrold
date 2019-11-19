<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConfiguracionColumnas.aspx.cs" Inherits="SistemaGestionRedes.PagesReportes.ConfiguracionColumnas" %>

<%@ Register Assembly="SGR.DataAccessLayer" Namespace="SGR.DataAccessLayer" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    
    <script language="javascript" type="text/javascript">

        function cerrarWindow() {
            window.close();
        }

        function cerrarPorAceptar() {
            if (form1.chkCerrarAceptar.checked) {
                window.close();
            }
        }

    </script>


</head>
<body onload="cerrarPorAceptar()">
    <form id="form1" runat="server">
    <div>
    
        <table width="100%">
            <tr>
                <td colspan="3" align="center" class="EstiloTituloSeccion">
                    <asp:Label ID="Label1" runat="server" 
                        Text="<%$ Resources:TextConfigColumnas %>" Font-Size="12px"></asp:Label>
                    <asp:Label ID="lblNombreReporte" runat="server" Font-Size="12px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td width="40%">
                </td>
                <td width="30%">
                    <asp:CheckBoxList ID="ChkBoxColumnas" runat="server">
                    </asp:CheckBoxList>
                </td>
                <td align="center" width="30%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center" colspan="3">
                    <asp:Button ID="btnAceptar" runat="server" CssClass="TextBoton" 
                        Text="<%$ Resources:TextBotonAceptar %>" onclick="btnAceptar_Click" />

&nbsp;              <asp:Button ID="btnCancelar" runat="server" CssClass="TextBoton" Text="<%$ Resources:TextBotonCancelar %>" 
                        OnClientClick="cerrarWindow();" />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:CheckBox ID="chkCerrarAceptar" runat="server" ClientIDMode="Static" 
                        Visible="True" style="visibility:hidden" />
                    <br />
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
