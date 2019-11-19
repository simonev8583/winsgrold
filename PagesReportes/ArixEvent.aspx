<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ArixEvent.aspx.cs" Inherits="SistemaGestionRedes.PagesReportes.ArixEvent" %>
<%@ Register TagPrefix="rjs" Namespace="RJS.Web.WebControl" Assembly="RJS.Web.WebControl.PopCalendar.Net.2010, Version=8.1.4043.37381, Culture=neutral, PublicKeyToken=5edbe80336f06114" %>
<%@ Register TagPrefix="RK" Namespace="KrishLabs.Web.Controls" Assembly="ExportToExcel" %>

<!DOCTYPE html>

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
                    <td width="50%" align="right">&nbsp;</td>
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
                    <td width="50%" align="right">&nbsp;</td>
                    <td width="50%">
                        <rjs:PopCalendarMessageContainer ID="PopCalendarMessageContainer2"
                            runat="server" Calendar="PopCalFf" CenterText="True" />
                    </td>
                </tr>
            <tr>
                <td align="right" width="50%">
                    <asp:Label ID="Label9" runat="server"  CssClass="textLabelInUsuario"
                               Text="<%$ Resources:TextLblEvento %>"></asp:Label>
                </td>
                <td align="left" width="50%">
                    <asp:DropDownList ID="DDListFallas" runat="server" AppendDataBoundItems="True"
                                      DataSourceID="SqDSFallas" DataTextField="Nombre" DataValueField="Id" Font-Names="Microsoft Sans Serif"
                                      Font-Size="12px" OnSelectedIndexChanged="DDListEvents_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Text="<%$ Resources:TextTodosEventos %>" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
                <tr>
                    <td width="50%" align="right">&nbsp;</td>
                    <td width="50%">&nbsp;</td>
                </tr>
                <tr>
                    <td width="100%" colspan="2">
                        <asp:UpdatePanel ID="UpPanelFiltrosEquipos" runat="server">
                            <ContentTemplate>

                                <table align="center" width="60%">
                                    <tr>
                                        <td align="right" width="15%">
                                            <asp:Label ID="Label5" runat="server" CssClass="textLabelInUsuario"
                                                Text="<%$ Resources:TextosGlobales,TextLblConcentrador %>"></asp:Label>
                                        </td>
                                        <td align="left" width="10%">
                                            <asp:DropDownList ID="DDListCntrs" runat="server" AutoPostBack="True"
                                                CssClass="textInUsuario" DataSourceID="SqlDSFwts" DataTextField="Serial"
                                                DataValueField="Id" OnDataBound="DDListCntrs_DataBound" Width="110px"
                                                OnSelectedIndexChanged="DDListCntrs_SelectedIndexChanged">
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
                            OnClick="btnAceptar_Click" Visible="False" />
                        <asp:Button ID="btnNewAceptar" runat="server" CssClass="TextBoton"
                            OnClick="btnNewAceptar_Click" Text="<%$ Resources:TextosGlobales,TextBotonBuscar %>" />
                    </td>
                </tr>
                <tr>
                    <td width="50%" align="right">&nbsp;</td>
                    <td width="50%">&nbsp;</td>
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
                                <asp:BoundField DataField="Serial_Arix"
                                                HeaderText="<%$ Resources:TextosGlobales,TextoSerial_Arix %>"
                                                SortExpression="Serial_Arix" Visible="True" />
                                <asp:BoundField DataField="Serial_Fwt"
                                                HeaderText="<%$ Resources:TextosGlobales,TextoSerial_Fwt %>"
                                                SortExpression="Serial_Fwt" Visible="True" />
                                <asp:BoundField DataField="Descripcion"
                                                HeaderText="<%$ Resources:TextosGlobales,TextoDescripcion %>"
                                                SortExpression="Descripcion" Visible="True" />
                                <asp:TemplateField HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>"
                                    SortExpression="Fecha">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFecha" runat="server" Text='<%# Bind("Fecha") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ValorAdicional"
                                    HeaderText="<%$ Resources:TextosGlobales,TextoValorAdicional %>"
                                    SortExpression="ValorAdicional" Visible="True" />

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
                            EnableHyperLinks="True" ExportFileName="LogEventArix.xls"
                            IncludeTimeStamp="True" PageSize="All" Text="<%$ Resources:TextosGlobales,TextBotonExpoExcel %>" />
                        &nbsp;<asp:Button ID="btnGraficar" runat="server" CssClass="TextBoton"
                            OnClick="btnGraficar_Click" Text="<%$ Resources:TextBotonGraficar%>"
                            ToolTip="<%$ Resources:TextToolTipGraficar %>" />

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
                            Text="<%$ Resources:TextMsgGrafica %>"
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
                SelectCommand="select a.Serial as Serial_Arix, f.Serial as Serial_Fwt, alog.Codigo, te.Descripcion, alog.Fecha, alog.ValorAdicional from 
