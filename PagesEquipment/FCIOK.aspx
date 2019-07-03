<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FCIOK.aspx.cs" Inherits="SistemaGestionRedes.FCIOK" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="rightDiv">
     <br />
        <asp:SqlDataSource ID="SqDSFCIsOK" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString.ProviderName %>" SelectCommand="
            select Id, Serial , 
            FWTId as [FWT], 
            FechaInstalacion as [Fecha Instalacion], 
            FechaRegistroGestion as [Fecha Registro], 
            case TipoCircuito
            when 1 then 'Monofásico'
            when 2 then 'Bifásico'
            when 3 then 'Trifásico'
            end as [TipoCircuito]
            from FCIs
            where Serial not in
            (
            select FCIs.Serial as [Serial] 
            FROM FCIs left outer join FWTs on (FCIs.FWTId = FWTs.Id)
            join AlarmasFCI on (FCIs.Id = AlarmasFCI.FCIId)
            join MtAlarmas on (AlarmasFCI.Id = MtAlarmas.Id)
            WHERE AlarmasFCI.ClearAlarma is null and
            MtAlarmas.OrigenAlarma = 'E'
            )
            order by Serial asc">
</asp:SqlDataSource>
        <br />
        <asp:GridView ID="GVFCIsOK" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataKeyNames="Id" DataSourceID="SqDSFCIsOK" 
            Font-Names="Microsoft Sans Serif" Font-Size="Small" ForeColor="#333333" 
            GridLines="None" HorizontalAlign="Center" AllowPaging="True" 
            AllowSorting="True" Caption="FCIs OK">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Serial" HeaderText="Serial" InsertVisible="False" 
                    ReadOnly="True" SortExpression="Serial" />
                <asp:BoundField DataField="FWT" HeaderText="FWT" SortExpression="FWT" />
                <asp:BoundField DataField="Fecha Instalacion" HeaderText="<%$ Resources:TextFechaInstalacion %>" 
                    SortExpression="Fecha Instalacion" />
                <asp:BoundField DataField="Fecha Registro" HeaderText="<%$ Resources:TextFechaRegistro %>" 
                    SortExpression="Fecha Registro" />
                <asp:BoundField DataField="TipoCircuito" HeaderText="<%$ Resources:TextTipoCircuito %>" 
                    SortExpression="TipoCircuito" />
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
