<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Historial.aspx.cs" Inherits="SistemaGestionRedes.Historial"  %>
<%@ Register assembly="RJS.Web.WebControl.PopCalendar.Net.2010" namespace="RJS.Web.WebControl" tagprefix="rjs" %>
<%@ Register assembly="ExportToExcel" namespace="KrishLabs.Web.Controls" tagprefix="RK" %>
<%@ Register Assembly="SistemaGestionRedes" Namespace="SistemaGestionRedes" TagPrefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <title></title>
    
    <style type="text/css">
        #form1
        {
            text-align: left;
        }
        </style>

        <script language="javascript" type="text/javascript">

            function abrirConfigColumnas() {
                window.open('ConfiguracionColumnas.aspx?IdReporte=10', '_blank', 'width=800,height=500');
                return false;
            }


        </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
 
        <center>
 
                
                    <br />
                    <table width="100%">
                        <tr>
                            <td align="left" width="50%">
 
                
        <asp:Label ID="LblTituloReporte" runat="server" CssClass="NombreReporte" 
            Text="<%$ Resources:TextTittleReporte %>"></asp:Label>
 
                            </td>
                            <td align="left" width="50%">
                                <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
                                </asp:ScriptManager>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="50%">
 
                
                    <asp:Label ID="Label1" runat="server" Font-Names="Microsoft Sans Serif" 
            Font-Size="Small" Text="<%$ Resources:TextosGlobales,TextFechaInicial %>"></asp:Label>
                            </td>
                            <td align="left" width="50%">
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
                            <td align="right" width="50%">
       <asp:Label ID="Label2" runat="server" Font-Names="Microsoft Sans Serif" 
            Font-Size="13px" Text="<%$ Resources:TextosGlobales,TextFechaFinal %>"></asp:Label>
                            </td>
                            <td align="left" width="50%">
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
                            <td align="right" width="50%">
            <asp:Label ID="Label9" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="Small"
                Text="<%$ Resources:TextLblFalla %>"></asp:Label>
                            </td>
                            <td align="left" width="50%">
                                <asp:DropDownList ID="DDListFallas" runat="server" AppendDataBoundItems="True"
                DataSourceID="SqDSFallas" DataTextField="Nombre" DataValueField="Id" Font-Names="Microsoft Sans Serif"
                Font-Size="12px">
                <asp:ListItem Selected="True" Text="<%$ Resources:TextTodasFallas %>" Value="0"></asp:ListItem>
            </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" width="100%">
                                <asp:UpdatePanel ID="UpPanelEquipos" runat="server">
                                    <ContentTemplate>
                                        <table width="100%">
                                            <tr>
                                                <td colspan="2" width="50%" align="right">
                                                    <asp:Label ID="Label10" runat="server" Font-Names="Microsoft Sans Serif" 
                                                        Font-Size="12px" Text="<%$ Resources:TextLblEquipo %>"></asp:Label>
                                                </td>
                                                <td colspan="2" width="50%" align="left">
                                                    <asp:DropDownList ID="DDListEquipos" runat="server" AutoPostBack="True" 
                                                        Font-Names="Microsoft Sans Serif" Font-Size="12px" 
                                                        onselectedindexchanged="DDListEquipos_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" width="40%">
                                                    <asp:Label ID="Label11" runat="server" Font-Names="Microsoft Sans Serif" 
                                                        Font-Size="12px" Text="<%$ Resources:TextosGlobales,TextLblConcentrador %>"></asp:Label>
                                                </td>
                                                <td align="left" width="10%">
                                                    <asp:DropDownList ID="DDListCntrs" runat="server" AutoPostBack="True" 
                                                        CssClass="textInUsuario" ondatabound="DDListCntrs_DataBound" 
                                                        onselectedindexchanged="DDListCntrs_SelectedIndexChanged" Width="110px" 
                                                        DataSourceID="SqlDSFwts" DataTextField="Serial" DataValueField="Id">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="right" width="7%">
                                                    <asp:Label ID="lblDescTipoEquipo" runat="server" Font-Names="Microsoft Sans Serif" 
                                                        Font-Size="12px" Text="FCI/SIX:"></asp:Label>
                                                </td>
                                                <td align="left" width="43%">
                                                    <asp:ListBox ID="LstBoxFcis" runat="server" CssClass="textInUsuario" 
                                                        Height="70px" SelectionMode="Multiple" Width="110px" 
                                                        DataSourceID="SqlDSFcis" DataTextField="Serial" DataValueField="Id"></asp:ListBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" width="100%">
                                <asp:Button ID="Button1" runat="server" Text="<%$ Resources:TextosGlobales,TextBotonBuscar %>" onclick="Button1_Click" Height="25px" />
                            &nbsp;
                                &nbsp;<asp:Button ID="btnIrConfigColumnas" runat="server" CssClass="TextBoton" 
                                    Text="<%$ Resources:TextosGlobales,TextBotonColoumnas %>" UseSubmitBehavior="False" 
                                    OnClientClick="return abrirConfigColumnas();" Width="85px" />
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" width="100%">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" width="100%">
        <asp:GridView ID="GVFCIData" runat="server" CellPadding="4" 
            Font-Names="Microsoft Sans Serif" Font-Size="11px" ForeColor="#333333" 
            GridLines="None" AllowPaging="True" 
                DataSourceID="EnDSFallasHistFCI" AutoGenerateColumns="False" 
                AllowSorting="True" onrowdatabound="GVFCIData_RowDataBound">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateFieldCel HeaderText="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" SortExpression="Serial" Name="Serial" >
                    <ItemTemplate> <%# Eval("Serial") %> </ItemTemplate>
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

                <asp:TemplateFieldCel HeaderText="<%$ Resources:TextosGlobales,TextoFalla %>" SortExpression="Nombre" Name="Falla">
                    <ItemTemplate> <%# Eval("Nombre") %> </ItemTemplate>
                </asp:TemplateFieldCel>

                <asp:BoundFieldCel DataField="Fecha" HeaderText="<%$ Resources:TextColFechaInicio %>" SortExpression="Fecha" Name="Fecha Inicio" />

                <asp:BoundFieldCel DataField="ClearAlarma" HeaderText="<%$ Resources:TextColFechaClear %>" SortExpression="ClearAlarma" Name="Fecha Clear" />

                <asp:BoundFieldCel DataField="DuracionTime" HeaderText="<%$ Resources:TextColDuracion %>" SortExpression="DuracionTime" Name="Duración" />

                <asp:TemplateFieldCel HeaderText="<%$ Resources:TextosGlobales,TextoValorCorriente %>" Name="Valor" >
                    <ItemTemplate> <asp:Label ID="lblValor" runat="server" Text='<%# Bind("Valor") %>'></asp:Label> </ItemTemplate>
                </asp:TemplateFieldCel>

                <asp:TemplateFieldCel HeaderText="<%$ Resources:TextColCausaAperturaSix %>" Name="CausaApertura" >
                    <ItemTemplate> <asp:Label ID="lblCausaApertura" runat="server" Text='<%# Bind("CausaApertura") %>'></asp:Label> </ItemTemplate>
                </asp:TemplateFieldCel>

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
                            <td align="center" colspan="2" width="100%">
        <RK:ExportToExcel ID="ExportToExcel1" runat="server" ApplyStyleInExcel="True" 
            Charset="utf-8" ContentEncoding="windows-1250" EnableHyperLinks="True" 
            ExportFileName="HistorialFallasFCI.xls" GridViewID="GVFCIData" 
            IncludeTimeStamp="True" PageSize="All" Text="<%$ Resources:TextosGlobales,TextBotonExpoExcel %>" CssClass="TextBoton" />
                            &nbsp;<asp:Button ID="btnGrafFwtFallas" runat="server" CssClass="TextBoton" 
                                    onclick="btnGrafFwtFallas_Click" Text="<%$ Resources:TextBotonGrafFWT_Fallas %>" 
                                    ToolTip="<%$ Resources:TextToolTipGrafFWT_Fallas %>" 
                                    Width="150px" />
                            &nbsp;<asp:Button ID="btnGraficarFallas" runat="server" CssClass="TextBoton" 
                                    onclick="btnGraficarFallas_Click" Text="<%$ Resources:TextBotonQtyFallas %>" 
                                    Width="135px" 
                                    ToolTip="<%$ Resources:TextToolTipGrafQtyFallas %>" />
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" width="100%">
                                <asp:Label ID="lblMsgNoData" runat="server" Font-Size="13px" 
                                    style="text-align: left" Text="<%$ Resources:TextosGlobales,TextMsgRepNoData %>" 
                                    Visible="False" Font-Bold="True" Font-Names="Microsoft Sans Serif"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" width="100%">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" width="100%">
                                <asp:Chart ID="chartReporte" runat="server" EnableViewState="True" 
                                    ViewStateMode="Enabled" Width="700px" Height="400px">
                                    <ChartAreas>
                                        <asp:ChartArea Name="CArea1">
                                        </asp:ChartArea>
                                    </ChartAreas>
                                    <Titles>
                                        <asp:Title Name="Unico" TextOrientation="Horizontal">
                                        </asp:Title>
                                    </Titles>
                                </asp:Chart>
                                <br />
                                <asp:Label ID="lblTextErrQtyFallasFwt" runat="server" CssClass="TextError" 
                                    Text="<%$ Resources:TextlblTextErrQtyFallasFwt %>" Visible="False"></asp:Label>
                                <br />
                                <asp:Label ID="lblMegErrTodasFallas" runat="server" CssClass="TextError" 
                                    Text="<%$ Resources:TextlblMegErrTodasFallas %>" 
                                    Visible="False"></asp:Label>
                                <br />
                                <asp:Label ID="lblMsgErrNoVariosFcis" runat="server" CssClass="TextError" 
                                    Text="<%$ Resources:TextlblMsgErrNoVariosFcis %>" 
                                    Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="2" width="100%">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td align="left" colspan="2" width="100%">
 
        <asp:EntityDataSource ID="EnDSFallasHistFCI" runat="server" 
            ConnectionString="name=SistemaGestionRemotoContainer" 
            DefaultContainerName="SistemaGestionRemotoContainer" 
            EntitySetName="vw_app_alarmasFCI" 
            Where="it.[ClearAlarma] is not null"  
            onselecting="EnDSFallasHistFCI_Selecting" EnableFlattening="False"
            OrderBy="it.Fecha DESC" 
            >
        </asp:EntityDataSource>

        <asp:EntityDataSource ID="EnDSFallasHistFCI_en" runat="server" 
            ConnectionString="name=SistemaGestionRemotoContainer" 
            DefaultContainerName="SistemaGestionRemotoContainer" 
            EntitySetName="vw_app_alarmasFCI_en" 
            Where="it.[ClearAlarma] is not null"  
            EnableFlattening="False"
            OrderBy="it.Fecha DESC" 
            >
        </asp:EntityDataSource>

                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="2" width="100%">
        <asp:SqlDataSource ID="SqDSFallas" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="select MtAlarmas_Lenguaje.Id, MtAlarmas_Lenguaje.Nombre 
                    FROM MtAlarmas, MtAlarmas_Lenguaje, MtLenguajes
                    WHERE MtAlarmas.Id = MtAlarmas_Lenguaje.Id 
                    and CHARINDEX('Clear', MtAlarmas.Nombre, 1) = 0 AND MtAlarmas.TipoEquipo = 'A'
                    and MtAlarmas_Lenguaje.Lang = MtLenguajes.Id
                    and MtLenguajes.Cod = @IdLang ">
            <SelectParameters>
                 <asp:Parameter Name="IdLang" />
             </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDSFwts" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
            SelectCommand="select 
                    FWTs.Id,
                    FWTs.Serial,
                    FWTs.Codigo
                    FROM FWTs
                    ORDER BY FWTs.Serial ASC">
          </asp:SqlDataSource>

          <asp:SqlDataSource ID="SqlDSFcis" runat="server" 
               ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
               SelectCommand="select 
                    FCIs.Id,
                    FCIs.Serial,
                    FCIs.Codigo,
                    FCIs.FWTId
                    from FCIs
                    where FCIs.TipoEquipo = @tipoEquipo">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DDListEquipos" Name="tipoEquipo" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
                            <td align="left" colspan="2" width="100%">
   
   <asp:QueryExtender ID="qExFechas" runat="server" 
        TargetControlID="EnDSFallasHistFCI">
        <asp:MethodExpression MethodName="FiltrarPorFecha">
        </asp:MethodExpression>
   </asp:QueryExtender>

    <asp:QueryExtender ID="qExFalla" runat="server" 
        TargetControlID="EnDSFallasHistFCI">
        <asp:MethodExpression MethodName="FiltrarPorFalla">
        </asp:MethodExpression>
    </asp:QueryExtender>

    <asp:QueryExtender ID="qExTipoEquipo" runat="server" 
        TargetControlID="EnDSFallasHistFCI">
        <asp:MethodExpression MethodName="FiltrarPorEquipo">
        </asp:MethodExpression>
    </asp:QueryExtender>

    <asp:QueryExtender ID="qExPorFwt_Fcis" runat="server" 
        TargetControlID="EnDSFallasHistFCI">
        <asp:MethodExpression MethodName="FiltrarPorFciFromFwt">
        </asp:MethodExpression>
    </asp:QueryExtender>

    <%--QueryExtender para el DS en inglés--%>

       <asp:QueryExtender ID="qExFechas_en" runat="server" 
        TargetControlID="EnDSFallasHistFCI_en">
        <asp:MethodExpression MethodName="FiltrarPorFechaEn">
        </asp:MethodExpression>
   </asp:QueryExtender>

    <asp:QueryExtender ID="qExFalla_en" runat="server" 
        TargetControlID="EnDSFallasHistFCI_en">
        <asp:MethodExpression MethodName="FiltrarPorFallaEn">
        </asp:MethodExpression>
    </asp:QueryExtender>

    <asp:QueryExtender ID="qExTipoEquipo_en" runat="server" 
        TargetControlID="EnDSFallasHistFCI_en">
        <asp:MethodExpression MethodName="FiltrarPorEquipoEn">
        </asp:MethodExpression>
    </asp:QueryExtender>

    <asp:QueryExtender ID="qExPorFwt_Fcis_en" runat="server" 
        TargetControlID="EnDSFallasHistFCI_en">
        <asp:MethodExpression MethodName="FiltrarPorFciFromFwtEn">
        </asp:MethodExpression>
    </asp:QueryExtender>


                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="2" width="100%">
                                <asp:SqlDataSource ID="SqlDSGrafFwtsQtyFallas" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                                    SelectCommand="select 
                                    FWTs.Serial as [SerialFWT], FWTs.Codigo as [CodigoFWT], COUNT(*) as TotalEventos
