<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewTemplateFCI.aspx.cs" Inherits="SistemaGestionRedes.NewTemplateFCI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
   
    <style type="text/css">
        
         .leftColumn
        {
        float:left;
        padding:5px;
       
        }
        .rightColumn
        {
        float:right ;
        padding:5px;
        }
        .centerColumn
        {
        float: none ;
        padding:5px;
        }
        
         body   
    {
        
        font-size: .80em;
        font-family: "Helvetica Neue", "Lucida Grande", "Segoe UI", Arial, Helvetica, Verdana, sans-serif;
        margin: 0px;
        padding: 0px;
        color: #696969;
    }
        
        .style3
        {
            height: 26px;
        }
        
        .style4
        {
            height: 20px;
        }
        
        </style>
</head>
<body>

    <form id="frmNewTemplateParamFCI" runat="server">
    <div  class="centerDiv">
    <center>
     <asp:Wizard ID="WizardNuevoTemplateParamFCI" 
                    runat="server" 
                    HeaderText="Nueva Plantilla Parametros FCI" 
                    CssClass="wizard"
                    HeaderStyle-CssClass="wizardHeader" 
                    SideBarStyle-CssClass="sideBar" 
                    StepStyle-CssClass="step"
                    ActiveStepIndex="3" 
                    Width="700px" 
                    onfinishbuttonclick="WizardNuevoTemplateParamFCI_FinishButtonClick"
                    OnNextButtonClick="WizardNuevoTemplateParamFCI_NextButtonClick" 
            Height="500px" 
            onpreviousbuttonclick="WizardNuevoTemplateParamFCI_PreviousButtonClick" 
            onsidebarbuttonclick="WizardNuevoTemplateParamFCI_SideBarButtonClick"  >
           
<HeaderStyle CssClass="wizardHeader"></HeaderStyle>

<SideBarStyle CssClass="sideBar" Font-Size="12px" Width="120px"></SideBarStyle>

