<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FWTFirmwareUpdating.aspx.cs" Inherits="SistemaGestionRedes.FWTFirmwareUpdating" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StylesSection.css" rel="stylesheet" type="text/css" />
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="rightDiv">
        <br />
        <%--<asp:SqlDataSource ID="SqDSGetFWT" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            
            SelectCommand="select FWTs.Serial as [FWT], FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera + ' ' + FWTs.ParamFWT_DireccionNomenclatura_Numero as [Direccion] 
                           , FWTs.ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad]
                           from FWTs order by FWTs.Serial asc">
            <UpdateParameters>
                <asp:Parameter Name="actFirmware" />
                <asp:Parameter Name="serial" />
            </UpdateParameters>
        </asp:SqlDataSource>--%>

        <asp:SqlDataSource ID="SqDSGetFWT" runat="server" CancelSelectOnNullParameter="False" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="pa_get_fwts_para_actualizacion_firmware"
            SelectCommandType="StoredProcedure" >
            <SelectParameters>
                <asp:Parameter Name="infoFwt" Type="String" />
            </SelectParameters>

            <UpdateParameters>
                <asp:Parameter Name="actFirmware" />
                <asp:Parameter Name="serial" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqDSInsertActFW" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            InsertCommand="INSERT INTO MtActualizacionesFW(ActFirmware, QtyEquipos, Programa) VALUES (@ActFw, @Qty, @Prog)" 
            
            SelectCommand="select count(*) as cant from MtActualizacionesFW where ActFirmware = @nmAct" 
            DataSourceMode="DataReader">
            <InsertParameters>
                <asp:Parameter Name="ActFw" />
                <asp:Parameter Name="Qty" />
                <asp:Parameter Name="Prog" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter Name="nmAct" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <center>
        <asp:Label ID="lblMensaje0" runat="server" Text="<%$ Resources:TextTittlePrimerPaso %>" Font-Names="Microsoft Sans Serif" Font-Size="Small"></asp:Label>
        <br />

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

        <br />
        <asp:GridView ID="GVFwts" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" CellPadding="5" DataSourceID="SqDSGetFWT" 
            Font-Names="Microsoft Sans Serif" Font-Size="Small" ForeColor="#333333" 
            GridLines="None" ondatabound="GVFwts_DataBound" 
            onpageindexchanging="GVFwts_PageIndexChanging" AllowSorting="True" 
                CellSpacing="5">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="<%$ Resources:TextColumnIncluir %>">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkSelect" runat="server" ViewStateMode="Enabled" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial" />
                <asp:BoundField DataField="SubEstacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" SortExpression="SubEstacion" />
                <asp:BoundField DataField="Direccion" HeaderText="<%$ Resources:TextosGlobales,TextoCalleKra %>" SortExpression="Direccion" />
                <asp:BoundField DataField="Ciudad" HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" />
                <asp:BoundField DataField="Version_Fw" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>" SortExpression="Version_Fw" />
                <asp:BoundField DataField="VersionEquipoRT" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFwERT %>" SortExpression="VersionEquipoRT" />
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
        <asp:Label ID="lblMensaje1" runat="server" Text="<%$ Resources:TextTittleSegundoPaso %>" Font-Names="Microsoft Sans Serif" Font-Size="Small"></asp:Label>
        <br />
        <br />
        <asp:FileUpload ID="FUpPrograma" runat="server" 
            Font-Names="Microsoft Sans Serif" Font-Size="Small" Width="448px" />
        <br />
        <br />
        <asp:Label ID="lblMensaje2" runat="server" Text="<%$ Resources:TextTittleTercerPaso %>" Font-Names="Microsoft Sans Serif" Font-Size="Small"></asp:Label>
        <br />
        <br />
        <asp:Button ID="btnRegistrar" runat="server" onclick="btnRegistrar_Click" 
            Text="<%$ Resources:TextBotonRegistrarActualizacion %>" />
        <br />
        <br />
        <asp:Label ID="lblMensaje" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small" ForeColor="Red"></asp:Label>
        <br />
        <asp:Label ID="lblMensajeNoAptos" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small" ForeColor="Red"></asp:Label>
        </center>
    </div>
    </form>
</body>
</html>
