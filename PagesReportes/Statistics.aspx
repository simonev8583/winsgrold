<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="SistemaGestionRedes.Statistics" %>

<%@ Register assembly="RJS.Web.WebControl.PopCalendar.Net.2010" namespace="RJS.Web.WebControl" tagprefix="rjs" %>

<%@ Register assembly="ExportToExcel" namespace="KrishLabs.Web.Controls" tagprefix="RK" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="SistemaGestionRedes" Namespace="SistemaGestionRedes" TagPrefix="asp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
        
    </title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

    <script language="javascript" type="text/javascript">

        function abrirConfigColumnas() {
            window.open('ConfiguracionColumnas.aspx?IdReporte=20', '_blank', 'width=800,height=500');
            return false;
        }


        </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="TSMRepStdsFcis" runat="server">
    </asp:ScriptManager>
  
    <div class="rightDiv">
        
       
        <asp:SqlDataSource ID="SqlDSInfoCompleta" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="SELECT FCIs.Serial as [Serial],
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
SUM(EstadisticasFCIs.ContFallasPermanentes) AS FallasPermanentes, 
SUM(EstadisticasFCIs.ContFallasTemporales) AS FallasTemporales, 
SUM(EstadisticasFCIs.ContFallasTension) AS FallasTension, 
SUM(EstadisticasFCIs.Libre) AS Cont

FROM FCIs INNER JOIN EstadisticasFCIs ON FCIs.Id = EstadisticasFCIs.FCIId
JOIN FWTs on (FCIs.FWTId = FWTs.Id)

WHERE (EstadisticasFCIs.Fecha BETWEEN @Finicial and @Ffinal )
and ((@idfwt is null) or (FWTs.Id = @idfwt) )
and ((@idequipo is null) or (FCIs.Id in (select GUI_IDS_Equipos_Reportes.Col_Id from GUI_IDS_Equipos_Reportes where UserName = @usuario)) )

GROUP BY FCIs.Serial,
FCIs.Fase,
FCIs.Codigo,
FCIs.Identificador,
FWTs.Serial,
FWTs.Id,
FWTs.Codigo,
FWTs.ParamFWT_DireccionElectrica_SubEstacion,
FWTs.ParamFWT_DireccionElectrica_Circuito,
FWTs.ParamFWT_DireccionElectrica_Tramo,
FWTs.ParamFWT_DireccionElectrica_Nodo,
FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera,
FWTs.ParamFWT_DireccionNomenclatura_Ciudad,
FWTs.ParamFWT_DireccionNomenclatura_Numero,
FWTs.VersionPrograma,
FWTs.ASDU" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter Name="Finicial" ConvertEmptyStringToNull="false" Type="String" />
            <asp:Parameter Name="Ffinal" ConvertEmptyStringToNull="false" Type="String" />
            <asp:Parameter Name="idfwt" ConvertEmptyStringToNull="false" Type="Int32"  />
            <asp:Parameter Name="idequipo" ConvertEmptyStringToNull="false" Type="Int32"  />
            <asp:Parameter Name="usuario" ConvertEmptyStringToNull="false" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>





        <asp:SqlDataSource ID="SqlDSInfoCompletaCorriente" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="select FCIs.Serial as [Serial], 
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
EstadisticasFCIs.Fecha,
EstadisticasFCIs.ValorPromedioIL as [ValPromIL],
EstadisticasFCIs.ValorMaximoIL as [ValMaxIL],
EstadisticasFCIs.ValorMinimoIL as [ValMinIL],
EstadisticasFCIs.ValorActualIL as [ValActIL],
EstadisticasFCIs.Voltaje as [Voltaje],
EstadisticasFCIs.Tension as [Tension]
FROM FCIs JOIN EstadisticasFCIs on (FCIs.Id = EstadisticasFCIs.FCIId)
JOIN FWTs on (FCIs.FWTId = FWTs.Id)

WHERE (EstadisticasFCIs.Fecha BETWEEN @Finicial and @Ffinal )
and ((@idfwt is null) or (FWTs.Id = @idfwt) )
and ((@idequipo is null) or (FCIs.Id in (select GUI_IDS_Equipos_Reportes.Col_Id from GUI_IDS_Equipos_Reportes where UserName = @usuario)) )
and ((@tension is null) or (EstadisticasFCIs.Tension = @tension) )

