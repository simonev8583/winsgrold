<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatisticsSix.aspx.cs" Inherits="SistemaGestionRedes.PagesReportes.StatisticsSix" %>

<%@ Register assembly="RJS.Web.WebControl.PopCalendar.Net.2010" namespace="RJS.Web.WebControl" tagprefix="rjs" %>

<%@ Register assembly="ExportToExcel" namespace="KrishLabs.Web.Controls" tagprefix="RK" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="SistemaGestionRedes" Namespace="SistemaGestionRedes" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link href="../Styles/Site.css" rel="stylesheet" type="text/css" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <title></title>

    <script language="javascript" type="text/javascript">

        function abrirConfigColumnas() {
            window.open('ConfiguracionColumnas.aspx?IdReporte=30', '_blank', 'width=800,height=500');
            return false;
        }


        </script>

    </head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="TSMRepStatisticsSixs" runat="server">
    </asp:ScriptManager>
    <div align="left">
    
        <asp:Label ID="Label4" runat="server" CssClass="NombreReporte" 
            Text="<%$ Resources:TextTittleReporte %>"></asp:Label>
    
        <br />
        <table align="center" width="70%">
            <tr>
                <td width="25%" align="right">
                    <asp:Label ID="Label1" runat="server" Text="<%$ Resources:TextosGlobales,TextFechaInicial %>" 
                        CssClass="textLabelInUsuario"></asp:Label>
                </td>
                <td width="45%">
                    <asp:TextBox ID="txtFechaInicial" runat="server" CssClass="textInUsuario" 
                        MaxLength="10"></asp:TextBox>
                    <rjs:PopCalendar ID="PopCalFi" runat="server" Control="txtFechaInicial" 
                        Format="yyyy mm dd" From-Date="2011-01-01" 
                        From-Message="<%$ Resources:TextosGlobales,TextCalendarFiFromMessage %>" 
                        InvalidDateMessage="<%$ Resources:TextosGlobales,TextCalendarFiInvalidDateMessage %>" 
                        RequiredDate="True" RequiredDateMessage="<%$ Resources:TextosGlobales,TextCalendarFiRequiredDateMessage %>" 
                        To-Message="<%$ Resources:TextosGlobales,TextCalendarFiToMessage %>" />
                </td>
            </tr>
            <tr>
                <td width="25%" align="right">
                    &nbsp;</td>
                <td width="45%">
                    <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer1" 
                        runat="server" Calendar="PopCalFi" CenterText="True" />
                </td>
            </tr>
            <tr>
                <td width="25%" align="right">
                    <asp:Label ID="Label2" runat="server" CssClass="textLabelInUsuario" Text="<%$ Resources:TextosGlobales,TextFechaFinal %>"></asp:Label>
                </td>
                <td width="45%">
                    <asp:TextBox ID="txtFechaFinal" runat="server" CssClass="textInUsuario" 
                        MaxLength="10"></asp:TextBox>
                    <rjs:PopCalendar ID="PopCalFf" runat="server" Control="txtFechaFinal" 
                        Format="yyyy mm dd" From-Control="txtFechaInicial" From-Date="" 
                        From-Message="<%$ Resources:TextosGlobales,TextCalendarFfFromMessage %>" 
                        InvalidDateMessage="<%$ Resources:TextosGlobales,TextCalendarFfInvalidDateMessage %>" 
                        RequiredDate="True" RequiredDateMessage="<%$ Resources:TextosGlobales,TextCalendarFfRequiredDateMessage %>" 
                        To-Message="<%$ Resources:TextosGlobales,TextCalendarFfToMessage %>" />
                </td>
            </tr>
            <tr>
                <td width="35%">
                    &nbsp;</td>
                <td width="35%">
                    <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer2" 
                        runat="server" Calendar="PopCalFf" CenterText="True" />
                </td>
            </tr>

            <tr>
                <td width="70%" colspan="2">
                    <asp:UpdatePanel ID="UpPanelFiltrosEquipos" runat="server">
                        <ContentTemplate>

                        <table align="center" width="70%" >
                            <tr>
                                <td align="right" width="15%">
                                    <asp:Label ID="Label5" runat="server" CssClass="textLabelInUsuario" 
                                        Text="<%$ Resources:TextosGlobales,TextLblConcentrador %>"></asp:Label>
                                </td>
                                <td align="left" width="10%">
                                    <asp:DropDownList ID="DDListCntrs" runat="server" AutoPostBack="True" 
                                        CssClass="textInUsuario" DataSourceID="SqlDSFwts" DataTextField="Serial" 
                                        DataValueField="Id" ondatabound="DDListCntrs_DataBound" Width="110px" 
                                        onselectedindexchanged="DDListCntrs_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td align="left" width="3%">
                                    <asp:Label ID="Label6" runat="server" CssClass="textLabelInUsuario" 
                                        Text="SIXs:"></asp:Label>
                                </td>
                                <td align="left" width="15%">
                                    <asp:ListBox ID="LstBoxSixs" runat="server" CssClass="textInUsuario" 
                                        DataSourceID="SqlDSSixs" DataTextField="Serial" DataValueField="Id" 
                                        Height="85px" SelectionMode="Multiple" Width="110px"></asp:ListBox>
                                </td>
                            </tr>
                        </table>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td width="15%" align="center" colspan="2">
                    <asp:Button ID="btnAceptar" runat="server" CssClass="TextBoton" Text="Buscar" 
                        onclick="btnAceptar_Click" Visible="False" />
                    <asp:Button ID="btnNewAceptar" runat="server" CssClass="TextBoton" Text="<%$ Resources:TextosGlobales,TextBotonBuscar %>" 
                        onclick="btnNewAceptar_Click" />
                &nbsp;<asp:Button ID="btnIrConfigColumnas" runat="server" CssClass="TextBoton" 
                                    Text="<%$ Resources:TextosGlobales,TextBotonColoumnas %>" UseSubmitBehavior="False" 
                                    OnClientClick="return abrirConfigColumnas();" Width="85px" />
                </td>
            </tr>
            <tr>
                <td width="15%" align="right">
                    &nbsp;</td>
                <td width="25%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td width="70%" align="center" colspan="2">
                    <br />
                    <asp:GridView ID="gvResultados" runat="server" CellPadding="4" 
                        ForeColor="#333333" GridLines="None" AllowPaging="True" 
                        AllowSorting="True" AutoGenerateColumns="False" 
                        DataSourceID="sqlDSResultadosFecha">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateFieldCel HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" SortExpression="Serial" Name="Serial">
                                <ItemTemplate>
                                    <asp:Label ID="lblSerial" runat="server" Text='<%# Bind("Serial") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateFieldCel>

                            <asp:BoundFieldCel DataField="Codigo" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoEquipo %>" SortExpression="Codigo" Visible="false" Name="Código FCI"  />

                            <asp:BoundFieldCel DataField="Identificador" HeaderText="<%$ Resources:TextosGlobales,TextoIdentificadorEquipo %>" SortExpression="Identificador" Visible="false" Name="Identificador" />

                            <asp:BoundFieldCel DataField="Fase" HeaderText="<%$ Resources:TextosGlobales,TextoFase %>" SortExpression="Fase" Visible="false" Name="Fase" />

                            <asp:BoundFieldCel DataField="Serial_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial_FWT" Visible="false" Name="Serial FWT" />

                            <asp:BoundFieldCel DataField="Codigo_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" SortExpression="Codigo_FWT" Visible="false" Name="Código FWT" />

                            <asp:BoundFieldCel DataField="SubEstacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" SortExpression="SubEstacion" Visible="false" Name="SubEstación" />

                            <asp:BoundFieldCel DataField="Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" SortExpression="Circuito" Visible="false" Name="Circuito" />

                            <asp:BoundFieldCel DataField="Tramo" HeaderText="<%$ Resources:TextosGlobales,TextoSeccionTramo %>" SortExpression="Tramo" Visible="false" Name="Tramo" />

                            <asp:BoundFieldCel DataField="Nodo" HeaderText="<%$ Resources:TextosGlobales,TextoNodo %>" SortExpression="Nodo" Visible="false" Name="Nodo" />

                            <asp:BoundFieldCel DataField="Calle_Cra" HeaderText="<%$ Resources:TextosGlobales,TextoCalleKra %>" SortExpression="Calle_Cra" Visible="false" Name="Calle-Cra" />

                            <asp:BoundFieldCel DataField="Numero" HeaderText="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>" SortExpression="Numero" Visible="false" Name="Número" />

                            <asp:BoundFieldCel DataField="Ciudad" HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" Visible="false" Name="Ciudad" />

                            <asp:BoundFieldCel DataField="Version_Fw" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>" SortExpression="Version_Fw" Visible="false" Name="Version Programa" />

                            <asp:BoundFieldCel DataField="Asdu" HeaderText="<%$ Resources:TextosGlobales,TextoASDU %>" SortExpression="Asdu" Visible="false" Name="ASDU" />

                            <asp:TemplateFieldCel HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>" SortExpression="Fecha" Name="Fecha" >
                                <ItemTemplate>
                                    <asp:Label ID="lblFecha" runat="server" Text='<%# Bind("Fecha") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateFieldCel>

                            <asp:TemplateFieldCel HeaderText="<%$ Resources:TextColOperaciones %>" SortExpression="Operaciones" Name="Operaciones">
                                <ItemTemplate>
                                    <asp:Label ID="lblOperaciones" runat="server" Text='<%# Bind("Operaciones") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateFieldCel>

                            <asp:TemplateFieldCel HeaderText="<%$ Resources:TextColTransitorios %>" SortExpression="Transitorios" Name="Transitorios">
                                <ItemTemplate>
                                    <asp:Label ID="lblTransitorios" runat="server" Text='<%# Bind("Transitorios") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateFieldCel>

                            <asp:TemplateFieldCel HeaderText="<%$ Resources:TextColTiempoSobreActuacion %>" SortExpression="TiempoEnActuacion" Name="TiempoEnActuacion">
                                <ItemTemplate>
                                    <asp:Label ID="lblTiempoEnActuacion" runat="server" Text='<%# Bind("TiempoEnActuacion") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateFieldCel>

                            <asp:TemplateFieldCel HeaderText="<%$ Resources:TextColTiempoSobreCteMax %>" SortExpression="TiempoEnMaxima" Name="TiempoEnMaxima">
                                <ItemTemplate>
                                    <asp:Label ID="lblTiempoEnMaxima" runat="server" Text='<%# Bind("TiempoEnMaxima") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateFieldCel>


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
                    <br />
                    <asp:Label ID="lblMsgNoResultados" runat="server" 
                        Text="<%$ Resources:TextosGlobales,TextMsgRepNoData %>" Visible="False" 
                        Font-Size="Large"></asp:Label>
                    <br />
                    <RK:ExportToExcel ID="ExportToExcel1" runat="server" ApplyStyleInExcel="True" 
                        Charset="utf-8" ContentEncoding="windows-1250" CssClass="TextBoton" 
                        EnableHyperLinks="True" ExportFileName="Estadisticas_Six.xls" 
                        IncludeTimeStamp="True" PageSize="All" Text="<%$ Resources:TextosGlobales,TextBotonExpoExcel %>" 
                        GridViewID="gvResultados" />
                </td>
            </tr>
            <tr>
                <td width="15%" align="right" colspan="2">
                    &nbsp;</td>
            </tr>
        </table>
        <br />

