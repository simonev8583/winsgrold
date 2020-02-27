<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ActualCommunications.aspx.cs" Inherits="SistemaGestionRedes.ActualCommunications" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <title></title>
</head>
<body>
    <form id="frmComAct" runat="server">

    <div class="rightDiv">
       
       
       
        <br />
        <br />
          <!-- Necesario para que se actualice solo esta Zona -->
        <asp:UpdatePanel runat="server" id="UpdatePanel1" UpdateMode="Conditional">

        <contenttemplate>

        <div class="centerDiv" align="center">
            <asp:GridView ID="GridViewComAct" runat="server" AutoGenerateColumns="False" CellPadding="5"
                DataKeyNames="Id" DataSourceID="SqlDSConexionesActuales" ForeColor="#333333"
                GridLines="None" Caption="<%$ Resources:TextCaptionGV %>" AllowPaging="True" 
                AllowSorting="True" ondatabound="GridViewComAct_DataBound" CellSpacing="5">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="EndPointConexion" HeaderText="<%$ Resources:TextColumnaDirIP %>" SortExpression="EndPointConexion" />
                    <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="~/PagesEquipment/EditFWT.aspx?Id={0}"
                        DataTextField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" Target="_self" />
                    <asp:TemplateField HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>"
                                    SortExpression="Fecha">
                                    <ItemTemplate>                                        
                                        <asp:Label ID="lblFecha" runat="server" Text='<%# string.Format("{0:dd-MM-yyyy HH:mm:ss}",Convert.ToDateTime(Eval("Fecha")).AddHours(0))%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                    <asp:BoundField DataField="Direccion" HeaderText="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>"
                        SortExpression="Direccion" />
                    <asp:BoundField DataField="ParamFWT_DireccionNomenclatura_Ciudad" 
                        HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="ParamFWT_DireccionNomenclatura_Ciudad" />
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#0b304f" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" /> 
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDSConexionesActuales" runat="server" ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>"
                SelectCommand="SELECT ConexionesFWT.EndPointConexion, FWTs.Id, FWTs.Serial , ConexionesFWT.Fecha, FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera + ' '
                +   FWTs.ParamFWT_DireccionNomenclatura_Numero as [Direccion] , FWTs.ParamFWT_DireccionNomenclatura_Ciudad  FROM ConexionesFWT INNER JOIN FWTs ON ConexionesFWT.FWT_Id = FWTs.Id">
            </asp:SqlDataSource>
        </div>

        <center> <asp:Label ID="LblComAct" runat="server" Text="<%$ Resources:TextMsgNoHayConexiones %>" CssClass="labelTitulo" Visible="false"></asp:Label>
        </center>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Timer ID="tmrComAct" runat="server" Interval="2000" OnTick="tmrComAct_Tick">
        </asp:Timer>

        </contenttemplate>
           </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
