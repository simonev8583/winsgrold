<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FWTsAll.aspx.cs" Inherits="SistemaGestionRedes.FWTsAll" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="rightDiv">
        <!-- Aqui se visualizaran todos los FWT instalados  -->
        <asp:SqlDataSource ID="SqDSFWTAll" runat="server" ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>"
            ProviderName="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString.ProviderName %>"
            SelectCommand="select Id, 
Serial, 
Codigo,
FechaInstalacion, 
FechaRegistroGestion, 
ParamFWT_DireccionNomenclatura_CalleCarrera,
ParamFWT_DireccionNomenclatura_Numero,
ParamFWT_DireccionNomenclatura_Ciudad,
ParamFWT_DireccionElectrica_SubEstacion,
ParamFWT_DireccionElectrica_Circuito,
ParamFWT_DireccionElectrica_Tramo,
ParamFWT_DireccionElectrica_Nodo,
VersionPrograma,
ASDU
from FWTs
order by Id asc"></asp:SqlDataSource>
        <asp:GridView ID="GVFWTs" runat="server" AutoGenerateColumns="False" Caption="<%$ Resources:TextoCaptionGV %>"
            CaptionAlign="Top" CellPadding="4" DataKeyNames="Id" DataSourceID="SqDSFWTAll"
            Font-Italic="False" Font-Names="Microsoft Sans Serif" 
            Font-Overline="False" Font-Size="11px"
            Font-Underline="False" ForeColor="#333333" GridLines="None" 
            HorizontalAlign="Center" AllowSorting="True" Font-Bold="False">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="EditFWT.aspx?Id={0}"
                    DataTextField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" />

                <asp:BoundField DataField="Codigo" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" SortExpression="Codigo" />

                <asp:BoundField DataField="FechaInstalacion" HeaderText="<%$ Resources:TextosGlobales,TextoFechaInstalacion %>" SortExpression="FechaInstalacion" />

                <asp:BoundField DataField="FechaRegistroGestion" HeaderText="<%$ Resources:TextosGlobales,TextoFechaRegistro %>" SortExpression="FechaRegistroGestion" />
                
                <asp:BoundField DataField="ParamFWT_DireccionNomenclatura_CalleCarrera" HeaderText="<%$ Resources:TextosGlobales,TextoCalleKra %>"
                    SortExpression="ParamFWT_DireccionNomenclatura_CalleCarrera" />
                
                <asp:BoundField DataField="ParamFWT_DireccionNomenclatura_Numero" HeaderText="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>"
                    SortExpression="ParamFWT_DireccionNomenclatura_Numero" />
                
                <asp:BoundField DataField="ParamFWT_DireccionNomenclatura_Ciudad" HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>"
                    SortExpression="ParamFWT_DireccionNomenclatura_Ciudad" />
                
                <asp:BoundField DataField="ParamFWT_DireccionElectrica_SubEstacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>"
                    SortExpression="ParamFWT_DireccionElectrica_SubEstacion" />
                
                <asp:BoundField DataField="ParamFWT_DireccionElectrica_Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>"
                    SortExpression="ParamFWT_DireccionElectrica_Circuito" />
                
                <asp:BoundField DataField="ParamFWT_DireccionElectrica_Tramo" HeaderText="<%$ Resources:TextosGlobales,TextoSeccionTramo %>"
                    SortExpression="ParamFWT_DireccionElectrica_Tramo" />

                <asp:BoundField DataField="ParamFWT_DireccionElectrica_Nodo" HeaderText="<%$ Resources:TextosGlobales,TextoNodo %>"
                    SortExpression="ParamFWT_DireccionElectrica_Nodo" />

                <asp:BoundField DataField="VersionPrograma" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>"
                    SortExpression="VersionPrograma" />

                <asp:BoundField DataField="ASDU" HeaderText="<%$ Resources:TextosGlobales,TextoASDU %>"
                    SortExpression="ASDU" />

            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F8FAFA" />
            <SortedAscendingHeaderStyle BackColor="#246B61" />
            <SortedDescendingCellStyle BackColor="#D4DFE1" />
            <SortedDescendingHeaderStyle BackColor="#15524A" />
        </asp:GridView>
    </div>

    </form>
</body>
</html>
