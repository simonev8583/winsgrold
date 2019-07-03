<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewFCI.aspx.cs" Inherits="SistemaGestionRedes.NewFCI" EnableEventValidation="false" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
   
    <style type="text/css">
        
       
        
        .style4
        {
            width: 277px;
        }
        
        .style5
        {
            width: 110px;
        }
        .style6
        {
            width: 156px;
        }
        
        .style13
        {
            width: 276px;
        }
        .style15
        {
            height: 30px;
            width: 622px;
        }
        .style16
        {
            width: 622px;
            height: 20px;
        }
        
      
       
        .style19
        {
            width: 409px;
            height: 55px;
        }
        .style21
        {
            width: 333px;
            height: 20px;
        }
        .style24
        {
            width: 491px;
        }
        
        .style25
        {
            width: 395px;
        }
        .style26
        {
            height: 29px;
            width: 395px;
        }
        .style28
        {
            width: 283px;
            height: 29px;
        }
        .style29
        {
            width: 283px;
        }
        
        .style30
        {
            width: 248px;
            height: 24px;
        }
        .style31
        {
            height: 24px;
        }
        
        .style32
        {
            width: 247px;
        }
        .style33
        {
            width: 216px;
        }
        
     </style>

     <script type="text/javascript">

         function CambioTipoCircuito() {
             var objTipoCto = document.getElementById('<%=listBoxTipoCircuito.ClientID %>');
             var objListFases = document.getElementById('<%=DDListFases.ClientID %>');
             if (objTipoCto.options[objTipoCto.selectedIndex].value == '1') {
                 objListFases.disabled = true;
             }
             else {
                 objListFases.disabled = false;
                 removeAllFases(objListFases);
                 if (objTipoCto.options[objTipoCto.selectedIndex].value == '2') {
                     llenarConBifasico(objListFases);
                 }
                 else {
                     llenarConTrifasico(objListFases);
                 }

             }
         }

         function removeAllFases(objSelect) {
             for (i = 0; i < objSelect.options.length;) {
                 objSelect.remove(i);
             }
         }

         function llenarConBifasico(objSelect) {
             var optionA;
             var optionB;
             optionA = document.createElement("option");
             optionB = document.createElement("option");
             optionA.text = 'A';
             optionB.text = 'B';
             objSelect.add(optionA, null);
             objSelect.add(optionB, null);
         }

         function llenarConTrifasico(objSelect) {
             var optionR;
             var optionS;
             var optionT;
             optionR = document.createElement("option");
             optionS = document.createElement("option");
             optionT = document.createElement("option");
             optionR.text = 'R';
             optionS.text = 'S';
             optionT.text = 'T';
             objSelect.add(optionR, null);
             objSelect.add(optionS, null);
             objSelect.add(optionT, null);
         }

     </script>

</head>
<body>
    <form id="form1" runat="server">
    <div class="rightDiv">
        <div class="centerDiv">
        <asp:Wizard ID="WizardNuevoFCI" 
                    runat="server" 
                    HeaderText="Nuevo FCI" 
                    CssClass="wizard"
                    HeaderStyle-CssClass="wizardHeader" 
                    SideBarStyle-CssClass="sideBar" 
                    StepStyle-CssClass="step"
                    ActiveStepIndex="1" 
                    Width="900px" 
                    onfinishbuttonclick="WizardNuevoFCI_FinishButtonClick"
                    OnNextButtonClick="WizardNuevoFCI_NextButtonClick" 
            Height="280px" 
            onpreviousbuttonclick="WizardNuevoFCI_PreviousButtonClick" 
            onsidebarbuttonclick="WizardNuevoFCI_SideBarButtonClick"  >
           
<HeaderStyle CssClass="wizardHeader"></HeaderStyle>

<SideBarStyle CssClass="sideBar" Font-Size="12px" HorizontalAlign="Left" Width="100px"></SideBarStyle>

