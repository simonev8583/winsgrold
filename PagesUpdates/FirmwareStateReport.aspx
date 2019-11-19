<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FirmwareStateReport.aspx.cs" Inherits="SistemaGestionRedes.PagesUpdates.FirmwareStateReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StylesSection.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <title></title>
</head>
<body>
    <form id="frmFirmStateReport" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
    <div id="filtros">
        <div class="centerDivFilters">
            <fieldset>
                <legend>
                    <asp:Label ID="Label1" runat="server" CssClass="legend" Text="<%$ Resources:TextLegendFiltros %>"></asp:Label></legend>
                <p>
                    <asp:Label ID="lblVersionFw" runat="server" Text="<%$ Resources:TextosGlobales,TextoWordVersion %>" CssClass="lebField"></asp:Label>
                    <asp:DropDownList ID="DDListVersionesFw" runat="server" CssClass="textbox-300" 
                        DataSourceID="SqlDSAllVersiones" DataTextField="VrFw" DataValueField="VrFw">
                    </asp:DropDownList>
                </p>
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
    <asp:SqlDataSource ID="SqlDSAllVersiones" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
        SelectCommand="pa_get_versionesFirmware_DEVRT" 
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <div id="resultados">
        <div class="centerDivResultados">
            <ajaxToolkit:TabContainer ID="TabContainerResults" runat="server" 
                ActiveTabIndex="0" Width="100%" Height="400px" ScrollBars="Vertical">
                
                <ajaxToolkit:TabPanel runat="server" HeaderText="<%$ Resources:TextPanel1 %>" ID="TabPanel1">
                    <ContentTemplate>
                        <asp:GridView ID="GVCurrentVersion" runat="server" AllowSorting="True" 
                            CssClass="GVstyle" AutoGenerateColumns="False" 
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" 
                            CellPadding="4" ForeColor="Black" GridLines="Vertical" 
                            ondatabound="GVCurrentVersion_DataBound" >
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial" />
                                <asp:BoundField DataField="SerialEQ" HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" SortExpression="SerialEQ" />
                                <asp:BoundField DataField="VerProg" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFwERT %>" SortExpression="VerProg" />
                                <asp:BoundField DataField="Codigo_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" SortExpression="Codigo_FWT" />
                                <asp:BoundField DataField="SubEstacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" SortExpression="SubEstacion" />
                                <asp:BoundField DataField="Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" SortExpression="Circuito" />
                                <asp:BoundField DataField="Ciudad" HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" />
                                <asp:BoundField DataField="Version_Fw" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>" SortExpression="Version_Fw" />
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                
                <ajaxToolkit:TabPanel runat="server" HeaderText="<%$ Resources:TextPanel2 %>" ID="TabPanel2">
                    <ContentTemplate>
                        <asp:GridView ID="GVFCIsPendientes" runat="server" AllowSorting="True" 
                            CssClass="GVstyle" AutoGenerateColumns="False" 
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" 
                            CellPadding="4" ForeColor="Black" GridLines="Vertical" 
                            ondatabound="GVCurrentVersion_DataBound" >
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial" />
                                <asp:BoundField DataField="SerialEQ" HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" SortExpression="SerialEQ" />
                                <asp:BoundField DataField="VerProg" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFwERT %>" SortExpression="VerProg" />
                                <asp:BoundField DataField="Codigo_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" SortExpression="Codigo_FWT" />
                                <asp:BoundField DataField="SubEstacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" SortExpression="SubEstacion" />
                                <asp:BoundField DataField="Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" SortExpression="Circuito" />
                                <asp:BoundField DataField="Ciudad" HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" />
                                <asp:BoundField DataField="Version_Fw" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>" SortExpression="Version_Fw" />
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>

                <ajaxToolkit:TabPanel runat="server" HeaderText="<%$ Resources:TextPanel3 %>" ID="TabPanel3">
                    <ContentTemplate>
                        <asp:GridView ID="GVFCIsNoActivadosYet" runat="server" AllowSorting="True" 
                            CssClass="GVstyle" AutoGenerateColumns="False" 
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" 
                            CellPadding="4" ForeColor="Black" GridLines="Vertical" 
                            ondatabound="GVCurrentVersion_DataBound" >
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial" />
                                <asp:BoundField DataField="SerialEQ" HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" SortExpression="SerialEQ" />
                                <asp:BoundField DataField="VerProg" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFwERT %>" SortExpression="VerProg" />
                                <asp:BoundField DataField="Codigo_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" SortExpression="Codigo_FWT" />
                                <asp:BoundField DataField="SubEstacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" SortExpression="SubEstacion" />
                                <asp:BoundField DataField="Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" SortExpression="Circuito" />
                                <asp:BoundField DataField="Ciudad" HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" />
                                <asp:BoundField DataField="Version_Fw" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>" SortExpression="Version_Fw" />
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>

                <ajaxToolkit:TabPanel runat="server" HeaderText="<%$ Resources:TextPanel4 %>" ID="TabPanel4">
                    <ContentTemplate>
                        <asp:GridView ID="GVFwtConVersion" runat="server" AllowSorting="True" 
                            CssClass="GVstyle" AutoGenerateColumns="False" 
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" 
                            CellPadding="4" ForeColor="Black" GridLines="Vertical" 
                            ondatabound="GVCurrentVersion_DataBound" >
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial" />
                                <asp:BoundField DataField="Codigo_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" SortExpression="Codigo_FWT" />
                                <asp:BoundField DataField="SubEstacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" SortExpression="SubEstacion" />
                                <asp:BoundField DataField="Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" SortExpression="Circuito" />
                                <asp:BoundField DataField="Ciudad" HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" />
                                <asp:BoundField DataField="Version_Fw" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>" SortExpression="Version_Fw" />
                                <asp:BoundField DataField="VersionCargada" HeaderText="<%$ Resources:TextVersionCargadaDevRT %>" SortExpression="VersionCargada" />
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>

                <ajaxToolkit:TabPanel runat="server" HeaderText="<%$ Resources:TextPanel5 %>" ID="TabPanel5">
                    <ContentTemplate>
                        <asp:GridView ID="GVFwtNoCargan" runat="server" AllowSorting="True" 
                            CssClass="GVstyle" AutoGenerateColumns="False" 
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" 
                            CellPadding="4" ForeColor="Black" GridLines="Vertical" 
                            ondatabound="GVCurrentVersion_DataBound" >
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial" />
                                <asp:BoundField DataField="Codigo_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" SortExpression="Codigo_FWT" />
                                <asp:BoundField DataField="SubEstacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" SortExpression="SubEstacion" />
                                <asp:BoundField DataField="Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" SortExpression="Circuito" />
                                <asp:BoundField DataField="Ciudad" HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" />
                                <asp:BoundField DataField="Version_Fw" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>" SortExpression="Version_Fw" />
                                <asp:BoundField DataField="VersionPendiente" HeaderText="<%$ Resources:TextVersionPendienteDevRT %>" SortExpression="VersionCargada" />
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>

            </ajaxToolkit:TabContainer>
            
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDSCurrVer" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
        SelectCommand="pa_reporte_FCIs_con_version_fw" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="versionFw" Type="String" />
            <asp:Parameter Name="infoFwt" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDSPorActualizar" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
        SelectCommand="pa_reporte_FCIs_pendientes_actualizar" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="versionFw" Type="String" />
            <asp:Parameter Name="infofwt" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDSNoActivosAun" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
        SelectCommand="pa_reporte_FCIs_No_activos_actualizacion" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="versionFw" Type="String" />
            <asp:Parameter Name="infofwt" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDSVersionCargada" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
        SelectCommand="pa_reporte_FWT_con_version_cargada" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="versionFw" Type="String" />
            <asp:Parameter Name="infofwt" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDSFWTsNoCargan" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
        SelectCommand="pa_reporte_FWTs_aun_no_cargan_versionEquipo" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="infofwt" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    </form>
    
</body>
</html>