ORDER BY EstadisticasFCIs.Fecha DESC" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter Name="Finicial" ConvertEmptyStringToNull="false" Type="String" />
            <asp:Parameter Name="Ffinal" ConvertEmptyStringToNull="false" Type="String" />
            <asp:Parameter Name="idfwt" ConvertEmptyStringToNull="false" Type="Int32"  />
            <asp:Parameter Name="idequipo" ConvertEmptyStringToNull="false" Type="Int32"  />
            <asp:Parameter Name="usuario" ConvertEmptyStringToNull="false" Type="String" />
            <asp:Parameter Name="tension" ConvertEmptyStringToNull="false" Type="Boolean" />
        </SelectParameters>
</asp:SqlDataSource>


        <asp:SqlDataSource ID="SqDSInfoLikeSerial" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="SELECT FCIs.Serial as [Serial],
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
SUM(EstadisticasFCIs.ContFallasPermanentes) AS FallasPermanentes, 
SUM(EstadisticasFCIs.ContFallasTemporales) AS FallasTemporales, 
SUM(EstadisticasFCIs.ContFallasTension) AS FallasTension, 
SUM(EstadisticasFCIs.Libre) AS Cont
FROM FCIs INNER JOIN EstadisticasFCIs ON FCIs.Id = EstadisticasFCIs.FCIId
JOIN FWTs on (FCIs.FWTId = FWTs.Id)
WHERE (EstadisticasFCIs.Fecha BETWEEN @Finicial and @Ffinal ) and (FCIId = @fciId)

