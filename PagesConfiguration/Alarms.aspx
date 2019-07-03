<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Alarms.aspx.cs" Inherits="SistemaGestionRedes.PagesConfiguration.Alarms" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
            <asp:SqlDataSource ID="SqDSMtAlarmas" runat="server" ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>"
            ProviderName="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString.ProviderName %>"
            SelectCommand="SELECT    Id, Nombre, Biestable, ClearedBy,  
            case TipoEquipo
                when 'A' then 'FCI'
                when 'B' then 'FWT'
            end as [TipoEquipo]
            , 
            case OrigenAlarma
                when 'C' then 'Circuito'
                when 'E' then 'Equipo'
            end as [OrigenAlarma]
            
            FROM MtAlarmas Order by TipoEquipo "></asp:SqlDataSource>
            
        <asp:GridView ID="GVAlarmas" runat="server" AutoGenerateColumns="False" Caption="Alarmas Configuradas"
            CaptionAlign="Top" CellPadding="4" DataKeyNames="Id" DataSourceID="SqDSMtAlarmas"
            Font-Italic="False" Font-Names="Microsoft Sans Serif" Font-Overline="False" Font-Size="Small"
            Font-Underline="False" ForeColor="#333333" GridLines="None" HorizontalAlign="Center"
            AllowPaging="True" AllowSorting="True" Font-Bold="False" PageSize="15">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" 
                    SortExpression="Nombre" />
                <asp:BoundField DataField="Biestable" HeaderText="Biestable" 
                    SortExpression="Biestable" />
                <asp:BoundField DataField="ClearedBy" HeaderText="Clear by " 
                    SortExpression="ClearedBy" />
                <asp:BoundField DataField="TipoEquipo" HeaderText="TipoEquipo" 
                    SortExpression="TipoEquipo" />
                <asp:BoundField DataField="OrigenAlarma" HeaderText="OrigenAlarma" 
                    SortExpression="OrigenAlarma" />
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



    <div>
    
    </div>
    </form>
</body>
</html>