<StepStyle CssClass="step"></StepStyle>
           
            <WizardSteps>
                <asp:WizardStep ID="WizardStepSerial" runat="server" Title="Serial" >
                        <table style="width:100%;">
                            <tr>
                                <td class="style33">
                                    <asp:Label ID="lblSerial" runat="server" CssClass="labelTitulo" 
                                        Text="Cual es el serial de este FCI ? (8 caracteres)"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style33">
                                    <asp:TextBox ID="txtSerial" runat="server" MaxLength="8"  Width="80px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="ReqValSerial" runat="server" 
                                        ControlToValidate="txtSerial" ForeColor="Red" SetFocusOnError="True">Defina el Serial</asp:RequiredFieldValidator>
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegValSerial" runat="server" 
                                        ControlToValidate="txtSerial" ForeColor="Red" SetFocusOnError="True" 
                                        ValidationExpression="[a-zA-Z0-9]{8}">Usar Letras o Numeros</asp:RegularExpressionValidator>
                                    <br />
                                    <asp:CustomValidator ID="CusValSerial" runat="server" 
                                        ControlToValidate="txtSerial" ForeColor="Red" OnServerValidate="CheckSerial" 
                                        SetFocusOnError="True">Ya Existe el Serial</asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="style33">
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        <asp:Label id="lblNoingresoSerial" Text="Ingrese correctamente el Serial del FCI !"  Runat="server" Font-Bold="True" ForeColor="Red" Visible="False" /> 
                       
                        
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStepConcYFase" runat="server" 
                    Title="Concentrador y Fase">
                    <asp:Label ID="lblConcentrador" CssClass="labelTitulo" Text="Escoja el Concentrador que gestionará este FCI :"
                        runat="server" />
                    <br />
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td style="width:30%;" valign="top" >
                                <asp:Label ID="lblIdConcentrador" runat="server" CssClass="labelTitulo" 
                                    Text="Serial Concentrador:"></asp:Label>
                            </td>
                            <td style="width:20%;" valign="top">
                                <asp:DropDownList ID="ddlConcentradores" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlConcentradores_SelectedIndexChanged">
                                </asp:DropDownList>
                                <br />
                                <asp:RequiredFieldValidator ID="ReqValCntr" runat="server" 
                                    ControlToValidate="ddlConcentradores" Font-Size="X-Small" ForeColor="Red">Se Requiere un Concentrador</asp:RequiredFieldValidator>
                            </td>
                            <td style="width:50%;">
                                <div class="centerDiv">
                                    <center>
                                    <table >
                                        <tr>
                                            <td align="center" style="background-color:#465c71; color: White" valign="top">
                                                Datos Concentrador
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="background-color: #eeeeee">
                                                Ciudad =
                                                <asp:Label ID="lblCiudad" runat="server"></asp:Label>
                                                <br />
                                                Calle =
                                                <asp:Label ID="lblCalle" runat="server"></asp:Label>
                                                <br />
                                                Número =
                                                <asp:Label ID="lblNumero" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    </center>
                                </div>
                            </td>
                        </tr>
                        <tr>
                           <td class="style6" > </td> 
                           <td class="style5" > </td> 
                           <td> </td> 
                        </tr>
                        <tr>
                            <td class="style6" valign="top">
                                <asp:Label ID="lblTipoCircuito" runat="server" CssClass="labelTitulo" 
                                    Text="Tipo Circuito : "></asp:Label>
                            </td>
                            <td class="style5" valign="top">
                                <asp:ListBox ID="listBoxTipoCircuito" runat="server" Height="54px" 
                                    AutoPostBack="True" 
                                    OnSelectedIndexChanged="listBoxTipoCircuito_SelectedIndexChanged">
                                    <asp:ListItem Selected="True" Value="1">Monofásico</asp:ListItem>
                                    <asp:ListItem Value="2">Bifásico</asp:ListItem>
                                    <asp:ListItem Value="3">Trifásico</asp:ListItem>
                                </asp:ListBox>
                            </td>
                            <td align="center" valign="middle" >
                                <center>
                                <asp:Label ID="lblTipoCircuito0" runat="server" CssClass="labelTitulo" 
                                    Text="Fase : "></asp:Label>
                                <asp:DropDownList ID="DDListFases" runat="server" Enabled="False">
                                </asp:DropDownList></center>
                            </td>
                        </tr>
                        
                    </table>
                    
                    
                    <br />
                    
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStepEscogerParametros" runat="server" 
                    Title="Parametros Equipo">
                    <asp:Label ID="lblLlenadoParametros" CssClass="labelTitulo" Text="Como desea ingresar los Parametros del Equipo ?"
                        runat="server" />
                    <br />
                    <br />
                    <asp:RadioButton ID="rdlParametrosManual" Text="Ingresar Parametros Manualmente."
                        GroupName="LLenadoParametros" Checked="true" runat="server" OnCheckedChanged="rdlParametrosManual_CheckedChanged"
                        AutoPostBack="true" />
                    <br />
                    <asp:RadioButton ID="rdlParametrosPlantilla" Text="Escoger Plantilla." GroupName="LLenadoParametros"
                        runat="server" OnCheckedChanged="rdlParametrosPlantilla_CheckedChanged" AutoPostBack="true" />
                    <br />
                    &nbsp; &nbsp;
                    <asp:DropDownList runat="server" ID="ddlPlantillasFCI" Enabled="False" 
                        AppendDataBoundItems="True">
                        <asp:ListItem Selected="True" Value="0">Seleccionar Plantilla</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;<asp:CustomValidator ID="CusValPlantilla" runat="server" 
                        ControlToValidate="ddlPlantillasFCI" ForeColor="Red" 
                        OnServerValidate="CheckPlantillaParametros">Debe Seleccionar una Plantilla</asp:CustomValidator>
                    <br />
                    <asp:Label id="lblNoPlantilla" Text="Debe escoger una plantilla  !"  Runat="server" Font-Bold="True" ForeColor="Red" Visible="False" /> 
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStepModoDisparo" runat="server" Title="Modo Disparo">
                 <asp:Label ID="lblModoDisparo" CssClass="labelTitulo" Text="Modo Disparo Indicador :"
                        runat="server" />
                    <br />
                    <br />
                    <div style="float: left">
                        <asp:RadioButton ID="rdButModoProporcional" Text="Proporcional."
                        GroupName="modoDisparo" Checked="true" runat="server" 
                        AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged" /> &nbsp;&nbsp;&nbsp;
                    <br />
                    <asp:RadioButton ID="rdButModoPorIncremento" Text="Por Incremento."
                        GroupName="modoDisparo" runat="server"
                         AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged" />
                    <br />
                     <asp:RadioButton ID="rdButModoPorValorFijo" Text="Por Valor Fijo."
                        GroupName="modoDisparo" runat="server"
                         AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged" />
                    <br />
                    <asp:RadioButton ID="rdButModoPorAutoRango" Text="Por Autorango."
                        GroupName="modoDisparo" runat="server"
                         AutoPostBack="true" OnCheckedChanged="rdButModoDisparo_CheckedChanged"/>
                    <br />
                    </div>
                    &nbsp;&nbsp;&nbsp;
                    <div style="float: left; width: 420px;">
                        
                        <table class="tablaInternaConcentrador" width="420px">
                            <tr>
                                <td style="background-color: #465c71; color: White" align="center" class="style21"  >
                                    Valor Falla
                                </td>
                            </tr>
                            <tr>
                                <td style="background-color: #eeeeee" align="center"  class="style24" valign="middle" >
                                   <asp:Label ID="lblNombreValorFalla" CssClass="labelTitulo" runat="server" 
                                        Text="DeltaI (di/dt) :" Font-Size="12px" />
                                   &nbsp;
                                    <asp:TextBox ID="txtValorFalla" runat="server" CssClass="textBoxHora" Text="2" 
                                        MaxLength="4" Font-Size="12px" Width="35px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="lblUnids" runat="server" Font-Size="11px" Text="2-100 Veces"></asp:Label>
                                    
                                    
                                </td>
                            </tr>
                          
                        </table>
                    </div>
                   
                   <br />
                    <br />

                    <div style="float: left; width: 420px;">
                        <table>
                            <tr>
                                <td align="left" class="style4"  valign="top">
                                    <asp:RequiredFieldValidator ID="ReqValPropor" runat="server" ControlToValidate="txtValorFalla"
                                        ErrorMessage="Se Requiere el Valor DeltaI" ForeColor="Red" SetFocusOnError="True"
                                        ValidationGroup="ModoDisparo">&nbsp;</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExPropor" runat="server" ControlToValidate="txtValorFalla"
                                        ErrorMessage="Valor Incorrecto de DeltaI" ForeColor="Red" SetFocusOnError="True"
                                        ValidationExpression="[0-9]{1,3}" ValidationGroup="ModoDisparo">&nbsp;</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPropor" runat="server" ControlToValidate="txtValorFalla"
                                        ErrorMessage="Valor Fuera de Rango" ForeColor="Red" MaximumValue="100" MinimumValue="2"
                                        SetFocusOnError="True" Type="Integer" ValidationGroup="ModoDisparo">&nbsp;</asp:RangeValidator>
                                    &nbsp;<asp:Label ID="Label5" runat="server" Text="Aqui Hay Val Objs" Visible="False"></asp:Label>
                                    <br />
                                    <asp:RequiredFieldValidator ID="ReqValIncre" runat="server" ControlToValidate="txtValorFalla"
                                        Enabled="False" ErrorMessage="Se Requiere Valor Incremento" ForeColor="Red" SetFocusOnError="True"
                                        ValidationGroup="ModoDisparo">&nbsp;</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValIncre" runat="server" ControlToValidate="txtValorFalla"
                                        Enabled="False" ErrorMessage="Valor Incorrecto del Incremento" ForeColor="Red"
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,4}" ValidationGroup="ModoDisparo">&nbsp;</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValIncre" runat="server" ControlToValidate="txtValorFalla"
                                        Enabled="False" ErrorMessage="Valor Incremento Fuera de Rango" ForeColor="Red"
                                        MaximumValue="1000" MinimumValue="10" SetFocusOnError="True" Type="Integer" ValidationGroup="ModoDisparo">&nbsp;</asp:RangeValidator>
                                    <br />
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
                            <tr>
                                <td align="left" class="style19" >
                                    <asp:ValidationSummary ID="ValResumenModoDisparo" runat="server" ForeColor="Red"
                                        ValidationGroup="ModoDisparo" />
                                </td>
                            </tr>
                        </table>
                    </div>

         
                   
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStepModoReposicion" runat="server" 
                    Title="Modo Reposicion" >
                <asp:Label ID="lblModoReposicion" CssClass="labelTitulo" Text="Modo de Reposición :"
                        runat="server" />
                    <br />
                    <br />
                    <asp:CheckBox ID="chkBoxModoRepPorTiempo" runat="server" Text="Por Tiempo."/>
                     <br />
                      <asp:CheckBox ID="chkBoxModoRepPorTension" runat="server" Text="Por Tensión."/>
                     <br />
                     <asp:CheckBox ID="chkBoxModoRepPorMagneto" runat="server" Text="Por Imán."/>
                     <br />
                     <asp:CheckBox ID="chkBoxModoRepPorCorriente" runat="server" Text="Por Corriente."/>
                     <br />

                </asp:WizardStep>
                <asp:WizardStep ID="WizardStepActivaciones" runat="server" 
                    Title="Activaciones" >
                <asp:Label ID="lblActivaciones" CssClass="labelTitulo" Text="Activaciones :"
                        runat="server" />
                    <br />
                    <br />
                    <asp:CheckBox ID="chkBoxHabReloj" runat="server" Text="Habilitar Reloj." Enabled="false" Checked="true"/>
                     <br />
                      <asp:CheckBox ID="chkBoxHabFallaTransitoria" runat="server" Text="Habilitar Falla Transitoria."/>
                     <br />
                     

                </asp:WizardStep>
               <asp:WizardStep ID="WizardStepTiempos" runat="server" Title="Tiempos">
                    <asp:Label id="lblTiempos" CssClass="labelTitulo"  Text="Tiempos"  Runat="server" /> 
                    <br />
                 
                    <asp:Panel ID="PanelDirNom" runat="server" Height="270px" >
                        <table style="width:100%;">
                            <tr>
                                <td align="right" class="style29">
                                    <asp:Label ID="lblTiempoValFalla" runat="server" 
                                        AssociatedControlID="txtTiempoValFalla" CssClass="labelParametros" 
                                        Text="Tiempo Validación Falla :" Font-Size="12px"></asp:Label>
                                </td>
                                <td style="margin-left: 40px" class="style25">
                                    <asp:TextBox ID="txtTiempoValFalla" runat="server" CssClass="textBoxHora" 
                                        MaxLength="3" Text="1" Width="30px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="Label6" runat="server" Font-Size="12px" Text="(1-120)Segs"></asp:Label>