<asp:SqlDataSource ID="sqlDSEquiposSix" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
    SelectCommand="select Id, Serial from FCIs where TipoEquipo = 2">
</asp:SqlDataSource>


<asp:SqlDataSource ID="sqlDSResultadosFecha" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
    SelectCommand="select 
Serial as [Serial], 
Codigo as [Codigo],
Identificador as [Identificador],
Fase as [Fase],
Serial_FWT as [Serial_FWT],
Codigo_FWT as [Codigo_FWT],
SubEstacion as [SubEstacion],
Circuito as [Circuito],
Tramo as [Tramo],
Nodo as [Nodo],
Calle_Cra as [Calle_Cra],
Ciudad as [Ciudad],
Numero as [Numero],
Version_Fw as [Version_Fw],
Asdu as [Asdu], 
Fecha, 
ContOperaciones as Operaciones, 
ContTransitorios as Transitorios,
TiempoEnActuacion, 
TiempoEnMaxima 
from vw_app_estadisticasSIX
where Fecha between @fechai and @fechaf 
order by Fecha desc">
            <SelectParameters>
                <asp:Parameter Name="fechai" />
                <asp:Parameter Name="fechaf" />
            </SelectParameters>
        </asp:SqlDataSource>


<asp:SqlDataSource ID="sqlDSResultadosConSix" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
    SelectCommand="select 
