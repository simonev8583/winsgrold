<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="seccionC.aspx.cs" Inherits="SistemaGestionRedes.seccionC" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

</head>
<body class="leftBody" >
    <form id="form1" runat="server">
    
  
        <div class="leftDiv">
            
                <table width="20%">
                    <tr>
                        <td width="10%">
            
                <asp:ImageButton ID="butRefresh" runat="server" Height="30px" Width="30px" OnClick="butRefresh_Click"
                    ToolTip="Refresh" ImageUrl="~/Images/refresh.jpg" ImageAlign="AbsMiddle" />
                        </td>
                        <td width="10%">
                <asp:ImageButton ID="butConnectDataBase" runat="server" Height="30px" Width="30px"
                    ToolTip="Connect Database" ImageUrl="~/Images/ConnectDataBase.JPG" ImageAlign="AbsMiddle"
                    OnClick="butConnectDataBase_Click" />
           
                        </td>
                    </tr>
                    <!--<tr>
                        <td colspan="2" width="20%">
                            <asp:CheckBox ID="chkVisualizarCodigosCorporativos" runat="server" 
                                AutoPostBack="True" 
                                oncheckedchanged="chkVisualizarCodigosCorporativos_CheckedChanged" 
                                Text="<%$ Resources:TextVerCodigos %>" 
                                ToolTip="<%$ Resources:TextVerCodigosToolTip %>" 
                                Font-Size="10px" ForeColor="Black" />
                        </td>
                    </tr>-->
                </table>
           
                <!-- Representa la sección C Arbol de Navegación-->
                <asp:TreeView ID="treeSistema" runat="server" ImageSet="Simple" NodeIndent="10" Width="118px" ViewStateMode="Enabled" OnSelectedNodeChanged="treeSistema_SelectedNodeChanged" ForeColor="White">
                    <HoverNodeStyle Font-Underline="False" ForeColor="White" />
                    <LeafNodeStyle ForeColor="White" />
                    <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="White" HorizontalPadding="0px" NodeSpacing="0px" VerticalPadding="0px" />
                    <ParentNodeStyle Font-Bold="True" ForeColor="White" />
                    <RootNodeStyle ForeColor="White" />
                    <SelectedNodeStyle Font-Underline="True" ForeColor="White" HorizontalPadding="0px" VerticalPadding="0px" />
                    
                </asp:TreeView>
                <br />
                <asp:Label ID="lblErrorConnectionBaseDatos" runat="server" Visible="False" Font-Bold="True"
                    ForeColor="Red"></asp:Label>
            
        </div>

    
    </form>
</body>
</html>