from AlarmasFCI join FCIs on AlarmasFCI.FCIId = FCIs.Id
join FWTs on FCIs.FWTId = FWTs.Id
where AlarmasFCI.Fecha between @finicial and @ffinal
and AlarmasFCI.ClearAlarma is not null
and AlarmasFCI.Id = @idAlarma
group by FWTs.Serial, FWTs.Codigo">
                                    <SelectParameters>
                                        <asp:Parameter Name="finicial" />
                                        <asp:Parameter Name="ffinal" />
                                        <asp:Parameter Name="idAlarma" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="SqlDSGrafFallasQty" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                                    SelectCommand="select 
                                    MtAlarmas_Lenguaje.Nombre, COUNT(*) as TotalEventos
from AlarmasFCI join MtAlarmas_Lenguaje on AlarmasFCI.Id = MtAlarmas_Lenguaje.Id
join MtLenguajes on MtAlarmas_Lenguaje.Lang = MtLenguajes.Id
join FCIs on AlarmasFCI.FCIId = FCIs.Id 
where AlarmasFCI.Fecha between @finicial and @ffinal
and AlarmasFCI.ClearAlarma is not null
and MtLenguajes.Cod = @codIdioma
and AlarmasFCI.Id in (164, 178, 179, 161) 
and AlarmasFCI.FCIId = 0
and FCIs.FWTId = 0
group by MtAlarmas_Lenguaje.Nombre
" ViewStateMode="Enabled">
                                    <SelectParameters>
                                        <asp:Parameter Name="finicial" />
                                        <asp:Parameter Name="ffinal" />
                                        <asp:Parameter Name="codIdioma" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="2" width="100%">
                                &nbsp;</td>
                        </tr>
                    </table>
               <br /> 
                &nbsp;<br />
                   
                
            
        
      

        </center>
&nbsp;&nbsp;
        <br />
        <br />
    </div>
    <br />
    <center>
        <br />
        <br />
    </center>
    <br />
    </form>
</body>
</html>

