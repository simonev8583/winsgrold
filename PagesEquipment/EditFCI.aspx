<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditFCI.aspx.cs" Inherits="SistemaGestionRedes.EditFCI" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="SistemaGestionRedes" Namespace="SistemaGestionRedes" TagPrefix="asp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <title></title>




</head>
<body>
    <form id="form1" runat="server">

        <div class="rightDiv">
            <div class="centerDiv">
                <table style="width: 100%;" border="0">
                    <tr>
                        <td align="center" bgcolor="#eeeeee">
                            <font><strong>
                                <asp:Label ID="lblSerialFCI" Text="<%$ Resources:TextosGlobales,TextoSerialEquipo %>" runat="server" /></strong></font>
                            <asp:Label ID="lblId" runat="server" Visible="false" />
                            :<asp:Label ID="lblSerial" runat="server" />
                            &nbsp;<asp:Label ID="lblSerialFWT" runat="server" Visible="False"></asp:Label>
                            &nbsp;<asp:Label ID="lblASDUFWT" runat="server" Visible="False"></asp:Label>
                            <asp:Label ID="lblCanal104FWT" runat="server" Visible="False"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td align="center">
                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                            <asp:UpdatePanel ID="upPanEstadoActFCI" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblEstadoFCI" runat="server" />
                                    &nbsp;
                                    <asp:Image ID="imgEstadoFCI" runat="server" ImageUrl="~/Images/roller.gif" Visible="false" />
                                    <!-- Este  timer va a servir para que automaticamente se actualice en la pagina el estado del FCI
                                         despues de actualización de parametros .  -->
                                    <asp:Timer ID="tmrActualizacionEstadoFCI" runat="server" Enabled="false"
                                        Interval="2000" OnTick="tmrActualizacionEstadoFCI_Tick">
                                    </asp:Timer>
                                </ContentTemplate>
                            </asp:UpdatePanel>


                        </td>
                    </tr>
                </table>
                <table style="width: 100%;" border="0">
                    <tr>
                        <td align="right" width="50%">
                            <asp:Label ID="Label23" runat="server" Text="<%$ Resources:TextoFechaRegistro %>"></asp:Label>
                            <br />
                            <asp:Label ID="Label29" runat="server" Text="<%$ Resources:TextoFechaInstalacion %>"></asp:Label>
                            <br />
                            <asp:Label ID="Label18" runat="server" Text="<%$ Resources:TextoVersionFirmware %>"></asp:Label>
                        </td>

                        <td width="50%">
                            <asp:Label ID="lblFechaRegistroGestion" runat="server"></asp:Label>
                            <br />
                            <asp:Label ID="lblFechaInstalacion" runat="server"></asp:Label>
                            <br />
                            <asp:Label ID="lblVersionFirmware" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>


                <br />


                <table border="0" width="100%">
                    <tr>
                        <td align="center" bgcolor="#eeeeee" colspan="6" width="38%">
                            <font><strong>
                                <asp:Label ID="lblGestionElectrica" Text="<%$ Resources:TextoGestionElectrica %>" runat="server"></asp:Label>
                            </strong></font>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" width="38%">
                            <asp:Label ID="Label30" runat="server" CssClass="txtLabelPrms"
                                Text="<%$ Resources:TextosGlobales,TextoSerialFWT %>"></asp:Label>:
                        
                        </td>
                        <td align="left" valign="middle" width="12%">
                            <asp:Label ID="lblTxtSerialFWT" runat="server" CssClass="txtLabelPrms"
                                Font-Size="12px"></asp:Label>
                            <br />
                            <asp:DropDownList runat="server" ID="ddlConcentradores" Visible="False">
                            </asp:DropDownList>

                        </td>
                        <td align="right" valign="middle" width="12%">
                            <asp:Label ID="Label36" runat="server" CssClass="txtLabelPrms"
                                Text="<%$ Resources:TextosGlobales,TextoIdentificadorEquipo %>"></asp:Label>:
                        </td>
                        <td align="left" width="38%" colspan="3">
                            <asp:Label ID="lblIdentificador" runat="server" ToolTip="<%$ Resources:ToolTipLblIdentificador %>"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" width="38%">
                            <asp:Label ID="Label35" runat="server" CssClass="txtLabelPrms" Text="<%$ Resources:TextosGlobales,TextoCodigoFWT %>"></asp:Label>:
                        
                        </td>
                        <td align="left" valign="middle" width="12%">
                            <asp:Label ID="lblTxtCodigoFWT" runat="server" CssClass="txtLabelPrms"
                                Font-Size="12px"></asp:Label>
                        </td>
                        <td align="right" valign="middle" width="12%">
                            <asp:Label ID="Label37" runat="server" CssClass="txtLabelPrms"
                                Text="<%$ Resources:TextoTipoCircuito %>"></asp:Label>:
                        </td>
                        <td align="left" width="12%">
                            <asp:ListBox ID="listBoxTipoCircuito" runat="server" Height="54px" Width="92px">
                                <asp:ListItem Value="1" Text="<%$ Resources:TextoTipoMonofasico %>"></asp:ListItem>
                                <asp:ListItem Value="2" Text="<%$ Resources:TextoTipoBifasico %>"></asp:ListItem>
                                <asp:ListItem Value="3" Text="<%$ Resources:TextoTipoTrifasico %>"></asp:ListItem>
                            </asp:ListBox>
                        </td>
                        <td align="right" width="5%">
                            <asp:Label ID="Label38" runat="server" CssClass="txtLabelPrms" Text="<%$ Resources:TextosGlobales,TextoFase %>"></asp:Label>:
                        </td>
                        <td width="21%">
                            <asp:DropDownList ID="DDListFases" runat="server">
                                <asp:ListItem>A</asp:ListItem>
                                <asp:ListItem>B</asp:ListItem>
                                <asp:ListItem>C</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" width="38%">&nbsp;</td>
                        <td align="left" valign="middle" width="12%">&nbsp;</td>
                        <td align="right" valign="middle" width="12%" colspan="1">
                            <asp:Label ID="Label74" runat="server" CssClass="txtLabelPrms"
                                Text="<%$ Resources:TextosGlobales,TextoCodigoEquipo %>"></asp:Label>
                        </td>
                        <td align="left" valign="middle" width="38%" colspan="3">
                            <asp:TextBox ID="txtCodigoEquipo" runat="server" CssClass="textInUsuario"
                                MaxLength="50" Width="100px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" width="38%">
                            <asp:Label ID="Label31" runat="server" CssClass="txtLabelPrms"
                                Text="<%$ Resources:TextosGlobales,TextoSubestacion %>"></asp:Label>:
                        
                        </td>
                        <td align="left" valign="middle" width="12%">
                            <asp:Label ID="lblTxtSubEstacionFWT" runat="server" CssClass="txtLabelPrms"
                                Font-Size="12px"></asp:Label>
                        </td>
                        <td align="center" valign="middle" width="12%" colspan="4">
                            <asp:Button ID="btnSaveInfoNoActualizable" runat="server" CssClass="TextBoton"
                                OnClick="btnSaveInfoNoActualizable_Click" Text="<%$ Resources:TextoBotonGuardar %>" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" width="38%">
                            <asp:Label ID="Label32" runat="server" CssClass="txtLabelPrms" Text="<%$ Resources:TextosGlobales,TextoCircuito %>"></asp:Label>:
                        
                        </td>
                        <td align="left" valign="middle" width="12%">
                            <asp:Label ID="lblTxtCircuitoFWT" runat="server" CssClass="txtLabelPrms"
                                Font-Size="12px"></asp:Label>
                        </td>
                        <td align="right" valign="middle" width="12%">
                            <asp:Label ID="Label21" runat="server" Text="<%$ Resources:TextCircuitoOriginal %>"></asp:Label>:
                        </td>
                        <td align="left" width="38%" colspan="3">
                            <asp:Label ID="lblCircuitoBDOrig" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" width="38%">
                            <asp:Label ID="Label33" runat="server" CssClass="txtLabelPrms"
                                Text="<%$ Resources:TextosGlobales,TextoSeccionTramo %>"></asp:Label>:
                        
                        </td>
                        <td align="left" valign="middle" width="12%">
                            <asp:Label ID="lblTxtTramoFWT" runat="server" CssClass="txtLabelPrms"
                                Font-Size="12px"></asp:Label>
                        </td>
                        <td align="right" valign="middle" width="12%">
                            <asp:Label ID="Label25" runat="server" Text="<%$ Resources:TextFaseOriginal %>"></asp:Label>:
                        </td>
                        <td align="left" width="38%" colspan="3">
                            <asp:Label ID="lblFaseBDOrig" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" width="38%">
                            <asp:Label ID="Label34" runat="server" CssClass="txtLabelPrms" Text="<%$ Resources:TextosGlobales,TextoNodo %>"></asp:Label>:
                        
                        </td>
                        <td align="left" valign="middle" width="12%">
                            <asp:Label ID="lblTxtNodoFWT" runat="server" CssClass="txtLabelPrms"
                                Font-Size="12px"></asp:Label>
                        </td>
                        <td align="right" valign="middle" width="12%">&nbsp;</td>
                        <td align="left" width="38%" colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" width="38%">&nbsp;</td>
                        <td align="left" valign="middle" width="12%">&nbsp;</td>
                        <td align="right" valign="middle" width="12%">&nbsp;</td>
                        <td align="left" width="38%" colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" width="38%">
                            <asp:Label ID="lblTextInScada" runat="server" Text="<%$ Resources:TextEnScada %>" Visible="False"></asp:Label>&nbsp;
                        <asp:Label ID="lblTextOutScada" runat="server" Text="<%$ Resources:TextSinScada %>" Visible="False"></asp:Label>

                        </td>
                        <td align="left" valign="middle" width="12%">
                            <asp:Button ID="btnSetScada" runat="server" Font-Size="9pt" Height="18px"
                                Text="<%$ Resources:TextBotonEnScada %>" OnClick="btnSetScada_Click" />&nbsp;

                        <asp:Button ID="btnQuitScada" runat="server" Font-Size="9pt" Height="18px"
                            Text="<%$ Resources:TextoBotonNoScada %>" OnClick="btnQuitScada_Click" />
                        </td>
                        <td align="left" valign="middle" width="12%">
                            <asp:Label ID="lblTxtMsgScada" runat="server"></asp:Label>
                        </td>
                        <td align="left" width="38%" colspan="3">&nbsp;</td>
                    </tr>
                </table>

                <br />
                <br />

                <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtenderEstadisticas" runat="server"
                    TargetControlID="ContentPanelEstadisticas"
                    ExpandControlID="TitlePanelEstadisticas"
                    CollapseControlID="TitlePanelEstadisticas"
                    Collapsed="true"
                    TextLabelID="LabelMostrarEstadisticas"
                    ExpandedText="<%$ Resources:TextExpandedText %>"
                    CollapsedText="<%$ Resources:TextCollapsedText %>"
                    ImageControlID="ImageActual"
                    ExpandedImage="~/Images/collapse.jpg"
                    CollapsedImage="~/Images/expand.jpg"
                    SuppressPostBack="true"></asp:CollapsiblePanelExtender>

                <asp:Panel ID="TitlePanelEstadisticas" runat="server" CssClass="collapsePanelHeader">
                    <asp:Image ID="ImageActual" runat="server" ImageUrl="~/Images/expand.jpg" />
                    &nbsp;<asp:Literal ID="Literal1" Text="<%$ Resources:TextEstadisticasOtrosCmds %>" runat="server"></asp:Literal>
                    &nbsp;&nbsp;
           <asp:Label ID="LabelMostrarEstadisticas" Text="<%$ Resources:TextMostrarDefecto %>" runat="server"></asp:Label>
                </asp:Panel>

                <asp:Panel ID="ContentPanelEstadisticas" runat="server">
                    <table style="width: 100%;" border="0">
                        <tr>
                            <td align="center" bgcolor="#eeeeee" style="width: 50%;">
                                <asp:Label ID="Label2" runat="server" Text="<%$ Resources:TextEstadisticasFCI %>" Font-Bold="True"></asp:Label>
                            </td>
                            <td align="center" bgcolor="#eeeeee" style="width: 50%;">
                                <asp:Label ID="Label24" runat="server" Text="<%$ Resources:TextOtrosComandos %>"
                                    Font-Bold="True"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" style="width: 50%;">
                                <asp:Button ID="butLeerEstadisticas" runat="server" Text="<%$ Resources:TextBotonLeerEstadisticas %>"
                                    Style="height: 26px"
                                    Enabled="False"
                                    ToolTip="<%$ Resources:TextToolTipBotonLeerEstadisticas %>" OnClick="butLeerEstadisticas_Click" />
                                <br />
                                <asp:SqlDataSource ID="SqlDSLastEstadistica" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" SelectCommand="select top 1 EstadisticasFCIs.* from EstadisticasFCIs, FCIs 
