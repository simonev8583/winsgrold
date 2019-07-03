<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FwtConnectionsState.aspx.cs" Inherits="SistemaGestionRedes.PagesCommunications.FwtConnectionsState" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StylesSection.css" rel="stylesheet" type="text/css" />
    <title></title>
</head>
<body>
 <form id="frmFwtConnSte" runat="server">

    <div id="filtros">
        <div class="centerDivFilters">
            <fieldset>
                <legend>
                    <asp:Label ID="Label1" runat="server" CssClass="legend" Text="<%$ Resources:TextLegendFiltros %>"></asp:Label></legend>
                <p>
                    <asp:Label ID="lblInfoFWT" runat="server" Text="<%$ Resources:TextLabelFiltros %>" CssClass="lebField"></asp:Label>
                    <asp:TextBox ID="txtInfoFwt" runat="server" CssClass="textbox-300" ToolTip="<%$ Resources:TextTooltipInfoFiltro %>" ></asp:TextBox>
                </p>
                <p>
                    <asp:Button ID="btnRefrescarFiltros" runat="server" Text="<%$ Resources:TextosGlobales,TextBotonBuscar %>" 
                        CssClass="botonSubmit" onclick="btnRefrescarFiltros_Click" />
                </p>
            </fieldset>
        </div>
    </div>

    <div id="conectados">
        <div class="centerDiv">
        <asp:GridView ID="GVConectados" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" 
            DataSourceID="SqlDSConnected" ForeColor="#333333" GridLines="None" 
                CssClass="GVstyle" ondatabinding="GVConectados_DataBinding" 
                ShowHeaderWhenEmpty="True" Caption="<%$ Resources:TextCaptionFwtConectados %>" CaptionAlign="Top">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" 
                    ReadOnly="True" SortExpression="Id" Visible="False" />
                <asp:HyperLinkField DataNavigateUrlFields="Id" DataTextField="Serial" DataNavigateUrlFormatString="~/PagesEquipment/EditFWT.aspx?Id={0}" 
                    HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" Target="_self" SortExpression="Serial" />
                <asp:BoundField DataField="Fecha" HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>" SortExpression="Fecha" />
                <asp:BoundField DataField="Direccion" HeaderText="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>" ReadOnly="True" 
                    SortExpression="Direccion" />
                <asp:BoundField DataField="Ciudad" 
                    HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" />
            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F8FAFA" />
            <SortedAscendingHeaderStyle BackColor="#246B61" />
            <SortedDescendingCellStyle BackColor="#D4DFE1" />
            <SortedDescendingHeaderStyle BackColor="#15524A" />
        </asp:GridView>
        </div>
    </div>

    <div id="desconectados">
        <div class="centerDiv">
            <asp:GridView ID="GVDesconectados" runat="server" AutoGenerateColumns="False" 
                CellPadding="4" CssClass="GVstyle" DataKeyNames="Id" 
                DataSourceID="SqlDSDisconnected" ForeColor="#333333" GridLines="None" 
                ondatabinding="GVDesconectados_DataBinding" AllowSorting="True" 
                ShowHeaderWhenEmpty="True" Caption="<%$ Resources:TextCaptionFwtdesconectados %>" CaptionAlign="Top" 
                ondatabound="GVDesconectados_DataBound">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" 
                        ReadOnly="True" SortExpression="Id" Visible="False" />
                    <asp:HyperLinkField DataNavigateUrlFields="Id" 
                        DataNavigateUrlFormatString="~/PagesEquipment/EditFWT.aspx?Id={0}" 
                        DataTextField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" SortExpression="Serial" 
                        Target="_self" />
                    <asp:BoundField DataField="Fecha" HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>" SortExpression="Fecha" />
                    <asp:BoundField DataField="Direccion" HeaderText="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>" ReadOnly="True" 
                        SortExpression="Direccion" />
                    <asp:BoundField DataField="Ciudad" 
                        HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" />
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>
        </div>
    </div>

    <div id="grafica">
        <div class="centerDivChart">
            <asp:Chart ID="ChartFwtConnections" runat="server" Height="150px" Width="600px">
                <Series>
                    <asp:Series Name="Series_Ppal" ChartArea="CAreaPpal" ChartType="Bar" 
                        LegendText="<%$ Resources:TextLegendChart %>" XValueType="String" YValueType="Int32">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="CAreaPpal">
                        <AxisY Title="<%$ Resources:TextAxisCantidad %>">
                        </AxisY>
                        <AxisX Title="<%$ Resources:TextAxisEstado %>">
                        </AxisX>
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
            <p class="pTextCentered">
                <asp:Label ID="lblEstadoCosoft" runat="server" Text="<%$ Resources:TextlblEstadoCosoft %>" CssClass="FieldGeneral" ForeColor="Red"></asp:Label>
                <asp:Label ID="lblAvailabilityCosoft" runat="server" Text="" CssClass="FieldGeneral" ForeColor="Red"></asp:Label>
            </p>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDSConnected" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
        SelectCommand="SELECT vw_app_FWTs_keepAlives.Id,
vw_app_FWTs_keepAlives.Serial,
vw_app_FWTs_keepAlives.FechaUltimoEnvio as Fecha,
vw_app_FWTs_keepAlives.Direccion,   
vw_app_FWTs_keepAlives.Ciudad
FROM vw_app_FWTs_keepAlives
WHERE (vw_app_FWTs_keepAlives.IsOnline = 1) 
and ((@infoPrm is null) or (vw_app_FWTs_keepAlives.InformacionFWT like @infoPrm))" CancelSelectOnNullParameter="False" >
        <SelectParameters>
            <asp:Parameter Name="infoPrm" Type="String" ConvertEmptyStringToNull="false"  />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDSDisconnected" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
        SelectCommand="SELECT vw_app_FWTs_keepAlives.Id,
vw_app_FWTs_keepAlives.Serial,
vw_app_FWTs_keepAlives.FechaUltimoEnvio as Fecha,
vw_app_FWTs_keepAlives.Direccion,   
vw_app_FWTs_keepAlives.Ciudad
FROM vw_app_FWTs_keepAlives
WHERE (coalesce(IsOnline, 0) = 0)
and ((@infoPrm is null) or (vw_app_FWTs_keepAlives.InformacionFWT like @infoPrm))" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter Name="infoPrm" Type="String" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:Timer ID="TimerRefresh" runat="server" ontick="TimerRefresh_Tick">
    </asp:Timer>

 </form>
</body>
</html>