&nbsp;<asp:RequiredFieldValidator ID="ReqValT1" runat="server" 
                                        ControlToValidate="txtTiempoValFalla" 
                                        ErrorMessage="Se Requiere Tiempo Validación Falla" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationGroup="Tiempos">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValT1" runat="server" 
                                        ControlToValidate="txtTiempoValFalla" 
                                        ErrorMessage="Tiempo Validación Falla Incorrecto" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,3}" 
                                        ValidationGroup="Tiempos">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValT1" runat="server" 
                                        ControlToValidate="txtTiempoValFalla" 
                                        ErrorMessage="Tiempo Validación Falla Fuera de Rango" ForeColor="Red" 
                                        MaximumValue="120" MinimumValue="1" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style29">
                                    <asp:Label ID="lblToleranciaTensionReposicion" runat="server" 
                                        AssociatedControlID="txtToleranciaTensionReposicion" CssClass="labelParametros" 
                                        Text="Tolerancia Tensión Reposición: " Font-Size="12px"></asp:Label>
                                </td>
                                <td class="style25">
                                    <asp:TextBox ID="txtToleranciaTensionReposicion" runat="server" 
                                        CssClass="textBoxHora" MaxLength="3" Text="3" Width="30px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="Label7" runat="server" Font-Size="12px" Text="(1-100)%"></asp:Label>
                                    &nbsp;<asp:RequiredFieldValidator ID="ReqValPrm2" runat="server" 
                                        ControlToValidate="txtToleranciaTensionReposicion" 
                                        ErrorMessage="Se Requiere Tolerancia Tensión Rep." ForeColor="Red" 
                                        SetFocusOnError="True" ValidationGroup="Tiempos">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm2" runat="server" 
                                        ControlToValidate="txtToleranciaTensionReposicion" 
                                        ErrorMessage="Valor de Toleracia Tensión Incorrecto" SetFocusOnError="True" 
                                        ValidationExpression="[0-9]{1,3}" ValidationGroup="Tiempos" 
                                        ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm2" runat="server" 
                                        ControlToValidate="txtToleranciaTensionReposicion" 
                                        ErrorMessage="Toleracia Tensión Reposición Fuera de Rango" ForeColor="Red" 
                                        MaximumValue="100" MinimumValue="1" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style28">
                                    <asp:Label ID="lblTiempoReposicion" runat="server" 
                                        AssociatedControlID="txtTiempoReposicion" CssClass="labelParametros" 
                                        Text="Tiempo Reposición :" Font-Size="12px"></asp:Label>
                                </td>
                                <td class="style26">
                                    <asp:TextBox ID="txtTiempoReposicion" runat="server" CssClass="textBoxHora" 
                                        MaxLength="5" Text="5" Width="40px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="Label11" runat="server" Font-Size="12px" Text="Segs"></asp:Label>