Id_FWT,
Id_FCI,
Serial as [Serial], 
Codigo as [Codigo],
Identificador as [Identificador],
Fase as [Fase],
Serial_FWT as [Serial_FWT],
Codigo_FWT as [Codigo_FWT],
SubEstacion as [SubEstacion],
Circuito as [Circuito],
Tramo as [Tramo],
Nodo as [Nodo],
Calle_Cra as [Calle_Cra],
Ciudad as [Ciudad],
Numero as [Numero],
Version_Fw as [Version_Fw],
Asdu as [Asdu], 
Fecha, 
ContOperaciones as Operaciones, 
ContTransitorios as Transitorios,
TiempoEnActuacion, 
TiempoEnMaxima 
from vw_app_estadisticasSIX
where (Fecha between @Finicial and @Ffinal) 
and ((@idfwt is null) or (Id_FWT = @idfwt))
and ((@idequipo is null) or (Id_FCI in (select GUI_IDS_Equipos_Reportes.Col_Id from GUI_IDS_Equipos_Reportes where UserName = @usuario)) )
order by Fecha desc" CancelSelectOnNullParameter="False" >
    <SelectParameters>
        <asp:Parameter Name="Finicial" />
        <asp:Parameter Name="Ffinal" />
        <asp:Parameter Name="idfwt" ConvertEmptyStringToNull="false" Type="Int32"  />
        <asp:Parameter Name="idequipo" ConvertEmptyStringToNull="false" Type="Int32"  />
        <asp:Parameter Name="usuario" ConvertEmptyStringToNull="false" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="SqlDSFwts" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
    SelectCommand="select distinct FWTs.Id, FWTs.Serial, FWTs.Codigo 
                   FROM FWTs, FCIs
                   WHERE FWTs.Id = FCIs.FWTId and FCIs.TipoEquipo = 2
                   ORDER BY FWTs.Serial ASC">
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDSSixs" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
    SelectCommand="select FCIs.Id, FCIs.Serial, FCIs.Codigo, FCIs.FWTId 
                   FROM FCIs 
                   WHERE FCIs.TipoEquipo = 2 
                   and ((@idfwt is null) or (FWTId = @idfwt))" CancelSelectOnNullParameter="false">
    <SelectParameters>
        <asp:Parameter Name="idfwt" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDSQuerySIXs" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
    DeleteCommand="delete GUI_IDS_Equipos_Reportes where UserName = @usuario" 
    InsertCommand="insert into GUI_IDS_Equipos_Reportes values(@col_id, @usuario)" 
    SelectCommand="select Col_Id, UserName from GUI_IDS_Equipos_Reportes where UserName = @usuario">
    <DeleteParameters>
        <asp:Parameter Name="usuario" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="col_id" />
        <asp:Parameter Name="usuario" />
    </InsertParameters>
    <SelectParameters>
        <asp:Parameter Name="usuario" />
    </SelectParameters>
</asp:SqlDataSource>

        <br />
    
    </div>
    </form>
</body>
</html>