<StepStyle CssClass="step"></StepStyle>
           
            <WizardSteps>
                <asp:WizardStep ID="WizardStepNombre" runat="server" Title="Nombre Plantilla">
                   
                    
                    <table style="width:100%;">
                        <tr>
                            <td width="50%">
                                 <asp:Label ID="lblNombrer" CssClass="labelTitulo" Text="Nombre para esta plantilla ?"
                        runat="server" />
                        <br />
                        <br />
                                <asp:TextBox ID="txtNombre" runat="server" Width="90%">Plantilla 1</asp:TextBox>
                            </td>
                            <td width="50%">
                                <asp:RequiredFieldValidator ID="ReqValNombrePlantilla" runat="server" 
                                    ControlToValidate="txtNombre" Font-Size="11px" ForeColor="Red" 
                                    SetFocusOnError="True">Se Requiere Nombre de Plantilla</asp:RequiredFieldValidator>
                                <br />
                                <asp:CustomValidator ID="CusValNombrePlantilla" runat="server" 
                                    ControlToValidate="txtNombre" Font-Size="11px" ForeColor="Red" 
                                    OnServerValidate="CheckNombrePlantillaFCI" SetFocusOnError="True">Nombre de Plantilla ya Existe</asp:CustomValidator>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <br />
                </asp:WizardStep>
                
                <asp:WizardStep ID="WizardStepModoDisparo" runat="server" Title="Modo Disparo">
                 <asp:Label ID="lblModoDisparo" CssClass="labelTitulo" Text="Modo Disparo Indicador :"
                        runat="server" />
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td align="left"  width="25%">
                                <asp:RadioButton ID="rdButModoProporcional" runat="server" AutoPostBack="True" 
                                    Checked="True" GroupName="modoDisparo" 
                                    OnCheckedChanged="rdButModoDisparo_CheckedChanged" Text="Proporcional." />
                                <br />
                                <asp:RadioButton ID="rdButModoPorIncremento" runat="server" AutoPostBack="True" 
                                    GroupName="modoDisparo" OnCheckedChanged="rdButModoDisparo_CheckedChanged" 
                                    Text="Por Incremento." />
                                <br />
                                <asp:RadioButton ID="rdButModoPorValorFijo" runat="server" AutoPostBack="True" 
                                    GroupName="modoDisparo" OnCheckedChanged="rdButModoDisparo_CheckedChanged" 
                                    Text="Por Valor Fijo." />
                                <br />
                                <asp:RadioButton ID="rdButModoPorAutoRango" runat="server" AutoPostBack="True" 
                                    GroupName="modoDisparo" OnCheckedChanged="rdButModoDisparo_CheckedChanged" 
                                    Text="Por Autorango." />
                            </td>
                            <td valign="top">
                                <table style="width:100%;">
                                    <tr>
                                        <td align="center" bgcolor="#465C71" height="20%">
                                            <asp:Label ID="Label2" runat="server" ForeColor="White" Text="Valor Falla"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" bgcolor="#EEEEEE" height="57px">
                                            <asp:Label ID="lblNombreValorFalla" runat="server" CssClass="labelTitulo" Font-Size="12px"
                                                Text="DeltaI (di/dt) : "></asp:Label>
                                            <asp:TextBox ID="txtValorFalla" runat="server" CssClass="textBoxHora" Text="2"></asp:TextBox>
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
                                            <asp:Label ID="Label5" runat="server" Text="Aqui Hay Val Objs" Visible="False"></asp:Label>

                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="25%">
                                &nbsp;</td>
                            <td valign="top" align="center">
                                <asp:ValidationSummary ID="ValSumModoDisparo" runat="server" Font-Size="11px" 
                                    ForeColor="Red" ValidationGroup="ModoDisparo" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <br />
                    <br />
                    <div style="float: left">
                        &nbsp;&nbsp;&nbsp;
                    <br />
                    <br />
                    <br />
                    <br />
                    </div>
                    
                   
                   <br/>
                   
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStepModoReposicion" runat="server" 
                    Title="Modo Reposición" >
                <asp:Label ID="lblModoReposicion" CssClass="labelTitulo" Text="Modo de Reposición :"
                        runat="server" />
                    <br />
                    <br />
                    <center>
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="left" >
                                <asp:CheckBox ID="chkBoxModoRepPorTiempo" runat="server" Text="Por Tiempo." />
                                <br />
                                <asp:CheckBox ID="chkBoxModoRepPorTension" runat="server" Text="Por Tensión." />
                                <br />
                                <asp:CheckBox ID="chkBoxModoRepPorMagneto" runat="server" Text="Por Imán." />
                                <br />
                                <asp:CheckBox ID="chkBoxModoRepPorCorriente" runat="server" Text="Por Corriente." />
                                <br />
                            </td>
                        </tr>
                    </table>
                   </center>

                </asp:WizardStep>
                <asp:WizardStep ID="WizardStepActivaciones" runat="server" 
                    Title="Activaciones" >
                <asp:Label ID="lblActivaciones" CssClass="labelTitulo" Text="Activaciones :"
                        runat="server" />
                    <br />
                    <br />
                   <center>
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="left" >
                                <asp:CheckBox ID="chkBoxHabReloj" runat="server" Text="Habilitar Reloj." Checked="true" Enabled="false"/>
                                <br />
                                <asp:CheckBox ID="chkBoxHabFallaTransitoria" runat="server" Text="Habilitar Falla Transitoria." />
                                <br />
                            </td>
                        </tr>
                    </table>
                     </center>

                </asp:WizardStep>
                <asp:WizardStep ID="WizardStepTiempos" runat="server" Title="Tiempos">
                    <asp:Label id="lblTiempos" CssClass="labelTitulo"  Text="Tiempos"  Runat="server" /> 
                    <br />
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td align="right" width="50%">
                                <asp:Label ID="lblTiempoValFalla" runat="server" 
                                    AssociatedControlID="txtTiempoValFalla" CssClass="labelParametros" 
                                    Text="Tiempo Validación Falla :"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtTiempoValFalla" runat="server" CssClass="textBoxHora" 
                                    Text="2"></asp:TextBox>
                                <asp:Label ID="Label6" runat="server" Font-Size="12px" Text="(1-120)Segs"></asp:Label>
                                &nbsp;
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
                            <td align="right" width="50%">
                                <asp:Label ID="lblToleranciaTensionReposicion" runat="server" 
                                    AssociatedControlID="txtToleranciaTensionReposicion" CssClass="labelParametros" 
                                    Text="Tolerancia Tensión Reposición:"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtToleranciaTensionReposicion" runat="server" 
                                    CssClass="textBoxHora" Text="3"></asp:TextBox>
                                <asp:Label ID="Label7" runat="server" Font-Size="12px" Text="%"></asp:Label>
                                &nbsp;
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
                            <td align="right" width="50%">
                                <asp:Label ID="lblTiempoReposicion" runat="server" 
                                    AssociatedControlID="txtTiempoReposicion" CssClass="labelParametros" 
                                    Text="Tiempo Reposición :"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtTiempoReposicion" runat="server" CssClass="textBoxHora" 
                                    Text="5"></asp:TextBox>
                                <asp:Label ID="Label11" runat="server" Font-Size="12px" Text="(1-24)Hrs"></asp:Label>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="ReqValPrm3" runat="server" ControlToValidate="txtTiempoReposicion"
                                    ErrorMessage="Se Requiere Tiempo de Reposición" SetFocusOnError="True" ValidationGroup="Tiempos"
                                    ForeColor="Red">*</asp:RequiredFieldValidator>
                                &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm3" runat="server" ControlToValidate="txtTiempoReposicion"
                                    ErrorMessage="Tiempo de Reposición Incorrecto" SetFocusOnError="True" ValidationExpression="[0-9]{1,2}"
                                    ValidationGroup="Tiempos" ForeColor="Red">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValPrm3" runat="server" ControlToValidate="txtTiempoReposicion"
                                    ErrorMessage="Tiempo Reposición Fuera de Rango" ForeColor="Red" MaximumValue="24"
                                    MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                        </tr>
                        <tr>
                            <td align="right" class="style3" width="50%">
                                <asp:Label ID="lblTiempoIndicacionFallatemp" runat="server" 
                                    AssociatedControlID="txtTiempoIndicacionFallatemp" CssClass="labelParametros" 
                                    Text="Tiempo Indicación Falla Temporal :"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtTiempoIndicacionFallatemp" runat="server" 
                                    CssClass="textBoxHora" Text="5"></asp:TextBox>
                                <asp:Label ID="Label8" runat="server" Font-Size="12px" Text="(1-24)Hrs"></asp:Label>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="ReqValPrm4" runat="server" ControlToValidate="txtTiempoIndicacionFallatemp"
                                    ErrorMessage="Se Requiere Tiempo Indicación Falla Temporal" SetFocusOnError="True"
                                    ValidationGroup="Tiempos" ForeColor="Red">*</asp:RequiredFieldValidator>
                                &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm4" runat="server" ControlToValidate="txtTiempoIndicacionFallatemp"
                                    ErrorMessage="Tiempo Indicación Falla Temporal Incorrecto" SetFocusOnError="True"
                                    ValidationExpression="[0-9]{1,2}" ValidationGroup="Tiempos" ForeColor="Red">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValPrm4" runat="server" ControlToValidate="txtTiempoIndicacionFallatemp"
                                    ErrorMessage="Tiempo Indicación Falla Temp. Fuera de Rango" ForeColor="Red" MaximumValue="24"
                                    MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                        </tr>
                        <tr>
                            <td align="right" width="50%">
                                <asp:Label ID="lblTiempoFlashIndicacion" runat="server" 
                                    AssociatedControlID="txtTiempoFlashIndicacion" CssClass="labelParametros" 
                                    Text="Duración Destello:"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtTiempoFlashIndicacion" runat="server" 
                                    CssClass="textBoxHora" Text="8"></asp:TextBox>
                                <asp:Label ID="Label12" runat="server" Text="multiplos de 8 msegs"></asp:Label>
                                &nbsp;
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
                            <td align="right" width="50%">
                                <asp:Label ID="lblTiempoEntreFlashIndicacion" runat="server" 
                                    AssociatedControlID="txtTiempoEntreFlashIndicacion" CssClass="labelParametros" 
                                    Text="Tiempo entre destellos:"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtTiempoEntreFlashIndicacion" runat="server" 
                                    CssClass="textBoxHora" Text="5"></asp:TextBox>
                                <asp:Label ID="Label9" runat="server" Font-Size="12px" Text="(1-10)Segs"></asp:Label>
                                &nbsp;<asp:RequiredFieldValidator ID="ReqValPrm6" runat="server" ControlToValidate="txtTiempoEntreFlashIndicacion"
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
                            <td align="right" width="50%">
                                <asp:Label ID="lblTiempoProteccionInRush" runat="server" 
                                    AssociatedControlID="txtTiempoProteccionInRush" CssClass="labelParametros" 
                                    Text="Tiempo Protección InRush:"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtTiempoProteccionInRush" runat="server" 
                                    CssClass="textBoxHora" Text="5"></asp:TextBox>
                                <asp:Label ID="Label10" runat="server" Font-Size="12px" Text="(1-120)Segs"></asp:Label>
                                &nbsp;
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
                            <td align="right" width="50%">
                                <asp:Label ID="lblTiempoRetardoValidacionTension" runat="server" 
                                    AssociatedControlID="txtTiempoRetardoValidacionTension" 
                                    CssClass="labelParametros" Text="Tiempo Retardo Validación Tensión:"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtTiempoRetardoValidacionTension" runat="server" 
                                    CssClass="textBoxHora" Text="5"></asp:TextBox>
                                <asp:Label ID="Label13" runat="server" Font-Size="12px" Text="(1-120)Segs"></asp:Label>
                                &nbsp;
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
                    <table style="width:100%;">
                        <tr>
                            <td align="center">
                                <asp:ValidationSummary ID="ValSumTiempos" runat="server" Font-Size="11px" 
                                    ForeColor="Red" ValidationGroup="Tiempos" />
                            </td>
                        </tr>
                    </table>
               </asp:WizardStep>

                <asp:WizardStep ID="WizardStepConfiguraciones" runat="server" 
                    Title="Configuraciones">
                    <asp:Label id="lblConfiguraciones" CssClass="labelTitulo"  Text="Configuraciones"  Runat="server" /> 
                    <br />
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td width="48%" align="right">
                                <asp:Label ID="lblCorrienteAbsolutaDisparo" runat="server" 
                                    AssociatedControlID="txtCorrienteAbsolutaDisparo" CssClass="labelParametros" 
                                    Text="Corriente Absoluta Disparo :"></asp:Label>
                            </td>
                            <td  align="left">
                                <asp:TextBox ID="txtCorrienteAbsolutaDisparo" runat="server" 
                                     Text="10" MaxLength="4" Width="40px"></asp:TextBox>
                                &nbsp;<asp:Label ID="Label15" runat="server" Text="(10-1000)A"></asp:Label>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="ReqValConfPrm1" runat="server" ControlToValidate="txtCorrienteAbsolutaDisparo"
                                    ErrorMessage="Se Requiere Corriente Absoluta Disparo" ForeColor="Red" SetFocusOnError="True"
                                    ValidationGroup="Configuraciones">*</asp:RequiredFieldValidator>
                                &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm1" runat="server" ControlToValidate="txtCorrienteAbsolutaDisparo"
                                    ErrorMessage="Corriente Absoluta Disparo Incorrecta" ForeColor="Red" SetFocusOnError="True"
                                    ValidationExpression="[0-9]{1,4}" ValidationGroup="Configuraciones">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValCteDisparo" runat="server" ControlToValidate="txtCorrienteAbsolutaDisparo"
                                    ErrorMessage="Corriente Fuera de Rango" MaximumValue="1000" MinimumValue="10"
                                    SetFocusOnError="True" Type="Integer" ValidationGroup="Configuraciones">*</asp:RangeValidator>
                                </td>
                        </tr>
                        <tr>
                            <td width="48%" align="right">
                                <asp:Label ID="lblNumeroReintentosComunicaciones" runat="server" 
                                    AssociatedControlID="txtNumeroReintentosComunicaciones" 
                                    CssClass="labelParametros" Text="Numero Reintentos Comunicaciones:"></asp:Label>
                            </td>
                            <td  align="left">
                                <asp:TextBox ID="txtNumeroReintentosComunicaciones" runat="server" 
                                    CssClass="textBoxHora" Text="3"></asp:TextBox>
                                &nbsp;<asp:Label ID="Label16" runat="server" Text="(1-10)"></asp:Label>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="ReqValCongPrm2" runat="server" ControlToValidate="txtNumeroReintentosComunicaciones"
                                    ErrorMessage="Se Requiere Numero de Reintentos" ForeColor="Red" SetFocusOnError="True"
                                    ValidationGroup="Configuraciones">*</asp:RequiredFieldValidator>
                                &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm2" runat="server" ControlToValidate="txtNumeroReintentosComunicaciones"
                                    ErrorMessage="Número de Reintentos Comms Incorrecto" ForeColor="Red" SetFocusOnError="True"
                                    ValidationExpression="[0-9]{1,2}" ValidationGroup="Configuraciones">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValNroReintentos" runat="server" ControlToValidate="txtNumeroReintentosComunicaciones"
                                    ErrorMessage="Número Reintentos Fuera de Rango" ForeColor="Red" MaximumValue="10"
                                    MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Configuraciones">*</asp:RangeValidator>
                                </td>
                        </tr>
                        <tr>
                            <td width="48%" align="right">
                                <asp:Label ID="lblSegundosProximaComunicacion" runat="server" 
                                    AssociatedControlID="txtSegundosProximaComunicacion" CssClass="labelParametros" 
                                    Text="Segundos Proxima Comunicación :"></asp:Label>
                            </td>
                            <td  align="left">
                                <asp:TextBox ID="txtSegundosProximaComunicacion" runat="server" 
                                     Text="30" MaxLength="4" Width="40px"></asp:TextBox>
                                &nbsp;<asp:Label ID="Label17" runat="server" Text="(30-3600)Segs"></asp:Label>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="ReqValConfPrm3" runat="server" ControlToValidate="txtSegundosProximaComunicacion"
                                    ErrorMessage="Se Requiere Segundos Próxima Comms" ForeColor="Red" SetFocusOnError="True"
                                    ValidationGroup="Configuraciones">*</asp:RequiredFieldValidator>
                                &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm3" runat="server" ControlToValidate="txtSegundosProximaComunicacion"
                                    ErrorMessage="Segundos Próxima Comm Incorrecto" ForeColor="Red" SetFocusOnError="True"
                                    ValidationExpression="[0-9]{1,4}" ValidationGroup="Configuraciones">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValSegsProxCom" runat="server" ControlToValidate="txtSegundosProximaComunicacion"
                                    ErrorMessage="Segundos Próxima Comunicación Fuera de Rango" ForeColor="Red" MaximumValue="3600"
                                    MinimumValue="30" SetFocusOnError="True" Type="Integer" ValidationGroup="Configuraciones">*</asp:RangeValidator>
                                </td>
                        </tr>
                        <tr>
                            <td width="48%" align="right">
                                <asp:Label ID="lblCapacidadBateria" runat="server" 
                                    AssociatedControlID="txtCapacidadBateria" CssClass="labelParametros" 
                                    Text="Capacidad Bateria Instalada :"></asp:Label>
                            </td>
                            <td  align="left">
                                <asp:TextBox ID="txtCapacidadBateria" runat="server" CssClass="textBoxHora" 
                                    Text="2400" MaxLength="5" Width="45px"></asp:TextBox>
                                &nbsp;<asp:Label ID="Label18" runat="server" Text="mA/h"></asp:Label>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="ReqValConfPrm4" runat="server" ControlToValidate="txtCapacidadBateria"
                                    ErrorMessage="Se Requiere Capacidad de Batería" ForeColor="Red" SetFocusOnError="True"
                                    ValidationGroup="Configuraciones">*</asp:RequiredFieldValidator>
                                &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm4" runat="server" ControlToValidate="txtCapacidadBateria"
                                    ErrorMessage="Capacidad Batería Instalada Incorrecto" ForeColor="Red" SetFocusOnError="True"
                                    ValidationExpression="[0-9]{1,5}" ValidationGroup="Configuraciones">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValCapBateria" runat="server" ControlToValidate="txtCapacidadBateria"
                                    ErrorMessage="Capacidad Batería Fuera de Rango" ForeColor="Red" MaximumValue="65535"
                                    MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Configuraciones">*</asp:RangeValidator>
                                </td>
                        </tr>
                    </table>
                    <table style="width:100%;">
                        <tr>
                            <td align="center" bgcolor="#465C71" height="2px">
                                <asp:Label ID="Label14" runat="server" Font-Size="12px" ForeColor="White" 
                                    Text="Autonomia Bateria Instalada"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table style="width:100%;">
                        <tr>
                            <td align="center" bgcolor="#EEEEEE" height="40px">
                                <asp:Button ID="butCalcularAutonomia" runat="server" 
                                    Text="Calcular Autonomia" OnClick="butCalcularAutonomia_Click" 
                                    ValidationGroup="Configuraciones" />
                                &nbsp;<asp:Label ID="lblAutonomia" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table style="width:100%;">
                        <tr>
                            <td align="center">
                                <asp:ValidationSummary ID="ValResumenConfigs" runat="server" ForeColor="Red" 
                                        ValidationGroup="Configuraciones" />
                                </td>
                        </tr>
                    </table>
                    <br />
               </asp:WizardStep>

               <asp:WizardStep ID="WizardStepDatosIngresados" runat="server" 
                    Title="Datos Ingresados" StepType="Finish" >
                
                <%-- El sufijo BD en el nombre de estos controles indica que estos datos se van a grabar en base de datos --%>
                <asp:Label id="lblDatosIng" CssClass="labelTitulo"  Text="Estos son los datos ingresados para crear la plantilla de Parametros FCI:"  Runat="server" /> 
                <br />
                   <br />
                   <table style="width:100%;">
                       <tr>
                           <td align="center" colspan="2">
                               Nombre :
                               <asp:Label ID="lblNombreBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td colspan="2">
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td align="right" class="style4" width="50%">
                               Modo Disparo:</td>
                           <td  align="left">
                               <asp:Label ID="lblModoDisparoBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Valor Falla [<asp:Label ID="lblNombreValorFallaBD" runat="server"></asp:Label>
                               ]:</td>
                           <td  align="left">
                               <asp:Label ID="lblValorFallaBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td colspan="2" width="100%">
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Reposición por Tiempo:</td>
                           <td  align="left">
                               <asp:CheckBox ID="chkBoxRepTiempoBD" runat="server" Enabled="False" />
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Reposición por Tensión:</td>
                           <td  align="left">
                               <asp:CheckBox ID="chkBoxRepTensionBD" runat="server" Enabled="False" />
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Reposición por Imán:</td>
                           <td  align="left">
                               <asp:CheckBox ID="chkBoxRepMagnetoBD" runat="server" Enabled="False" />
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Reposición por Corriente:</td>
                           <td  align="left">
                               <asp:CheckBox ID="chkBoxRepCorrienteBD" runat="server" Enabled="False" />
                           </td>
                       </tr>
                       <tr>
                           <td colspan="2" width="50%">
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Habilitar Reloj:</td>
                           <td  align="left">
                               <asp:CheckBox ID="chkBoxHabRelojBD" runat="server" Enabled="False" Checked="true"/>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Habilitar Falla Transitoria:</td>
                           <td  align="left">
                               <asp:CheckBox ID="chkBoxHabFallaTransBD" runat="server" Enabled="False" />
                           </td>
                       </tr>
                       <tr>
                           <td colspan="2" width="50%">
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Tiempo Validación Falla:</td>
                           <td  align="left">
                               <asp:Label ID="lblTimeValFallaBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Tolerancia Tensión Reposición:</td>
                           <td  align="left">
                               <asp:Label ID="lblToleranciaTensBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Tiempo Reposición:</td>
                           <td  align="left">
                               <asp:Label ID="lblTimeReposBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Tiempo Indicación Falla Temporal:</td>
                           <td  align="left">
                               <asp:Label ID="lblTimeIndicFallatempBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Tiempo de Indicación de Flash:</td>
                           <td  align="left">
                               <asp:Label ID="lblTimeIndicFlashBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Tiempo entre Destellos:</td>
                           <td  align="left">
                               <asp:Label ID="lblTimeEntreIndicFlashBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Tiempo Protección InRush:</td>
                           <td  align="left">
                               <asp:Label ID="lblTimeProtecInRushBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Tiempo Retardo Validación Tensión:</td>
                           <td  align="left">
                               <asp:Label ID="lblTimeRetardoValidTensionBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td colspan="2" width="50%">
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Corriente Absoluta de Disparo:</td>
                           <td  align="left">
                               <asp:Label ID="lblCorrienteAbsDisparoBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Número Reintentos Comunicaciones:</td>
                           <td  align="left">
                               <asp:Label ID="lblNumReintComBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Segundos para Proxima Comunicación:</td>
                           <td  align="left">
                               <asp:Label ID="lblSegProxComBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Capacidad Bateria Instalada:</td>
                           <td  align="left">
                               <asp:Label ID="lblCapBatInstBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td align="right" width="50%">
                               Autonomia Bateria Instalada:</td>
                           <td  align="left">
                               <asp:Label ID="lblAutonomiaBattInstBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                   </table>
                   <br />
                   &nbsp;<br />
                 <asp:Label id="Label1" CssClass="labelTitulo"  Text="De click en Finalizar para crear la plantilla de parametros FCI."  Runat="server" /> 
                 <br />
                 <br />
               </asp:WizardStep>
               <asp:WizardStep  ID="WizardStepPlantillaParamFCIIngresada" runat="server" 
                    Title="Datos Ingresados" StepType="Complete"> 
               <asp:Label id="lblPlantillaParamFCIIngresada" CssClass="labelTitulo" Runat="server" /> 
               
               </asp:WizardStep>

            </WizardSteps>
        </asp:Wizard>  
        </center>
    </div >
    </form>
</body>
</html>
