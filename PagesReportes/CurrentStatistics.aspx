<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CurrentStatistics.aspx.cs" Inherits="SistemaGestionRedes.PagesReportes.CurrentStatistics" %>

<%@ Register assembly="RJS.Web.WebControl.PopCalendar.Net.2010" namespace="RJS.Web.WebControl" tagprefix="rjs" %>

<%@ Register assembly="ExportToExcel" namespace="KrishLabs.Web.Controls" tagprefix="RK" %>

<%@ Register Assembly="SistemaGestionRedes" Namespace="SistemaGestionRedes" TagPrefix="asp" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <title></title>
    

    <script type="text/javascript" language="javascript">

        function abrirConfigColumnas() {
            window.open('ConfiguracionColumnas.aspx?IdReporte=40', '_blank', 'width=800,height=500');
            return false;
        }


        </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="TSMRepLogCte" runat="server">
    </asp:ScriptManager>
   
    
    <table width="100%">
        <tr>
            <td align="left" width="50%" colspan="2">
                <asp:Label ID="Label3" runat="server" Text="<%$ Resources:TextTittleReporte %>" 
            CssClass="NombreReporte"></asp:Label>
            </td>
            <td align="left" width="50%" colspan="2">
                
&nbsp;</td>
        </tr>
        <tr>
            <td align="right" width="50%" colspan="2">
        <asp:Label ID="Label1" runat="server" Font-Names="Microsoft Sans Serif" 
            Font-Size="Small" Text="<%$ Resources:TextosGlobales,TextFechaInicial %>" CssClass="textLabelInUsuario"></asp:Label>
            </td>
            <td align="left" width="50%" colspan="2">
        <asp:TextBox ID="txtFechaInicial" runat="server" 
                        Font-Names="Microsoft Sans Serif" Font-Size="12px" MaxLength="10" Width="100px"></asp:TextBox>
                <rjs:PopCalendar ID="PopCalFi" runat="server" Control="txtFechaInicial" 
                        Format="yyyy mm dd" From-Date="2011-01-01" 
                        From-Message="<%$ Resources:TextosGlobales,TextCalendarFiFromMessage %>" 
                        InvalidDateMessage="<%$ Resources:TextosGlobales,TextCalendarFiInvalidDateMessage %>" 
                        RequiredDate="True" RequiredDateMessage="<%$ Resources:TextosGlobales,TextCalendarFiRequiredDateMessage %>" 
                        To-Message="<%$ Resources:TextosGlobales,TextCalendarFiToMessage %>" />
        <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer1" 
                        runat="server" Calendar="PopCalFi" CenterText="True" />
               </td>
        </tr>
        <tr>
            <td align="right" width="50%" colspan="2">
        <asp:Label ID="Label2" runat="server" Font-Names="Microsoft Sans Serif" 
            Font-Size="Small" Text="<%$ Resources:TextosGlobales,TextFechaFinal %>" CssClass="textLabelInUsuario"></asp:Label>
            </td>
            <td align="left" width="50%" colspan="2">
        <asp:TextBox ID="txtFechaFinal" runat="server" 
                        Font-Names="Microsoft Sans Serif" Font-Size="12px" MaxLength="10" Width="100px"></asp:TextBox>
                <rjs:PopCalendar ID="PopCalFf" runat="server" Control="txtFechaFinal" 
                        Format="yyyy mm dd" From-Control="txtFechaInicial" From-Date="" 
                        From-Message="<%$ Resources:TextosGlobales,TextCalendarFfFromMessage %>" 
                        InvalidDateMessage="<%$ Resources:TextosGlobales,TextCalendarFfInvalidDateMessage %>" 
                        RequiredDate="True" RequiredDateMessage="<%$ Resources:TextosGlobales,TextCalendarFfRequiredDateMessage %>" 
                        To-Message="<%$ Resources:TextosGlobales,TextCalendarFfToMessage %>" />
                
                <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer2" 
                        runat="server" Calendar="PopCalFf" CenterText="True" />
            </td>
        </tr>
        <tr>
            <td width="25%" colspan="4">
                <asp:UpdatePanel ID="UpPanelFiltrosEquipos" runat="server">
                    <ContentTemplate>
                        <table width="100%">
                            <tr>
                                <td align="right" width="40%">
                                    <asp:Label ID="Label11" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small"
                                        Text="<%$ Resources:TextosGlobales,TextLblConcentrador %>" CssClass="textLabelInUsuario"></asp:Label>
                                </td>
                                <td width="10%">
                                    <asp:DropDownList ID="DDListCntrs" runat="server" AutoPostBack="True" CssClass="textInUsuario"
                                        DataSourceID="SqlDSFwts" DataTextField="Serial" DataValueField="Id" OnDataBound="DDListCntrs_DataBound"
                                        OnSelectedIndexChanged="DDListCntrs_SelectedIndexChanged" Width="110px">
                                    </asp:DropDownList>
                                </td>
                                <td align="right" width="7%">
                                    <asp:Label ID="Label10" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small"
                                        Text="FCIs: " CssClass="textLabelInUsuario"></asp:Label>
                                </td>
                                <td width="43%">
                                    <asp:ListBox ID="LstBoxFcis" runat="server" CssClass="textInUsuario" DataSourceID="SqlDSFcis"
                                        DataTextField="Serial" DataValueField="Id" SelectionMode="Multiple" Width="110px"
                                        Height="85px"></asp:ListBox>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td width="25%">
            </td>
            <td align="right" width="25%">
                &nbsp;</td>
            <td align="right" width="25%">
       
        <asp:Label ID="Label9" runat="server" Font-Names="Microsoft Sans Serif" 
            Font-Size="Small" Text="Serial Equipo: " Visible="False"></asp:Label>
       
            </td>
            <td align="left" width="25%">
       
            <asp:DropDownList ID="txtSerialFCI" runat="server" AutoPostBack="False" 
                    Visible="False" >
            </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%" colspan="2">
                &nbsp;</td>
            <td align="left" width="50%" colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" width="50%" colspan="2">
        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" onclick="btnBuscar_Click" 
                CssClass="TextBoton" Visible="False" />
            &nbsp;<asp:Button ID="btnNewBuscar" runat="server" CssClass="TextBoton" 
                    onclick="btnNewBuscar_Click" Text="<%$ Resources:TextosGlobales,TextBotonBuscar %>" />
            </td>
            <td align="left" width="50%" colspan="2">
                <asp:Button ID="btnIrConfigColumnas" runat="server" CssClass="TextBoton" 
                                    Text="<%$ Resources:TextosGlobales,TextBotonColoumnas %>" UseSubmitBehavior="False" 
                                    OnClientClick="return abrirConfigColumnas();" Width="85px" />
            </td>
        </tr>
        <tr>
            <td align="right" width="50%" colspan="2">
                &nbsp;</td>
            <td align="left" width="50%" colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="4" width="100%">
        <asp:GridView ID="GVReporte" runat="server" CellPadding="4" 
            Font-Names="Microsoft Sans Serif" Font-Size="11px" ForeColor="#333333" 
            GridLines="None" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" ondatabound="GVReporte_DataBound" 
                onrowdatabound="GVReporte_RowDataBound" ViewStateMode="Enabled">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundFieldCel DataField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" SortExpression="Serial" Name="Serial" />

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

                <asp:BoundFieldCel DataField="Fecha" HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>" SortExpression="Fecha" Name="Fecha" />

                <asp:BoundFieldCel DataField="ValorCorriente" HeaderText="<%$ Resources:TextosGlobales,TextoValorCorriente %>" SortExpression="ValorCorriente" Name="ValorCorriente" />
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
            </td>
        </tr>
        <tr>
            <td align="center" width="100%" colspan="4">
          <RK:ExportToExcel ID="ExportToExcel1" runat="server" ApplyStyleInExcel="True" 
            Charset="utf-8" ContentEncoding="windows-1250" EnableHyperLinks="False" 
            ExportFileName="EstadisticasCorrienteFCI.xls" GridViewID="GVReporte" 
            IncludeTimeStamp="True" PageSize="All" Text="<%$ Resources:TextosGlobales,TextBotonExpoExcel %>" CssClass="TextBoton" />
            &nbsp;<asp:Button ID="btnGraficar" runat="server" CssClass="TextBoton" 
                    onclick="btnGraficar_Click" Text="<%$ Resources:TextBotonGraficarUnFCI %>" 
                    ToolTip="<%$ Resources:TextToolTipGraficarUnFCI %>" />
            &nbsp;<asp:Button ID="btnPruebaThree" runat="server" CssClass="TextBoton" 
                    onclick="btnPruebaThree_Click" Text="Graf. Comparativa" 
                    ToolTip="Gráfica comparativa Cte-Tpo de 2 o 3 FCIs." Visible="False" />
            &nbsp;<asp:Button ID="btnManualPoints" runat="server" CssClass="TextBoton" 
                    onclick="btnManualPoints_Click" Text="<%$ Resources:TextBotonGraficaComparativa %>" 
                    ToolTip="<%$ Resources:TextToolTipGrafComparativa %>" />
            </td>
        </tr>
        <tr>
            <td align="center" width="100%" colspan="4">
        <asp:Label ID="LblMsgNoData" runat="server" Font-Bold="True" 
            Font-Names="Microsoft Sans Serif" Font-Size="15px" 
            Text="<%$ Resources:TextosGlobales,TextMsgRepNoData %>" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center" width="100%" colspan="4">
                <asp:Chart ID="chartCorriente" runat="server" Width="700px" 
                    EnableViewState="True" ViewStateMode="Enabled">
                    <chartareas>
                        <asp:ChartArea Name="ChartArea1">
                            <AxisY TextOrientation="Rotated270" Title="<%$ Resources:TextTittleAxisY %>">
                            </AxisY>
                            <AxisX Title="<%$ Resources:TextTittleAxisX %>">
                                <LabelStyle Format="yyyy-MM-dd HH:mm:ss" />
                            </AxisX>
                        </asp:ChartArea>
                    </chartareas>
                    <Legends>
                        <asp:Legend Name="EquipoIndividual" Title="<%$ Resources:TextTittleLegendEquipos %>">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Name="General" Text="<%$ Resources:TextTittleGeneral %>">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
                <br />
                <asp:Label ID="lblMsgGeneracionGrafica" runat="server" CssClass="TextError" 
                    Font-Size="12px" 
                    Text="<%$ Resources:TextMsgGraficaParaUnFCI %>" 
                    Visible="False"></asp:Label>
                <br />
                <asp:Label ID="lblMsgGraficaComparativa" runat="server" CssClass="TextError" 
                    Text="<%$ Resources:TextMsgGraficaPara2o3CI %>" 
                    Visible="False"></asp:Label>
                <br />
                <asp:Label ID="lblMsgErrCriticoGenGrafico" runat="server" CssClass="TextError" 
                    Text="<%$ Resources:TextErrCriticoBD %>" 
                    Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%" colspan="2">
                &nbsp;</td>
            <td align="left" width="50%" colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" width="50%" colspan="2">
                &nbsp;</td>
            <td align="left" width="50%" colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="left" width="50%" colspan="2">
    
        <asp:SqlDataSource ID="SqDSInfoCompleta" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="select 