&nbsp;<asp:RequiredFieldValidator ID="ReqValPrm3" runat="server" 
                                        ControlToValidate="txtTiempoReposicion" 
                                        ErrorMessage="Se Requiere Tiempo de Reposición" SetFocusOnError="True" 
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm3" runat="server" 
                                        ControlToValidate="txtTiempoReposicion" 
                                        ErrorMessage="Tiempo de Reposición Incorrecto" SetFocusOnError="True" 
                                        ValidationExpression="[0-9]{1,2}" ValidationGroup="Tiempos" 
                                        ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm3" runat="server" 
                                        ControlToValidate="txtTiempoReposicion" 
                                        ErrorMessage="Tiempo Reposición Fuera de Rango" ForeColor="Red" 
                                        MaximumValue="86400" MinimumValue="1" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style29">
                                    <asp:Label ID="lblTiempoIndicacionFallatemp" runat="server" 
                                        AssociatedControlID="txtTiempoIndicacionFallatemp" CssClass="labelParametros" 
                                        Text="Tiempo Indicación Falla Temporal :" Font-Size="12px"></asp:Label>
                                </td>
                                <td class="style25">
                                    <asp:TextBox ID="txtTiempoIndicacionFallatemp" runat="server" 
                                        CssClass="textBoxHora" MaxLength="5" Text="5" Width="40px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="Label8" runat="server" Font-Size="12px" Text="Segs"></asp:Label>
