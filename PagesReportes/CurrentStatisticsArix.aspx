<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CurrentStatisticsSix.aspx.cs" Inherits="SistemaGestionRedes.PagesReportes.CurrentStatisticsSix" %>
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


    </head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="TSMRepCurrentSixs" runat="server">
    </asp:ScriptManager>
    <div align="left">
    
        <asp:Label ID="Label4" runat="server" CssClass="NombreReporte" 
            Text="<%$ Resources:TextTittleReporte %>"></asp:Label>
    
        <br />
        <table align="center" width="100%">
            <tr>
                <td width="50%" align="right">
                    <asp:Label ID="Label1" runat="server" Text="<%$ Resources:TextosGlobales,TextFechaInicial %>" 
                        CssClass="textLabelInUsuario"></asp:Label>
                </td>
                <td width="50%">
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
                <td width="50%" align="right">
                    &nbsp;</td>
                <td width="50%">
                    <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer1" 
                        runat="server" Calendar="PopCalFi" CenterText="True" />
                </td>
            </tr>
            <tr>
                <td width="50%" align="right">
                    <asp:Label ID="Label2" runat="server" CssClass="textLabelInUsuario" Text="<%$ Resources:TextosGlobales,TextFechaFinal %>"></asp:Label>
                </td>
                <td width="50%">
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
                <td width="50%" align="right">
                    &nbsp;</td>
                <td width="50%">
                    <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer2" 
                        runat="server" Calendar="PopCalFf" CenterText="True" />
                </td>
            </tr>
            <tr>
                <td width="50%" align="right">
                    &nbsp;</td>
                <td width="50%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td width="100%" colspan="2">
                    <asp:UpdatePanel ID="UpPanelFiltrosEquipos" runat="server">
                        <ContentTemplate>

                        <table align="center" width="60%" >
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
                                        Text="ARIXs:"></asp:Label>
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
                <td width="100%" align="center" colspan="2">
                    <asp:Button ID="btnAceptar" runat="server" CssClass="TextBoton" Text="Buscar" 
                        onclick="btnAceptar_Click" Visible="False" />
                    <asp:Button ID="btnNewAceptar" runat="server" CssClass="TextBoton" 
                        onclick="btnNewAceptar_Click" Text="<%$ Resources:TextosGlobales,TextBotonBuscar %>" />
                </td>
            </tr>
            <tr>
                <td width="50%" align="right">
                    &nbsp;</td>
                <td width="50%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td width="100%" align="center" colspan="2">
                    <br />
                    <asp:GridView ID="gvResultados" runat="server" CellPadding="4" 
                        ForeColor="#333333" GridLines="None" AllowPaging="True" 
                        AllowSorting="True" AutoGenerateColumns="False" 
                        DataSourceID="sqlDSResultadosFecha">
                        <AlternatingRowStyle BackColor="White" />

                        <Columns>
                            <asp:TemplateField HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" 
                                SortExpression="Serial">
                                <ItemTemplate>
                                    <asp:Label ID="lblSerial" runat="server" Text='<%# Bind("Serial") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Codigo" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoCodigoEquipo %>" 
                                SortExpression="Codigo" Visible="False" />
                            <asp:BoundField DataField="Identificador" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoIdentificadorEquipo %>" 
                                SortExpression="Identificador" Visible="False" />
                            <asp:BoundField DataField="Fase" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoFase %>" SortExpression="Fase" 
                                Visible="False" />
                            <asp:BoundField DataField="Serial_FWT" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" 
                                SortExpression="Serial_FWT" Visible="False" />
                            <asp:BoundField DataField="Codigo_FWT" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" 
                                SortExpression="Codigo_FWT" Visible="False" />
                            <asp:BoundField DataField="SubEstacion" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" 
                                SortExpression="SubEstacion" Visible="False" />
                            <asp:BoundField DataField="Circuito" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" 
                                SortExpression="Circuito" Visible="False" />
                            <asp:BoundField DataField="Tramo" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoSeccionTramo %>" 
                                SortExpression="Tramo" Visible="False" />
                            <asp:BoundField DataField="Nodo" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoNodo %>" SortExpression="Nodo" 
                                Visible="False" />
                            <asp:BoundField DataField="Calle_Cra" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoCalleKra %>" 
                                SortExpression="Calle_Cra" Visible="False" />
                            <asp:BoundField DataField="Numero" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>" 
                                SortExpression="Numero" Visible="False" />
                            <asp:BoundField DataField="Ciudad" 
                                HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" 
                                Visible="False" />
                            <asp:BoundField DataField="Version_Fw" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>" 
                                SortExpression="Version_Fw" Visible="False" />
                            <asp:BoundField DataField="Asdu" 
                                HeaderText="<%$ Resources:TextosGlobales,TextoASDU %>" SortExpression="Asdu" 
                                Visible="False" />
                            <asp:TemplateField HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>" 
                                SortExpression="Fecha">
                                <ItemTemplate>
                                    <asp:Label ID="lblFecha" runat="server" Text='<%# Bind("Fecha") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="<%$ Resources:TextosGlobales,TextoValorCorriente %>" 
                                SortExpression="ValorCorriente">
                                <ItemTemplate>
                                    <%--<asp:Label ID="lblValorCorriente" runat="server" Text='<%# Bind("ValorCorriente") %>'></asp:Label>--%>
                                    <asp:Label ID="lblValorCorriente" runat="server" 
                                        Text='<%# UtilitariosWebGUI.MostrarValorCorrienteSIXAjustado( Eval("ValorCorriente")) %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                        </Columns>

                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#0b304f" ForeColor="White" HorizontalAlign="Center" />
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
                        IncludeTimeStamp="True" PageSize="All" Text="<%$ Resources:TextosGlobales,TextBotonExpoExcel %>" />
                &nbsp;<asp:Button ID="btnGraficar" runat="server" CssClass="TextBoton" 
                        onclick="btnGraficar_Click" Text="<%$ Resources:TextBotonGraficarUnSIX %>" 
                        ToolTip="<%$ Resources:TextToolTipGraficarUnSIX %>" />

                &nbsp;<asp:Button ID="btnManualPoints" runat="server" CssClass="TextBoton" 
                    Text="<%$ Resources:TextBotonGraficaComparativa %>" 
                    ToolTip="<%$ Resources:TextToolTipGrafComparativa %>" 
                        onclick="btnManualPoints_Click" />
                </td>
            </tr>
            <tr>
                <td width="100%" align="center" colspan="2">
                    <asp:Chart ID="chartCorriente" runat="server" Height="400px" Width="943px"
                                EnableViewState="True" ViewStateMode="Enabled">
                        
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisY TextOrientation="Rotated270" Title="<%$ Resources:TextTittleAxisY %>">
                                </AxisY>
                                <AxisX Title="<%$ Resources:TextTittleAxisX %>">
                                    <LabelStyle Format="yyyy-MM-dd HH:mm:ss" />
                                </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>

                        <Legends>
                            <asp:Legend Name="EquipoIndividual" Title="<%$ Resources:TextTittleLegendEquipos %>">
                            </asp:Legend>
                        </Legends>
                    
                        <Titles>
                            <asp:Title Name="General" Text="<%$ Resources:TextTittleGeneral %>">
                            </asp:Title>
                        </Titles>

                    </asp:Chart>
                </td>
            </tr>
            <tr>
                <td width="100%" align="center" colspan="2">
                <asp:Label ID="lblMsgGeneracionGrafica" runat="server" CssClass="TextError" 
                    Font-Size="12px" 
                    Text="<%$ Resources:TextMsgGraficaParaUnSIX %>" 
                    Visible="False"></asp:Label>
                    <br />
                <asp:Label ID="lblMsgGraficaComparativa" runat="server" CssClass="TextError" 
                    Text="<%$ Resources:TextMsgGraficaPara2o3SIX %>" 
                    Visible="False"></asp:Label>
                    <br />
                <asp:Label ID="lblMsgErrCriticoGenGrafico" runat="server" CssClass="TextError" 
                    Text="<%$ Resources:TextErrCriticoBD %>" 
                    Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
        <br />

        <asp:SqlDataSource ID="sqlDSResultadosFecha" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="select 