FCIs.Serial as [Serial],
FCIs.Codigo as [Codigo],
FCIs.Identificador as [Identificador], 
FCIs.Fase as [Fase],
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
LogCorrienteFCIs.Fecha as [Fecha],
LogCorrienteFCIs.ValorIL as [ValorCorriente],
FCIs.TipoEquipo as [TipoEquipo]
FROM FCIs JOIN LogCorrienteFCIs on (FCIs.Id = LogCorrienteFCIs.FCIId)
JOIN FWTs on (FCIs.FWTId = FWTs.Id)
WHERE LogCorrienteFCIs.Fecha between @Finicial and @Ffinal 
ORDER BY LogCorrienteFCIs.Fecha DESC">
        </asp:SqlDataSource>
            </td>
            <td align="left" width="50%" colspan="2">

<asp:SqlDataSource ID="SqlDSFwts" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
    SelectCommand="select distinct FWTs.Id, FWTs.Serial, FWTs.Codigo 
                   FROM FWTs, FCIs
                   WHERE FWTs.Id = FCIs.FWTId and FCIs.TipoEquipo = 1
                   ORDER BY FWTs.Serial ASC">
</asp:SqlDataSource>

&nbsp;<asp:SqlDataSource ID="SqlDSFcis" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                    SelectCommand="select 
FCIs.Id,
FCIs.Serial,
FCIs.Codigo,
FCIs.FWTId
from FCIs
where FCIs.TipoEquipo = 1"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="left" width="50%" colspan="2">
        <asp:SqlDataSource ID="SqDSInfoLikeSerial" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="select 