&nbsp;<asp:RequiredFieldValidator ID="ReqValPrm4" runat="server" 
                                        ControlToValidate="txtTiempoIndicacionFallatemp" 
                                        ErrorMessage="Se Requiere Tiempo Indicación Falla Temporal" 
                                        SetFocusOnError="True" ValidationGroup="Tiempos" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm4" runat="server" 
                                        ControlToValidate="txtTiempoIndicacionFallatemp" 
                                        ErrorMessage="Tiempo Indicación Falla Temporal Incorrecto" 
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,2}" 
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm4" runat="server" 
                                        ControlToValidate="txtTiempoIndicacionFallatemp" 
                                        ErrorMessage="Tiempo Indicación Falla Temp. Fuera de Rango" ForeColor="Red" 
                                        MaximumValue="86400" MinimumValue="1" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style29">
                                    <asp:Label ID="lblTiempoFlashIndicacion" runat="server" 
                                        AssociatedControlID="txtTiempoFlashIndicacion" CssClass="labelParametros" 
                                        Text="Duración Destello:" Font-Size="12px"></asp:Label>
                                </td>
                                <td class="style25">
                                    <asp:TextBox ID="txtTiempoFlashIndicacion" runat="server" 
                                        CssClass="textBoxHora" MaxLength="3" Text="8" Width="40px"></asp:TextBox>
                                    &nbsp;multiplos de 8 milsegs. (8-104)<asp:RequiredFieldValidator ID="ReqValPrm5" 
                                        runat="server" ControlToValidate="txtTiempoFlashIndicacion" 
                                        ErrorMessage="Se Requiere Duración Destello" SetFocusOnError="True" 
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm5" runat="server" 
                                        ControlToValidate="txtTiempoFlashIndicacion" 
                                        ErrorMessage="Duración Destello Incorrecto" SetFocusOnError="True" 
                                        ValidationExpression="[0-9]{1,3}" ValidationGroup="Tiempos" 
                                        ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm5" runat="server" 
                                        ControlToValidate="txtTiempoFlashIndicacion" 
                                        ErrorMessage="Duración Destello Fuera de Rango" ForeColor="Red" 
                                        MaximumValue="104" MinimumValue="8" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="Tiempos">*</asp:RangeValidator>
                                    &nbsp;<asp:CustomValidator ID="CusValDurDestello" runat="server" 
                                        ControlToValidate="txtTiempoFlashIndicacion" 
                                        ErrorMessage="La Duración Destello debe ser Múltiplo de 8" 
                                        OnServerValidate="CheckTiempoDuracionDestello" SetFocusOnError="True" 
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style29">
                                    <asp:Label ID="lblTiempoEntreFlashIndicacion" runat="server" 
                                        AssociatedControlID="txtTiempoEntreFlashIndicacion" CssClass="labelParametros" 
                                        Text="Tiempo entre destellos:" Font-Size="12px"></asp:Label>
                                </td>
                                <td class="style25">
                                    <asp:TextBox ID="txtTiempoEntreFlashIndicacion" runat="server" 
                                        CssClass="textBoxHora" MaxLength="2" Text="5" Width="30px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="Label9" runat="server" Font-Size="12px" Text="(1-10)Segs"></asp:Label>
&nbsp;<asp:RequiredFieldValidator ID="ReqValPrm6" runat="server" 
                                        ControlToValidate="txtTiempoEntreFlashIndicacion" 
                                        ErrorMessage="Se Requiere Tiempo entre Destellos" SetFocusOnError="True" 
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm6" runat="server" 
                                        ControlToValidate="txtTiempoEntreFlashIndicacion" 
                                        ErrorMessage="Tiempo entre Destellos Incorrecto" SetFocusOnError="True" 
                                        ValidationExpression="[0-9]{1,3}" ValidationGroup="Tiempos" 
                                        ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm6" runat="server" 
                                        ControlToValidate="txtTiempoEntreFlashIndicacion" 
                                        ErrorMessage="Tiempo entre Destellos Fuera de Rango" ForeColor="Red" 
                                        MaximumValue="10" MinimumValue="1" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style28">
                                    <asp:Label ID="lblTiempoProteccionInRush" runat="server" 
                                        AssociatedControlID="txtTiempoProteccionInRush" CssClass="labelParametros" 
                                        Text="Tiempo Protección InRush:" Font-Size="12px"></asp:Label>
                                </td>
                                <td class="style26">
                                    <asp:TextBox ID="txtTiempoProteccionInRush" runat="server" 
                                        CssClass="textBoxHora" MaxLength="3" Text="5" Width="40px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="Label10" runat="server" Font-Size="12px" Text="(1-120)Segs"></asp:Label>