ARIXs.Serial as [Serial],
ARIXs.Codigo as [Codigo],
ARIXs.Identificador as [Identificador],
ARIXs.Fase as [Fase],
FWTs.Serial as [Serial_FWT],
FWTs.Codigo as [Codigo_FWT],
FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion],
FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
FWTs.ParamFWT_DireccionElectrica_Tramo as [Tramo],
FWTs.ParamFWT_DireccionElectrica_Nodo as [Nodo],
FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Calle_Cra],
FWTs.ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad],
FWTs.ParamFWT_DireccionNomenclatura_Numero as [Numero],
FWTs.VersionPrograma as [Version_Fw],
FWTs.ASDU as [Asdu],
LogCorrienteARIXs.Fecha as [Fecha],
LogCorrienteARIXs.ValorIL as [ValorCorriente]
FROM ARIXs JOIN LogCorrienteARIXs on (ARIXs.Id = LogCorrienteARIXs.ARIXId)
JOIN FWTs on (ARIXs.FWTId = FWTs.Id)
WHERE LogCorrienteARIXs.Fecha between @fechai and @fechaf 
ORDER BY LogCorrienteARIXs.Fecha DESC">
            <SelectParameters>
                <asp:Parameter Name="fechai" />
                <asp:Parameter Name="fechaf" />
            </SelectParameters>
        </asp:SqlDataSource>

