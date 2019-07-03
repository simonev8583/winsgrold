<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FWTFault.aspx.cs" Inherits="SistemaGestionRedes.FWTFault" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="rightDiv">
    
        <asp:SqlDataSource ID="SqDSDatosAll" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            ProviderName="System.Data.SqlClient" SelectCommand="select FWTs.Id as [FWT], FWTs.Serial as [Serial] ,
        FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Direccion],
        FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion],
        FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
        MtAlarmas_Lenguaje.Nombre as [Alarma], AlarmasFWT.Valor as [Valor] ,
        AlarmasFWT.Fecha as [Fecha]
        FROM FWTs join AlarmasFWT on (FWTs.Id = AlarmasFWT.FWTId)
        join MtAlarmas on (AlarmasFWT.Id = MtAlarmas.Id)
        join MtAlarmas_Lenguaje on (MtAlarmas.Id = MtAlarmas_Lenguaje.Id)
        join MtLenguajes on (MtAlarmas_Lenguaje.Lang = MtLenguajes.Id)
        WHERE AlarmasFWT.ClearAlarma is null 
        and MtAlarmas.OrigenAlarma = 'E' 
        and MtLenguajes.Cod = @IdLang
        ORDER BY Fecha DESC">
        <SelectParameters>
                 <asp:Parameter Name="IdLang" />
         </SelectParameters>
</asp:SqlDataSource>
        <br />
        <br />
        <asp:GridView ID="GVFallasEquFWTs" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" CellPadding="5" 
                Font-Names="Microsoft Sans Serif" Font-Size="Small" 
            ForeColor="#333333" GridLines="None" HorizontalAlign="Center" 
            ondatabound="GVFallasEquFWTs_DataBound" 
                Caption="<%$ Resources:TextoCaptionGV %>" CellSpacing="5" 
                DataSourceID="SqDSDatosAll">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="FWT" 
                    DataNavigateUrlFormatString="EditFWT.aspx?Id={0}" DataTextField="Serial" 
                    HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" />
                <asp:BoundField DataField="Direccion" HeaderText="<%$ Resources:TextosGlobales,TextoCalleKra %>" 
                    SortExpression="Direccion" />
                <asp:BoundField DataField="SubEstacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" 
                    SortExpression="SubEstacion" />
                <asp:BoundField DataField="Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" 
                    SortExpression="Circuito" />
                <asp:BoundField DataField="Alarma" HeaderText="<%$ Resources:TextosGlobales,TextoFalla %>" 
                    SortExpression="Alarma" />
                <asp:BoundField DataField="Valor" HeaderText="<%$ Resources:TextosGlobales,TextoGenericoValor %>" SortExpression="Valor" />
                <asp:BoundField DataField="Fecha" HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>" SortExpression="Fecha" />
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
        <br />
        <center>
        <asp:Label ID="LblMsgNoData" runat="server" Font-Bold="True" 
            Font-Names="Microsoft Sans Serif" Font-Size="Large" 
            Text="<%$ Resources:TextoMsgNoFallas %>" Visible="False"></asp:Label>
        </center>
    </div>

    </form>
</body>
</html>