GROUP BY FCIs.Serial,
FCIs.Fase,
FCIs.Codigo,
FCIs.Identificador,
FWTs.Serial,
FWTs.Codigo,
FWTs.ParamFWT_DireccionElectrica_SubEstacion,
FWTs.ParamFWT_DireccionElectrica_Circuito,
FWTs.ParamFWT_DireccionElectrica_Tramo,
FWTs.ParamFWT_DireccionElectrica_Nodo,
FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera,
FWTs.ParamFWT_DireccionNomenclatura_Ciudad,
FWTs.ParamFWT_DireccionNomenclatura_Numero,
FWTs.VersionPrograma,
FWTs.ASDU">


        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqDSInfoLikeSerialCorriente" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="select FCIs.Serial as [Serial], 
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
EstadisticasFCIs.Fecha,
EstadisticasFCIs.ValorPromedioIL as [ValPromIL],
EstadisticasFCIs.ValorMaximoIL as [ValMaxIL],
EstadisticasFCIs.ValorMinimoIL as [ValMinIL],
EstadisticasFCIs.ValorActualIL as [ValActIL],
EstadisticasFCIs.Voltaje as [Voltaje],
EstadisticasFCIs.Tension as [Tension]
FROM FCIs JOIN EstadisticasFCIs on (FCIs.Id = EstadisticasFCIs.FCIId)
JOIN FWTs on (FCIs.FWTId = FWTs.Id)
WHERE EstadisticasFCIs.Fecha between @Finicial and @Ffinal
AND FCIs.Serial like + @Serial + '%'
ORDER BY EstadisticasFCIs.Fecha DESC">
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDSFwts" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                    SelectCommand="select distinct FWTs.Id, FWTs.Serial, FWTs.Codigo 
                                   FROM FWTs, FCIs
                                   WHERE FWTs.Id = FCIs.FWTId and FCIs.TipoEquipo = 1
                                   ORDER BY FWTs.Serial ASC">
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDSFcis" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                    SelectCommand="select FCIs.Id, FCIs.Serial, FCIs.Codigo, FCIs.FWTId from FCIs where FCIs.TipoEquipo = 1">
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDSQueryFCIs" runat="server" 
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
        <br />

        <table width="100%">
            <tr>
                <td align="left" width="50%">
                    <asp:Label ID="Label3" runat="server" Text="<%$ Resources:TextTittleReporte %>" CssClass="NombreReporte"></asp:Label>
                </td>
                <td width="50%">
                </td>
            </tr>

            <tr>
                <td align="right" width="50%">
                    <asp:Label ID="Label1" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small" Text="<%$ Resources:TextosGlobales,TextFechaInicial %>"></asp:Label>
                </td>
                <td align="left" width="50%">
                    <asp:TextBox ID="txtFechaInicial" runat="server" 
                        Font-Names="Microsoft Sans Serif" Font-Size="12px" MaxLength="10" Width="100px"></asp:TextBox>
                        &nbsp;<rjs:PopCalendar ID="PopCalFi" runat="server" Control="txtFechaInicial" 
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
                <td align="right" width="50%">
                    <asp:Label ID="Label2" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small" Text="<%$ Resources:TextosGlobales,TextFechaFinal %>"></asp:Label>
                </td>

                <td align="left" width="50%">
                    <asp:TextBox ID="txtFechaFinal" runat="server" 
                        Font-Names="Microsoft Sans Serif" Font-Size="12px" MaxLength="10" Width="100px"></asp:TextBox>
                        &nbsp;<rjs:PopCalendar ID="PopCalFf" runat="server" Control="txtFechaFinal" 
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
                <%--Manejo del panel update para filtros de FWT con sus respectivos FCIs.--%>
                <td colspan="2">
                    <asp:UpdatePanel ID="UpPanelFiltrosEquipos" runat="server">
                    <ContentTemplate>
                        <table width="100%">
                            <tr>
                                <td align="right" width="40%">
                                    <asp:Label ID="Label11" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="12px"
                                        Text="<%$ Resources:TextosGlobales,TextLblConcentrador %>" CssClass="textLabelInUsuario"></asp:Label>:
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
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                </td>
            </tr>

            <tr>
                <td width="50%" align="right">
                    <asp:Label ID="Label4" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Smaller"
                         Text="<%$ Resources:TextMsgSoloFCISinTension %>" CssClass="textLabelInUsuario"></asp:Label>
                </td>

                <td width="50%" align="left">
                    <asp:CheckBox ID="ChkSoloAusenciaTension" runat="server" />
                </td>
            </tr>

            <tr>
                <td align="right" width="50%"> 
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" 
                        onclick="btnBuscar_Click" CssClass="TextBoton" Visible="False" /> 
                    <asp:Button ID="btnNewBuscar" runat="server" onclick="btnNewBuscar_Click" 
                        Text="<%$ Resources:TextosGlobales,TextBotonBuscar %>" />
                </td>
                
                <td width="50%"> 
                    <asp:Button ID="btnIrConfigColumnas" runat="server" CssClass="TextBoton" Text="<%$ Resources:TextosGlobales,TextBotonColoumnas %>" UseSubmitBehavior="False" OnClientClick="return abrirConfigColumnas();" Width="85px" />
                </td>
            </tr>

        </table>
        
        <asp:Label ID="Label9" runat="server" Font-Names="Microsoft Sans Serif" 
            Font-Size="Small" Text="Serial FCI: " Visible="False"></asp:Label>
            <asp:DropDownList ID="txtSerialFCI" runat="server" AutoPostBack="False" 
                Visible="False" >
            </asp:DropDownList>

        <center>
        <asp:GridView ID="GVReporte" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" Font-Names="Microsoft Sans Serif" Font-Size="11px" 
            ForeColor="#333333" GridLines="None" 
                AllowPaging="True" AllowSorting="True" Caption="<%$ Resources:TextCaptionContadores %>">
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
                
                <asp:BoundFieldCel DataField="FallasPermanentes" HeaderText="<%$ Resources:TextColFallasPermanentes %>" SortExpression="FallasPermanentes" Name="Fallas Permanentes" />

                <asp:BoundFieldCel DataField="FallasTemporales" HeaderText="<%$ Resources:TextColFallasTemporales %>" SortExpression="FallasTemporales" Name="Fallas Temporales" />
                
                <asp:BoundFieldCel DataField="FallasTension" HeaderText="<%$ Resources:TextColFallasTension %>" SortExpression="FallasTension" Name="Fallas Tensión" />

                <asp:BoundFieldCel DataField="Cont" HeaderText="<%$ Resources:TextColContador %>" SortExpression="Cont" Name="Cont" />
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
            <br />
        </center>
        <center>
        <asp:GridView ID="GVReporteCorriente" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" Font-Names="Microsoft Sans Serif" Font-Size="11px" 
            ForeColor="#333333" GridLines="None" 
                AllowPaging="True" AllowSorting="True" Caption="<%$ Resources:TextCaptionCorrientes %>" 
                onrowdatabound="GVReporteCorriente_RowDataBound" 
                ondatabound="GVReporteCorriente_DataBound">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundFieldCel DataField="Serial" HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" SortExpression="Serial" Name="Serial" />

                <asp:BoundFieldCel DataField="Codigo" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoEquipo %>" SortExpression="Codigo" Visible="false" Name="Código FCI"  />

                <asp:BoundFieldCel DataField="Identificador" HeaderText="<%$ Resources:TextosGlobales,TextoIdentificadorEquipo %>" SortExpression="Identificador" Visible="false" Name="Identificador" />

                <asp:BoundFieldCel DataField="Fase" HeaderText="<%$ Resources:TextosGlobales,TextoFase %>" SortExpression="Fase" Visible="false" Name="Fase" />

                <asp:BoundFieldCel DataField="Serial_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoSerialFWT %>" SortExpression="Serial_FWT" Visible="false" Name="Serial FWT" />

                <asp:BoundFieldCel DataField="Codigo_FWT" HeaderText="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" SortExpression="Codigo_FWT" Visible="false" Name="Código FWT" />

                <asp:BoundFieldCel DataField="Subestacion" HeaderText="<%$ Resources:TextosGlobales,TextoSubestacion %>" SortExpression="SubEstacion" Visible="false" Name="SubEstación" />
                
                <asp:BoundFieldCel DataField="Circuito" HeaderText="<%$ Resources:TextosGlobales,TextoCircuito %>" SortExpression="Circuito" Visible="false" Name="Circuito" />
                
                <asp:BoundFieldCel DataField="Tramo" HeaderText="<%$ Resources:TextosGlobales,TextoSeccionTramo %>" SortExpression="Tramo" Visible="false" Name="Tramo" />

                <asp:BoundFieldCel DataField="Nodo" HeaderText="<%$ Resources:TextosGlobales,TextoNodo %>" SortExpression="Nodo" Visible="false" Name="Nodo" />

                <asp:BoundFieldCel DataField="Calle_Cra" HeaderText="<%$ Resources:TextosGlobales,TextoCalleKra %>" SortExpression="Calle_Cra" Visible="false" Name="Calle-Cra" />

                <asp:BoundFieldCel DataField="Numero" HeaderText="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>" SortExpression="Numero" Visible="false" Name="Número" />

                <asp:BoundFieldCel DataField="Ciudad" HeaderText="<%$ Resources:TextosGlobales,TextCiudad %>" SortExpression="Ciudad" Visible="false" Name="Ciudad" />

                <asp:BoundFieldCel DataField="Version_Fw" HeaderText="<%$ Resources:TextosGlobales,TextoVersionFw %>" SortExpression="Version_Fw" Visible="false" Name="Version Programa" />

                <asp:BoundFieldCel DataField="Asdu" HeaderText="<%$ Resources:TextosGlobales,TextoASDU %>" SortExpression="Asdu" Visible="false" Name="ASDU" />

                <asp:TemplateField HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>"
                                    SortExpression="Fecha">
                                    <ItemTemplate>                                        
                                        <asp:Label ID="lblFecha" runat="server" Text='<%# string.Format("{0:dd-MM-yyyy HH:mm:ss}",Convert.ToDateTime(Eval("Fecha")).AddHours(0))%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                
                <asp:BoundFieldCel DataField="ValPromIL" HeaderText="<%$ Resources:TextColValorPrmCte %>" SortExpression="ValPromIL" Name="Valor Promedio Corriente" />

                <asp:BoundFieldCel DataField="ValMaxIL" HeaderText="<%$ Resources:TextColValorMaxCte %>" SortExpression="ValMaxIL" Name="Valor Máximo Corriente" />

                <asp:BoundFieldCel DataField="ValMinIL" HeaderText="<%$ Resources:TextColValorMinCte %>" SortExpression="ValMinIL" Name="Valor Minimo Corriente" />

                <asp:BoundFieldCel DataField="ValActIL" HeaderText="<%$ Resources:TextColPresentCte %>" SortExpression="ValActIL" Name="Valor Actual Corriente" />

                <asp:TemplateFieldCel HeaderText="<%$ Resources:TextColTension %>" Name="Tensión" >
                    <ItemTemplate>
                        <asp:Label ID="lblTension" runat="server" Text='<%# Bind("Tension") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateFieldCel>

                <%--La siguiente columna debe ser siemrpe la ultima--%>
                <asp:TemplateFieldCel HeaderText="<%$ Resources:TextColVoltaje %>" Name="Voltaje" Visible="true" >
                    <ItemTemplate>
                        <asp:Label ID="lblVoltaje" runat="server" Text='<%# Bind("Voltaje") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateFieldCel>

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
            <br />
        </center>

    <p>
        <center>
          <RK:ExportToExcel ID="ExportToExcel1" runat="server" ApplyStyleInExcel="True" 
            Charset="utf-8" ContentEncoding="windows-1250" EnableHyperLinks="False" 
            ExportFileName="EstadisticasFCI.xls" GridViewID="GVReporteCorriente" 
            IncludeTimeStamp="True" PageSize="All" Text="<%$ Resources:TextosGlobales,TextBotonExpoExcel %>" CssClass="TextBoton" />
          </center>
            
        <br />
        
        
        <center>
        <asp:Label ID="LblMsgNoData" runat="server" Font-Bold="True" 
            Font-Names="Microsoft Sans Serif" Font-Size="Large" 
            Text="<%$ Resources:TextosGlobales,TextMsgRepNoData %>" Visible="False"></asp:Label>
        </center>
        </p>
    </div>
    </form>
</body>
</html>