&nbsp;<asp:RequiredFieldValidator ID="ReqValPrm7" runat="server" 
                                        ControlToValidate="txtTiempoProteccionInRush" 
                                        ErrorMessage="Se Requiere Tiempo Protección InRush" SetFocusOnError="True" 
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm7" runat="server" 
                                        ControlToValidate="txtTiempoProteccionInRush" 
                                        ErrorMessage="Tiempo Protección InRush Incorrecto" SetFocusOnError="True" 
                                        ValidationExpression="[0-9]{1,3}" ValidationGroup="Tiempos" 
                                        ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm7" runat="server" 
                                        ControlToValidate="txtTiempoProteccionInRush" 
                                        ErrorMessage="Tiempo Protección Inrush Fuera de Rango" ForeColor="Red" 
                                        MaximumValue="120" MinimumValue="1" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style29">
                                    <asp:Label ID="lblTiempoRetardoValidacionTension" runat="server" 
                                        AssociatedControlID="txtTiempoRetardoValidacionTension" 
                                        CssClass="labelParametros" Text="Tiempo Retardo Validación Tensión:" 
                                        Font-Size="12px"></asp:Label>
                                </td>
                                <td class="style25">
                                    <asp:TextBox ID="txtTiempoRetardoValidacionTension" runat="server" 
                                        CssClass="textBoxHora" MaxLength="3" Text="5" Width="40px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="Label12" runat="server" Font-Size="12px" Text="(1-120)Segs"></asp:Label>
&nbsp;<asp:RequiredFieldValidator ID="ReqValPrm8" runat="server" 
                                        ControlToValidate="txtTiempoRetardoValidacionTension" 
                                        ErrorMessage="Se Requiere Tiempo Reatrdo Validación Tensión" 
                                        SetFocusOnError="True" ValidationGroup="Tiempos" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValPrm8" runat="server" 
                                        ControlToValidate="txtTiempoRetardoValidacionTension" 
                                        ErrorMessage="Tiempo Retardo Validación Tensión Incorrecto" 
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,3}" 
                                        ValidationGroup="Tiempos" ForeColor="Red">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPrm8" runat="server" 
                                        ControlToValidate="txtTiempoRetardoValidacionTension" 
                                        ErrorMessage="Tiempo Retardo Validación Tensión Fuera de Rango" ForeColor="Red" 
                                        MaximumValue="120" MinimumValue="1" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="Tiempos">*</asp:RangeValidator>
                                </td>
                            </tr>
                        </table>
                        <table style="width:100%;">
                            <tr>
                                <td align="center">
                                    <asp:ValidationSummary ID="ValResumen" runat="server" ForeColor="Red" 
                                        ValidationGroup="Tiempos" />
                                </td>
                            </tr>
                        </table>
                        </asp:Panel>
               </asp:WizardStep>

                    <asp:WizardStep ID="WizardStepConfiguraciones" runat="server" 
                    Title="Configuraciones">
                    <asp:Label id="lblConfiguraciones" CssClass="labelTitulo"  Text="Configuraciones"  Runat="server" /> 
                    <asp:Panel ID="panelConfiguraciones" runat="server" >
                        <br />
                        <table style="width:100%;">
                            <tr>
                                <td align="right" class="style13">
                                    <asp:Label ID="lblCorrienteAbsolutaDisparo" runat="server" 
                                        AssociatedControlID="txtCorrienteAbsolutaDisparo" CssClass="labelParametros" 
                                        Text="Corriente Absoluta Disparo :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCorrienteAbsolutaDisparo" runat="server" 
                                        CssClass="textBoxHora" MaxLength="4" Text="10" Width="40px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="Label13" runat="server" Text="(10-1000)A"></asp:Label>
                                    &nbsp;<asp:RequiredFieldValidator ID="ReqValConfPrm1" runat="server" 
                                        ControlToValidate="txtCorrienteAbsolutaDisparo" 
                                        ErrorMessage="Se Requiere Corriente Absoluta Disparo" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationGroup="Configuraciones">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm1" runat="server" 
                                        ControlToValidate="txtCorrienteAbsolutaDisparo" 
                                        ErrorMessage="Corriente Absoluta Disparo Incorrecta" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,4}" 
                                        ValidationGroup="Configuraciones">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValCteDisparo" runat="server" 
                                        ControlToValidate="txtCorrienteAbsolutaDisparo" 
                                        ErrorMessage="Corriente Fuera de Rango" MaximumValue="1000" MinimumValue="10" 
                                        SetFocusOnError="True" Type="Integer" ValidationGroup="Configuraciones">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style13">
                                    <asp:Label ID="lblNumeroReintentosComunicaciones" runat="server" 
                                        AssociatedControlID="txtNumeroReintentosComunicaciones" 
                                        CssClass="labelParametros" Text="Numero Reintentos Comunicaciones:"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNumeroReintentosComunicaciones" runat="server" 
                                        CssClass="textBoxHora" MaxLength="2" Text="3" Width="30px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="Label14" runat="server" Text="(1-10)"></asp:Label>
