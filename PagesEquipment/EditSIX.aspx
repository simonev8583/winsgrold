<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditSIX.aspx.cs" Inherits="SistemaGestionRedes.PagesEquipment.EditSIX" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="SistemaGestionRedes" Namespace="SistemaGestionRedes" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <title></title>
    
</head>

<script language="javascript" type="text/javascript" >

    function click_boton_OnLineStds() {
        form1.imgStdsOnLine.style.visibility = "visible";
    }

    function click_boton_OnLineCorriente() {
        form1.imgCteOnLine.style.visibility = "visible";
    }

    function click_boton_OnLineLeerParametros() {
        form1.imgPrmsOnLine.style.visibility = "visible";
    }

</script>


<body>
    <form id="form1" runat="server">
    <div>
    <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
   </asp:ScriptManager>

        <br />


        <table style="width:100%;">
            <tr>
                <td width="100%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center" class="EstiloTituloSeccion" width="100%">
                    <asp:Label ID="Label1" runat="server" CssClass="TituloSeccion" Text="<%$ Resources:TextTittleGenerales %>"></asp:Label>
                </td>
            </tr>
            <tr>
                <td width="100%">
                    <table style="width:100%;">
                        <tr>
                            <td align="right" width="20%">
                                <asp:Label ID="Label2" runat="server" CssClass="LabelDato" Text="<%$ Resources:TextLabelEstado %>"></asp:Label>:
                            </td>
                            <td width="30%">
                                &nbsp;<asp:UpdatePanel ID="genUpdatePanelEstadoSix" runat="server">
                                    <ContentTemplate>
                                        <asp:Label ID="genLblEstado" runat="server" 
    CssClass="LabelInformacion"></asp:Label>
                                        <asp:Image ID="imgEstadoSix" runat="server" Height="20px" 
                                            ImageUrl="~/Images/roller.gif" Visible="False" Width="20px" />
                                        &nbsp;<asp:Timer ID="tmrActualizacionEstadoSix" runat="server" Enabled="False" 
                                            Interval="5000" ontick="tmrActualizacionEstadoSix_Tick">
                                        </asp:Timer>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                            <td width="20%" align="right">
                                <asp:Label ID="Label3" runat="server" CssClass="LabelDato" 
                                    Text="<%$ Resources:TextLabelFechaRegistro %>"></asp:Label>:
                            </td>
                            <td width="30%">
                                <asp:Label ID="genLblFechaRegistro" runat="server" CssClass="LabelInformacion"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="20%">
                                <asp:Label ID="Label5" runat="server" CssClass="LabelDato" 
                                    Text="<%$ Resources:TextLabelFallaCircuito %>"></asp:Label>:
                            </td>
                            <td width="30%">
                                <asp:Label ID="genLblFallaCircuito" runat="server" CssClass="LabelInformacion"></asp:Label>
                            </td>
                            <td width="20%" align="right">
                                <asp:Label ID="Label4" runat="server" CssClass="LabelDato" 
                                    Text="<%$ Resources:TextLabelFechaInstalacion %>"></asp:Label>:
                            </td>
                            <td width="30%">
                                <asp:Label ID="genLblFechaInstalacion" runat="server" 
                                    CssClass="LabelInformacion"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="20%">
                                <asp:Label ID="Label26" runat="server" CssClass="LabelDato" 
                                    Text="<%$ Resources:TextLabelVersionPrograma %>"></asp:Label>:
                            </td>
                            <td width="30%">
                                <asp:Label ID="genLblVersionPrograma" runat="server" 
                                    CssClass="LabelInformacion"></asp:Label>
                            </td>
                            <td width="20%" align="right">
                                <asp:Label ID="Label27" runat="server" CssClass="LabelDato" Text="<%$ Resources:TextLabelSixSerial %>"></asp:Label>:
                            </td>
                            <td width="30%">
                                <asp:Label ID="genLblSerialSix" runat="server" CssClass="LabelInformacion"></asp:Label>
                            </td>
                        </tr>
                        </table>
                </td>
            </tr>
            <tr>
                <td width="100%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center" class="EstiloTituloSeccion" width="100%">
                    <asp:Label ID="Label6" runat="server" CssClass="TituloSeccion" 
                        Text="<%$ Resources:TextLabelGestionElectrica %>"></asp:Label>
                </td>
            </tr>
            <tr>
                <td width="100%">
                    <table style="width:100%;">
                        <tr>
                            <td align="right" width="30%">
                                <asp:Label ID="Label7" runat="server" CssClass="LabelDato" 
                                    Text="<%$ Resources:TextosGlobales,TextoSerialFWT %>"></asp:Label>:
                            </td>
                            <td width="20%">
                                <asp:DropDownList ID="gesDDLConcentradores" runat="server" 
                                    CssClass="textInUsuario" Width="100px" DataSourceID="datEDSConcentradores" 
                                    DataTextField="Serial" DataValueField="Id" 
                                    ondatabound="gesDDLConcentradores_DataBound">
                                </asp:DropDownList>
                            </td>
                            <td width="25%" align="right">
                                <asp:Label ID="gesLblOriginalFase" runat="server" CssClass="LabelInformacion" 
                                    Visible="False"></asp:Label>
                                <asp:Label ID="Label11" runat="server" CssClass="LabelDato" Text="<%$ Resources:TextosGlobales,TextoFase %>"></asp:Label>:
                            </td>
                            <td width="25%">
                                <asp:DropDownList ID="gesDDLFases" runat="server" CssClass="textInUsuario" 
                                    Width="40px">
                                    <asp:ListItem>R</asp:ListItem>
                                    <asp:ListItem>S</asp:ListItem>
                                    <asp:ListItem>T</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">
                                <asp:Label ID="Label8" runat="server" CssClass="LabelDato" 
                                    Text="<%$ Resources:TextosGlobales,TextoIdentificadorEquipo %>"></asp:Label>:
                            </td>
                            <td width="20%">
                                <asp:Label ID="gesLblIdentificador" runat="server" CssClass="LabelInformacion"></asp:Label>
                            </td>
                            <td width="25%" align="right">
                                <asp:Label ID="gesLblOriginalCirto" runat="server" CssClass="LabelInformacion" 
                                    Visible="False"></asp:Label>
                                <asp:Label ID="Label9" runat="server" CssClass="LabelDato" 
                                    Text="<%$ Resources:TextLabelTipoCircuito %>" Visible="False"></asp:Label>:
                            </td>
                            <td width="25%">
                                <asp:DropDownList ID="gesDDLTiposCircuito" runat="server" 
                                    CssClass="textInUsuario" Width="100px" AutoPostBack="True" 
                                    onselectedindexchanged="gesDDLTiposCircuito_SelectedIndexChanged" 
                                    Visible="False">
                                    <asp:ListItem Value="1" Text="<%$ Resources:TextoTipoMonofasico %>"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="<%$ Resources:TextoTipoBifasico %>"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="<%$ Resources:TextoTipoTrifasico %>"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" width="30%" colspan="4">
                                <asp:UpdatePanel ID="gesUpdatePanel" runat="server">
                                    <ContentTemplate>
                                        <table style="width:100%;">
                                            <tr>
                                                <td align="right" width="30%">
                                                    <asp:CheckBox ID="gesChkValEnScada" runat="server" CssClass="LabelInformacion" 
                                                        Visible="False" />
                                                    <asp:Label ID="Label10" runat="server" CssClass="LabelDato" 
                                                        Text="<%$ Resources:TextLabelEstadoScada %>"></asp:Label>:
                                                </td>
                                                <td width="10%">
                                                    <asp:CheckBox ID="gesChkScada" runat="server" AutoPostBack="True" 
                                                        CssClass="LabelInformacion" oncheckedchanged="gesChkScada_CheckedChanged" 
                                                        Text="<%$ Resources:TextCheckHabilitadoScada %>" />
                                                </td>
                                                <td width="60%">
                                                    <asp:Button ID="gesBtnConfirScada" runat="server" CssClass="TextBoton" 
                                                        Text="<%$ Resources:TextBotonConfirmar %>" onclick="gesBtnConfirScada_Click" />
                                                    &nbsp;
                                                    <asp:Label ID="gesLblTextoMensajeScada" runat="server" CssClass="TextError"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        </table>
                </td>
            </tr>
            <tr>
                <td width="100%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center" class="EstiloTituloSeccion" width="100%">
                    <asp:Label ID="Label12" runat="server" CssClass="TituloSeccion" 
                        Text="<%$ Resources:TextTittleParametros %>"></asp:Label>
                </td>
            </tr>
            <tr>
                <td width="100%">
                    <asp:UpdatePanel ID="prmsUpdatePanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <%--Tabla global de parámetros SIX.--%>
                            <table style="width:100%;">
                                <tr>
                                    
                                    <%--Celda para grupo de Corriente de Actuación.--%>

                                    <td width="50%">
                                        <table width="100%">
                                            <tr> 
                                                <td align="center" colspan="2" bgcolor="#00FFCC"> 
                                                    <asp:Label ID="Label28" runat="server" Text="<%$ Resources:TextTittleCorrienteActuacion %>"></asp:Label>
                                                </td> 
                                            </tr>
                                            
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label29" runat="server" Text="<%$ Resources:TextLabelModo %>"></asp:Label>:
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="rbLstModoActuacion" runat="server" BorderStyle="Solid" 
                                                        BorderWidth="2px" RepeatDirection="Horizontal" AutoPostBack="True" 
                                                        onselectedindexchanged="rbLstModoActuacion_SelectedIndexChanged">
                                                        <asp:ListItem Value="1" Selected="True" Text="<%$ Resources:TextModoUmbral %>"></asp:ListItem>
                                                        <asp:ListItem Value="0" Text="<%$ Resources:TextModoIncremental %>"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="right"> 
                                                    <asp:Label ID="Label13" runat="server" Text="<%$ Resources:TextLabelFrecuencia %>"></asp:Label>:
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="rbLstFrecuencia" runat="server" BorderStyle="Solid" 
                                                        BorderWidth="2px" RepeatDirection="Horizontal" AutoPostBack="False" >
                                                        <asp:ListItem Value="1" Selected="True" Text="60Hz"></asp:ListItem>
                                                        <asp:ListItem Value="0" Text="50Hz"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label30" runat="server" Text="<%$ Resources:TextLabelCorrienteUmbral %>"></asp:Label>:
                                                </td>

                                                <td>
                                                    
                                                    <asp:TextBox ID="prmTxtCteNominal" runat="server" CssClass="textInUsuario" 
                                                        MaxLength="3" Width="30px"></asp:TextBox>
                                                    &nbsp;<asp:Label ID="Label33" runat="server" CssClass="LabelAyuda" Text="(4-320) A"></asp:Label>
                                                    
                                                    &nbsp;<asp:RequiredFieldValidator ID="valRFcteNominal" runat="server" 
                                                        ControlToValidate="prmTxtCteNominal" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRFcteNominal %>"
                                                        ValidationGroup="parametros">*</asp:RequiredFieldValidator>

                                                    &nbsp;<asp:RangeValidator ID="valRVcteNominal" runat="server" 
                                                        ControlToValidate="prmTxtCteNominal" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRVcteNominal %>" 
                                                        MaximumValue="320" MinimumValue="4" Type="Integer" 
                                                        ValidationGroup="parametros">*</asp:RangeValidator>
                                                    
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label31" runat="server" Text="<%$ Resources:TextLabelCorrienteIncremental %>"></asp:Label>:
                                                </td>

                                                <td>
                                                    
                                                    <asp:TextBox ID="prmTxtCorrienteIncremental" runat="server" 
                                                        CssClass="textInUsuario" MaxLength="3" Width="30px" 
                                                        ontextchanged="prmTxtCorrienteIncremental_TextChanged" AutoPostBack="True" 
                                                        CausesValidation="True"></asp:TextBox>
                                                    &nbsp;<asp:Label ID="Label34" runat="server" CssClass="LabelAyuda" Text="(4-200) A"></asp:Label>
                                                    
                                                    &nbsp;<asp:RequiredFieldValidator ID="valRFCorrienteIncremental" runat="server" 
                                                        ControlToValidate="prmTxtCorrienteIncremental" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRFCorrienteIncremental %>" 
                                                        ValidationGroup="parametros">*</asp:RequiredFieldValidator>

                                                    &nbsp;<asp:RangeValidator ID="valRVCorrienteIncremental" runat="server" 
                                                        ControlToValidate="prmTxtCorrienteIncremental" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRVCorrienteIncremental %>" 
                                                        MaximumValue="200" MinimumValue="4" Type="Integer" ValidationGroup="parametros">*</asp:RangeValidator>
                                                    
                                                    &nbsp;<asp:RegularExpressionValidator ID="valRExCorrienteIncremental" runat="server" 
                                                        ControlToValidate="prmTxtCorrienteIncremental" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRExCorrienteIncremental %>" 
                                                        ValidationExpression="\d+" ValidationGroup="parametros">*</asp:RegularExpressionValidator>
                                                    
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label32" runat="server" Text="<%$ Resources:TextLabelTiempoIncremental %>"></asp:Label>:
                                                </td>

                                                <td>
                                                    
                                                    <asp:TextBox ID="prmTxtTiempoIncremental" runat="server" CssClass="textInUsuario" 
                                                        MaxLength="3" Width="30px" ToolTip="<%$ Resources:TextToolTipprmTxtTiempoIncremental %>"></asp:TextBox>
                                                    &nbsp;<asp:Label ID="lblHelpTiempoIncremental" runat="server" CssClass="LabelAyuda" 
                                                        Text="(40-100) ms"></asp:Label>
                                                    
                                                    &nbsp;<asp:RequiredFieldValidator ID="valRFTiempoIncremental" runat="server" 
                                                        ControlToValidate="prmTxtTiempoIncremental" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRFTiempoIncremental %>" 
                                                        ValidationGroup="parametros">*</asp:RequiredFieldValidator>

                                                    &nbsp;<asp:RangeValidator ID="valRVTiempoIncremental" runat="server" 
                                                        ControlToValidate="prmTxtTiempoIncremental" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRVTiempoIncremental %>" 
                                                        MaximumValue="100" MinimumValue="40" Type="Integer" 
                                                        ValidationGroup="parametros">*</asp:RangeValidator>
                                                    
                                                    &nbsp;<asp:CustomValidator ID="valCVTiempoIncremental" runat="server" 
                                                        ControlToValidate="prmTxtTiempoIncremental" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalCVTiempoIncremental %>" 
                                                        onservervalidate="valCVTiempoIncremental_ServerValidate" 
                                                        ValidationGroup="parametros">*</asp:CustomValidator>
                                                    
                                                </td>
                                            </tr>

                                        </table>
                                    </td>

                                    <%--Celda para grupo de conteos--%>

                                    <td width="50%" valign="top">
                                        <table width="100%">
                                            <tr>
                                                <td align="center" colspan="2" bgcolor="#00FFCC">
                                                    <asp:Label ID="Label36" runat="server" Text="<%$ Resources:TextLabelConteos %>"></asp:Label>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label37" runat="server" Text="<%$ Resources:TextLabelConteosFalla %>"></asp:Label>:
                                                </td>

                                                <td>
                                                    
                                                    <asp:TextBox ID="prmTxtConteos" runat="server" CssClass="textInUsuario" 
                                                        MaxLength="1" Width="20px"></asp:TextBox>

                                                    <asp:Label ID="Label39" runat="server" CssClass="LabelAyuda" Text="(1-4)"></asp:Label>

                                                    &nbsp;<asp:RequiredFieldValidator ID="valRFconteos" runat="server" 
                                                        ControlToValidate="prmTxtConteos" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRFconteos %>" 
                                                        ValidationGroup="parametros">*</asp:RequiredFieldValidator>

                                                    &nbsp;<asp:RangeValidator ID="valRVconteos" runat="server" 
                                                        ControlToValidate="prmTxtConteos" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRVconteos %>" MaximumValue="4" 
                                                        MinimumValue="1" Type="Integer" ValidationGroup="parametros">*</asp:RangeValidator>
