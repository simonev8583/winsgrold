<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FCIFault.aspx.cs" Inherits="SistemaGestionRedes.FCIFault" %>

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
    
<asp:SqlDataSource ID="SqDSDatosAll" runat="server" 
     ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
     ProviderName="System.Data.SqlClient" SelectCommand="select FCIs.Id as [FCI], FCIs.Serial as [Serial] ,
FWTs.Id as [FWT],
FWTs.Serial as [SerialFWT], 
FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Direccion],
FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion],
FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
MtAlarmas_Lenguaje.Nombre as [Alarma],
AlarmasFCI.Fecha as [Fecha]
FROM FCIs left outer join FWTs on (FCIs.FWTId = FWTs.Id)
join AlarmasFCI on (FCIs.Id = AlarmasFCI.FCIId)
join MtAlarmas on (AlarmasFCI.Id = MtAlarmas.Id)
join MtAlarmas_Lenguaje on (MtAlarmas.Id = MtAlarmas_Lenguaje.Id)
join MtLenguajes on (MtLenguajes.Id = MtAlarmas_Lenguaje.Lang)
WHERE AlarmasFCI.ClearAlarma is null and
MtAlarmas.OrigenAlarma = 'E' and
MtLenguajes.Cod = @IdLang" >
             <SelectParameters>
                 <asp:Parameter Name="IdLang" />
             </SelectParameters>
</asp:SqlDataSource>

        <asp:SqlDataSource ID="SqDSDatosFCIdeFWT" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            ProviderName="System.Data.SqlClient" 
            SelectCommand="select FCIs.Id as [FCI], FCIs.Serial as [Serial] ,FWTs.Id as [FWT], 
FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Direccion], FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion], 
FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito], MtAlarmas_Lenguaje.Nombre as [Alarma],
AlarmasFCI.Fecha as [Fecha] 
FROM FCIs join FWTs on (FCIs.FWTId = FWTs.Id) 
join AlarmasFCI on (FCIs.Id = AlarmasFCI.FCIId) 
join MtAlarmas on (AlarmasFCI.Id = MtAlarmas.Id)
join MtAlarmas_Lenguaje on (MtAlarmas.Id = MtAlarmas_Lenguaje.Id)
join MtLenguajes on (MtLenguajes.Id = MtAlarmas_Lenguaje.Lang) 
WHERE AlarmasFCI.ClearAlarma is null and MtAlarmas.OrigenAlarma = 'E' 
and FWTs.Id = @param_id
and MtLenguajes.Cod = @IdLang ">
            <SelectParameters>
                <asp:ControlParameter ControlID="DDListFWTs" DefaultValue="2" Name="param_id" 
                    PropertyName="SelectedValue" Type="String" />
                <asp:Parameter Name="IdLang" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:SqlDataSource ID="SqDSFiltroFWTs" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString.ProviderName %>" 
            SelectCommand="select FWTs.Id as [Id], FWTs.Serial as [Serial] from FWTs order by Descripcion asc">
        </asp:SqlDataSource>
        <br />
        <br />
        <div class="centerDiv" >
            <center>
                <asp:Label ID="Label1" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small"
                    Text="<%$ Resources:TextosGlobales,TextoSerialFWT %>"></asp:Label>:
                &nbsp;&nbsp;
                <asp:DropDownList ID="DDListFWTs" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                    DataSourceID="SqDSFiltroFWTs" DataTextField="Serial" DataValueField="Id" Font-Names="Microsoft Sans Serif"
                    Font-Size="X-Small" OnSelectedIndexChanged="DDListFWTs_SelectedIndexChanged"
                    Width="83px">
                    <asp:ListItem Selected="True" Value="0" Text="<%$ Resources:TextListItemTodos %>" ></asp:ListItem>
                </asp:DropDownList>
            </center>
        </div >
        <br />
        <br />
        <br />
        <asp:GridView ID="GVFallasEquFCIs" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
            DataSourceID="SqDSDatosAll" Font-Names="Microsoft Sans Serif" Font-Size="Small" 
            ForeColor="#333333" GridLines="None" HorizontalAlign="Center" 
            ondatabound="GVFallasEquFCIs_DataBound" 
            Caption="<%$ Resources:TextTittleGridViewPpal %>">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="FCI" 
                    DataNavigateUrlFormatString="EditFCI.aspx?Id={0}" DataTextField="Serial" 
                    HeaderText="FCI" />
                <asp:HyperLinkField DataNavigateUrlFields="FWT" 
                    DataNavigateUrlFormatString="EditFWT.aspx?Id={0}" DataTextField="SerialFWT" 
                    HeaderText="FWT" />
                <asp:BoundField DataField="Direccion" HeaderText="<%$ Resources:TextosGlobales,TextoCalleKra %>" 
                    SortExpression="Direccion" />
                <asp:BoundField DataField="SubEstacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" 
                    SortExpression="SubEstacion" />
                <asp:BoundField DataField="Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" 
                    SortExpression="Circuito" />
                <asp:BoundField DataField="Alarma" HeaderText="<%$ Resources:TextosGlobales,TextoFalla %>" 
                    SortExpression="Alarma" />
                <asp:BoundField DataField="Fecha" HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>" SortExpression="Fecha" />
            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#0b304f" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F8FAFA" />
            <SortedAscendingHeaderStyle BackColor="#246B61" />
            <SortedDescendingCellStyle BackColor="#D4DFE1" />
            <SortedDescendingHeaderStyle BackColor="#15524A" />
        </asp:GridView>
        <br />
        <center>
        <asp:Label ID="LblMsgNoData" runat="server" Font-Bold="True" 
            Font-Names="Microsoft Sans Serif" Font-Size="Large" 
            Text="<%$ Resources:TextTittleNoHayData %>" Visible="False"></asp:Label>
        </center>
    </div>
    </form>
</body>
</html>