FCIs.Serial as [Serial],
FCIs.Codigo as [Codigo],
FCIs.Identificador as [Identificador], 
FCIs.Fase as [Fase],
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
LogCorrienteFCIs.Fecha as [Fecha],
LogCorrienteFCIs.ValorIL as [ValorCorriente],
FCIs.TipoEquipo as [TipoEquipo]
FROM FCIs JOIN LogCorrienteFCIs on (FCIs.Id = LogCorrienteFCIs.FCIId)
JOIN FWTs on (FCIs.FWTId = FWTs.Id)
WHERE LogCorrienteFCIs.Fecha between @Finicial and @Ffinal
AND FCIs.Serial like + @Serial + '%'
ORDER BY LogCorrienteFCIs.Fecha DESC">
        </asp:SqlDataSource>
                <br />
                <asp:SqlDataSource ID="SqlDSNewInfoCompleta" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                    SelectCommand="select 
FCIs.Id as [IdFCI],
FCIs.Serial as [Serial],
FCIs.Codigo as [Codigo],
FCIs.Identificador as [Identificador], 
FCIs.Fase as [Fase],
FWTs.Id as [IdFWT],
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
LogCorrienteFCIs.Fecha as [Fecha],
LogCorrienteFCIs.ValorIL as [ValorCorriente],
FCIs.TipoEquipo as [TipoEquipo]
FROM FCIs JOIN LogCorrienteFCIs on (FCIs.Id = LogCorrienteFCIs.FCIId)
JOIN FWTs on (FCIs.FWTId = FWTs.Id)
WHERE LogCorrienteFCIs.Fecha between @Finicial and @Ffinal
ORDER BY LogCorrienteFCIs.Fecha DESC" ViewStateMode="Enabled">
                    <SelectParameters>
                        <asp:Parameter Name="Finicial" />
                        <asp:Parameter Name="Ffinal" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
            &nbsp;<asp:SqlDataSource ID="SqlDataGrafOneFci" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                    SelectCommand="select 
