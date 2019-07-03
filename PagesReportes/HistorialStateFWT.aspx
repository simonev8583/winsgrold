<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistorialStateFWT.aspx.cs" Inherits="SistemaGestionRedes.PagesReportes.HistorialStateFWT" %>

<%@ Register assembly="RJS.Web.WebControl.PopCalendar.Net.2010" namespace="RJS.Web.WebControl" tagprefix="rjs" %>

<%@ Register assembly="ExportToExcel" namespace="KrishLabs.Web.Controls" tagprefix="RK" %>

<%@ Register Assembly="SistemaGestionRedes" Namespace="SistemaGestionRedes" TagPrefix="asp" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <title></title>
    

    <script language="javascript" type="text/javascript">

        function abrirConfigColumnas() {
            window.open('ConfiguracionColumnas.aspx?IdReporte=70', '_blank', 'width=800,height=500');
            return false;
        }

        </script>

</head>
<body>
        <form id="form1" runat="server">
  
        
  
    <div class="rightDiv">
        <asp:Label ID="Label10" runat="server" CssClass="NombreReporte" 
            Text="<%$ Resources:TextTittleReporte %>"></asp:Label>
            <br />

        <asp:SqlDataSource ID="SqlDSInfoCompleta" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="select
FWTs.Id as [FWT], 
FWTs.Serial as [Serial],
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
HistorialEstadosFWTs.Fecha,
CAST(LEFT(HistorialEstadosFWTs.VoltajeBatt, LEN(HistorialEstadosFWTs.VoltajeBatt) - 1) + '.'  +  RIGHT(HistorialEstadosFWTs.VoltajeBatt ,1) as DECIMAL(5,1)) as [VoltajeBatt],
CAST(LEFT(HistorialEstadosFWTs.VoltajePanel , LEN(HistorialEstadosFWTs.VoltajePanel) - 1) + '.'  +  RIGHT(HistorialEstadosFWTs.VoltajePanel ,1) as DECIMAL(5,1)) as [VoltajePanel],
HistorialEstadosFWTs.Temperatura as [Temperatura]
FROM FWTs JOIN HistorialEstadosFWTs on (FWTs.Id = HistorialEstadosFWTs.FWTId)
WHERE HistorialEstadosFWTs.Fecha between @Finicial and @Ffinal 
ORDER BY HistorialEstadosFWTs.Fecha DESC
">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqDSInfoLikeSerial" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="select
FWTs.Id as [FWT], 
FWTs.Serial as [Serial],
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
HistorialEstadosFWTs.Fecha,
CAST(LEFT(HistorialEstadosFWTs.VoltajeBatt, LEN(HistorialEstadosFWTs.VoltajeBatt) - 1) + '.'  +  RIGHT(HistorialEstadosFWTs.VoltajeBatt ,1) as DECIMAL(5,1)) as [VoltajeBatt],
CAST(LEFT(HistorialEstadosFWTs.VoltajePanel , LEN(HistorialEstadosFWTs.VoltajePanel) - 1) + '.'  +  RIGHT(HistorialEstadosFWTs.VoltajePanel ,1) as DECIMAL(5,1)) as [VoltajePanel],
HistorialEstadosFWTs.Temperatura as [Temperatura]
FROM FWTs JOIN HistorialEstadosFWTs on (FWTs.Id = HistorialEstadosFWTs.FWTId)
WHERE HistorialEstadosFWTs.Fecha between @Finicial and @Ffinal
AND FWTs.Serial like + @Serial + '%'
ORDER BY HistorialEstadosFWTs.Fecha DESC">
        </asp:SqlDataSource>
    
    <div   style="position:absolute;top:0;right:0;">
                <asp:Literal ID="Literal3" Text="<%$ Resources:TextTiempoActual %>" runat="server"></asp:Literal>
                
                <br />
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:UpdatePanel ID="upPanTimeActual" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lblTimeActual" runat="server" onload="lblTimeActual_Load"></asp:Label>
                    <asp:Timer ID="tmrTimeActual" runat="server" Interval="1000" 
                        ontick="tmrTimeActual_Tick">
                    </asp:Timer>
                </ContentTemplate>
                </asp:UpdatePanel>
    </div>
   
        <div style="width:90%; margin-left:auto;margin-right:auto;">
            <center>
                <asp:Label ID="Label1" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small"
                    Text="<%$ Resources:TextosGlobales,TextFechaInicial %>"></asp:Label>
                <asp:TextBox ID="txtFechaInicial" runat="server" Font-Names="Microsoft Sans Serif"
                    Font-Size="12px" MaxLength="10" Width="100px"></asp:TextBox>
                &nbsp;<rjs:PopCalendar ID="PopCalFi" runat="server" Control="txtFechaInicial" 
                        Format="yyyy mm dd" From-Date="2011-01-01" 
                        From-Message="<%$ Resources:TextosGlobales,TextCalendarFiFromMessage %>" 
                        InvalidDateMessage="<%$ Resources:TextosGlobales,TextCalendarFiInvalidDateMessage %>" 
                        RequiredDate="True" RequiredDateMessage="<%$ Resources:TextosGlobales,TextCalendarFiRequiredDateMessage %>" 
                        To-Message="<%$ Resources:TextosGlobales,TextCalendarFiToMessage %>" />
                <br />
                <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer1" runat="server"
                    Calendar="PopCalFi" CenterText="True" />
                <br />
                <br />
                <asp:Label ID="Label2" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small"
                    Text="<%$ Resources:TextosGlobales,TextFechaFinal %>"></asp:Label>
                <asp:TextBox ID="txtFechaFinal" runat="server" Font-Names="Microsoft Sans Serif"
                    Font-Size="12px" MaxLength="10" Width="100px"></asp:TextBox>
                &nbsp;<rjs:PopCalendar ID="PopCalFf" runat="server" Control="txtFechaFinal" 
                        Format="yyyy mm dd" From-Control="txtFechaInicial" From-Date="" 
                        From-Message="<%$ Resources:TextosGlobales,TextCalendarFfFromMessage %>" 
                        InvalidDateMessage="<%$ Resources:TextosGlobales,TextCalendarFfInvalidDateMessage %>" 
                        RequiredDate="True" RequiredDateMessage="<%$ Resources:TextosGlobales,TextCalendarFfRequiredDateMessage %>" 
                        To-Message="<%$ Resources:TextosGlobales,TextCalendarFfToMessage %>" />
                <br />
                <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer2" runat="server"
                    Calendar="PopCalFf" CenterText="True" />
                <br />
                <br />
                <asp:Label ID="Label9" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small"
                    Text="<%$ Resources:TextosGlobales,TextoSerialFWT %>"></asp:Label>:
                <asp:DropDownList ID="txtSerialFWT" runat="server" AutoPostBack="False">
                </asp:DropDownList>
                <br />
                <br />
                <br />
                <asp:Button ID="btnBuscar" runat="server" Text="<%$ Resources:TextosGlobales,TextBotonBuscar %>" 
                    OnClick="btnBuscar_Click" CssClass="TextBoton" />
            &nbsp;<asp:Button ID="btnIrConfigColumnas" runat="server" CssClass="TextBoton" 
                                    Text="<%$ Resources:TextosGlobales,TextBotonColoumnas %>" UseSubmitBehavior="False" 
                                    OnClientClick="return abrirConfigColumnas();" Width="85px" />
            </center>
            <br />
            <center>
                <asp:CheckBox ID="ckBoxRefreshReporte" runat="server" OnCheckedChanged="ckBoxRefreshReporte_CheckedChanged"
                    AutoPostBack="True" />
                <asp:Literal ID="Literal1" Text="<%$ Resources:TextRefrescarMsg %>" runat="server"></asp:Literal>
                 &nbsp;
                <asp:DropDownList ID="ddListIntervalRefresh" runat="server" 
                    onselectedindexchanged="ddListIntervalRefresh_SelectedIndexChanged">
                    <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>30</asp:ListItem>
                    <asp:ListItem>40</asp:ListItem>
                    <asp:ListItem>50</asp:ListItem>
                    <asp:ListItem Selected="True">60</asp:ListItem>
                </asp:DropDownList>
                <asp:Literal ID="Literal2" Text="<%$ Resources:TextosGlobales,TextoSecs %>" runat="server"></asp:Literal>.
                &nbsp; 
            </center>
            <br />
            <center>
                
                <!-- Necesario para que se actualice solo esta Zona sin necesidad de Postback-->
                <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Timer ID="tmrRefreshReporte" runat="server" Interval="5000" OnTick="tmrRefreshReporte_Tick"
                            Enabled="False">
                        </asp:Timer>
                        <asp:GridView ID="GVReporte" runat="server" AutoGenerateColumns="False" CellPadding="5"
                            Font-Names="Microsoft Sans Serif" Font-Size="11px" ForeColor="#333333" GridLines="None"
                            OnDataBound="GVReporte_DataBound" AllowPaging="True" AllowSorting="True" CellSpacing="5"
                            Caption="<%$ Resources:TextCaptionResultados %>">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:HyperLinkField DataNavigateUrlFields="FWT" DataNavigateUrlFormatString="~/PagesEquipment/EditFWT.aspx?id={0}" DataTextField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial" />

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

                                <asp:BoundFieldCel DataField="VoltajeBatt" HeaderText="<%$ Resources:TextColVoltajeBateria %>" SortExpression="VoltajeBatt" Name="Voltaje Bateria" />

                                <asp:BoundFieldCel DataField="VoltajePanel" HeaderText="<%$ Resources:TextColVoltajePanel %>" SortExpression="VoltajePanel" Name="Voltaje Panel" />

                                <asp:BoundFieldCel DataField="Temperatura" HeaderText="<%$ Resources:TextColTemperatura %>" SortExpression="Temperatura" Name="Temperatura" />

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
                    </ContentTemplate>
                </asp:UpdatePanel>
                <br />
            </center>
            <p>
                <center>
                    <RK:ExportToExcel ID="ExportToExcel1" runat="server" ApplyStyleInExcel="True" Charset=""
                        ContentEncoding="windows-1250" EnableHyperLinks="False" ExportFileName="EstadosHistoricosFWT.xls"
                        GridViewID="GVReporte" IncludeTimeStamp="True" PageSize="All" 
                        Text="<%$ Resources:TextosGlobales,TextBotonExpoExcel %>" 
                        CssClass="TextBoton" />
                </center>
                <br />
                <center>
                    <asp:Label ID="LblMsgNoData" runat="server" Font-Bold="True" Font-Names="Microsoft Sans Serif"
                        Font-Size="Large" Text="<%$ Resources:TextosGlobales,TextMsgRepNoData %>" Visible="False"></asp:Label>
                </center>
            </p>
        </div>
    
    
    </div>
    </form>

</body>
</html>