where FCIs.Serial = @SerialFCI and FCIs.Id = EstadisticasFCIs.FCIId
order by Fecha desc">
                                    <SelectParameters>
                                        <asp:Parameter Name="SerialFCI" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:DetailsView ID="DVUltEstadisticaFCI" runat="server"
                                    AutoGenerateRows="False" BackColor="White" BorderColor="#999999"
                                    BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="FCIId,Fecha"
                                    DataSourceID="SqlDSLastEstadistica" GridLines="Vertical" Height="50px"
                                    Width="250px">
                                    <AlternatingRowStyle BackColor="#DCDCDC" />
                                    <EditRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                    <FieldHeaderStyle HorizontalAlign="Right" Width="150px" />
                                    <Fields>
                                        <asp:BoundField DataField="Fecha" HeaderText="<%$ Resources:TextGVStdFecha %>" ReadOnly="True"
                                            SortExpression="Fecha" />
                                        <asp:BoundField DataField="ContFallasTemporales"
                                            HeaderText="<%$ Resources:TextGVStdContFallasTemp %>" SortExpression="ContFallasTemporales" />
                                        <asp:BoundField DataField="ContFallasPermanentes"
                                            HeaderText="<%$ Resources:TextGVStdContFallasPermanentes %>" SortExpression="ContFallasPermanentes" />
                                        <asp:BoundField DataField="ContFallasTension" HeaderText="<%$ Resources:TextGVStdContAusenciasTension %>"
                                            SortExpression="ContFallasTension" />
                                        <asp:BoundField DataField="ContFallasLowBattery"
                                            HeaderText="<%$ Resources:TextGVStdContFallasBatBaja %>" SortExpression="ContFallasLowBattery" />
                                        <asp:BoundField DataField="ValorPromedioIL" HeaderText="<%$ Resources:TextGVStdCorrientePromedio %>"
                                            SortExpression="ValorPromedioIL" />
                                        <asp:BoundField DataField="ValorMaximoIL" HeaderText="<%$ Resources:TextGVStdCorrienteMaxima %>"
                                            SortExpression="ValorMaximoIL" />
                                        <asp:BoundField DataField="ValorMinimoIL" HeaderText="<%$ Resources:TextGVStdCorrienteMin %>"
                                            SortExpression="ValorMinimoIL" />
                                        <asp:BoundField DataField="ValorActualIL" HeaderText="<%$ Resources:TextGVStdCorrienteActual %>"
                                            SortExpression="ValorActualIL" />
                                        <asp:TemplateField HeaderText="<%$ Resources:TextGVStdTension %>" SortExpression="Tension">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTension" runat="server" Text='<%# UtilitariosWebGUI.MostrarValorTensionFriendly( Eval("Tension") ) %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Fields>
                                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                                </asp:DetailsView>
                                <asp:Label ID="lblStdContFallasTemp" runat="server" Visible="False"></asp:Label>
                                <br />
                                <asp:Label ID="lblStdContFallasPermanentes" runat="server" Visible="False"></asp:Label>
                                <br />
                                <asp:Label ID="lblStdTension" runat="server" Visible="False"></asp:Label>
                                <br />
                                <asp:Label ID="lblEstadisticasActuales" runat="server" Text="" ForeColor="Red"
                                    Font-Bold="True" Visible="False"></asp:Label><br />

                            </td>
                            <td align="center" style="width: 50%;">
                                <asp:Button ID="butLeerEstadisticasCorriente" runat="server" Text="Leer Corrientes Online"
                                    Style="height: 26px"
                                    Enabled="False" ToolTip="<%$ Resources:ToolTipBotonLeerCorrientes %>" Visible="False" />
                                <br />

                                <asp:Button ID="btnComandoTestFCI" runat="server" Text="<%$ Resources:TextBotonCmdTest %>"
                                    Enabled="true" Font-Size="11px"
                                    ToolTip="<%$ Resources:ToolTipBotonTestCmd %>"
                                    OnClick="btnComandoTestFCI_Click" />
                                <br />

                                <asp:Label ID="lblTestFCI" runat="server" Text="" Font-Bold="True" ForeColor="Red"
                                    Visible="False"></asp:Label>
                                <br />

                                <asp:Button ID="btnResetFCI" runat="server" Enabled="False" Font-Size="11px"
                                    OnClick="btnResetFCI_Click" Text="<%$ Resources:TextBotonResetFCI %>"
                                    ToolTip="<%$ Resources:TextBotonResetFCIToolTip %>" />
                                <br />
                                <asp:Label ID="lblResetFCI" runat="server" Font-Bold="True" ForeColor="Red"
                                    Visible="False"></asp:Label>
                                <br />

                                <asp:UpdatePanel ID="UpPanelMostrarEventosReposicion" runat="server">
                                    <ContentTemplate>
                                        <asp:SqlDataSource ID="SqlDSLastEventosReposicion" runat="server"
                                            ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" SelectCommand="select top 4 EventosReposicion.Fecha, Resultado =
                                    CASE EventosReposicion.TipoReposicion
                                    WHEN 1 THEN 'Hizo Reposición'
                                    WHEN 2 THEN 'FCI No Indicaba'
                                    END
                                    FROM EventosReposicion
                                    WHERE EventosReposicion.FCIId = @fciid
                                    ORDER BY EventosReposicion.Fecha DESC">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblId" Name="fciid" PropertyName="Text" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:Timer ID="TimerShowEventosReposicion" runat="server" Interval="20000"
                                            OnTick="TimerShowEventosReposicion_Tick">
                                        </asp:Timer>
                                        <br />
                                        <asp:Label ID="Label75" runat="server" Font-Bold="True"
                                            Text="<%$ Resources:TextTittleEventosRepRemota %>"></asp:Label>
                                        <br />
                                        <asp:GridView ID="GVEventosReposicion" runat="server"
                                            AutoGenerateColumns="False" CellPadding="4"
                                            DataSourceID="SqlDSLastEventosReposicion" ForeColor="#333333" GridLines="None">
                                            <AlternatingRowStyle BackColor="White" />
                                            <Columns>
                                                <asp:BoundField DataField="Fecha" HeaderText="<%$ Resources:TextGVStdFecha %>" SortExpression="Fecha" />
                                                <asp:BoundField DataField="Resultado" HeaderText="<%$ Resources:TextGVResetsResultados %>" ReadOnly="True"
                                                    SortExpression="Resultado" />
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
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>

                <table style="width: 100%;" border="0">
                    <tr>
                        <td align="center" bgcolor="#eeeeee" colspan="8">
                            <font><strong>
                                <asp:Literal ID="Literal2" Text="<%$ Resources:TextTittleParametros %>" runat="server"></asp:Literal>
                            </strong></font>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" bgcolor="#eeeeee" colspan="2">
                            <asp:Label ID="Label1" Text="<%$ Resources:TextTittleModoDisparo %>" runat="server" />
                        </td>

                        <td align="center" bgcolor="#eeeeee" colspan="2">
                            <asp:Label ID="Label3" Text="<%$ Resources:TextTittleValorFalla %>" runat="server" />
                        </td>

                        <td align="center" bgcolor="#eeeeee" colspan="4">
                            <asp:Label ID="Label12" Text="<%$ Resources:TextTittleResetModes %>" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="middle" colspan="2">

                            <table style="width: 70%;" border="0">
                                <tr>
                                    <td align="left">
                                        <asp:RadioButton ID="rdButModoProporcional" Text="<%$ Resources:TextModoDisparoProporcional %>" GroupName="modoDisparo"
                                            runat="server" AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged" />
                                        <br />
                                        <br />
                                        <asp:RadioButton ID="rdButModoPorIncremento" Text="<%$ Resources:TextModoDisparoIncremental %>" GroupName="modoDisparo"
                                            runat="server" AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged" />
                                        <br />
                                        <br />
                                        <asp:RadioButton ID="rdButModoPorValorFijo" Text="<%$ Resources:TextModoDisparoValorFijo %>" GroupName="modoDisparo"
                                            runat="server" AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged" />
                                        <br />
                                        <br />
                                        <asp:RadioButton ID="rdButModoPorAutoRango" Text="<%$ Resources:TextModoDisparoAutorango %>" GroupName="modoDisparo"
                                            runat="server" AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged" />
                                    </td>
                                </tr>
                            </table>

                        </td>
                        <td align="center" valign="middle" colspan="2">
                            <asp:Label ID="lblNombreValorFalla" CssClass="labelTitulo" runat="server" Text="DeltaI (di/dt) : " /><br />
                            <asp:TextBox ID="txtValorFalla" runat="server" OnTextChanged="Control_TextChanged"
                                CssClass="textBoxHora" Width="40px" MaxLength="4" ViewStateMode="Enabled"></asp:TextBox>
                            <br />
                            <asp:Label runat="server" Text="2-100 Veces" Font-Size="11px" ID="lblUnids"></asp:Label>
                            <br />
                            <asp:RequiredFieldValidator ID="ReqValPropor" runat="server" ControlToValidate="txtValorFalla"
                                ErrorMessage="<%$ Resources:ReqValProporErrText %>" ForeColor="Red" SetFocusOnError="True"
                                ValidationGroup="edicionFCI">&nbsp;</asp:RequiredFieldValidator>

                            &nbsp;<asp:RegularExpressionValidator ID="RegExPropor" runat="server" ControlToValidate="txtValorFalla"
                                ErrorMessage="<%$ Resources:RegExProporErrText %>" ForeColor="Red" SetFocusOnError="True"
                                ValidationExpression="[0-9]{1,4}" ValidationGroup="edicionFCI">&nbsp;</asp:RegularExpressionValidator>

                            &nbsp;<asp:RangeValidator ID="RanValPropor" runat="server" ControlToValidate="txtValorFalla"
                                ErrorMessage="<%$ Resources:RanValProporErrText %>" ForeColor="Red" MaximumValue="100" MinimumValue="2"
                                SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">&nbsp;</asp:RangeValidator>
                            &nbsp;<asp:Label ID="Label5" runat="server" Text="Aqui Hay Val Objs" Visible="False"></asp:Label>
                            <br />


                            <asp:RequiredFieldValidator ID="ReqValIncre" runat="server" ControlToValidate="txtValorFalla"
                                Enabled="False" ErrorMessage="<%$ Resources:ReqValIncreErrText %>" ForeColor="Red" SetFocusOnError="True"
                                ValidationGroup="edicionFCI">&nbsp;</asp:RequiredFieldValidator>

                            &nbsp;<asp:RegularExpressionValidator ID="RegExValIncre" runat="server" ControlToValidate="txtValorFalla"
                                Enabled="False" ErrorMessage="<%$ Resources:RegExValIncreErrText %>" ForeColor="Red"
                                SetFocusOnError="True" ValidationExpression="[0-9]{1,4}" ValidationGroup="edicionFCI">&nbsp;</asp:RegularExpressionValidator>

                            &nbsp;<asp:RangeValidator ID="RanValIncre" runat="server" ControlToValidate="txtValorFalla"
                                Enabled="False" ErrorMessage="<%$ Resources:RanValIncreErrText %>" ForeColor="Red"
                                MaximumValue="1000" MinimumValue="10" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">&nbsp;</asp:RangeValidator>
                            <br />


                            <asp:RequiredFieldValidator ID="ReqValFijo" runat="server" ControlToValidate="txtValorFalla"
                                Enabled="False" ErrorMessage="<%$ Resources:ReqValFijoErrText %>" ForeColor="Red" SetFocusOnError="True"
                                ValidationGroup="edicionFCI">&nbsp;</asp:RequiredFieldValidator>

                            &nbsp;<asp:RegularExpressionValidator ID="RegExValFijo" runat="server" ControlToValidate="txtValorFalla"
                                Enabled="False" ErrorMessage="<%$ Resources:RegExValFijoErrText %>" ForeColor="Red"
                                SetFocusOnError="True" ValidationExpression="[0-9]{1,4}" ValidationGroup="edicionFCI">&nbsp;</asp:RegularExpressionValidator>

                            &nbsp;<asp:RangeValidator ID="RanValFijo" runat="server" ControlToValidate="txtValorFalla"
                                Enabled="False" ErrorMessage="<%$ Resources:RanValFijoErrText %>" ForeColor="Red"
                                MaximumValue="1000" MinimumValue="10" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">&nbsp;</asp:RangeValidator>

                        </td>


                        <td colspan="4">

                            <fieldset>
                                <legend>
                                    <asp:Literal ID="Literal3" Text="<%$ Resources:TextModosResetPorTiempo %>" runat="server"></asp:Literal>
                                </legend>
                                <center>
                                    <table style="width: 80%;" border="0">
                                        <tr>
                                            <td align="right" style="width: 40%;">
                                                <asp:Literal ID="Literal4" Text="<%$ Resources:TextModosResetPorTiempoHabilitado %>" runat="server"></asp:Literal>:
                                            </td>
                                            <td align="left" style="width: 40%;">
                                                <asp:CheckBox ID="chkBoxRepTiempo" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 40%;">
                                                <asp:Literal ID="Literal5" Text="<%$ Resources:TextModosResetPorTiempoTpoFallaTemp %>" runat="server"></asp:Literal>:
                                            </td>
                                            <td align="left" style="width: 40%;">
                                                <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoIndicacionFallatemp"
                                                    OnTextChanged="Control_TextChanged" Width="40px" MaxLength="5" ToolTip="<%$ Resources:ToolTipTxtBoxTiempoIndicacionFallaTemp %>"></asp:TextBox>
                                                <asp:Literal ID="Literal28" Text="(1-86400)" runat="server"></asp:Literal>
                                                &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextosGlobales,TextoSegundos %>"
                                                    Font-Size="11px" ID="Label8"></asp:Label>
                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValPrm4" runat="server" ControlToValidate="txtTiempoIndicacionFallatemp"
                                                    ErrorMessage="<%$ Resources:ReqValPrm4ErrMsg %>" SetFocusOnError="True"
                                                    ValidationGroup="edicionFCI" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm4" runat="server" ControlToValidate="txtTiempoIndicacionFallatemp"
                                                    ErrorMessage="<%$ Resources:RegExValPrm4ErrMsg %>" SetFocusOnError="True"
                                                    ValidationExpression="[0-9]{1,5}" ValidationGroup="edicionFCI" ForeColor="Red">*</asp:RegularExpressionValidator>
                                                &nbsp;<asp:RangeValidator ID="RanValPrm4" runat="server" ControlToValidate="txtTiempoIndicacionFallatemp"
                                                    ErrorMessage="<%$ Resources:RanValPrm4ErrMsg %>" ForeColor="Red" MaximumValue="86400"
                                                    MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">*</asp:RangeValidator>
                                                <!-- El tiempo se recibe en segundos maximo un dia 1440 minutos   -->
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 40%;">
                                                <asp:Literal ID="Literal6" Text="<%$ Resources:TextModosResetPorTiempoTpoFallaPerm %>" runat="server"></asp:Literal>:
                                            </td>
                                            <td align="left" style="width: 40%;">
                                                <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoReposicion" OnTextChanged="Control_TextChanged"
                                                    Width="40px" MaxLength="5"></asp:TextBox>
                                                <asp:Literal ID="Literal29" Text="(1-86400)" runat="server"></asp:Literal>
                                                &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextosGlobales,TextoSegundos %>" Font-Size="11px" ID="Label11"></asp:Label>
                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValPrm3" runat="server" ControlToValidate="txtTiempoReposicion"
                                                    ErrorMessage="<%$ Resources:ReqValPrm3ErrMsg %>" SetFocusOnError="True" ValidationGroup="edicionFCI"
                                                    ForeColor="Red">*</asp:RequiredFieldValidator>
                                                &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm3" runat="server" ControlToValidate="txtTiempoReposicion"
                                                    ErrorMessage="<%$ Resources:RegExValPrm3ErrMsg %>" SetFocusOnError="True" ValidationExpression="[0-9]{1,5}"
                                                    ValidationGroup="edicionFCI" ForeColor="Red">*</asp:RegularExpressionValidator>
                                                &nbsp;<asp:RangeValidator ID="RanValPrm3" runat="server" ControlToValidate="txtTiempoReposicion"
                                                    ErrorMessage="<%$ Resources:RanValPrm3ErrMsg %>" ForeColor="Red" MaximumValue="86400"
                                                    MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">*</asp:RangeValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </center>

                            </fieldset>

                            <fieldset>
                                <legend>
                                    <asp:Literal ID="Literal7" Text="<%$ Resources:TextModosResetPorTension %>" runat="server"></asp:Literal></legend>
                                <center>
                                    <table style="width: 80%;" border="0">
                                        <tr>
                                            <td align="right" style="width: 40%;">
                                                <asp:Literal ID="Literal8" Text="<%$ Resources:TextModosResetPorTensionHabilitado %>" runat="server"></asp:Literal>
                                            </td>
                                            <td align="left" style="width: 40%;">
                                                <asp:CheckBox ID="chkBoxRepTension" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 40%;">
                                                <asp:Literal ID="Literal9" Text="<%$ Resources:TextModosResetPorTensionToleraciaTension %>" runat="server"></asp:Literal>:
                                            </td>
                                            <td align="left" style="width: 40%;">
                                                <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtToleranciaTensionReposicion"
                                                    OnTextChanged="Control_TextChanged" Width="30px" MaxLength="3"></asp:TextBox>
                                                &nbsp;<asp:Label runat="server" Text="%" Font-Size="12px" ID="Label7"></asp:Label>
                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValPrm2" runat="server" ControlToValidate="txtToleranciaTensionReposicion"
                                                    ErrorMessage="<%$ Resources:ReqValPrm2ErrMsg %>" ForeColor="Red" SetFocusOnError="True"
                                                    ValidationGroup="edicionFCI">*</asp:RequiredFieldValidator>
                                                &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm2" runat="server" ControlToValidate="txtToleranciaTensionReposicion"
                                                    ErrorMessage="<%$ Resources:RegExValPrm2ErrMsg %>" SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                                    ValidationGroup="edicionFCI" ForeColor="Red">*</asp:RegularExpressionValidator>
                                                &nbsp;<asp:RangeValidator ID="RanValPrm2" runat="server" ControlToValidate="txtToleranciaTensionReposicion"
                                                    ErrorMessage="<%$ Resources:RanValPrm2ErrMsg %>" ForeColor="Red" MaximumValue="100"
                                                    MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">*</asp:RangeValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 40%;">
                                                <asp:Literal ID="Literal10" Text="<%$ Resources:TextModosResetPorTensionTiemporetardoVal %>" runat="server"></asp:Literal>:
                                            </td>
                                            <td align="left" style="width: 40%;">
                                                <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoRetardoValidacionTension"
                                                    OnTextChanged="Control_TextChanged" Width="30px" MaxLength="3"></asp:TextBox>
                                                &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextModosResetPorTensionUnidsTiemporetardo %>" Font-Size="11px" ID="Label13"></asp:Label>
                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValPrm8" runat="server" ControlToValidate="txtTiempoRetardoValidacionTension"
                                                    ErrorMessage="<%$ Resources:ReqValPrm8ErrMsg %>" SetFocusOnError="True"
                                                    ValidationGroup="edicionFCI" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm8" runat="server" ControlToValidate="txtTiempoRetardoValidacionTension"
                                                    ErrorMessage="<%$ Resources:RegExValPrm8ErrMsg %>" SetFocusOnError="True"
                                                    ValidationExpression="[0-9]{1,3}" ValidationGroup="edicionFCI" ForeColor="Red">*</asp:RegularExpressionValidator>
                                                &nbsp;<asp:RangeValidator ID="RanValPrm8" runat="server" ControlToValidate="txtTiempoRetardoValidacionTension"
                                                    ErrorMessage="<%$ Resources:RanValPrm8ErrMsg %>" ForeColor="Red"
                                                    MaximumValue="120" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">*</asp:RangeValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </center>



                            </fieldset>
                            <fieldset>
                                <legend>
                                    <asp:Literal ID="Literal11" Text="<%$ Resources:TextModosResetPorImanCte %>" runat="server"></asp:Literal></legend>

                                <center>
                                    <table style="width: 80%;" border="0">
                                        <tr>
                                            <td align="right" style="width: 40%;">
                                                <asp:Literal ID="Literal12" Text="<%$ Resources:TextModosResetPorImanCteHabilitado %>" runat="server"></asp:Literal>
                                            </td>
                                            <td align="left" style="width: 40%;">
                                                <asp:CheckBox ID="chkBoxRepMagneto" runat="server" Text="<%$ Resources:TextModosResetPorImanCtePorIman %>" /><br />
                                                <asp:CheckBox ID="chkBoxRepCorriente" runat="server" Visible="True"
                                                    Text="<%$ Resources:TextModosResetPorImanCtePorCorriente %>" />
                                            </td>
                                        </tr>


                                    </table>

                                </center>

                            </fieldset>

                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">

                            <asp:Literal ID="Literal30" Text="<%$ Resources:TextFrecuencia %>" runat="server"></asp:Literal>

                            <br />

                            <asp:RadioButtonList ID="rblFrecuencia" runat="server" BorderStyle="Solid"
                                BorderWidth="2px" RepeatDirection="Horizontal">
                                <asp:ListItem Value="True">60Hz</asp:ListItem>
                                <asp:ListItem Value="False">50Hz</asp:ListItem>
                            </asp:RadioButtonList>

                        </td>
                        <td colspan="6"></td>
                    </tr>

                    <tr>
                        <td colspan="4" align="center" bgcolor="#eeeeee">
                            <asp:Literal ID="Literal13" Text="<%$ Resources:TextTittleTiempos %>" runat="server"></asp:Literal>
                        </td>

                        <td colspan="4" align="center" bgcolor="#eeeeee">
                            <asp:Literal ID="Literal16" Text="<%$ Resources:TextTittleActivaciones %>" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" colspan="2" valign="top">
                            <asp:Literal ID="Literal14" Text="<%$ Resources:TextTittleTiemposInrushProteccion %>" runat="server"></asp:Literal>
                        </td>
                        <td colspan="2" valign="top">
                            <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoProteccionInRush"
                                OnTextChanged="Control_TextChanged" Width="30px" MaxLength="3"></asp:TextBox>
                            &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextTittleTiemposUnidsInrushProteccion %>" Font-Size="11px"
                                ID="Label10"></asp:Label>
                            &nbsp;<asp:RequiredFieldValidator ID="ReqValPrm7" runat="server" ControlToValidate="txtTiempoProteccionInRush"
                                ErrorMessage="<%$ Resources:ReqValPrm7ErrMsg %>" SetFocusOnError="True" ValidationGroup="edicionFCI"
                                ForeColor="Red">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm7" runat="server" ControlToValidate="txtTiempoProteccionInRush"
                                ErrorMessage="<%$ Resources:RegExValPrm7ErrMsg %>" SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                ValidationGroup="edicionFCI" ForeColor="Red">*</asp:RegularExpressionValidator>
                            &nbsp;<asp:RangeValidator ID="RanValPrm7" runat="server" ControlToValidate="txtTiempoProteccionInRush"
                                ErrorMessage="<%$ Resources:RanValPrm7ErrMsg %>" ForeColor="Red" MaximumValue="120"
                                MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">*</asp:RangeValidator>
                        </td>

                        <td colspan="2">
                            <asp:Literal ID="Literal17" Text="<%$ Resources:TextTittleActivacionesReloj %>" runat="server"></asp:Literal>
                            <br />
                            <asp:Literal ID="Literal18" Text="<%$ Resources:TextTittleActivacionesFallaTemporal %>" runat="server"></asp:Literal>
                        </td>
                        <td colspan="2">

                            <asp:CheckBox ID="chkBoxHabReloj" runat="server" Checked="true"
                                Enabled="false" />
                            <br />
                            <asp:CheckBox ID="chkBoxHabFallaTrans" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="left" colspan="2" valign="top">
                            <asp:Literal ID="Literal15" Text="<%$ Resources:TextTittleTiemposValidacionFalla %>" runat="server"></asp:Literal>
                        </td>

                        <td colspan="2" valign="top">
                            <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoValFalla" OnTextChanged="Control_TextChanged"
                                Width="30px" MaxLength="3"></asp:TextBox>&nbsp;
                            <asp:Label runat="server" Text="<%$ Resources:TextTittleTiemposUnidsValidacionFalla %>" Font-Size="11px" ID="Label6"></asp:Label>
                            &nbsp;<asp:RequiredFieldValidator ID="ReqValT1" runat="server" ControlToValidate="txtTiempoValFalla"
                                ErrorMessage="<%$ Resources:ReqValT1ErrMsg %>" ForeColor="Red" SetFocusOnError="True"
                                ValidationGroup="edicionFCI">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegExValT1" runat="server" ControlToValidate="txtTiempoValFalla"
                                ErrorMessage="<%$ Resources:RegExValT1ErrMsg %>" ForeColor="Red" SetFocusOnError="True"
                                ValidationExpression="[0-9]{1,3}" ValidationGroup="edicionFCI">*</asp:RegularExpressionValidator>
                            &nbsp;<asp:RangeValidator ID="RanValT1" runat="server" ControlToValidate="txtTiempoValFalla"
                                ErrorMessage="<%$ Resources:RanValT1ErrMsg %>" ForeColor="Red" MaximumValue="120"
                                MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">*</asp:RangeValidator>
                        </td>
                        <td colspan="4" align="center" bgcolor="#eeeeee">
                            <asp:Literal ID="Literal19" Text="<%$ Resources:TextTittleCorrientes %>" runat="server"></asp:Literal>
                        </td>

                    </tr>
                    <tr>
                        <td align="left" colspan="2" valign="top"></td>
                        <td colspan="2" valign="top"></td>
                        <td colspan="2">
                            <asp:Literal ID="Literal20" Text="<%$ Resources:TextTittleCorrientesCorrienteAbsoluta %>" runat="server"></asp:Literal>
                        </td>

                        <td colspan="2">

                            <asp:TextBox ID="txtCorrienteAbsolutaDisparo" runat="server"
                                CssClass="textBoxHora" MaxLength="4" OnTextChanged="Control_TextChanged"
                                Width="40px"></asp:TextBox>
                            &nbsp;<asp:Label ID="Label14" runat="server" Text="<%$ Resources:TextTittleCorrientesUnidsCteAbsoluta %>"></asp:Label>
                            &nbsp;<asp:RequiredFieldValidator ID="ReqValConfPrm1" runat="server"
                                ControlToValidate="txtCorrienteAbsolutaDisparo"
                                ErrorMessage="<%$ Resources:ReqValConfPrm1ErrMsg %>" ForeColor="Red"
                                SetFocusOnError="True" ValidationGroup="edicionFCI">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm1" runat="server"
                                ControlToValidate="txtCorrienteAbsolutaDisparo"
                                ErrorMessage="<%$ Resources:RegExValConfPrm1ErrMsg %>" ForeColor="Red"
                                SetFocusOnError="True" ValidationExpression="[0-9]{1,4}"
                                ValidationGroup="edicionFCI">*</asp:RegularExpressionValidator>
                            &nbsp;<asp:RangeValidator ID="RanValCteDisparo" runat="server"
                                ControlToValidate="txtCorrienteAbsolutaDisparo"
                                ErrorMessage="<%$ Resources:RanValCteDisparoErrMsg %>" MaximumValue="1000" MinimumValue="10"
                                SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">*</asp:RangeValidator>
                    </tr>
                    <tr>
                        <td colspan="4" align="center" bgcolor="#eeeeee">
                            <asp:Label ID="Label20" Text="<%$ Resources:TextTittleAutonomiaBatNormal %>" runat="server" />

                        </td>
                        <td colspan="4" align="center" bgcolor="#eeeeee">

                            <asp:Label ID="Label4" Text="<%$ Resources:TextTittleAutonomiaBatDestello %>" runat="server" />

                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" valign="top">
                            <asp:Literal ID="Literal21" Text="<%$ Resources:TextTittleAutonomiaEnfuncionamiento %>" runat="server"></asp:Literal>:
                        </td>
                        <td colspan="2" valign="top">
                            <asp:UpdatePanel ID="upPanAutonomNormal" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnCalcularAutNormal" runat="server"
                                        Text="<%$ Resources:TextTittleAutonomiaBotonAutonomiaNormal %>" Height="26px"
                                        ValidationGroup="CalcAutonBatFunc" OnClick="btnCalcularAutNormal_Click" /><br />
                                    <asp:Label ID="lblAutonomiaFuncionamiento" runat="server" /><br />
                                    <asp:Label ID="lblAutonomiaFuncionamientoDias" runat="server" /><br />
                                    <asp:Label ID="lblAutonomiaFuncionamientoAnios" runat="server" />
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </td>
                        <td colspan="2" valign="top">
                            <asp:Literal ID="Literal22" Text="<%$ Resources:TextTittleAutonomiaBatDestelloLabel %>" runat="server"></asp:Literal>
                        </td>
                        <td colspan="2" valign="top">
                            <asp:UpdatePanel ID="upPanBateriaDestellos" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnCalcAutonoBat" runat="server" Height="26px"
                                        OnClick="btnCalcAutonoBat_Click" Text="<%$ Resources:TextTittleAutonomiaBatDestelloEstimar %>" ValidationGroup="CalcAutonoBat" /><br />
                                    <asp:Label ID="lblAutonomiaBattInst" runat="server" /><br />
                                    <asp:Label ID="lblAutonomiaBattInstDias" runat="server" /><br />
                                    <asp:Label ID="lblAutonomiaBattInstAnios" runat="server" />

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>

                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:ValidationSummary ID="ValSumCalcAutonBatFunc" runat="server" Font-Size="12px" ForeColor="Red"
                                ValidationGroup="CalcAutonBatFunc" />

                        </td>
                        <td colspan="4">
                            <asp:ValidationSummary ID="ValSumCalcAutonoBat" runat="server" Font-Size="12px" ForeColor="Red"
                                ValidationGroup="CalcAutonoBat" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Literal ID="Literal23" Text="<%$ Resources:TextTittleAutonomiaBatNormalRetriesComms %>" runat="server"></asp:Literal>
                        </td>
                        <td colspan="2">
                            <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtNumeroReintentosComunicaciones"
                                OnTextChanged="Control_TextChanged" MaxLength="2" Width="30px"></asp:TextBox>
                            &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextTittleAutonomiaBatNormalUnidsRetries %>" ID="Label15"></asp:Label>
                            &nbsp;<asp:RequiredFieldValidator ID="ReqValCongPrm2" runat="server" ControlToValidate="txtNumeroReintentosComunicaciones"
                                ErrorMessage="<%$ Resources:ReqValCongPrm2ErrMsg %>" ForeColor="Red" SetFocusOnError="True"
                                ValidationGroup="edicionFCI">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm2" runat="server" ControlToValidate="txtNumeroReintentosComunicaciones"
                                ErrorMessage="<%$ Resources:RegExValConfPrm2ErrMsg %>" ForeColor="Red" SetFocusOnError="True"
                                ValidationExpression="[0-9]{1,2}" ValidationGroup="edicionFCI">*</asp:RegularExpressionValidator>
                            &nbsp;<asp:RangeValidator ID="RanValNroReintentos" runat="server" ControlToValidate="txtNumeroReintentosComunicaciones"
                                ErrorMessage="<%$ Resources:RanValNroReintentosErrMsg %>" ForeColor="Red" MaximumValue="10"
                                MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">*</asp:RangeValidator>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="Label22" runat="server" Text="<%$ Resources:TextTittleAutonomiaBatDestelloDurDestello %>"></asp:Label>
                        </td>
                        <td colspan="2">

                            <asp:TextBox ID="txtTiempoFlashIndicacion" runat="server"
                                CssClass="textBoxHora" MaxLength="3" OnTextChanged="Control_TextChanged"
                                Width="30px"></asp:TextBox>
                            <asp:Literal ID="Literal25" Text="<%$ Resources:TextTittleAutonomiaBatDestelloUnidsDurDestello %>" runat="server"></asp:Literal>
                            &nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="ReqValPrm5" runat="server"
                            ControlToValidate="txtTiempoFlashIndicacion"
                            ErrorMessage="<%$ Resources:ReqValPrm5ErrMsg %>" ForeColor="Red"
                            SetFocusOnError="True" ValidationGroup="edicionFCI">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm5" runat="server"
                                ControlToValidate="txtTiempoFlashIndicacion"
                                ErrorMessage="<%$ Resources:RegExValPrm5ErrMsg %>" ForeColor="Red"
                                SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                ValidationGroup="edicionFCI">*</asp:RegularExpressionValidator>
                            &nbsp;<asp:RangeValidator ID="RanValPrm5" runat="server"
                                ControlToValidate="txtTiempoFlashIndicacion"
                                ErrorMessage="<%$ Resources:RanValPrm5ErrMsg %>" ForeColor="Red"
                                MaximumValue="104" MinimumValue="8" SetFocusOnError="True" Type="Integer"
                                ValidationGroup="edicionFCI">*</asp:RangeValidator>
                            &nbsp;<asp:CustomValidator ID="CusValDurDestello" runat="server"
                                ControlToValidate="txtTiempoFlashIndicacion"
                                ErrorMessage="<%$ Resources:CusValDurDestelloErrMsg %>" ForeColor="Red"
                                OnServerValidate="CheckTiempoDuracionDestello" SetFocusOnError="True"
                                ValidationGroup="edicionFCI">*</asp:CustomValidator>
                            &nbsp;<asp:RequiredFieldValidator ID="ReqTiempoFlashIndicacionAuBat" runat="server"
                                ControlToValidate="txtTiempoFlashIndicacion"
                                ErrorMessage="<%$ Resources:ReqValPrm5ErrMsg %>" ForeColor="Red"
                                SetFocusOnError="True" ValidationGroup="CalcAutonoBat">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegExTiempoFlashIndicacionAuBat"
                                runat="server" ControlToValidate="txtTiempoFlashIndicacion"
                                ErrorMessage="<%$ Resources:RegExValPrm5ErrMsg %>" ForeColor="Red"
                                SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                ValidationGroup="CalcAutonoBat">*</asp:RegularExpressionValidator>
                            &nbsp;<asp:RangeValidator ID="RanValTiempoFlashIndicacionAuBat" runat="server"
                                ControlToValidate="txtTiempoFlashIndicacion"
                                ErrorMessage="<%$ Resources:RanValPrm5ErrMsg %>" ForeColor="Red"
                                MaximumValue="104" MinimumValue="8" SetFocusOnError="True" Type="Integer"
                                ValidationGroup="CalcAutonoBat">*</asp:RangeValidator>
                            &nbsp;<asp:CustomValidator ID="CusValTiempoFlashIndicacionAuBat" runat="server"
                                ControlToValidate="txtTiempoFlashIndicacion"
                                ErrorMessage="<%$ Resources:CusValDurDestelloErrMsg %>" ForeColor="Red"
                                OnServerValidate="CheckTiempoDuracionDestello" SetFocusOnError="True"
                                ValidationGroup="CalcAutonoBat">*</asp:CustomValidator>

                        </td>

                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Literal ID="Literal24" Text="<%$ Resources:TextTittleAutonomiaBatNormalConnectPeriod %>" runat="server"></asp:Literal>
                        </td>

                        </td>
                    <td colspan="2">

                        <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtSegundosProximaComunicacion"
                            OnTextChanged="Control_TextChanged" Width="40px" MaxLength="4"></asp:TextBox>
                        &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextTittleAutonomiaBatNormalUnidsConnectPeriod %>" ID="Label16"></asp:Label>
                        &nbsp;<asp:RequiredFieldValidator ID="ReqValConfPrm3" runat="server" ControlToValidate="txtSegundosProximaComunicacion"
                            ErrorMessage="<%$ Resources:ReqValConfPrm3ErrMsg %>" ForeColor="Red" SetFocusOnError="True"
                            ValidationGroup="edicionFCI">*</asp:RequiredFieldValidator>
                        &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm3" runat="server" ControlToValidate="txtSegundosProximaComunicacion"
                            ErrorMessage="<%$ Resources:RegExValConfPrm3ErrMsg %>" ForeColor="Red" SetFocusOnError="True"
                            ValidationExpression="[0-9]{1,4}" ValidationGroup="edicionFCI">*</asp:RegularExpressionValidator>
                        &nbsp;<asp:RangeValidator ID="RanValSegsProxCom" runat="server" ControlToValidate="txtSegundosProximaComunicacion"
                            ErrorMessage="<%$ Resources:RanValSegsProxComErrMsg %>" ForeColor="Red" MaximumValue="3600"
                            MinimumValue="30" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">*</asp:RangeValidator>

                    </td>
                        <td colspan="2">
                            <asp:Literal ID="Literal26" Text="<%$ Resources:TextTittleAutonomiaBatDestelloTpoEntreDeste %>" runat="server"></asp:Literal>
                        </td>
                        <td colspan="2">
                            <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoEntreFlashIndicacion"
                                OnTextChanged="Control_TextChanged" Width="30px" MaxLength="2"></asp:TextBox>
                            &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextTittleAutonomiaBatDestelloUnidsEntreDes %>" Font-Size="11px" ID="Label9"></asp:Label>
                            &nbsp;<asp:RequiredFieldValidator ID="ReqValPrm6" runat="server" ControlToValidate="txtTiempoEntreFlashIndicacion"
                                ErrorMessage="<%$ Resources:ReqValPrm6ErrMsg %>" SetFocusOnError="True" ValidationGroup="edicionFCI"
                                ForeColor="Red">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm6" runat="server" ControlToValidate="txtTiempoEntreFlashIndicacion"
                                ErrorMessage="<%$ Resources:RegExValPrm6ErrMsg %>" SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                ValidationGroup="edicionFCI" ForeColor="Red">*</asp:RegularExpressionValidator>
                            &nbsp;<asp:RangeValidator ID="RanValPrm6" runat="server" ControlToValidate="txtTiempoEntreFlashIndicacion"
                                ErrorMessage="<%$ Resources:RanValPrm6ErrMsg %>" ForeColor="Red" MaximumValue="10"
                                MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">*</asp:RangeValidator>
                            &nbsp;<asp:RequiredFieldValidator ID="ReqValTiempoEntreFlashIndicacionAuBat" runat="server"
                                ControlToValidate="txtTiempoEntreFlashIndicacion" ErrorMessage="<%$ Resources:ReqValPrm6ErrMsg %>"
                                SetFocusOnError="True" ValidationGroup="CalcAutonoBat" ForeColor="Red">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegrExTiempoEntreFlashIndicacionAuBat"
                                runat="server" ControlToValidate="txtTiempoEntreFlashIndicacion" ErrorMessage="<%$ Resources:RegExValPrm6ErrMsg %>"
                                SetFocusOnError="True" ValidationExpression="[0-9]{1,3}" ValidationGroup="CalcAutonoBat"
                                ForeColor="Red">*</asp:RegularExpressionValidator>
                            &nbsp;<asp:RangeValidator ID="RanValTiempoEntreFlashIndicacionAuBat" runat="server"
                                ControlToValidate="txtTiempoEntreFlashIndicacion" ErrorMessage="<%$ Resources:RanValPrm6ErrMsg %>"
                                ForeColor="Red" MaximumValue="10" MinimumValue="1" SetFocusOnError="True" Type="Integer"
                                ValidationGroup="CalcAutonoBat">*</asp:RangeValidator>
                        </td>

                    </tr>
                    <tr>

                        <td colspan="4" align="right" bgcolor="#eeeeee">
                            <asp:Literal ID="Literal27" Text="<%$ Resources:TextCapacidadBateria %>" runat="server"></asp:Literal>

                        </td>
                        <td colspan="4" bgcolor="#eeeeee">
                            <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtCapacidadBateria" MaxLength="5"
                                OnTextChanged="Control_TextChanged" Width="60px"></asp:TextBox>
                            &nbsp;<asp:Label runat="server" Text="mA/h" ID="Label17"></asp:Label>
                            &nbsp;<asp:RequiredFieldValidator ID="ReqValConfPrm4" runat="server" ControlToValidate="txtCapacidadBateria"
                                ErrorMessage="<%$ Resources:ReqValConfPrm4ErrMsg %>" ForeColor="Red" SetFocusOnError="True"
                                ValidationGroup="edicionFCI">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm4" runat="server" ControlToValidate="txtCapacidadBateria"
                                ErrorMessage="<%$ Resources:RegExValConfPrm4ErrMsg %>" ForeColor="Red" SetFocusOnError="True"
                                ValidationExpression="[0-9]{1,5}" ValidationGroup="edicionFCI">*</asp:RegularExpressionValidator>
                            &nbsp;<asp:RangeValidator ID="RanValCapBateria" runat="server" ControlToValidate="txtCapacidadBateria"
                                ErrorMessage="<%$ Resources:RanValCapBateriaErrMsg %>" ForeColor="Red" MaximumValue="20000"
                                MinimumValue="2400" SetFocusOnError="True" Type="Integer" ValidationGroup="edicionFCI">*</asp:RangeValidator>
                            &nbsp;<asp:RequiredFieldValidator ID="ReqValCapacidadBateriaAuBat" runat="server"
                                ControlToValidate="txtCapacidadBateria" ErrorMessage="<%$ Resources:ReqValConfPrm4ErrMsg %>"
                                ForeColor="Red" SetFocusOnError="True" ValidationGroup="CalcAutonoBat">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegExCapacidadBateriaAuBat" runat="server"
                                ControlToValidate="txtCapacidadBateria" ErrorMessage="<%$ Resources:RegExValConfPrm4ErrMsg %>"
                                ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{1,5}" ValidationGroup="CalcAutonoBat">*</asp:RegularExpressionValidator>
                            &nbsp;<asp:RangeValidator ID="RanValCapacidadBateriaAuBat" runat="server" ControlToValidate="txtCapacidadBateria"
                                ErrorMessage="<%$ Resources:RanValCapBateriaErrMsg %>" ForeColor="Red" MaximumValue="20000"
                                MinimumValue="2400" SetFocusOnError="True" Type="Integer" ValidationGroup="CalcAutonoBat">*</asp:RangeValidator>

                        </td>

                    </tr>

                </table>
                <table border="0" style="width: 100%">
                    <tr>
                        <td align="center">
                            <br />
                            <asp:UpdatePanel ID="UpdatePanelHistPrms" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="Label73" runat="server" CssClass="txtLabelPrms"
                                        Text="<%$ Resources:TextHistoriaActualizacionesPrms %>"></asp:Label>:
                                <asp:DropDownList ID="DDLFechasActualizacionesPrms" runat="server"
                                    AutoPostBack="True" CssClass="textInUsuario" Width="200px"
                                    OnSelectedIndexChanged="DDLFechasActualizacionesPrms_SelectedIndexChanged">
                                </asp:DropDownList>
                                    &nbsp;&nbsp;<asp:HyperLink ID="HyperLinkVerPrmsHistorico" runat="server"
                                        BorderStyle="Outset" Target="_blank" Text="<%$ Resources:TextLinkVerPrms %>"
                                        ToolTip="<%$ Resources:ToolTipLinkBotonVerHistPrms %>"> </asp:HyperLink>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:ValidationSummary ID="ValSumEdicionFCI" runat="server" Font-Size="12px" ForeColor="Red"
                                ValidationGroup="edicionFCI" />
                        </td>
                    </tr>
                </table>
                <br />

                <center>
                    <asp:Label ID="lblEstadoActualizacion" runat="server" ForeColor="Red"
                        Font-Bold="True" Visible="false"></asp:Label>
                </center>
                <center>
                    <asp:Label ID="lblEstadoActualizacionOnline" runat="server" ForeColor="Red"
                        Font-Bold="True" Visible="False"></asp:Label>
                </center>
            </div>
            <div class="centerDiv" align="center">
                <asp:Button ID="butUpdate" runat="server" Text="Enviar" OnClick="butUpdate_Click"
                    ValidationGroup="edicionFCI"
                    ToolTip="Envía todos los parametros configurados en esta pantalla al fci la proxima vez que su FWT respectivo se conecté ."
                    Visible="False" />
                <asp:Button ID="butUpdateOnline" runat="server" Text="<%$ Resources:TextBotonEnviar %>"
                    ValidationGroup="edicionFCI" Style="height: 26px"
                    OnClick="butUpdateOnline_Click" Enabled="False"
                    ToolTip="<%$ Resources:ToolTipBotonUpdateOnLine %>" />&nbsp;&nbsp;
            &nbsp;&nbsp;
            <asp:Button ID="butLeerParamOnline" runat="server" Text="<%$ Resources:TextBotonLeerPrmOnline %>"
                Style="height: 26px"
                Enabled="False" OnClick="butLeerParamOnline_Click" />&nbsp;&nbsp;
            <asp:Button ID="butDelete" runat="server" Text="<%$ Resources:TextBotonBorrar %>" OnClientClick="return confirm('Está seguro que quiere eliminar este FCI?');"
                OnClick="butDelete_Click" CausesValidation="False" />
                &nbsp;&nbsp;
            <asp:Button ID="butCancelar" runat="server" Text="<%$ Resources:TextBotonCancelar %>" OnClick="butCancelar_Click"
                CausesValidation="False" />
            </div>


        </div>


    </form>
</body>
</html>