LogCorrienteFCIs.Fecha as [Fecha],
LogCorrienteFCIs.ValorIL as [ValorCorriente]
FROM LogCorrienteFCIs
WHERE LogCorrienteFCIs.Fecha between @Finicial and @Ffinal
and LogCorrienteFCIs.FCIId = @FciId
ORDER BY LogCorrienteFCIs.Fecha ASC
">
                    <SelectParameters>
                        <asp:Parameter Name="Finicial" />
                        <asp:Parameter Name="Ffinal" />
                        <asp:Parameter Name="FciId" />
                    </SelectParameters>
                </asp:SqlDataSource>

                &nbsp;<asp:SqlDataSource ID="SqlDataGrafOneFciCteProm" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                    SelectCommand="select 
EstadisticasFCIs.Fecha as [Fecha],
EstadisticasFCIs.ValorPromedioIL as [ValorCorriente]
FROM EstadisticasFCIs
WHERE EstadisticasFCIs.Fecha between @Finicial and @Ffinal
and EstadisticasFCIs.FCIId = @FciId
ORDER BY EstadisticasFCIs.Fecha ASC
">
                    <SelectParameters>
                        <asp:Parameter Name="Finicial" />
                        <asp:Parameter Name="Ffinal" />
                        <asp:Parameter Name="FciId" />
                    </SelectParameters>
                </asp:SqlDataSource>

            &nbsp;<asp:SqlDataSource ID="SqlDataThreeFcis" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                    SelectCommand="SELECT [FechaFCI1], [ValorIL1], [FechaFCI2], [ValorIL2], [FechaFCI3], [ValorIL3]
FROM [LogCorrienteFCIChart]"></asp:SqlDataSource>
            </td>
            <td align="left" width="50%" colspan="2">
                &nbsp;</td>
        </tr>
    </table>
    </form>
</body>
</html>