&nbsp;<asp:RequiredFieldValidator ID="ReqValCongPrm2" runat="server" 
                                        ControlToValidate="txtNumeroReintentosComunicaciones" 
                                        ErrorMessage="Se Requiere Numero de Reintentos" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationGroup="Configuraciones">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm2" runat="server" 
                                        ControlToValidate="txtNumeroReintentosComunicaciones" 
                                        ErrorMessage="Número de Reintentos Comms Incorrecto" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,2}" 
                                        ValidationGroup="Configuraciones">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValNroReintentos" runat="server" 
                                        ControlToValidate="txtNumeroReintentosComunicaciones" 
                                        ErrorMessage="Número Reintentos Fuera de Rango" ForeColor="Red" 
                                        MaximumValue="10" MinimumValue="1" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="Configuraciones">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style13">
                                    <asp:Label ID="lblSegundosProximaComunicacion" runat="server" 
                                        AssociatedControlID="txtSegundosProximaComunicacion" CssClass="labelParametros" 
                                        Text="Segundos Proxima Comunicación :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSegundosProximaComunicacion" runat="server" 
                                        CssClass="textBoxHora" MaxLength="4" Text="30" Width="40px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="Label15" runat="server" Text="(30-3600)"></asp:Label>
                                    &nbsp;Segs
                                    <asp:RequiredFieldValidator ID="ReqValConfPrm3" runat="server" 
                                        ControlToValidate="txtSegundosProximaComunicacion" 
                                        ErrorMessage="Se Requiere Segundos Próxima Comms" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationGroup="Configuraciones">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm3" runat="server" 
                                        ControlToValidate="txtSegundosProximaComunicacion" 
                                        ErrorMessage="Segundos Próxima Comm Incorrecto" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,4}" 
                                        ValidationGroup="Configuraciones">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValSegsProxCom" runat="server" 
                                        ControlToValidate="txtSegundosProximaComunicacion" 
                                        ErrorMessage="Segundos Próxima Comunicación Fuera de Rango" ForeColor="Red" 
                                        MaximumValue="3600" MinimumValue="30" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="Configuraciones">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style13">
                                    <asp:Label ID="lblCapacidadBateria" runat="server" 
                                        AssociatedControlID="txtCapacidadBateria" CssClass="labelParametros" 
                                        Text="Capacidad Bateria Instalada :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCapacidadBateria" runat="server" CssClass="textBoxHora" 
                                        MaxLength="5" Text="2400" Width="40px"></asp:TextBox>
                                    &nbsp;<asp:Label ID="Label16" runat="server" Text="mA/h"></asp:Label>
                                    &nbsp;<asp:RequiredFieldValidator ID="ReqValConfPrm4" runat="server" 
                                        ControlToValidate="txtCapacidadBateria" 
                                        ErrorMessage="Se Requiere Capacidad de Batería" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationGroup="Configuraciones">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValConfPrm4" runat="server" 
                                        ControlToValidate="txtCapacidadBateria" 
                                        ErrorMessage="Capacidad Batería Instalada Incorrecto" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,5}" 
                                        ValidationGroup="Configuraciones">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValCapBateria" runat="server" 
                                        ControlToValidate="txtCapacidadBateria" 
                                        ErrorMessage="Capacidad Batería Fuera de Rango" ForeColor="Red" 
                                        MaximumValue="20000" MinimumValue="2400" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="Configuraciones">*</asp:RangeValidator>
                                </td>
                            </tr>
                        </table>
                        <table style="width:100%;">
                            <tr>
                                <td>
                                    <table class="tablaInternaConcentrador">
                                        <tr>
                                            <td align="center" class="style16" 
                                                style="background-color: #465c71; color: White">
                                                Autonomia Bateria Instalada
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="style15" style="background-color: #eeeeee">
                                                <asp:Button ID="butCalcularAutonomia" runat="server" 
                                                    Text="Calcular Autonomia" OnClick="butCalcularAutonomia_Click" 
                                                    ValidationGroup="Configuraciones" />
                                                &nbsp;<asp:Label ID="lblAutonomia" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
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
                        <br />
                        <br />
                        <br />
                        
                    </asp:Panel>
               </asp:WizardStep>

               <asp:WizardStep ID="WizardStepDatosIngresados" runat="server" 
                    Title="Datos Ingresados" StepType="Finish" >
                
                <%-- El sufijo BD en el nombre de estos controles indica que estos datos se van a grabar en base de datos --%>
                    <table style="width:100%;">
                       <tr>
                           <td align="right">
                               <asp:Label ID="Label3" runat="server" Text="SerialFCI:" CssClass="labelTitulo"></asp:Label>
                           </td>
                           <td>
                               <asp:Label ID="lblSerialBD" runat="server"></asp:Label>
                           </td>
                            <td align="right">
                                <asp:Label ID="Label1" runat="server" Text="Tipo Circuito:" CssClass="labelTitulo"></asp:Label></td>
                           <td>
                               <asp:Label ID="lblTipoCircuitoMostrar" runat="server"></asp:Label>
                               <asp:Label ID="lblTipoCircuitoBD" runat="server" Visible="False"></asp:Label>
                           </td>
                           <td align="right">
                                <asp:Label ID="Label2" runat="server" Text="Serial Concentrador:" CssClass="labelTitulo"></asp:Label></td>
                           <td>
                               <asp:Label ID="lblSerialConcMostrar" runat="server"></asp:Label>
                               <asp:Label ID="lblIdConcBD" runat="server" Visible="False"></asp:Label>
                           </td>
                            <td align="right">
                               <asp:Label ID="Label17" runat="server" Text="Valor Fase:" CssClass="labelTitulo"></asp:Label></td>
                           <td>
                               <asp:Label ID="lblFaseBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       
                      
                   </table>
                   <table style="width:100%;">
                       <tr>
                           <td align="center">
                               <asp:Label ID="Label4" runat="server" CssClass="labelTitulo" 
                                   Text="Parametrización"></asp:Label>
                           </td>
                       </tr>
                   </table>
                   <table style="width:100%;">
                       <tr>
                           <td align="right">
                               Modo Disparo:</td>
                           <td>
                               <asp:Label ID="lblModoDisparoBD" runat="server"></asp:Label>
                           </td>
                           <td class="style18" colspan="1" align="right">
                               Tiempo Validación Falla:
                           </td>
                           <td>
                               <asp:Label ID="lblTimeValFallaBD" runat="server"></asp:Label>
                           </td>
                           <td class="style18" colspan="1" align="right">
                               Corriente Absoluta de Disparo:</td>
                           <td>
                               <asp:Label ID="lblCorrienteAbsDisparoBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td class="style18" align="right">
                               Valor Falla [<asp:Label ID="lblNombreValorFallaBD" runat="server"></asp:Label>
                               ]:</td>
                           <td>
                               <asp:Label ID="lblValorFallaBD" runat="server"></asp:Label>
                           </td>
                              <td class="style18" colspan="1" align="right">
                               Tolerancia Tensión Reposición:</td>
                           <td>
                               <asp:Label ID="lblToleranciaTensBD" runat="server"></asp:Label>
                           </td>
                            <td class="style18" colspan="1" align="right">
                               Número Reintentos Comunicaciones:
                           </td>
                           <td>
                               <asp:Label ID="lblNumReintComBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td class="style18" align="right">
                               Reposición por Tiempo:</td>
                           <td>
                               <asp:CheckBox ID="chkBoxRepTiempoBD" runat="server" Enabled="False" />
                           </td>
                           <td class="style18" colspan="1" align="right">
                               Tiempo Reposición:</td>
                           <td>
                               <asp:Label ID="lblTimeReposBD" runat="server"></asp:Label>
                           </td>
                             <td class="style18" colspan="1" align="right">
                               Segs. para Proxima Comunicación:</td>
                           <td>
                               <asp:Label ID="lblSegProxComBD" runat="server"></asp:Label>
                           </td>
                           
                       </tr>
                       <tr>
                           <td class="style18" align="right">
                               Reposición por Tensión:</td>
                           <td>
                               <asp:CheckBox ID="chkBoxRepTensionBD" runat="server" Enabled="False" />
                           </td>
                           <td class="style18" colspan="1" align="right">
                               Tiempo Indicación Falla Temporal:</td>
                           <td>
                               <asp:Label ID="lblTimeIndicFallatempBD" runat="server"></asp:Label>
                           </td>
                                                      <td class="style18" colspan="1" align="right">
                               Capacidad Bateria Instalada:</td>
                           <td>
                               <asp:Label ID="lblCapBatInstBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td class="style18" align="right">
                               Reposición por Imán:</td>
                           <td>
                               <asp:CheckBox ID="chkBoxRepMagnetoBD" runat="server" Enabled="False" />
                           </td>
                            <td class="style18" colspan="1" align="right">
                               Tiempo de Indicación de Flash:</td>
                           <td>
                               <asp:Label ID="lblTimeIndicFlashBD" runat="server"></asp:Label>
                           </td>
                           <td class="style18" colspan="1" align="right">
                               Autonomia Bateria Instalada:</td>
                           <td>
                               <asp:Label ID="lblAutonomiaBattInstBD" runat="server"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td class="style18" align="right">
                               Reposición por Corriente:</td>
                           <td>
                               <asp:CheckBox ID="chkBoxRepCorrienteBD" runat="server" Enabled="False" />
                           </td>
                           <td class="style18" colspan="1" align="right">
                               Tiempo entre Destellos:</td>
                           <td>
                               <asp:Label ID="lblTimeEntreIndicFlashBD" runat="server"></asp:Label>
                           </td>
                           <td class="style18" align="right">
                               Habilitar Reloj:</td>
                           <td>
                               <asp:CheckBox ID="chkBoxHabRelojBD" runat="server" Enabled="False" />
                           </td>
                       </tr>
                       <tr>
                           
                            <td class="style18" colspan="1" align="right">
                               Tiempo Protección InRush:</td>
                           <td>
                               <asp:Label ID="lblTimeProtecInRushBD" runat="server"></asp:Label>
                           </td>
                            <td class="style18" colspan="1" align="right">
                               Tiempo Retardo Validación Tensión:</td>
                           <td>
                               <asp:Label ID="lblTimeRetardoValidTensionBD" runat="server"></asp:Label>
                           </td>
                           <td class="style30" align="right">
                               Habilitar Falla Transitoria:</td>
                           <td class="style31">
                               <asp:CheckBox ID="chkBoxHabFallaTransBD" runat="server" Enabled="False" />
                           </td>
                       </tr>
                                    
                      
                      
                      
                   </table>
                               
               </asp:WizardStep>
               <asp:WizardStep  ID="WizardStepFCIIngresado" runat="server" 
                    Title="FCI Ingresado" StepType="Complete"> 
               <asp:Label id="lblFCIIngresado" CssClass="labelTitulo" Runat="server" /> 
               
               </asp:WizardStep>

            </WizardSteps>
        </asp:Wizard>  
        </div>
    </div>
    </form>
</body>
</html>