&nbsp;</td>
                                            </tr>
                                            
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label38" runat="server" Text="<%$ Resources:TextLabelTiempoReset %>"></asp:Label>:
                                                </td>

                                                <td>
                                                    
                                                    <asp:TextBox ID="prmTxtResetContador" runat="server" CssClass="textInUsuario" 
                                                        MaxLength="2" Width="25px"></asp:TextBox>

                                                    <asp:Label ID="Label40" runat="server" CssClass="LabelAyuda" Text="(1-99) S"></asp:Label>

                                                    &nbsp;<asp:RequiredFieldValidator ID="valRFresetCon" runat="server" 
                                                        ControlToValidate="prmTxtResetContador" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRFresetCon %>" 
                                                        ValidationGroup="parametros">*</asp:RequiredFieldValidator>

                                                    &nbsp;<asp:RangeValidator ID="valRVresetCon" runat="server" 
                                                        ControlToValidate="prmTxtResetContador" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextvalRVresetCon %>" 
                                                        MaximumValue="99" MinimumValue="1" Type="Integer" 
                                                        ValidationGroup="parametros">*</asp:RangeValidator>
&nbsp;
                                                    
                                                </td>
                                            </tr>

                                        </table> <%--Fin tabla de grupo Conteos--%>
                                    </td>
                                </tr>

                                <%--Fila inferior de la tabla de parametros.--%>
                                <tr>
                                    <%--Celsa del grupo Corriente de Apertura.--%>
                                    <td valign="top">
                                        <table width="100%">
                                            <tr>
                                                <td align="center" colspan="2" bgcolor="#00FFCC">
                                                    <asp:Label ID="Label19" runat="server" Text="<%$ Resources:TextLabelCorrienteApertura %>"></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label41" runat="server" Text="<%$ Resources:TextLabelUmbralCteApertura %>"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="rbLstUmbralCteApertura" runat="server" 
                                                        BorderStyle="Solid" BorderWidth="2px" RepeatDirection="Horizontal">
                                                        <asp:ListItem Selected="True" Value="0">200mA</asp:ListItem>
                                                        <asp:ListItem Value="1">300mA</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label42" runat="server" Text="<%$ Resources:TextLabelTiempoDeteccion %>"></asp:Label>:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="prmTxtTiempoDeteccion" runat="server" CssClass="textInUsuario" 
                                                        MaxLength="4" Width="45px"></asp:TextBox>
                                                    &nbsp;<asp:Label ID="Label44" runat="server" CssClass="LabelAyuda" 
                                                        Text="(50-5000)ms"></asp:Label>

                                                    &nbsp;<asp:RequiredFieldValidator ID="valRFTiempoDeteccion" runat="server" 
                                                        ControlToValidate="prmTxtTiempoDeteccion" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRFTiempoDeteccion %>" 
                                                        ValidationGroup="parametros">*</asp:RequiredFieldValidator>

                                                    &nbsp;<asp:RangeValidator ID="valRVTiempoDeteccion" runat="server" 
                                                        ControlToValidate="prmTxtTiempoDeteccion" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRVTiempoDeteccion %>" 
                                                        MaximumValue="5000" MinimumValue="50" Type="Integer" 
                                                        ValidationGroup="parametros">*</asp:RangeValidator>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label43" runat="server" Text="<%$ Resources:TextLabelTiempoValidacion %>"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="prmTxtTiempoValidacion" runat="server" 
                                                        CssClass="textInUsuario" MaxLength="3" Width="35px"></asp:TextBox>
                                                    &nbsp;<asp:Label ID="Label45" runat="server" CssClass="LabelAyuda" 
                                                        Text="(80-120)ms"></asp:Label>

                                                    &nbsp;<asp:RequiredFieldValidator ID="valRFTiempoValidacion" runat="server" 
                                                        ControlToValidate="prmTxtTiempoValidacion" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRFTiempoValidacion %>" 
                                                        ValidationGroup="parametros">*</asp:RequiredFieldValidator>

                                                    &nbsp;<asp:RangeValidator ID="valRVTiempoValidadcion" runat="server" 
                                                        ControlToValidate="prmTxtTiempoValidacion" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRVTiempoValidadcion %>" 
                                                        MaximumValue="120" MinimumValue="80" Type="Integer" 
                                                        ValidationGroup="parametros">*</asp:RangeValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>

                                    <%--Celda para el grupo de Comunicaciones.--%>
                                    <td valign="top">
                                        <table width="100%">
                                            <tr>
                                                <td  align="center" colspan="2" bgcolor="#00FFCC">
                                                    <asp:Label ID="Label46" runat="server" Text="<%$ Resources:TextLabelComunicaciones %>"></asp:Label>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label47" runat="server" Text="<%$ Resources:TextosGlobales,TextoFase %>"></asp:Label>:
                                                </td>

                                                <td>
                                                    <asp:RadioButtonList ID="rbLstFase" runat="server" BorderStyle="Solid" 
                                                        BorderWidth="2px" RepeatDirection="Horizontal">
                                                        <asp:ListItem Selected="True" Value="1">A(R)</asp:ListItem>
                                                        <asp:ListItem Value="2">B(S)</asp:ListItem>
                                                        <asp:ListItem Value="3">C(T)</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td  align="right">
                                                    <asp:Label ID="Label48" runat="server" Text="<%$ Resources:TextLabelModoComunicaciones %>"></asp:Label>:
                                                </td>

                                                <td>
                                                    <asp:RadioButtonList ID="rbLstModoSix" runat="server" BorderStyle="Solid" 
                                                        BorderWidth="2px" RepeatDirection="Horizontal" AutoPostBack="True" 
                                                        onselectedindexchanged="rbLstModoSix_SelectedIndexChanged">
                                                        <asp:ListItem Selected="True" Text="<%$ Resources:TextoTipoMonofasico %>" Value="0"></asp:ListItem>
                                                        <asp:ListItem Value="1" Text="<%$ Resources:TextoTipoTrifasico %>"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td  align="right">
                                                    <asp:Label ID="Label49" runat="server" Text="<%$ Resources:TextLabelCanalComunicaciones %>"></asp:Label>:
                                                </td>

                                                <td>
                                                    <asp:DropDownList ID="prmDDLCanalComm" runat="server" CssClass="textInUsuario" 
                                                        Width="40px" Enabled="False">
                                                        <asp:ListItem>0</asp:ListItem>
                                                        <asp:ListItem>1</asp:ListItem>
                                                        <asp:ListItem>2</asp:ListItem>
                                                        <asp:ListItem>3</asp:ListItem>
                                                        <asp:ListItem>4</asp:ListItem>
                                                        <asp:ListItem>5</asp:ListItem>
                                                        <asp:ListItem>6</asp:ListItem>
                                                        <asp:ListItem>7</asp:ListItem>
                                                        <asp:ListItem>8</asp:ListItem>
                                                        <asp:ListItem>9</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td  align="right">
                                                    <asp:Label ID="Label50" runat="server" Text="<%$ Resources:TextLabelCodigoGrupo %>"></asp:Label>:
                                                </td>

                                                <td>
                                                    <asp:DropDownList ID="prmDDLCodigoTerna" runat="server" 
                                                        CssClass="textInUsuario" Width="40px">
                                                        <asp:ListItem Selected="True">1</asp:ListItem>
                                                        <asp:ListItem>2</asp:ListItem>
                                                        <asp:ListItem>3</asp:ListItem>
                                                        <asp:ListItem>4</asp:ListItem>
                                                        <asp:ListItem>5</asp:ListItem>
                                                        <asp:ListItem>6</asp:ListItem>
                                                        <asp:ListItem>7</asp:ListItem>
                                                        <asp:ListItem>8</asp:ListItem>
                                                        <asp:ListItem>9</asp:ListItem>
                                                        <asp:ListItem>10</asp:ListItem>
                                                    </asp:DropDownList>
                                                    &nbsp;<asp:CustomValidator ID="CusValCambioGrupo" runat="server" 
                                                        ErrorMessage="<%$ Resources: TextErrCusValCambioGrupo %>" 
                                                        ForeColor="Red" onservervalidate="valCambioCodigoGrupo_ServerValidate" 
                                                        SetFocusOnError="True" ValidationGroup="parametros">*</asp:CustomValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                                <%--Ultima fila de la tabla de prms.--%>
                                <tr>
                                    <%--Celsa para el grupo Varios.--%>
                                    <td valign="top">
                                        <table width="100%">
                                            <tr>
                                                <td align="center" colspan="2" bgcolor="#00FFCC">
                                                    <asp:Label ID="Label51" runat="server" Text="<%$ Resources:TextLabelVarios %>"></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label52" runat="server" Text="<%$ Resources:TextLabelTiempoInrush %>"></asp:Label>:
                                                </td>
                                                
                                                <td>
                                                    
                                                    <asp:TextBox ID="prmTxtTiempoValidacionInrush" runat="server" 
                                                        CssClass="textInUsuario" MaxLength="2" Width="25px"></asp:TextBox>
                                                    &nbsp;<asp:Label ID="Label55" runat="server" CssClass="LabelAyuda" 
                                                        Text="(1-99) Segs"></asp:Label>
                                                    
                                                    &nbsp;<asp:RequiredFieldValidator ID="valRFTiempoInrush" runat="server" 
                                                        ControlToValidate="prmTxtTiempoValidacionInrush" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRFTiempoInrush %>" 
                                                        ValidationGroup="parametros">*</asp:RequiredFieldValidator>
                                                    &nbsp;<asp:RangeValidator ID="valRVTiempoValidacionInrush" runat="server" 
                                                        ControlToValidate="prmTxtTiempoValidacionInrush" CssClass="TextError" 
                                                        ErrorMessage="<%$ Resources:TextErrvalRVTiempoValidacionInrush %>" 
                                                        MaximumValue="99" MinimumValue="1" Type="Integer" ValidationGroup="parametros">*</asp:RangeValidator>
                                                    
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label53" runat="server" Text="LED:"></asp:Label>
                                                </td>

                                                <td>
                                                    
                                                    <asp:CheckBox ID="prmChkActivarLED" runat="server" Text="<%$ Resources:TextLabelActivado %>" />
                                                    
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Label54" runat="server" Text="<%$ Resources:TextLabelSGR %>"></asp:Label>:
                                                </td>

                                                <td>
                                                    
                                                    <asp:RadioButtonList ID="prmRBLstSGR" runat="server" BorderStyle="Solid" 
                                                        BorderWidth="2px" Font-Size="11px" RepeatDirection="Horizontal">
                                                        <asp:ListItem Value="1" Text="<%$ Resources:TextSGRRemoto %>"></asp:ListItem>
                                                        <asp:ListItem Value="0" Selected="True" Text="<%$ Resources:TextSGRLocalRemoto %>"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                    
                                                </td>
                                            </tr>

                                        </table>
                                    </td>
                                </tr>

                            </table>
                            
                            <table align="center" width="50%">
                                <tr>
                                    <td align="center">
                                        <asp:Button ID="btnLeerPrmsOnLine" runat="server" CssClass="TextBoton" 
                                            onclick="btnLeerPrmsOnLine_Click" 
                                            Text="<%$ Resources:TextBotonLeerPrmsOnline %>" 
                                            OnClientClick="click_boton_OnLineLeerParametros();" Enabled="False" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="MsgLblResultadoCmdLeerPrmsOnLine" runat="server" 
                                            CssClass="TextError" Visible="False"></asp:Label>
                                        &nbsp;<img alt="" src="../Images/roller.gif" height="20px" name="imgPrmsOnLine" style="visibility: hidden" width="20px" /></td>
                                </tr>
                                <tr>
                                    <td width="100%" align="center">
                                        <asp:ValidationSummary ID="prmsValSumm" runat="server" CssClass="TextError" 
                                            ValidationGroup="parametros" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td align="center" class="EstiloTituloSeccion" width="100%">
                    <asp:Label ID="Label20" runat="server" CssClass="TituloSeccion" 
                        Text="<%$ Resources:TextTittleStdsCorriente %>"></asp:Label>
                </td>
            </tr>
            <tr>
                <td width="100%" align="center">
                    <table style="width:100%;">
                        <tr>
                            <td align="left" width="100%">
                            <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtenderStdsCte" runat="server"
                                TargetControlID="stdPanelContenidoCorrientes"
                                ExpandControlID="stdCtePanelHeader" 
                                CollapseControlID="stdCtePanelHeader" 
                                Collapsed="True"
                                TextLabelID="lblTextoHeaderCorrienteOcultar" 
                                ExpandedText = "<%$ Resources:TextPanelCtesExpandedText %>" 
                                CollapsedText = "<%$ Resources:TextPanelCtesCollapsedText %>"
                                ImageControlID="ImageStdCtes" 
                                ExpandedImage="~/Images/collapse.jpg" 
                                CollapsedImage="~/Images/expand.jpg"
                                SuppressPostBack="true">
                               </asp:CollapsiblePanelExtender>

                                <asp:Panel ID="stdCtePanelHeader" runat="server" CssClass="collapsePanelHeader" 
                                    Width="40%">
                                    <asp:Image ID="ImageStdCtes" runat="server" ImageUrl="~/Images/expand.jpg" 
                                        Height="16px" />
                                    &nbsp;<asp:Label ID="lblTextoHeaderPanelCorriente" runat="server" Text="<%$ Resources:TextPanelCtesUltimosDatosCtes %>"></asp:Label>
                                    &nbsp;&nbsp;<asp:Label ID="lblTextoHeaderCorrienteOcultar" runat="server" Text=""></asp:Label>
                                </asp:Panel>
                                <center>
                                <asp:Panel ID="stdPanelContenidoCorrientes" runat="server">
                                    <asp:UpdatePanel ID="stdUpPanel" runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="stdGVCorrientes" runat="server" AllowSorting="True" 
                                                AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" 
                                                GridLines="None" PageSize="5">
                                                <AlternatingRowStyle BackColor="White" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>" SortExpression="Fecha">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFecha" runat="server" Text='<%# Bind("Fecha") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="<%$ Resources:TextosGlobales,TextoValorCorriente %>" SortExpression="ValorIL">
                                                        <ItemTemplate>
                                                            <%--<asp:Label ID="lblValorIL" runat="server" Text='<%# Bind("ValorIL") %>'></asp:Label>--%>
                                                            <asp:Label ID="lblValorIL" runat="server" Text='<%# UtilitariosWebGUI.MostrarValorCorrienteSIXAjustado( Eval("ValorIL") ) %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
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
                                            <table width="50%">
                                                <tr>
                                                    <td align="right" width="25%">
                                                        <asp:Button ID="stdButRefresh" runat="server" CssClass="TextBoton" 
                                                            onclick="stdButRefresh_Click" Text="<%$ Resources:TextPanelCtesBotonActualizar %>" />
                                                    </td>
                                                    <td align="left" width="25%">
                                                        <asp:Button ID="btnCteActualOnLine" runat="server" CssClass="TextBoton" 
                                                            onclick="btnCteActualOnLine_Click" Text="<%$ Resources:TextPanelCtesBotonValorCteActual %>" 
                                                            OnClientClick="click_boton_OnLineCorriente();" Enabled="False" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="2" width="25%">
                                                        <asp:Label ID="MsgLblResultadoCmdCteOnLine" runat="server" CssClass="TextError" 
                                                            Visible="False"></asp:Label>
                                                        &nbsp;<img alt="" src="../Images/roller.gif" height="20px" name="imgCteOnLine" style="visibility: hidden" width="20px" /></td>
                                                </tr>
                                            </table>
                                            <br />
                                            <br />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <br />
                                </asp:Panel>
                                </center>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="100%" align="center" class="EstiloTituloSeccion">
                    <asp:Label ID="Label21" runat="server" CssClass="TituloSeccion" 
                        Text="<%$ Resources:TextTittleEstadisticasFuncionales %>"></asp:Label>
                </td>
            </tr>
            <tr>
                <td width="100%" align="center">
                    <table style="width:100%;">
                        <tr>
                            <td align="left">
                            
                            <asp:CollapsiblePanelExtender ID="CollapsiblePanelDatosFuncionales" runat="server"
                                TargetControlID="stdPanelOtrosDatosContenido"
                                ExpandControlID="stdPanelHeaderOtrosDatos" 
                                CollapseControlID="stdPanelHeaderOtrosDatos" 
                                Collapsed="True"
                                TextLabelID="lblTextHeaderEstadoPanel"
                                ExpandedText =  "<%$ Resources:TextPanelStdsExpandedText %>" 
                                CollapsedText = "<%$ Resources:TextPanelStdsCollapsedText %>"
                                ImageControlID="ImageOtrosDatos" 
                                ExpandedImage="~/Images/collapse.jpg" 
                                CollapsedImage="~/Images/expand.jpg"
                                SuppressPostBack="true">
                               </asp:CollapsiblePanelExtender>

                                <asp:Panel ID="stdPanelHeaderOtrosDatos" runat="server" 
                                    CssClass="collapsePanelHeader" Width="40%">
                                    <asp:Image ID="ImageOtrosDatos" runat="server" ImageUrl="~/Images/expand.jpg" />
                                    &nbsp;<asp:Label ID="lblTextHeaderStdDatos" runat="server" Text="<%$ Resources:TextPanelStdsUltimosDatosFunc %>"></asp:Label>
                                    &nbsp;&nbsp;<asp:Label ID="lblTextHeaderEstadoPanel" runat="server" Text=""></asp:Label>
                                </asp:Panel>
                                <center>
                                <asp:Panel ID="stdPanelOtrosDatosContenido" runat="server">
                                    <asp:UpdatePanel ID="stdFunUpdatePanel" runat="server">
                                        <ContentTemplate>
                                            <br />
                                            <asp:GridView ID="stdGVOtrosDatos" runat="server" AutoGenerateColumns="false" 
                                                CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="5">
                                                <AlternatingRowStyle BackColor="White" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="<%$ Resources:TextosGlobales,TextoFecha %>">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFecha" runat="server" Text='<%# Bind("Fecha") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="<%$ Resources:TextGridStdsOperaciones %>">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblOperaciones" runat="server" 
                                                                Text='<%# Bind("ContOperaciones") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="<%$ Resources:TextGridStdsTransitorios %>">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTransitorios" runat="server" 
                                                                Text='<%# Bind("ContTransitorios") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="<%$ Resources:TextGridStdsTiempoSobreActuacion %>">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTiempoSobreCteActuacion" runat="server" 
                                                                Text='<%# Bind("TiempoEnActuacion") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="<%$ Resources:TextGridStdsTiempoSobreCteMax %>">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTiempoSobreCteMaxima" runat="server" 
                                                                Text='<%# Bind("TiempoEnMaxima") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
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
                                            <table width="50%">
                                                <tr>
                                                    <td align="right" width="25%">
                                                        <asp:Button ID="stdFuncionalesRefresh" runat="server" CssClass="TextBoton" 
                                                            onclick="stdFuncionalesRefresh_Click" Text="<%$ Resources:TextGridStdsBotonActualizar %>" />
                                                    </td>
                                                    <td align="left" width="25%">
                                                        <asp:Button ID="stdFuncionalesOnLine" runat="server" CssClass="TextBoton" 
                                                            onclick="stdFuncionalesOnLine_Click" OnClientClick="click_boton_OnLineStds();" 
                                                            Text="<%$ Resources:TextGridStdsBotonAskOnline %>" Enabled="False" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" width="50%" align="center">
                                                        <asp:Label ID="MsgLblResultadoCmdStdsOnLine" runat="server" CssClass="TextError" 
                                                            Visible="False"></asp:Label>
                                                        &nbsp;<img alt="" src="../Images/roller.gif" height="20px" name="imgStdsOnLine" style="visibility: hidden" width="20px" /></td>
                                                </tr>
                                            </table>
                                            <br />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <br />
                                </asp:Panel>
                                </center>
                            <br />
                                <br />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="100%" align="center">
                    <asp:Button ID="btnActualizarInfo" runat="server" CssClass="TextBoton" 
                        onclick="btnActualizarInfo_Click" Text="<%$ Resources:TextBotonModificar %>" 
                        ValidationGroup="parametros" Enabled="False" />
                </td>
            </tr>
            <tr>
                <td width="100%" align="center">
                    <asp:Label ID="MsgLblResultadoCmdWritePrmsOnLine" runat="server" 
                      CssClass="TextError" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td width="100%">
                    <asp:EntityDataSource ID="datEDSConcentradores" runat="server" 
                        ConnectionString="name=SistemaGestionRemotoContainer" 
                        DefaultContainerName="SistemaGestionRemotoContainer" EntitySetName="FWTs" 
                        Select="it.[Id], it.[Serial]">
                    </asp:EntityDataSource>
                    <br />
                </td>
            </tr>
        </table>
        <br />
        <br />


    </div>
    </form>
    
</body>
</html>
