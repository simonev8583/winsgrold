<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FWTOK.aspx.cs" Inherits="SistemaGestionRedes.FWTOK" %>

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
        <br />
        <!-- Se consultan los FWT que no tengan fallas propias-->
        <asp:SqlDataSource ID="SqDSFWTsOK" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString.ProviderName %>" SelectCommand="select Id , Serial, FechaInstalacion as [Fecha Instalacion], FechaRegistroGestion as [Fecha Registro], 
            ParamFWT_DireccionNomenclatura_CalleCarrera as [Direccion],
            ParamFWT_DireccionNomenclatura_Numero as [Numero],
            ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad],
            ParamFWT_DireccionElectrica_SubEstacion as [Subestacion],
            ParamFWT_DireccionElectrica_Circuito as [Circuito],
            ParamFWT_DireccionElectrica_Tramo as [Tramo]
            from FWTs
            where Serial not in 
            (
            select FWTs.Serial as [Serial] 
            FROM FWTs join AlarmasFWT on (FWTs.Id = AlarmasFWT.FWTId)
            join MtAlarmas on (AlarmasFWT.Id = MtAlarmas.Id)
            WHERE AlarmasFWT.ClearAlarma is null and
            MtAlarmas.OrigenAlarma = 'E'
            )
            order by Serial asc">
       </asp:SqlDataSource>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataKeyNames="Id" DataSourceID="SqDSFWTsOK" 
            Font-Names="Microsoft Sans Serif" Font-Size="Small" ForeColor="#333333" 
            GridLines="None" HorizontalAlign="Center" AllowPaging="True" 
            AllowSorting="True" Caption="Concentradores OK ">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Serial" HeaderText="Serial" InsertVisible="False" 
                    ReadOnly="True" SortExpression="Serial" />
                <asp:BoundField DataField="Fecha Instalacion" HeaderText="Fecha Instalacion" 
                    SortExpression="Fecha Instalacion" />
                <asp:BoundField DataField="Fecha Registro" HeaderText="Fecha Registro" 
                    SortExpression="Fecha Registro" />
                <asp:BoundField DataField="Direccion" HeaderText="Direccion" 
                    SortExpression="Direccion" />
                <asp:BoundField DataField="Numero" HeaderText="Numero" 
                    SortExpression="Numero" />
                <asp:BoundField DataField="Ciudad" HeaderText="Ciudad" 
                    SortExpression="Ciudad" />
                <asp:BoundField DataField="Subestacion" HeaderText="Subestacion" 
                    SortExpression="Subestacion" />
                <asp:BoundField DataField="Circuito" HeaderText="Circuito" 
                    SortExpression="Circuito" />
                <asp:BoundField DataField="Tramo" HeaderText="Sección Cercana" SortExpression="Tramo" />
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
    </div>
    </form>
</body>
</html>
