<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewTemplateFWT.aspx.cs" Inherits="SistemaGestionRedes.NewTemplateFWT" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <title></title>
    <style type="text/css">
        .style3
        {
            height: 20px;
        }
    </style>
</head>
<body>

    <form id="frmNewTemplateParamFWT" runat="server">
    <div class="centerDiv" >
    <center>
    <asp:Wizard ID="WizardNuevoTemplateParamFWT" 
                runat="server" 
                HeaderText="Nueva Plantilla Parametros Concentrador"  
                CssClass="wizard" 
                HeaderStyle-CssClass="wizardHeader" 
                SideBarStyle-CssClass="sideBar"
                StepStyle-CssClass="step" 
                ActiveStepIndex="7" 
                OnNextButtonClick="NextButtonClick" 
                onfinishbuttonclick="WizardNuevoTemplateParamFWT_FinishButtonClick" 
                Width="650px" Height="400px" 
            onpreviousbuttonclick="WizardNuevoTemplateParamFWT_PreviousButtonClick" >
            
<HeaderStyle CssClass="wizardHeader"></HeaderStyle>

<SideBarStyle CssClass="sideBar" Font-Size="12px" Width="140px"></SideBarStyle>

<StepStyle CssClass="step"></StepStyle>
            
            <WizardSteps>
                <asp:WizardStep ID="WizardStepNombre" runat="server" Title="Nombre Plantilla">
                        
                       
                        <table style="width:100%;">
                            <tr>
                                <td width="50%">
                                    <asp:Label id="lblNombre" CssClass="labelTitulo"  Text="Nombre de la plantilla ?"  Runat="server" /> 
                                     <br />
                                      <br />
                                       <br />
                                    <asp:TextBox ID="txtNombre" runat="server">Plantilla Local</asp:TextBox>
                                </td>
                                <td  valign="bottom" >
                                    <asp:RequiredFieldValidator ID="ReqValNombrePlantilla" runat="server" 
                                        ControlToValidate="txtNombre" Font-Size="11px" ForeColor="Red" 
                                        SetFocusOnError="True">Se Requiere Nombre de Plantilla</asp:RequiredFieldValidator>
                                    <br />
                                    <asp:CustomValidator ID="CusValNombrePlantilla" runat="server" 
                                        ControlToValidate="txtNombre" Font-Size="11px" ForeColor="Red" 
                                        OnServerValidate="CheckNombreTemplate" SetFocusOnError="True">Nombre de Plantilla ya Existe</asp:CustomValidator>
                                </td>
                            </tr>
                        </table>
                        <br />
                </asp:WizardStep>
                
               <asp:WizardStep ID="WizardStepParametrosGPRS" runat="server" 
                    Title="Parametros GPRS">
                   <center>
                    <asp:Label id="lblParamGPRS" CssClass="labelTitulo"  Text="Parametros GPRS"  Runat="server" /> 
                    </center>
                    <br />
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblAPN" runat="server" AssociatedControlID="txtAPN" 
                                    CssClass="labelParametros" Text="APN:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtAPN" runat="server" Text="internet.movistar.com.co" 
                                    Width="90%"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;<asp:RequiredFieldValidator ID="ReqValAPN" runat="server" ControlToValidate="txtAPN" 
                                ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere el APN </asp:RequiredFieldValidator>
                                </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblUsuario" runat="server" AssociatedControlID="txtUsuario" 
                                    CssClass="labelParametros" Text="Usuario:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtUsuario" runat="server" Text="movistar"></asp:TextBox>
                            </td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" 
                                    CssClass="labelParametros" Text="Password:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtPassword" runat="server" Text="movistar"></asp:TextBox>
                            </td>
                            <td>
                              
                            </td>
                        </tr>
                        <tr>
                            <td class="style3" width="40%">
                                <asp:Label ID="lblRePassword" runat="server" AssociatedControlID="txtPassword" 
                                    CssClass="labelParametros" Text="Re-Password:"></asp:Label>
                            </td>
                            <td class="style3">
                            </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtRePassword" runat="server" MaxLength="100" Text="movistar" 
                                    TextMode="Password"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="lblValoresDistintos" runat="server" Text="Los Valores de Password son Distintos" ForeColor="Red" Font-Size="11px" Visible="False"></asp:Label>
                                </td>
                                   
                        </tr>
                    </table>
                    
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepParametrosRED" runat="server" 
                    Title="Parámetros Red">
                    <asp:Label id="lblParamRed" CssClass="labelTitulo"  Text="Parametros Red"  Runat="server" /> 
                    <br />
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblIpGestion" runat="server" AssociatedControlID="txtIpGestion" 
                                    CssClass="labelParametros" Text="Dirección ip Gestión:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtIpGestion" runat="server" Text="200.200.200.200" MaxLength="15"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValIPGestion" runat="server" ControlToValidate="txtIpGestion"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere IP de Gestión</asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="RegExValIPGestion" runat="server" ControlToValidate="txtIpGestion"
                                    ForeColor="Red" SetFocusOnError="True" 
                                    ValidationExpression="\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b" 
                                    Font-Size="11px">IP de Gestión Incorrecta</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblPuertoGestion" runat="server" 
                                    AssociatedControlID="txtPuertoGestion" CssClass="labelParametros" 
                                    Text="Puerto Gestión:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtPuertoGestion" runat="server" Text="20000" MaxLength="5" Width="60px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValGestion" runat="server" ControlToValidate="txtPuertoGestion"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere Puerto de Gestión</asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="RegExpValPtoGestion" runat="server" ControlToValidate="txtPuertoGestion"
                                    ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{4,5}" 
                                    Font-Size="11px">Puerto de Gestión Incorrecto</asp:RegularExpressionValidator>
                                <br />
                                <asp:RangeValidator ID="RanValPtoGestion" runat="server" ControlToValidate="txtPuertoGestion"
                                    ForeColor="Red" MaximumValue="65535" MinimumValue="1025" 
                                    SetFocusOnError="True" Font-Size="11px">Mal Definido el Pto Gestión (1025-65535)</asp:RangeValidator>
                            </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblIpSCADA" runat="server" AssociatedControlID="txtIpSCADA" 
                                    CssClass="labelParametros" Text="Dirección ip SCADA:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtIpSCADA" runat="server" Text="200.200.200.200" MaxLength="15"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValIPScada" runat="server" ControlToValidate="txtIpSCADA"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere IP de Scada</asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="RegExValIPScada" runat="server" ControlToValidate="txtIpSCADA"
                                    ForeColor="Red" SetFocusOnError="True" 
                                    ValidationExpression="\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b" 
                                    Font-Size="11px">IP de Scada Incorrecta</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblPuertoSCADA" runat="server" 
                                    AssociatedControlID="txtPuertoSCADA" CssClass="labelParametros" 
                                    Text="Puerto SCADA:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtPuertoSCADA" runat="server" Text="20000" MaxLength="5" Width="60px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValPtoScada" runat="server" ControlToValidate="txtPuertoSCADA"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere Puerto de Scada</asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="RegExpValPtoScada" runat="server" ControlToValidate="txtPuertoSCADA"
                                    ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{4,5}" 
                                    Font-Size="11px">Puerto de Scada Incorrecto</asp:RegularExpressionValidator>
                                <br />
                                <asp:RangeValidator ID="RanValPtoScada" runat="server" ControlToValidate="txtPuertoSCADA"
                                    ForeColor="Red" MaximumValue="65535" MinimumValue="1025" 
                                    SetFocusOnError="True" Font-Size="11px">Mal Definido el Pto Scada (1025-65535)</asp:RangeValidator>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
                            </asp:ScriptManager>
                    
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepDirNom" runat="server" Title="Dir. Nomenclatura">
                    <asp:Label id="lblDirNom" CssClass="labelTitulo"  Text="Direccion Nomenclatura"  Runat="server" /> 
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblCiudad" runat="server" AssociatedControlID="txtCiudad" 
                                    CssClass="labelParametros" Text="Ciudad:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtCiudad" runat="server" Text="Itaguí"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValCiudad" runat="server" ControlToValidate="txtCiudad"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere la Ciudad</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblCalle" runat="server" AssociatedControlID="txtCalle" 
                                    CssClass="labelParametros" Text="Calle:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtCalle" runat="server" Text="Calle 50 A "></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValCalle" runat="server" ControlToValidate="txtCalle"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere la Calle</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblNumero" runat="server" AssociatedControlID="txtNumero" 
                                    CssClass="labelParametros" Text="Numero:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtNumero" runat="server" Text="40"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValNumero" runat="server" ControlToValidate="txtNumero"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere el Número</asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="RegExValNumero" runat="server" ControlToValidate="txtNumero"
                                    ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{1,5}" 
                                    Font-Size="11px">Valor de Número Incorrecto</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                    
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepDirElec" runat="server" 
                    Title="Dirección Eléctrica">
                    <asp:Label id="lblDirElectrica" CssClass="labelTitulo"  Text="Direccion Electrica"  Runat="server" /> 
                    <br />
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblSubEstacion" runat="server" 
                                    AssociatedControlID="txtSubEstacion" CssClass="labelParametros" 
                                    Text="SubEstación:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtSubEstacion" runat="server" Text="Las Lomas"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValSubEsta" runat="server" ControlToValidate="txtSubEstacion"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere la SubEstación</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblCircuito" runat="server" AssociatedControlID="txtCircuito" 
                                    CssClass="labelParametros" Text="Circuito:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtCircuito" runat="server" Text="14"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValCircuito" runat="server" ControlToValidate="txtCircuito"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere el Circuito</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblTramo" runat="server" AssociatedControlID="txtTramo" 
                                    CssClass="labelParametros" Text="Tramo:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtTramo" runat="server" Text="20"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValTramo" runat="server" ControlToValidate="txtTramo"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere el Tramo</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="PanelDirElectrica" runat="server" >
                        <br />
                        <br /><br />
                        <br />
                        <br /><br />
                        <br />
                    </asp:Panel>
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepDirGPS" runat="server" Title="Dirección GPS">
                    <asp:Label id="lblDirGPS" CssClass="labelTitulo"  Text="Direccion GPS"  Runat="server" /> 
                    <br />
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblLatitud" runat="server" AssociatedControlID="txtLatitud" 
                                    CssClass="labelParametros" Text="Latitud:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtLatitud" runat="server" Text="15" MaxLength="6"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblLongitud" runat="server" AssociatedControlID="txtLongitud" 
                                    CssClass="labelParametros" Text="Longitud:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtLongitud" runat="server" Text="20" MaxLength="6"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                    <br />
                    
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepParametrosAdicionales" runat="server" 
                    Title="Prms Adicionales">
                    <asp:Label id="lblParAd" CssClass="labelTitulo"  Text="Parametros Adicionales"  Runat="server" /> 
                    <br />
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblCanalRF" runat="server" AssociatedControlID="txtCanalRF" 
                                    CssClass="labelParametros" Text="Canal RF:"></asp:Label>
                            </td>
                            <td width="60%">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtCanalRF" runat="server" MaxLength="1"></asp:TextBox>
                                <asp:NumericUpDownExtender ID="NumericUpDownExtenderCanalRF" runat="server" 
                                    Enabled="True" Maximum="9" Minimum="0" RefValues="" ServiceDownMethod="" 
                                    ServiceDownPath="" ServiceUpMethod="" Tag="" TargetButtonDownID="" 
                                    TargetButtonUpID="" TargetControlID="txtCanalRF" Width="50">
                                </asp:NumericUpDownExtender>
                                <asp:Label ID="lblCanalRF0" runat="server" AssociatedControlID="txtCanalRF" 
                                    CssClass="labelParametros" Text=" (0-9)"></asp:Label>
                            </td>
                            <td width="60%">
                                <asp:RangeValidator ID="RanValCanal" runat="server" ControlToValidate="txtCanalRF"
                                    ForeColor="Red" MaximumValue="9" MinimumValue="0" SetFocusOnError="True" 
                                    Type="Integer" Font-Size="11px">Valor Incorrecto del Canal (0-9)</asp:RangeValidator>
                                <br />
                                <asp:RequiredFieldValidator ID="ReqValCanal" runat="server" ControlToValidate="txtCanalRF"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere el Canal RF</asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="RegExpValCanal" runat="server" ControlToValidate="txtCanalRF"
                                    ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{1,1}" 
                                    Font-Size="11px">Valor Incorrecto del Canal RF</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:Label ID="lblNUmeroMaximoFCI" runat="server" 
                                    AssociatedControlID="txtNumeroMaximoFCI" CssClass="labelParametros" 
                                    Text="Número Máximo FCI:"></asp:Label>
                            </td>
                            <td width="60%">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <asp:TextBox ID="txtNumeroMaximoFCI" runat="server" CssClass="textBoxHora" 
                                    Text="18" MaxLength="2"></asp:TextBox>
                                <asp:Label ID="lblNUmeroMaximoFCI0" runat="server" 
                                    AssociatedControlID="txtNumeroMaximoFCI" CssClass="labelParametros" 
                                    Text=" (1-18)"></asp:Label>
                            </td>
                            <td width="60%">
                                <asp:RequiredFieldValidator ID="ReqValQtyFci" runat="server" ControlToValidate="txtNumeroMaximoFCI"
                                    ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere Máximo de FCIs</asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="RegExValQtyFci" runat="server" ControlToValidate="txtNumeroMaximoFCI"
                                    ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{1,2}" 
                                    Font-Size="11px">Valor Incorrecto en Número de FCIs</asp:RegularExpressionValidator>
                                <br />
                                <asp:RangeValidator ID="RanValQtyFci" runat="server" ControlToValidate="txtNumeroMaximoFCI"
                                    ForeColor="Red" MaximumValue="18" MinimumValue="1" SetFocusOnError="True" 
                                    Type="Integer" Font-Size="11px">Valor Incorrecto en Número Máximo de FCI (1-18)</asp:RangeValidator>
                            </td>
                        </tr>
                    </table>
                    <br />
                   <asp:Label ID="lblVecesNoReportar" Text="Veces sin Reportar:" AssociatedControlID="txtVecesNoReportar"
                       runat="server" CssClass="labelParametros" Visible="False" />
                   <br />
                   <asp:TextBox ID="txtVecesNoReportar" runat="server" Text="10" CssClass="textBoxHora"
                       Visible="False" />
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepDatosIngresados" runat="server" 
                    Title="Datos Ingresados" StepType="Finish" >
                
                <%-- El sufijo BD en el nombre de estos controles indica que estos datos se van a grabar en base de datos --%>
                <asp:Label id="lblDatosIng" CssClass="labelTitulo"  Text="Estos son los datos ingresados para crear la Plantilla:"  Runat="server" /> 
                <br />
                   <br />
                   <table border="0" style="width:100%;">
                       <tr>
                           <td  align="left"  width="35%">
                               Nombre Plantilla</td>
                           <td align="left">
                               <asp:Label ID="lblNombreBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td width="35%">
                               &nbsp;</td>
                           <td>
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               APN</td>
                           <td  align="left">
                               <asp:Label ID="lblAPNBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Usuario</td>
                           <td  align="left">
                               <asp:Label ID="lblUserBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Password</td>
                           <td align="left" >
                               <asp:Label ID="lblPwdBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td width="35%">
                               &nbsp;</td>
                           <td>
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Dirección ip Gestión</td>
                           <td  align="left">
                               <asp:Label ID="lblDirIpGesBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Puerto Gestión</td>
                           <td  align="left">
                               <asp:Label ID="lblPtoGesBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Dirección ip SCADA</td>
                           <td  align="left">
                               <asp:Label ID="lblDirIpSCADABD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Puerto SCADA</td>
                           <td  align="left">
                               <asp:Label ID="lblPtoSCADABD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td width="35%">
                               &nbsp;</td>
                           <td>
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Ciudad</td>
                           <td  align="left">
                               <asp:Label ID="lblCiudadBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Calle</td>
                           <td  align="left">
                               <asp:Label ID="lblCalleBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Número</td>
                           <td  align="left">
                               <asp:Label ID="lblNumeroBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                     
                       <tr>
                           <td   align="left" width="35%">
                               Subestación</td>
                           <td  align="left">
                               <asp:Label ID="lblSubEsBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Circuito</td>
                           <td  align="left">
                               <asp:Label ID="lblCircuitoBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Tramo</td>
                           <td  align="left">
                               <asp:Label ID="lblTramoBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                      
                       <tr>
                           <td  align="left" width="35%">
                               Latitud</td>
                           <td  align="left">
                               <asp:Label ID="lblLatitudBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td width="35%">
                               Longitud</td>
                           <td>
                               <asp:Label ID="lblLongitudBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td width="35%">
                               &nbsp;</td>
                           <td>
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Canal RF</td>
                           <td  align="left">
                               <asp:Label ID="lblCanalRFBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td  align="left" width="35%">
                               Veces sin grabar</td>
                           <td  align="left">
                               <asp:Label ID="lblVecesNoBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td   align="left" width="35%">
                               Número Máximo de FCIs</td>
                           <td  align="left">
                               <asp:Label ID="lblNumeroMaximoFCIBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                   </table>
                 <br />
                 <asp:Label id="Label1" CssClass="labelTitulo"  Text="De click en Finalizar para crear la plantilla de Parametros de Concentrador."  Runat="server" /> 
                 <br />
                 <br />
               </asp:WizardStep>
               <asp:WizardStep  ID="WizardStepTemplateParamFWTIngresado" runat="server" 
                    Title="Plantilla Ingresada" StepType="Complete"> 
               <asp:Label id="lblPlantillaIngresada" CssClass="labelTitulo" Runat="server" /> 
               
               </asp:WizardStep>

            </WizardSteps>
        </asp:Wizard>
        </center>
    </div>
    </form>
</body>
</html>
