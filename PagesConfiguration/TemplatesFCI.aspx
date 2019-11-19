<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TemplatesFCI.aspx.cs" Inherits="SistemaGestionRedes.TemplatesFCI" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="rightDiv">

        <div class="centerDiv" align="center">
            Id Plantilla FCI :
            <asp:DropDownList runat="server" ID="ddlPlantillasFCI" AutoPostBack="true" OnSelectedIndexChanged="ddlPlantillasFCI_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
        <br />
        <div class="centerDiv">
            <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
            </asp:ScriptManager>
           <center>
            <asp:TabContainer ID="tbContainerPlantillasFCI" runat="server" ActiveTabIndex="0"
                Height="280px" BackColor="Silver" Width="700px">
                <asp:TabPanel ID="tbPanelGeneral" runat="server" HeaderText="General">
                    <ContentTemplate>
                       
                        <table style="width: 100%;" border="0">
                            <tr style="vertical-align: middle;">
                                <td align="right" style="width: 50%;">
                                    &nbsp;<asp:Label ID="Label1" runat="server" Text="Nombre:"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>&nbsp;
                                    <asp:RequiredFieldValidator ID="ReqValNombrePlantilla" runat="server" ControlToValidate="txtNombre"
                                        Font-Size="11px" ForeColor="Red" ErrorMessage="Se Requiere Nombre de Plantilla"
                                        SetFocusOnError="True" ValidationGroup="general">*</asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="CusValNombrePlantilla" runat="server" ControlToValidate="txtNombre"
                                        Font-Size="11px" ForeColor="Red" ErrorMessage="Nombre de Plantilla ya Existe"
                                        OnServerValidate="CheckNombrePlantillaFCI" SetFocusOnError="True" ValidationGroup="general">*</asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    &nbsp;<asp:Label ID="Label2" runat="server" Text="Corriente Absoluta Disparo:"></asp:Label>
                                </td>
                                <td align="left" style="vertical-align: middle;">
                                    <asp:TextBox ID="txtCorrienteAbsolutaDisparo" runat="server" CssClass="textBoxHora"
                                        Width="40px" />&nbsp;
                                    <asp:Label ID="Label4" runat="server" Text="(10-1000)A"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValConfPrm1" runat="server" ControlToValidate="txtCorrienteAbsolutaDisparo"
                                        Font-Size="11px" ForeColor="Red" SetFocusOnError="True" ErrorMessage="Se Requiere Corriente Absoluta Disparo"
                                        ValidationGroup="general">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm1" runat="server" ControlToValidate="txtCorrienteAbsolutaDisparo"
                                        Font-Size="11px" ForeColor="Red" SetFocusOnError="True" ErrorMessage="Corriente Absoluta Disparo Incorrecta"
                                        ValidationExpression="[0-9]{1,4}" ValidationGroup="general">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValCteDisparo" runat="server" ControlToValidate="txtCorrienteAbsolutaDisparo"
                                        MaximumValue="1000" MinimumValue="10" Font-Size="11px" ForeColor="Red" ErrorMessage="Corriente Fuera de Rango"
                                        SetFocusOnError="True" Type="Integer" ValidationGroup="general">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    &nbsp;<asp:Label ID="Label3" runat="server" Text="Numero Reintentos Comunicaciones:"></asp:Label>
                                </td>
                                <td align="left" style="vertical-align: middle;">
                                    <asp:TextBox ID="txtNumeroReintentosComunicaciones" runat="server" CssClass="textBoxHora"
                                        Width="40px" />&nbsp;
                                    <asp:Label ID="Label9" runat="server" Text="(1-10)"></asp:Label>&nbsp;
                                    <asp:RequiredFieldValidator ID="ReqValCongPrm2" runat="server" ControlToValidate="txtNumeroReintentosComunicaciones"
                                        ForeColor="Red" Font-Size="11px" SetFocusOnError="True" ErrorMessage="Se Requiere Numero de Reintentos"
                                        ValidationGroup="general">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegExValConfPrm2" runat="server" ControlToValidate="txtNumeroReintentosComunicaciones"
                                        ForeColor="Red" Font-Size="11px" SetFocusOnError="True" ErrorMessage="Número de Reintentos Comms Incorrecto"
                                        ValidationExpression="[0-9]{1,2}" ValidationGroup="general">*</asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RanValNroReintentos" runat="server" ControlToValidate="txtNumeroReintentosComunicaciones"
                                        ForeColor="Red" Font-Size="11px" MaximumValue="10" ErrorMessage="Número Reintentos Fuera de Rango"
                                        MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="general">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label5" runat="server" Text="Segundos Proxima Comunicación:"></asp:Label>
                                </td>
                                <td align="left" style="vertical-align: middle;">
                                    <asp:TextBox ID="txtSegundosProximaComunicacion" runat="server" CssClass="textBoxHora"
                                        Width="40px" />&nbsp;
                                    <asp:Label ID="Label6" runat="server" Text="(30-3600)Segs"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValConfPrm3" runat="server" ControlToValidate="txtSegundosProximaComunicacion"
                                        ForeColor="Red" Font-Size="11px" SetFocusOnError="True" ErrorMessage="Se Requiere Segundos Próxima Comms"
                                        ValidationGroup="general">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegExValConfPrm3" runat="server" ControlToValidate="txtSegundosProximaComunicacion"
                                        ForeColor="Red" Font-Size="11px" SetFocusOnError="True" ErrorMessage="Segundos Próxima Comm Incorrecto"
                                        ValidationExpression="[0-9]{1,4}" ValidationGroup="general">*</asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RanValSegsProxCom" runat="server" ControlToValidate="txtSegundosProximaComunicacion"
                                        ForeColor="Red" Font-Size="11px" MaximumValue="3600" ErrorMessage="Segundos Próxima Comunicación Fuera de Rango"
                                        MinimumValue="30" SetFocusOnError="True" Type="Integer" ValidationGroup="general">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label7" runat="server" Text="Capacidad Bateria Instalada:"></asp:Label>
                                </td>
                                <td align="left" style="vertical-align: middle;">
                                    <asp:TextBox ID="txtCapacidadBateria" runat="server" CssClass="textBoxHora" Width="40px" />&nbsp;
                                    <asp:Label ID="Label8" runat="server" Text="mA/h"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValConfPrm4" runat="server" ControlToValidate="txtCapacidadBateria"
                                        ForeColor="Red" Font-Size="11px" SetFocusOnError="True" ErrorMessage="Se Requiere Capacidad de Batería"
                                        ValidationGroup="general">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegExValConfPrm4" runat="server" ControlToValidate="txtCapacidadBateria"
                                        ForeColor="Red" Font-Size="11px" SetFocusOnError="True" ErrorMessage="Capacidad Batería Instalada Incorrecto"
                                        ValidationExpression="[0-9]{1,5}" ValidationGroup="general">*</asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RanValCapBateria" runat="server" ControlToValidate="txtCapacidadBateria"
                                        ForeColor="Red" Font-Size="11px" MaximumValue="65535" ErrorMessage="Capacidad Batería Fuera de Rango"
                                        MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="general">*</asp:RangeValidator>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">
                                    <asp:ValidationSummary ID="ValSumGeneral" runat="server" Font-Size="11px" ForeColor="Red"
                                        ValidationGroup="general" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel ID="tbPanelModoDisparo" runat="server" HeaderText="Modo Disparo">
                    <ContentTemplate>
                        <asp:Label ID="lblModoDisparo" CssClass="labelTitulo" Text="Modo Disparo Indicador :"
                            runat="server" />
                        <br />
                        <br />
                       <div class="centerDiv">
                        <div style="float: left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align="left">
                                        <asp:RadioButton ID="rdButModoProporcional" Text="Proporcional." GroupName="modoDisparo"
                                            Checked="true" runat="server" AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged" />
                                        &nbsp;&nbsp;&nbsp;
                                        <br />
                                        <asp:RadioButton ID="rdButModoPorIncremento" Text="Por Incremento." GroupName="modoDisparo"
                                            runat="server" AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged" />
                                        <br />
                                        <asp:RadioButton ID="rdButModoPorValorFijo" Text="Por Valor Fijo." GroupName="modoDisparo"
                                            runat="server" AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged" />
                                        <br />
                                        <asp:RadioButton ID="rdButModoPorAutoRango" Text="Por Autorango." GroupName="modoDisparo"
                                            runat="server" AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged" />
                                        <br />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        &nbsp;&nbsp;&nbsp;
                        <div style="float: left; width: 500px;">
                            <table class="tablaInternaConcentrador">
                                <tr>
                                    <td style="background-color: #465c71; color: White" align="center">
                                        Valor Falla
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color: #eeeeee" align="left">
                                        <br />
                                        <asp:Label ID="lblNombreValorFalla" CssClass="labelTitulo" runat="server" Text="DeltaI (di/dt) : " />
                                        &nbsp;
                                        <asp:TextBox ID="txtValorFalla" runat="server" CssClass="textBoxHora" Width="50px"></asp:TextBox>
                                        <asp:Label ID="lblUnids" runat="server" Font-Size="11px" Text="2-100 Veces"></asp:Label>
                                        <br />
                                        <asp:RequiredFieldValidator ID="ReqValPropor" runat="server" ControlToValidate="txtValorFalla"
                                            ErrorMessage="Se Requiere el Valor DeltaI" ForeColor="Red" SetFocusOnError="True"
                                            ValidationGroup="ModoDisparo">&nbsp;</asp:RequiredFieldValidator>
                                        &nbsp;<asp:RegularExpressionValidator ID="RegExPropor" runat="server" ControlToValidate="txtValorFalla"
                                            ErrorMessage="Valor Incorrecto de DeltaI" ForeColor="Red" SetFocusOnError="True"
                                            ValidationExpression="[0-9]{1,3}" ValidationGroup="ModoDisparo">&nbsp;</asp:RegularExpressionValidator>
                                        &nbsp;<asp:RangeValidator ID="RanValPropor" runat="server" ControlToValidate="txtValorFalla"
                                            ErrorMessage="Valor Fuera de Rango" ForeColor="Red" MaximumValue="100" MinimumValue="2"
                                            SetFocusOnError="True" Type="Integer" ValidationGroup="ModoDisparo">&nbsp;</asp:RangeValidator>
                                        &nbsp;<asp:RequiredFieldValidator ID="ReqValIncre" runat="server" ControlToValidate="txtValorFalla"
                                            Enabled="False" ErrorMessage="Se Requiere Valor Incremento" ForeColor="Red" SetFocusOnError="True"
                                            ValidationGroup="ModoDisparo">&nbsp;</asp:RequiredFieldValidator>
                                        &nbsp;<asp:RegularExpressionValidator ID="RegExValIncre" runat="server" ControlToValidate="txtValorFalla"
                                            Enabled="False" ErrorMessage="Valor Incorrecto del Incremento" ForeColor="Red"
                                            SetFocusOnError="True" ValidationExpression="[0-9]{1,4}" ValidationGroup="ModoDisparo">&nbsp;</asp:RegularExpressionValidator>
                                        &nbsp;<asp:RangeValidator ID="RanValIncre" runat="server" ControlToValidate="txtValorFalla"
                                            Enabled="False" ErrorMessage="Valor Incremento Fuera de Rango" ForeColor="Red"
                                            MaximumValue="1000" MinimumValue="10" SetFocusOnError="True" Type="Integer" ValidationGroup="ModoDisparo">&nbsp;</asp:RangeValidator>
                                        <asp:RequiredFieldValidator ID="ReqValFijo" runat="server" ControlToValidate="txtValorFalla"
                                            Enabled="False" ErrorMessage="Se Requiere Valor Corriente" ForeColor="Red" SetFocusOnError="True"
                                            ValidationGroup="ModoDisparo">&nbsp;</asp:RequiredFieldValidator>
                                        &nbsp;<asp:RegularExpressionValidator ID="RegExValFijo" runat="server" ControlToValidate="txtValorFalla"
                                            Enabled="False" ErrorMessage="Valor Incorrecto de Corriente" ForeColor="Red"
                                            SetFocusOnError="True" ValidationExpression="[0-9]{1,4}" ValidationGroup="ModoDisparo">&nbsp;</asp:RegularExpressionValidator>
                                        &nbsp;<asp:RangeValidator ID="RanValFijo" runat="server" ControlToValidate="txtValorFalla"
                                            Enabled="False" ErrorMessage="Valor Corriente Fuera de Rango" ForeColor="Red"
                                            MaximumValue="1000" MinimumValue="10" SetFocusOnError="True" Type="Integer" ValidationGroup="ModoDisparo">&nbsp;</asp:RangeValidator>
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 400px;" border="0">
                                <tr>
                                    <td align="center">
                                        <asp:ValidationSummary ID="ValSumModoDisparo" runat="server" Font-Size="11px" ForeColor="Red"
                                            ValidationGroup="ModoDisparo" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        
                        </div>
                        
                        <br />
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel ID="tbPanelModoReposicion" runat="server" HeaderText="Modo Reposición">
                    <ContentTemplate>
                        <br />
                        <asp:Label ID="lblModoReposicion" CssClass="labelTitulo" Text="Modo de Reposición :"
                            runat="server" />
                        <br />
                        <br />
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left">
                                    <asp:CheckBox ID="chkBoxModoRepPorTiempo" runat="server" Text="Por Tiempo." />
                                    <br />
                                    <asp:CheckBox ID="chkBoxModoRepPorTension" runat="server" Text="Por Tensión." />
                                    <br />
                                    <asp:CheckBox ID="chkBoxModoRepPorMagneto" runat="server" Text="Por Imán." />
                                    <br />
                                    <asp:CheckBox ID="chkBoxModoRepPorCorriente" runat="server" Text="Por Corriente." />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        <br />
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel ID="tbPanelActivaciones" runat="server" HeaderText="Activaciones">
                    <ContentTemplate>
                        <br />
                        <br />
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left">
                                    <asp:CheckBox ID="chkBoxHabReloj" runat="server" Text="Habilitar Reloj." Checked="true" Enabled="false"/>
                                    <br />
                                    <asp:CheckBox ID="chkBoxHabFallaTransitoria" runat="server" Text="Habilitar Falla Transitoria." />
                                </td>
                            </tr>
                        </table>
                        <br />
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel ID="tbPanelTiempos" runat="server" HeaderText="Tiempos">
                    <ContentTemplate>
                        <br />
                        <table style="width: 100%;" border="0">
                            <tr>
                                <td align="right" style="width: 50%;">
                                    <asp:Label ID="Label10" runat="server" Text="Tiempo Validación Falla: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtTiempoValFalla" runat="server" CssClass="textBoxHora" Width="30px" />
                                    <asp:Label ID="Label18" runat="server" Text="(1-120)Segs"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValT1" runat="server" ControlToValidate="txtTiempoValFalla"
                                        ErrorMessage="Se Requiere Tiempo Validación Falla" ForeColor="Red" SetFocusOnError="True"
                                        ValidationGroup="Tiempos">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValT1" runat="server" ControlToValidate="txtTiempoValFalla"
                                        ErrorMessage="Tiempo Validación Falla Incorrecto" ForeColor="Red" SetFocusOnError="True"
                                        ValidationExpression="[0-9]{1,3}" ValidationGroup="Tiempos">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValT1" runat="server" ControlToValidate="txtTiempoValFalla"
                                        ErrorMessage="Tiempo Validación Falla Fuera de Rango" ForeColor="Red" MaximumValue="120"
                                        MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label11" runat="server" Text="Tolerancia Tensión Reposición :"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtToleranciaTensionReposicion" runat="server" CssClass="textBoxHora"
                                        Width="30px" />
                                    <asp:Label ID="Label19" runat="server" Text="%"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValPrm2" runat="server" ControlToValidate="txtToleranciaTensionReposicion"
                                        ErrorMessage="Se Requiere Tolerancia Tensión Rep." ForeColor="Red" SetFocusOnError="True"
                                        ValidationGroup="Tiempos">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm2" runat="server" ControlToValidate="txtToleranciaTensionReposicion"
                                        ErrorMessage="Valor de Toleracia Tensión Incorrecto" SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm2" runat="server" ControlToValidate="txtToleranciaTensionReposicion"
                                        ErrorMessage="Toleracia Tensión Reposición Fuera de Rango" ForeColor="Red" MaximumValue="100"
                                        MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label12" runat="server" Text="Tiempo Reposición :"></asp:Label>
                                </td>
                                <td  align="left">
                                    <asp:TextBox ID="txtTiempoReposicion" runat="server" CssClass="textBoxHora" Width="30px" />
                                    <asp:Label ID="Label20" runat="server" Text="(1-86400)Segs"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValPrm3" runat="server" ControlToValidate="txtTiempoReposicion"
                                        ErrorMessage="Se Requiere Tiempo de Reposición" SetFocusOnError="True" ValidationGroup="Tiempos"
                                        ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm3" runat="server" ControlToValidate="txtTiempoReposicion"
                                        ErrorMessage="Tiempo de Reposición Incorrecto" SetFocusOnError="True" ValidationExpression="[0-9]{1,5}"
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm3" runat="server" ControlToValidate="txtTiempoReposicion"
                                        ErrorMessage="Tiempo Reposición Fuera de Rango" ForeColor="Red" MaximumValue="86400"
                                        MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label13" runat="server" Text="Tiempo Indicación Falla Temporal :"></asp:Label>
                                </td>
                                <td  align="left">
                                    <asp:TextBox ID="txtTiempoIndicacionFallatemp" runat="server" CssClass="textBoxHora"
                                        Width="30px" />
                                    <asp:Label ID="Label21" runat="server" Text="(1-86400)Segs"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValPrm4" runat="server" ControlToValidate="txtTiempoIndicacionFallatemp"
                                        ErrorMessage="Se Requiere Tiempo Indicación Falla Temporal" SetFocusOnError="True"
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm4" runat="server" ControlToValidate="txtTiempoIndicacionFallatemp"
                                        ErrorMessage="Tiempo Indicación Falla Temporal Incorrecto" SetFocusOnError="True"
                                        ValidationExpression="[0-9]{1,5}" ValidationGroup="Tiempos" ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm4" runat="server" ControlToValidate="txtTiempoIndicacionFallatemp"
                                        ErrorMessage="Tiempo Indicación Falla Temp. Fuera de Rango" ForeColor="Red" MaximumValue="86400"
                                        MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label14" runat="server" Text="Duración Destello :"></asp:Label>
                                </td>
                                <td  align="left">
                                    <asp:TextBox ID="txtTiempoFlashIndicacion" runat="server" CssClass="textBoxHora"
                                        Width="30px" />
                                    <asp:Label ID="Label22" runat="server" Text="multiplos de 8 msegs"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValPrm5" runat="server" ControlToValidate="txtTiempoFlashIndicacion"
                                        ErrorMessage="Se Requiere Duración Destello" SetFocusOnError="True" ValidationGroup="Tiempos"
                                        ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm5" runat="server" ControlToValidate="txtTiempoFlashIndicacion"
                                        ErrorMessage="Duración Destello Incorrecto" SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm5" runat="server" ControlToValidate="txtTiempoFlashIndicacion"
                                        ErrorMessage="Duración Destello Fuera de Rango" ForeColor="Red" MaximumValue="104"
                                        MinimumValue="8" SetFocusOnError="True" Type="Integer" ValidationGroup="Tiempos">*</asp:RangeValidator>
                                    &nbsp;<asp:CustomValidator ID="CusValDurDestello" runat="server" ControlToValidate="txtTiempoFlashIndicacion"
                                        ErrorMessage="La Duración Destello debe ser Múltiplo de 8" OnServerValidate="CheckTiempoDuracionDestello"
                                        SetFocusOnError="True" ValidationGroup="Tiempos" ForeColor="Red">*</asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label15" runat="server" Text="Tiempo entre destellos :"></asp:Label>
                                </td>
                                <td  align="left">
                                    <asp:TextBox ID="txtTiempoEntreFlashIndicacion" runat="server" CssClass="textBoxHora"
                                        Width="30px" />
                                    <asp:Label ID="Label23" runat="server" Text="(1-10)Segs"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValPrm6" runat="server" ControlToValidate="txtTiempoEntreFlashIndicacion"
                                        ErrorMessage="Se Requiere Tiempo entre Destellos" SetFocusOnError="True" ValidationGroup="Tiempos"
                                        ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm6" runat="server" ControlToValidate="txtTiempoEntreFlashIndicacion"
                                        ErrorMessage="Tiempo entre Destellos Incorrecto" SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm6" runat="server" ControlToValidate="txtTiempoEntreFlashIndicacion"
                                        ErrorMessage="Tiempo entre Destellos Fuera de Rango" ForeColor="Red" MaximumValue="10"
                                        MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label16" runat="server" Text="Tiempo Protección InRush :"></asp:Label>
                                </td>
                                <td  align="left">
                                    <asp:TextBox ID="txtTiempoProteccionInRush" runat="server" CssClass="textBoxHora"
                                        Width="30px" />
                                    <asp:Label ID="Label24" runat="server" Text="(1-120)Segs"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValPrm7" runat="server" ControlToValidate="txtTiempoProteccionInRush"
                                        ErrorMessage="Se Requiere Tiempo Protección InRush" SetFocusOnError="True" ValidationGroup="Tiempos"
                                        ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm7" runat="server" ControlToValidate="txtTiempoProteccionInRush"
                                        ErrorMessage="Tiempo Protección InRush Incorrecto" SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm7" runat="server" ControlToValidate="txtTiempoProteccionInRush"
                                        ErrorMessage="Tiempo Protección Inrush Fuera de Rango" ForeColor="Red" MaximumValue="120"
                                        MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label17" runat="server" Text="Tiempo Retardo Validación Tensión :"></asp:Label>
                                </td>
                                <td  align="left">
                                    <asp:TextBox ID="txtTiempoRetardoValidacionTension" runat="server" CssClass="textBoxHora"
                                        Width="30px" />
                                    <asp:Label ID="Label25" runat="server" Text="(1-120)Segs"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValPrm8" runat="server" ControlToValidate="txtTiempoRetardoValidacionTension"
                                        ErrorMessage="Se Requiere Tiempo Reatrdo Validación Tensión" SetFocusOnError="True"
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm8" runat="server" ControlToValidate="txtTiempoRetardoValidacionTension"
                                        ErrorMessage="Tiempo Retardo Validación Tensión Incorrecto" SetFocusOnError="True"
                                        ValidationExpression="[0-9]{1,3}" ValidationGroup="Tiempos" ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm8" runat="server" ControlToValidate="txtTiempoRetardoValidacionTension"
                                        ErrorMessage="Tiempo Retardo Validación Tensión Fuera de Rango" ForeColor="Red"
                                        MaximumValue="120" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">
                                    <asp:ValidationSummary ID="ValSumTiempos" runat="server" Font-Size="11px" ForeColor="Red"
                                        ValidationGroup="Tiempos" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:TabPanel>
            </asp:TabContainer>
            </center>
        </div>
        <br />
        <div class="centerDiv" align="center">
            <asp:Label ID="lblEstadoActualizacion" runat="server" Text="Label" ForeColor="Red"
                Font-Bold="True" Visible="False"></asp:Label>
        </div>
        <br />
        <div class="centerDiv" align="center">
            <asp:Button ID="butActualizar" runat="server" Text="Actualizar" OnClick="butActualizar_Click" />
            &nbsp;&nbsp;
            <asp:Button ID="butDelete" runat="server" Text="Borrar" OnClientClick="return confirm('Esta seguro de borrar la plantilla de FCI?');"
                OnClick="butDelete_Click" />
        </div>
    </div>
    </form>
</body>
</html>