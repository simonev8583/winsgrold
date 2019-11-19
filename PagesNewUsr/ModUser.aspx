<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModUser.aspx.cs" Inherits="SistemaGestionRedes.PagesNewUsr.ModUser"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <title></title>
    <style type="text/css">
        .style2
        {
            height: 23px;
        }
    </style>
</head>

<script language="javascript" type="text/javascript" >

    function confirmar_borrar() {
        if (confirm('Desea borrar el usuario ' + form1.DDListUsers.value + ' ?')) {
            return true;
        }
        else {
            return false;
        }
    }

    function confirmar_borrar_en() {
        if (confirm('Do you really want to delete the user ' + form1.DDListUsers.value + ' ?')) {
            return true;
        }
        else {
            return false;
        }
    }
   

</script>

<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        <table width="100%">
            <tr>
                <td align="center" width="100%" colspan="3">
                    <asp:Label ID="lblTitulo" runat="server" Font-Bold="True" 
                        Font-Names="Microsoft Sans Serif" Font-Size="16px" 
                        Text="<%$ Resources:TextPagina %>"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center" width="100%" colspan="3">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    <asp:Label ID="lblUsers" runat="server" Font-Bold="True" 
                        Font-Names="Microsoft Sans Serif" Font-Size="Small" Text="<%$ Resources:TextLblUsuarios %>"></asp:Label>
                </td>
                <td colspan="2" width="50%">
                    <asp:DropDownList ID="DDListUsers" runat="server" AutoPostBack="True" 
                        DataSourceID="SqlDSAllUsers" DataTextField="userName" DataValueField="userName" 
                        Font-Names="Microsoft Sans Serif" Font-Size="12px" 
                        onselectedindexchanged="DDListUsers_SelectedIndexChanged" 
                        ondatabound="DDListUsers_DataBound">
                    </asp:DropDownList>
                &nbsp;
                    <asp:Label ID="lblMsgSUs" runat="server" Font-Names="Microsoft Sans Serif" 
                        Font-Size="10px" Text="<%$ Resources:TextOtrosUsrsAdmins %>"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    &nbsp;</td>
                <td colspan="2" width="50%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    <asp:Label ID="lblUser" runat="server" Font-Bold="True" 
                        Font-Names="Microsoft Sans Serif" Font-Size="Small" Text="<%$ Resources:TextLblUsuario %>"></asp:Label>
                </td>
                <td width="15%">
                    <asp:Label ID="lblUserSelected" runat="server" Font-Bold="False" 
                        Font-Italic="True" Font-Names="Microsoft Sans Serif" Font-Size="Small"></asp:Label>
                </td>
                <td width="35%">
                    <asp:Button ID="btnBorrar" runat="server" Font-Names="Microsoft Sans Serif" 
                        Font-Size="11px" Text="<%$ Resources:TextBotonEliminar %>" 
                        OnClientClick="return confirmar_borrar();" onclick="btnBorrar_Click" />
                &nbsp;</td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    <asp:Label ID="lblEstadoUsr" runat="server" Font-Bold="True" 
                        Font-Names="Microsoft Sans Serif" Font-Size="Small" Text="<%$ Resources:TextLblEstado %>"></asp:Label>
                </td>
                <td colspan="1" width="15%">
                    <asp:Label ID="lblEstadoActualUsr" runat="server" Font-Bold="False" 
                        Font-Italic="True" Font-Names="Microsoft Sans Serif" Font-Size="Small"></asp:Label>
                </td>
                <td width="35%">
                    <asp:Button ID="btnBloquear" runat="server" Font-Names="Microsoft Sans Serif" 
                        Font-Size="11px" Text="<%$ Resources:TextBotonBloquear %>" onclick="btnBloquear_Click" />
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    <asp:Label ID="lblTipoUsr" runat="server" Font-Bold="True" 
                        Font-Names="Microsoft Sans Serif" Font-Size="Small" Text="<%$ Resources:TextLblTipoUsuario %>"></asp:Label>
                </td>
                <td colspan="1" width="15%">
                    <asp:DropDownList ID="DDListTiposUsuario" runat="server" 
                        Font-Names="Microsoft Sans Serif" Font-Size="12px" 
                        DataSourceID="SqlDSRoles" DataTextField="RoleNameVisual" 
                        DataValueField="RoleName" AutoPostBack="True" 
                        onselectedindexchanged="DDListTiposUsuario_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td width="35%">
                    <asp:Button ID="btnCambiar" runat="server" Font-Names="Microsoft Sans Serif" 
                        Font-Size="11px" onclick="btnCambiar_Click" Text="Cambiar" 
                        Enabled="False" />
                &nbsp;<asp:Label ID="lblRolOriginal" runat="server" Font-Bold="False" 
                        Font-Italic="True" Font-Names="Microsoft Sans Serif" Font-Size="Small" 
                        Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    &nbsp;</td>
                <td colspan="2" width="50%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center" colspan="3" width="100%">
                    <asp:Label ID="lblMsgBorrarUsuario" runat="server" 
                        Font-Names="Microsoft Sans Serif" Font-Size="11px" Visible="False"></asp:Label>
                    <br />
                    <asp:Label ID="lblMsgCambiarUsr" runat="server" 
                        Font-Names="Microsoft Sans Serif" Font-Size="11px" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="3" width="100%">
                    <asp:SqlDataSource ID="SqlDSAllUsers" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" >
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDSRoles" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                        SelectCommand="select MtRolesLenguajes.RoleNameVisual, aspnet_Roles.RoleName
                                from aspnet_Roles join MtRolesLenguajes on (aspnet_Roles.RoleId = MtRolesLenguajes.RoleId)
                                where MtRolesLenguajes.Codlang = @IdLang
                                order by aspnet_Roles.RoleName asc">
                        <SelectParameters>
                            <asp:Parameter Name="IdLang" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