<asp:SqlDataSource ID="sqlDSResultadosConSix" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="select 
ARIXs.Serial as [Serial],
ARIXs.Codigo as [Codigo],
ARIXs.Identificador as [Identificador],
ARIXs.Fase as [Fase],
FWTs.Serial as [Serial_FWT],
FWTs.Codigo as [Codigo_FWT],
FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion],
FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
FWTs.ParamFWT_DireccionElectrica_Tramo as [Tramo],
FWTs.ParamFWT_DireccionElectrica_Nodo as [Nodo],
FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Calle_Cra],
FWTs.ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad],
FWTs.ParamFWT_DireccionNomenclatura_Numero as [Numero],
FWTs.VersionPrograma as [Version_Fw],
FWTs.ASDU as [Asdu],
LogCorrienteARIXs.Fecha as [Fecha],
LogCorrienteARIXs.ValorIL as [ValorCorriente]
FROM ARIXs JOIN LogCorrienteARIXs on (ARIXs.Id = LogCorrienteARIXs.ARIXId)
JOIN FWTs on (ARIXs.FWTId = FWTs.Id)
WHERE (LogCorrienteARIXs.Fecha between @Finicial and @Ffinal)
AND ((@idfwt is null) or (FWTs.Id = @idfwt) )
AND ((@idequipo is null) or (ARIXs.Id in (select GUI_IDS_Equipos_Reportes.Col_Id from GUI_IDS_Equipos_Reportes where UserName = @usuario)) )
ORDER BY LogCorrienteARIXs.Fecha DESC" CancelSelectOnNullParameter="False">
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
                   FROM FWTs, ARIXs
                   WHERE FWTs.Id = ARIXs.FWTId and ARIXs.TipoEquipo = 4
                   ORDER BY FWTs.Serial ASC">
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDSSixs" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
    SelectCommand="select ARIXs.Id, ARIXs.Serial, ARIXs.Codigo, ARIXs.FWTId 
                   FROM ARIXs 
                   WHERE ARIXs.TipoEquipo = 4 
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

<asp:SqlDataSource ID="SqlDataGrafOneSixCte" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                    SelectCommand="select 
LogCorrienteARIXs.Fecha as [Fecha],
CONVERT(decimal(15,1), LogCorrienteARIXs.ValorIL/10.0) as [ValorCorriente]
FROM LogCorrienteARIXs
WHERE LogCorrienteARIXs.Fecha between @Finicial and @Ffinal
and LogCorrienteARIXs.ARIXId = @SixId
ORDER BY LogCorrienteARIXs.Fecha ASC
">
                    <SelectParameters>
                        <asp:Parameter Name="Finicial" />
                        <asp:Parameter Name="Ffinal" />
                        <asp:Parameter Name="SixId" />
                    </SelectParameters>
                </asp:SqlDataSource>

        <br />
    
    </div>
    </form>
</body>
</html>