ARIX_LogEventos alog inner join
ARIX_TipoEventos te on (te.Codigo = alog.Codigo) inner join
ARIXs a on (alog.IdArix = a.Id) inner join
FWTs f on (f.Id = a.FWTId)
WHERE 
((@idAlarma is null) or (te.Codigo = @idAlarma) ) and
(alog.Fecha between @Finicial and @Ffinal) 
ORDER BY alog.Fecha DESC">
                <SelectParameters>
                    <asp:Parameter Name="Finicial" />
                    <asp:Parameter Name="Ffinal" />
                    <asp:Parameter Name="idAlarma" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlDSResultadosConSix" runat="server"
                ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>"
                SelectCommand="select a.Serial as Serial_Arix, f.Serial as Serial_Fwt, alog.Codigo, te.Descripcion, alog.Fecha, alog.ValorAdicional from 
ARIX_LogEventos alog inner join
ARIX_TipoEventos te on (te.Codigo = alog.Codigo) inner join
ARIXs a on (alog.IdArix = a.Id) inner join
FWTs f on (f.Id = a.FWTId)
  WHERE (alog.Fecha between @Finicial and @Ffinal)
 AND ((@idAlarma is null) or (te.Codigo = @idAlarma) )
  AND ((@idfwt is null) or (f.Id = @idfwt) )
AND ((@idequipo is null) or (a.Id in (select GUI_IDS_Equipos_Reportes.Col_Id from GUI_IDS_Equipos_Reportes where UserName = @usuario)) )
ORDER BY alog.Fecha DESC"
                CancelSelectOnNullParameter="False">
                <SelectParameters>
                    <asp:Parameter Name="Finicial" />
                    <asp:Parameter Name="Ffinal" />
                    <asp:Parameter Name="idAlarma" />
                    <asp:Parameter Name="idfwt" ConvertEmptyStringToNull="false" Type="Int32" />
                    <asp:Parameter Name="idequipo" ConvertEmptyStringToNull="false" Type="Int32" />
                    <asp:Parameter Name="usuario" ConvertEmptyStringToNull="false" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDSFwts" runat="server"
                ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>"
                SelectCommand="select distinct FWTs.Id, FWTs.Serial, FWTs.Codigo 
                   FROM FWTs, ARIXs
                   WHERE FWTs.Id = ARIXs.FWTId and ARIXs.TipoEquipo = 4
                   ORDER BY FWTs.Serial ASC"></asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDSSixs" runat="server"
                ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>"
                SelectCommand="select ARIXs.Id, ARIXs.Serial, ARIXs.Codigo, ARIXs.FWTId 
                   FROM ARIXs 
                   WHERE ARIXs.TipoEquipo = 4 and FWTId is not null
                   and ((@idfwt is null) or (FWTId = @idfwt))"
                CancelSelectOnNullParameter="false">
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
ARIX_InfoHardware.Fecha as [Fecha],
ARIX_InfoHardware.VoltActualSuperCapacitor as [ValorCorriente]
FROM ARIX_InfoHardware
WHERE ARIX_InfoHardware.Fecha between @Finicial and @Ffinal
and ARIX_InfoHardware.IdArix = @SixId
ORDER BY ARIX_InfoHardware.Fecha ASC
">
                <SelectParameters>
                    <asp:Parameter Name="Finicial" />
                    <asp:Parameter Name="Ffinal" />
                    <asp:Parameter Name="SixId" />
                </SelectParameters>
            </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlDSResultadosFechaUltimo" runat="server"
                ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>"
                SelectCommand="SELECT [CorrActuacionAperturaMax]
      ,[CorrActuacionCierreMax]
      ,[TiempoActuacionAperturaMax]
      ,[TiempoActuacionCierreMax]
      ,[TemperaturaMax]
      ,[TemperaturaMin]
      ,[VelActuacionAperturaMax]
      ,[VelActuacionCierreMax]
      ,[DesplazamientoContactosMax]
      ,[IdArix]
  FROM [SGRCelsa].[dbo].[ARIX_InfoHardware]
  WHERE 
   Fecha = (SELECT MAX(Fecha) FROM ARIX_InfoHardware where Fecha between @Finicial and @Ffinal)
ORDER BY Fecha ASC
">
                <SelectParameters>
                    <asp:Parameter Name="Finicial" />
                    <asp:Parameter Name="Ffinal" />
                </SelectParameters>
            </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqDSFallas" runat="server" 
                           ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                           SelectCommand="select Codigo as Id, Descripcion as Nombre From ARIX_TipoEventos ">
        </asp:SqlDataSource>

            <br />

        </div>
    </form>
</body>
</html>
