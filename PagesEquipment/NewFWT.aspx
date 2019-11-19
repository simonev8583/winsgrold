<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewFWT.aspx.cs" Inherits="SistemaGestionRedes.NewFWT" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <style type="text/css">
     

        
        .style37
        {
            width: 238px;
        }

 

        .style38
        {
            width: 190px;
        }
        .style39
        {
            width: 174px;
            height: 36px;
        }
        .style40
        {
            height: 36px;
            width: 263px;
        }

 

        .style41
        {
            width: 161px;
        }
        .style42
        {
            width: 153px;
        }

 

        .style43
        {
            width: 164px;
        }

 

        .style46
        {
            width: 263px;
        }

 

        .style47
        {
            width: 56px;
        }

 

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div  class="rightDiv"  >
        <div class="centerDiv">

              <asp:Wizard ID="WizardNuevoFWT" 
                runat="server" 
                HeaderText="Nuevo Concentrador"  
                CssClass="wizard" 
                HeaderStyle-CssClass="wizardHeader" 
                SideBarStyle-CssClass="sideBar"
                StepStyle-CssClass="step" 
                ActiveStepIndex="9" 
                OnNextButtonClick="NextButtonClick" 
                onfinishbuttonclick="WizardNuevoFWT_FinishButtonClick" 
                Width="710px" onpreviousbuttonclick="WizardNuevoFWT_PreviousButtonClick" 
                  Height="240px" >
            
<HeaderStyle CssClass="wizardHeader"></HeaderStyle>

<SideBarStyle CssClass="sideBar" Font-Size="12px" HorizontalAlign="Left" Width="140px"></SideBarStyle>

<StepStyle CssClass="step"></StepStyle>
            
            <WizardSteps>
               <asp:WizardStep ID="WizardStepSerial" runat="server" Title="Serial" >
                        <table>
                            <tr>
                                <td  align="left" width="50%">
                                    <asp:Label ID="lblSerial" runat="server" CssClass="labelTitulo" 
                                        Text="Cual es el serial de este Concentrador ?  (8 caracteres)"></asp:Label>
                                </td>
                                
                                
                            </tr>
                            <tr>
                                <td align="left" width="50%">
                                    <asp:TextBox ID="txtSerial" runat="server" MaxLength="8" Width="80px"></asp:TextBox>
                                </td>
                                <td >
                                    <asp:RequiredFieldValidator ID="ReqValSerial" runat="server" 
                                        ControlToValidate="txtSerial" CssClass="validador" SetFocusOnError="True">Defina el Serial</asp:RequiredFieldValidator>
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegValSerial" runat="server" 
                                        ControlToValidate="txtSerial" CssClass="validador" 
                                        SetFocusOnError="True" ValidationExpression="[a-zA-Z0-9]{8}">Usar Letras o Numeros</asp:RegularExpressionValidator>
                                    <br />
                                    <asp:CustomValidator ID="CusValSerial" runat="server" 
                                        ControlToValidate="txtSerial" CssClass="validador" ForeColor="Red" 
                                        OnServerValidate="CheckSerial" SetFocusOnError="True">Ya Existe el Serial</asp:CustomValidator>
                                </td>
                                
                            </tr>
                            
                        </table>
                       
                        <br />
                        <br />
                        <asp:Label id="lblNoingresoSerial" Text="Ingrese correctamente el Serial del Concentrador !"  Runat="server" Font-Bold="True" ForeColor="Red" Visible="False" /> 
                       
                        
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStepHoraReporte" runat="server" 
                    Title="Periodo Autoreporte">
                        <asp:Label ID="lblHoraReporte" runat="server" CssClass="labelTitulo" 
                            Text="Cada cuanto se reporta el concentrador ? "></asp:Label>
                        <br />
                        <table style="width:100%;">
                            <tr>
                                <td width="20%">
                                    <asp:Label ID="lblHoraReporte2" runat="server" CssClass="labelTitulo" 
                                        Text="Periodo Reporte:"></asp:Label>
                                </td>
                                <td width="30%">
                                    <asp:TextBox ID="txtPeriodoReporteSeg" runat="server" CssClass="textInUsuario" 
                                        MaxLength="5" Width="30%"></asp:TextBox>
                                    <asp:Label ID="Label2" runat="server" Font-Size="11px" Text="(60-84600)Segs"></asp:Label>
                                </td>
                                <td width="50%">
                                    <asp:RequiredFieldValidator ID="ReqValtxtPeriodoReporteSeg" runat="server" ControlToValidate="txtPeriodoReporteSeg"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px">Se Requiere Periodo de Reporte</asp:RequiredFieldValidator>
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegExtxtPeriodoReporteSeg" runat="server" ControlToValidate="txtPeriodoReporteSeg"
                                        ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{2,5}" 
                                        Font-Size="11px">Periodo de Reporte Incorrecto (60-86400)</asp:RegularExpressionValidator>
                                    <br />
                                    <asp:RangeValidator ID="RanValtxtPeriodoReporteSeg" runat="server" ControlToValidate="txtPeriodoReporteSeg"
                                        ForeColor="Red" MaximumValue="86400" MinimumValue="60" SetFocusOnError="True" Font-Size="11px" Type="Integer">Periodo de Reporte Incorrecto (60-86400)</asp:RangeValidator>
                                </td>
                            </tr>
                        </table>
                        &nbsp;<br />&nbsp;&nbsp;<br />
                        <br />
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStepEscogerParametros" runat="server" 
                    Title="Parametros Equipo">
                    <asp:Label id="lblLlenadoParametros" CssClass="labelTitulo"  Text="Como desea ingresar los Parametros del Equipo ?"  Runat="server" /> 
                    <br />
                     <br />
                    
                    <asp:RadioButton id="rdlParametrosManual" 
                        Text="Ingresar Parametros Manualmente." GroupName="LLenadoParametros" 
                        Checked="true"  Runat="server" 
                        OnCheckedChanged="rdlParametrosManual_CheckedChanged"
                        AutoPostBack="true" />
                    <br />
                      
                   
                    <asp:RadioButton id="rdlParametrosPlantilla" Text="Escoger Plantilla." 
                        GroupName="LLenadoParametros" Runat="server" 
                        OnCheckedChanged="rdlParametrosPlantilla_CheckedChanged" 
                        AutoPostBack="true" />
                    <br />&nbsp; &nbsp; 
                    <asp:DropDownList runat="server" ID="ddlPlantillasFWT" Enabled="False" 
                        AppendDataBoundItems="True" >
                        <asp:ListItem Selected="True" Value="0">Seleccionar Plantilla</asp:ListItem>
                    </asp:DropDownList> 
                    &nbsp;<asp:CustomValidator ID="CusValPlantilla" runat="server" 
                        ControlToValidate="ddlPlantillasFWT" ForeColor="Red" 
                        OnServerValidate="CheckPlantillaParametros" SetFocusOnError="True">Debe Seleccionar una Plantilla</asp:CustomValidator>
                    <br />
                    <asp:Label id="lblNoPlantilla" Text="Debe escoger una plantilla  !"  Runat="server" Font-Bold="True" ForeColor="Red" Visible="False" />
                    
                    
                         
                </asp:WizardStep>
               <asp:WizardStep ID="WizardStepParametrosGPRS" runat="server" 
                    Title="Parametros GPRS">
                    <asp:Label id="lblParamGPRS" CssClass="labelTitulo"  Text="Parametros GPRS"  Runat="server" /> 
                    <asp:Panel ID="PanelGPRS" runat="server" >
                        <br />
                        <table style="width:100%;">
                            <tr>
                                <td class="style37">
                                    <asp:Label ID="lblAPN" runat="server" AssociatedControlID="txtAPN" 
                                        CssClass="labelParametros" Text="APN:"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style37">
                                    <asp:TextBox ID="txtAPN" runat="server" MaxLength="40" 
                                        Text="internet.movistar.com.co" Width="252px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="ReqValAPN" runat="server" 
                                        ControlToValidate="txtAPN" ForeColor="Red" SetFocusOnError="True">Se Requiere el APN </asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style37">
                                    <asp:Label ID="lblUsuario" runat="server" AssociatedControlID="txtUsuario" 
                                        CssClass="labelParametros" Text="Usuario:"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style37">
                                    <asp:TextBox ID="txtUsuario" runat="server" MaxLength="15" Text="movistar" 
                                        Width="110px"></asp:TextBox>
                                </td>
                                <td>
                                    
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style37">
                                    <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" 
                                        CssClass="labelParametros" Text="Password:"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style37">
                                    <asp:TextBox ID="txtPassword" runat="server" MaxLength="8" Text="movistar" 
                                        TextMode="Password" Width="90px"></asp:TextBox>
                                </td>
                                <td>
                                   
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style37">
                                    <asp:Label ID="lblRePassword" runat="server" AssociatedControlID="txtPassword" 
                                        CssClass="labelParametros" Text="Re-Password:"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style37">
                                    <asp:TextBox ID="txtRePassword" runat="server" MaxLength="8" Text="movistar" 
                                        TextMode="Password" Width="90px"></asp:TextBox>
                                </td>
                                <td>
                                   
                                    <br />
                                    <asp:CompareValidator ID="CompValRePWD" runat="server" 
                                        ControlToCompare="txtPassword" ControlToValidate="txtRePassword" 
                                        ForeColor="Red">Los Valores de Password son Distintos</asp:CompareValidator>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                        <br />
                        <br />
                    </asp:Panel>
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepRed" runat="server" Title="Parametros Red">
                    <asp:Label id="lblParamRed" CssClass="labelTitulo"  Text="Parametros Red"  Runat="server" /> 
                    <br />
                    <asp:Panel ID="PanelRed" runat="server" Height="200px" >
                        <table style="width:100%;">
                            <tr>
                                <td class="style38">
                                    <asp:Label ID="lblIpGestion0" runat="server" AssociatedControlID="txtIpGestion" 
                                        CssClass="labelParametros" Text="Dirección ip Gestión:"></asp:Label>
                                </td>
                                  <td class="style38">
                                    <asp:TextBox ID="txtIpGestion" runat="server" Text="200.200.200.200" 
                                        MaxLength="15" Width="112px"></asp:TextBox>
                                </td>
                                <td class="style46">
                                    <asp:RequiredFieldValidator ID="ReqValIPGestion" runat="server" 
                                        ControlToValidate="txtIpGestion" ForeColor="Red" SetFocusOnError="True">Se Requiere IP de Gestión</asp:RequiredFieldValidator>
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegExValIPGestion" runat="server" 
                                        ControlToValidate="txtIpGestion" ForeColor="Red" SetFocusOnError="True" 
                                        ValidationExpression="\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b">IP de Gestión Incorrecta</asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="style38">
                                    <asp:Label ID="lblPuertoGestion0" runat="server" 
                                        AssociatedControlID="txtPuertoGestion" CssClass="labelParametros" 
                                        Text="Puerto Gestión:"></asp:Label>
                                </td>
                                <td class="style39">
                                    <asp:TextBox ID="txtPuertoGestion" runat="server" Text="20000" MaxLength="5" 
                                        Width="45px"></asp:TextBox>
                                </td>
                                    <td class="style40">
                                    <asp:RequiredFieldValidator ID="ReqValGestion" runat="server" 
                                        ControlToValidate="txtPuertoGestion" ForeColor="Red" SetFocusOnError="True">Se Requiere Puerto de Gestión</asp:RequiredFieldValidator>
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegExpValPtoGestion" runat="server" 
                                        ControlToValidate="txtPuertoGestion" ForeColor="Red" SetFocusOnError="True" 
                                        ValidationExpression="[0-9]{4,5}">Puerto de Gestión Incorrecto</asp:RegularExpressionValidator>
                                    <br />
                                    <asp:RangeValidator ID="RanValPtoGestion" runat="server" 
                                        ControlToValidate="txtPuertoGestion" ForeColor="Red" MaximumValue="65535" 
                                        MinimumValue="1025" SetFocusOnError="True">Mal Definido el Pto Gestión (1025-65535)</asp:RangeValidator>
                                    <br />
                                </td>
                            </tr>
                           <tr>
                                <td class="style38">
                                    <asp:Label ID="lblIpSCADA0" runat="server" AssociatedControlID="txtIpSCADA" 
                                        CssClass="labelParametros" Text="Dirección ip SCADA:"></asp:Label>
                                </td>
                                 <td class="style38">
                                    <asp:TextBox ID="txtIpSCADA" runat="server" Text="200.200.200.200" 
                                        MaxLength="15" Width="112px"></asp:TextBox>
                                </td>
                                <td class="style46">
                                    <asp:RequiredFieldValidator ID="ReqValIPScada" runat="server" 
                                        ControlToValidate="txtIpSCADA" ForeColor="Red" SetFocusOnError="True">Se Requiere IP de Scada</asp:RequiredFieldValidator>
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegExValIPScada" runat="server" 
                                        ControlToValidate="txtIpSCADA" ForeColor="Red" SetFocusOnError="True" 
                                        ValidationExpression="\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b">IP de Scada Incorrecta</asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="style38">
                                    <asp:Label ID="lblPuertoSCADA0" runat="server" 
                                        AssociatedControlID="txtPuertoSCADA" CssClass="labelParametros" 
                                        Text="Puerto SCADA:"></asp:Label>
                                </td>
                                 <td class="style38">
                                    <asp:TextBox ID="txtPuertoSCADA" runat="server" Text="20000" MaxLength="5" 
                                        Width="43px"></asp:TextBox>
                                </td>
                                 <td class="style46">
                                    <asp:RequiredFieldValidator ID="ReqValPtoScada" runat="server" 
                                        ControlToValidate="txtPuertoSCADA" ForeColor="Red" SetFocusOnError="True">Se Requiere Puerto de Scada</asp:RequiredFieldValidator>
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegExpValPtoScada" runat="server" 
                                        ControlToValidate="txtPuertoSCADA" ForeColor="Red" SetFocusOnError="True" 
                                        ValidationExpression="[0-9]{4,5}">Puerto de Scada Incorrecto</asp:RegularExpressionValidator>
                                    <br />
                                    <asp:RangeValidator ID="RanValPtoScada" runat="server" 
                                        ControlToValidate="txtPuertoSCADA" ForeColor="Red" MaximumValue="65535" 
                                        MinimumValue="1025" SetFocusOnError="True">Mal Definido el Pto Scada (1025-65535)</asp:RangeValidator>
                                </td>
                            </tr>
                            
                        </table>
                       
                        
                    </asp:Panel>
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepNomenclatura" runat="server" 
                    Title="Dir. Nomenclatura">
                    <asp:Label id="lblDirNom" CssClass="labelTitulo"  Text="Direccion Nomenclatura"  Runat="server" /> 
                    <asp:Panel ID="PanelDirNom" runat="server" Height="196px" >
                        <br />
                        <table style="width:100%;">
                            <tr>
                                <td class="style41">
                                    <asp:Label ID="lblCiudad" runat="server" AssociatedControlID="txtCiudad" 
                                        CssClass="labelParametros" Text="Ciudad:"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style41">
                                   
                                    <asp:DropDownList ID="txtCiudad" runat="server">
                                    <asp:ListItem>ABEJORRAL                            </asp:ListItem>             
                                    <asp:ListItem>ABREGO                               </asp:ListItem>
                                    <asp:ListItem>ABRIAQUI                             </asp:ListItem>
                                    <asp:ListItem>ACACIAS                              </asp:ListItem>
                                    <asp:ListItem>ACANDI                               </asp:ListItem>
                                    <asp:ListItem>ACEVEDO                              </asp:ListItem>
                                    <asp:ListItem>ACHI                                 </asp:ListItem>
                                    <asp:ListItem>AGRADO                               </asp:ListItem>
                                    <asp:ListItem>AGUA DE DIOS                         </asp:ListItem>
                                    <asp:ListItem>AGUACHICA                            </asp:ListItem>
                                    <asp:ListItem>AGUADA                               </asp:ListItem>
                                    <asp:ListItem>AGUADAS                              </asp:ListItem>
                                    <asp:ListItem>AGUAZUL                              </asp:ListItem>
                                    <asp:ListItem>AGUSTIN CODAZZI                      </asp:ListItem>
                                    <asp:ListItem>AIPE                                 </asp:ListItem>
                                    <asp:ListItem>ALBAN                                </asp:ListItem>
                                    <asp:ListItem>ALBAN                                </asp:ListItem>
                                    <asp:ListItem>ALBANIA                              </asp:ListItem>
                                    <asp:ListItem>ALBANIA                              </asp:ListItem>
                                    <asp:ListItem>ALBANIA                              </asp:ListItem>
                                    <asp:ListItem>ALCALA                               </asp:ListItem>
                                    <asp:ListItem>ALDANA                               </asp:ListItem>
                                    <asp:ListItem>ALEJANDRIA                           </asp:ListItem>
                                    <asp:ListItem>ALGARROBO                            </asp:ListItem>
                                    <asp:ListItem>ALGECIRAS                            </asp:ListItem>
                                    <asp:ListItem>ALMAGUER                             </asp:ListItem>
                                    <asp:ListItem>ALMEIDA                              </asp:ListItem>
                                    <asp:ListItem>ALPUJARRA                            </asp:ListItem>
                                    <asp:ListItem>ALTAMIRA                             </asp:ListItem>
                                    <asp:ListItem>ALTO BAUDO (PIE DE PATO)             </asp:ListItem>
                                    <asp:ListItem>ALTOS DEL ROSARIO                    </asp:ListItem>
                                    <asp:ListItem>ALVARADO                             </asp:ListItem>
                                    <asp:ListItem>AMAGA                                </asp:ListItem>
                                    <asp:ListItem>AMALFI                               </asp:ListItem>
                                    <asp:ListItem>AMBALEMA                             </asp:ListItem>
                                    <asp:ListItem>ANAPOIMA                             </asp:ListItem>
                                    <asp:ListItem>ANCUYA                               </asp:ListItem>
                                    <asp:ListItem>ANDALUCIA                            </asp:ListItem>
                                    <asp:ListItem>ANDES                                </asp:ListItem>
                                    <asp:ListItem>ANGELOPOLIS                          </asp:ListItem>
                                    <asp:ListItem>ANGOSTURA                            </asp:ListItem>
                                    <asp:ListItem>ANOLAIMA                             </asp:ListItem>
                                    <asp:ListItem>ANORI                                </asp:ListItem>
                                    <asp:ListItem>ANSERMA                              </asp:ListItem>
                                    <asp:ListItem>ANSERMANUEVO                         </asp:ListItem>
                                    <asp:ListItem>ANTIOQUIA                            </asp:ListItem>
                                    <asp:ListItem>ANZA                                 </asp:ListItem>
                                    <asp:ListItem>ANZOATEGUI                           </asp:ListItem>
                                    <asp:ListItem>APARTADO                             </asp:ListItem>
                                    <asp:ListItem>APIA                                 </asp:ListItem>
                                    <asp:ListItem>AQUITANIA                            </asp:ListItem>
                                    <asp:ListItem>ARACATACA                            </asp:ListItem>
                                    <asp:ListItem>ARANZAZU                             </asp:ListItem>
                                    <asp:ListItem>ARATOCA                              </asp:ListItem>
                                    <asp:ListItem>ARAUCA                               </asp:ListItem>
                                    <asp:ListItem>ARAUQUITA                            </asp:ListItem>
                                    <asp:ListItem>ARBELAEZ                             </asp:ListItem>
                                    <asp:ListItem>ARBOLEDA                             </asp:ListItem>
                                    <asp:ListItem>ARBOLEDAS                            </asp:ListItem>
                                    <asp:ListItem>ARBOLETES                            </asp:ListItem>
                                    <asp:ListItem>ARCABUCO                             </asp:ListItem>
                                    <asp:ListItem>ARENAL                               </asp:ListItem>
                                    <asp:ListItem>ARGELIA                              </asp:ListItem>
                                    <asp:ListItem>ARGELIA                              </asp:ListItem>
                                    <asp:ListItem>ARGELIA                              </asp:ListItem>
                                    <asp:ListItem>ARIGUANI                             </asp:ListItem>
                                    <asp:ListItem>ARJONA                               </asp:ListItem>
                                    <asp:ListItem>ARMENIA                              </asp:ListItem>
                                    <asp:ListItem>ARMENIA                              </asp:ListItem>
                                    <asp:ListItem>ARMERO (GUAYABAL)                    </asp:ListItem>
                                    <asp:ListItem>ARROYOHONDO                          </asp:ListItem>
                                    <asp:ListItem>ASTREA                               </asp:ListItem>
                                    <asp:ListItem>ATACO                                </asp:ListItem>
                                    <asp:ListItem>ATRATO                               </asp:ListItem>
                                    <asp:ListItem>AYAPEL                               </asp:ListItem>
                                    <asp:ListItem>BAGADO                               </asp:ListItem>
                                    <asp:ListItem>BAHIA SOLANO (MUTIS)                 </asp:ListItem>
                                    <asp:ListItem>BAJO BAUDO (PIZARRO)                 </asp:ListItem>
                                    <asp:ListItem>BALBOA                               </asp:ListItem>
                                    <asp:ListItem>BALBOA                               </asp:ListItem>
                                    <asp:ListItem>BARANOA                              </asp:ListItem>
                                    <asp:ListItem>BARAYA                               </asp:ListItem>
                                    <asp:ListItem>BARBACOAS                            </asp:ListItem>
                                    <asp:ListItem>BARBOSA                              </asp:ListItem>
                                    <asp:ListItem>BARBOSA                              </asp:ListItem>
                                    <asp:ListItem>BARICHARA                            </asp:ListItem>
                                    <asp:ListItem>BARRANCA DE UPIA                     </asp:ListItem>
                                    <asp:ListItem>BARRANCABERMEJA                      </asp:ListItem>
                                    <asp:ListItem>BARRANCAS                            </asp:ListItem>
                                    <asp:ListItem>BARRANCO DE LOBA                     </asp:ListItem>
                                    <asp:ListItem>BARRANQUILLA                         </asp:ListItem>
                                    <asp:ListItem>BECERRIL                             </asp:ListItem>
                                    <asp:ListItem>BELALCAZAR                           </asp:ListItem>
                                    <asp:ListItem>BELEN                                </asp:ListItem>
                                    <asp:ListItem>BELEN                                </asp:ListItem>
                                    <asp:ListItem>BELEN ANDAQUIES                      </asp:ListItem>
                                    <asp:ListItem>BELEN DE UMBRIA                      </asp:ListItem>
                                    <asp:ListItem>BELLO                                </asp:ListItem>
                                    <asp:ListItem>BELMIRA                              </asp:ListItem>
                                    <asp:ListItem>BELTRAN                              </asp:ListItem>
                                    <asp:ListItem>BERBEO                               </asp:ListItem>
                                    <asp:ListItem>BETANIA                              </asp:ListItem>
                                    <asp:ListItem>BETEITIVA                            </asp:ListItem>
                                    <asp:ListItem>BETULIA                              </asp:ListItem>
                                    <asp:ListItem>BETULIA                              </asp:ListItem>
                                    <asp:ListItem>BITUIMA                              </asp:ListItem>
                                    <asp:ListItem>BOAVITA                              </asp:ListItem>
                                    <asp:ListItem>BOCHALEMA                            </asp:ListItem>
                                    <asp:ListItem>BOGOTA D.C.                          </asp:ListItem>
                                    <asp:ListItem>BOJACA                               </asp:ListItem>
                                    <asp:ListItem>BOJAYA (BELLAVISTA)                  </asp:ListItem>
                                    <asp:ListItem>BOLIVAR                              </asp:ListItem>
                                    <asp:ListItem>BOLIVAR                              </asp:ListItem>
                                    <asp:ListItem>BOLIVAR                              </asp:ListItem>
                                    <asp:ListItem>BOLIVAR                              </asp:ListItem>
                                    <asp:ListItem>BOSCONIA                             </asp:ListItem>
                                    <asp:ListItem>BOYACA                               </asp:ListItem>
                                    <asp:ListItem>BRICEÑO                              </asp:ListItem>
                                    <asp:ListItem>BRICEÑO                              </asp:ListItem>
                                    <asp:ListItem>BUCARAMANGA                          </asp:ListItem>
                                    <asp:ListItem>BUCARASICA                           </asp:ListItem>
                                    <asp:ListItem>BUENAVENTURA                         </asp:ListItem>
                                    <asp:ListItem>BUENAVISTA                           </asp:ListItem>
                                    <asp:ListItem>BUENAVISTA                           </asp:ListItem>
                                    <asp:ListItem>BUENAVISTA                           </asp:ListItem>
                                    <asp:ListItem>BUENAVISTA                           </asp:ListItem>
                                    <asp:ListItem>BUENOS AIRES                         </asp:ListItem>
                                    <asp:ListItem>BUESACO                              </asp:ListItem>
                                    <asp:ListItem>BUGA                                 </asp:ListItem>
                                    <asp:ListItem>BUGALAGRANDE                         </asp:ListItem>
                                    <asp:ListItem>BURITICA                             </asp:ListItem>
                                    <asp:ListItem>BUSBANZA                             </asp:ListItem>
                                    <asp:ListItem>CABRERA                              </asp:ListItem>
                                    <asp:ListItem>CABRERA                              </asp:ListItem>
                                    <asp:ListItem>CABUYARO                             </asp:ListItem>
                                    <asp:ListItem>CACERES                              </asp:ListItem>
                                    <asp:ListItem>CACHIPAY                             </asp:ListItem>
                                    <asp:ListItem>CACHIRA                              </asp:ListItem>
                                    <asp:ListItem>CACOTA                               </asp:ListItem>
                                    <asp:ListItem>CAICEDO                              </asp:ListItem>
                                    <asp:ListItem>CAICEDONIA                           </asp:ListItem>
                                    <asp:ListItem>CAIMITO                              </asp:ListItem>
                                    <asp:ListItem>CAJAMARCA                            </asp:ListItem>
                                    <asp:ListItem>CAJIBIO                              </asp:ListItem>
                                    <asp:ListItem>CAJICA                               </asp:ListItem>
                                    <asp:ListItem>CALAMAR                              </asp:ListItem>
                                    <asp:ListItem>CALAMAR                              </asp:ListItem>
                                    <asp:ListItem>CALARCA                              </asp:ListItem>
                                    <asp:ListItem>CALDAS                               </asp:ListItem>
                                    <asp:ListItem>CALDAS                               </asp:ListItem>
                                    <asp:ListItem>CALDONO                              </asp:ListItem>
                                    <asp:ListItem>CALI                                 </asp:ListItem>
                                    <asp:ListItem>CALIFORNIA                           </asp:ListItem>
                                    <asp:ListItem>CALIMA-DARIEN                        </asp:ListItem>
                                    <asp:ListItem>CALOTO                               </asp:ListItem>
                                    <asp:ListItem>CAMPAMENTO                           </asp:ListItem>
                                    <asp:ListItem>CAMPO DE LA CRUZ                     </asp:ListItem>
                                    <asp:ListItem>CAMPOALEGRE                          </asp:ListItem>
                                    <asp:ListItem>CAMPOHERMOSO                         </asp:ListItem>
                                    <asp:ListItem>CANALETE                             </asp:ListItem>
                                    <asp:ListItem>CANDELARIA                           </asp:ListItem>
                                    <asp:ListItem>CANDELARIA                           </asp:ListItem>
                                    <asp:ListItem>CANTAGALLO                           </asp:ListItem>
                                    <asp:ListItem>CANTON DE SAN PABLO                  </asp:ListItem>
                                    <asp:ListItem>CAÑASGORDAS                          </asp:ListItem>
                                    <asp:ListItem>CAPARRAPI                            </asp:ListItem>
                                    <asp:ListItem>CAPITANEJO                           </asp:ListItem>
                                    <asp:ListItem>CAQUEZA                              </asp:ListItem>
                                    <asp:ListItem>CARACOLI                             </asp:ListItem>
                                    <asp:ListItem>CARAMANTA                            </asp:ListItem>
                                    <asp:ListItem>CARCASI                              </asp:ListItem>
                                    <asp:ListItem>CAREPA                               </asp:ListItem>
                                    <asp:ListItem>CARMEN DE APICALA                    </asp:ListItem>
                                    <asp:ListItem>CARMEN DE CARUPA                     </asp:ListItem>
                                    <asp:ListItem>CARMEN DE VIBORAL                    </asp:ListItem>
                                    <asp:ListItem>CARMEN DEL DARIEN                    </asp:ListItem>
                                    <asp:ListItem>CAROLINA                             </asp:ListItem>
                                    <asp:ListItem>CARTAGENA                            </asp:ListItem>
                                    <asp:ListItem>CARTAGENA DEL CHAIRA                 </asp:ListItem>
                                    <asp:ListItem>CARTAGO                              </asp:ListItem>
                                    <asp:ListItem>CARURU                               </asp:ListItem>
                                    <asp:ListItem>CASABIANCA                           </asp:ListItem>
                                    <asp:ListItem>CASTILLA LA NUEVA                    </asp:ListItem>
                                    <asp:ListItem>CAUCASIA                             </asp:ListItem>
                                    <asp:ListItem>CEPITA                               </asp:ListItem>
                                    <asp:ListItem>CERETE                               </asp:ListItem>
                                    <asp:ListItem>CERINZA                              </asp:ListItem>
                                    <asp:ListItem>CERRITO                              </asp:ListItem>
                                    <asp:ListItem>CERRO SAN ANTONIO                    </asp:ListItem>
                                    <asp:ListItem>CERTEGUI                             </asp:ListItem>
                                    <asp:ListItem>CHACHAGUI                            </asp:ListItem>
                                    <asp:ListItem>CHAGUANI                             </asp:ListItem>
                                    <asp:ListItem>CHALAN                               </asp:ListItem>
                                    <asp:ListItem>CHAMEZA                              </asp:ListItem>
                                    <asp:ListItem>CHAPARRAL                            </asp:ListItem>
                                    <asp:ListItem>CHARALA                              </asp:ListItem>
                                    <asp:ListItem>CHARTA                               </asp:ListItem>
                                    <asp:ListItem>CHIA                                 </asp:ListItem>
                                    <asp:ListItem>CHIGORODO                            </asp:ListItem>
                                    <asp:ListItem>CHIMA                                </asp:ListItem>
                                    <asp:ListItem>CHIMA                                </asp:ListItem>
                                    <asp:ListItem>CHIMICHAGUA                          </asp:ListItem>
                                    <asp:ListItem>CHINACOTA                            </asp:ListItem>
                                    <asp:ListItem>CHINAVITA                            </asp:ListItem>
                                    <asp:ListItem>CHINCHINA                            </asp:ListItem>
                                    <asp:ListItem>CHINU                                </asp:ListItem>
                                    <asp:ListItem>CHIPAQUE                             </asp:ListItem>
                                    <asp:ListItem>CHIPATA                              </asp:ListItem>
                                    <asp:ListItem>CHIQUINQUIRA                         </asp:ListItem>
                                    <asp:ListItem>CHIQUIZA                             </asp:ListItem>
                                    <asp:ListItem>CHIRIGUANA                           </asp:ListItem>
                                    <asp:ListItem>CHISCAS                              </asp:ListItem>
                                    <asp:ListItem>CHITA                                </asp:ListItem>
                                    <asp:ListItem>CHITAGA                              </asp:ListItem>
                                    <asp:ListItem>CHITARAQUE                           </asp:ListItem>
                                    <asp:ListItem>CHIVATA                              </asp:ListItem>
                                    <asp:ListItem>CHIVOLO                              </asp:ListItem>
                                    <asp:ListItem>CHIVOR                               </asp:ListItem>
                                    <asp:ListItem>CHOACHI                              </asp:ListItem>
                                    <asp:ListItem>CHOCONTA                             </asp:ListItem>
                                    <asp:ListItem>CICUCO                               </asp:ListItem>
                                    <asp:ListItem>CIENAGA                              </asp:ListItem>
                                    <asp:ListItem>CIENAGA DE ORO                       </asp:ListItem>
                                    <asp:ListItem>CIENEGA                              </asp:ListItem>
                                    <asp:ListItem>CIMITARRA                            </asp:ListItem>
                                    <asp:ListItem>CIRCASIA                             </asp:ListItem>
                                    <asp:ListItem>CISNEROS                             </asp:ListItem>
                                    <asp:ListItem>CLEMENCIA                            </asp:ListItem>
                                    <asp:ListItem>COCORNA                              </asp:ListItem>
                                    <asp:ListItem>COELLO                               </asp:ListItem>
                                    <asp:ListItem>COGUA                                </asp:ListItem>
                                    <asp:ListItem>COLOMBIA                             </asp:ListItem>
                                    <asp:ListItem>COLON                                </asp:ListItem>
                                    <asp:ListItem>COLON-GENOVA                         </asp:ListItem>
                                    <asp:ListItem>COLOSO                               </asp:ListItem>
                                    <asp:ListItem>COMBITA                              </asp:ListItem>
                                    <asp:ListItem>CONCEPCION                           </asp:ListItem>
                                    <asp:ListItem>CONCEPCION                           </asp:ListItem>
                                    <asp:ListItem>CONCORDIA                            </asp:ListItem>
                                    <asp:ListItem>CONCORDIA                            </asp:ListItem>
                                    <asp:ListItem>CONDOTO                              </asp:ListItem>
                                    <asp:ListItem>CONFINES                             </asp:ListItem>
                                    <asp:ListItem>CONSACA                              </asp:ListItem>
                                    <asp:ListItem>CONTADERO                            </asp:ListItem>
                                    <asp:ListItem>CONTRATACION                         </asp:ListItem>
                                    <asp:ListItem>CONVENCION                           </asp:ListItem>
                                    <asp:ListItem>COPACABANA                           </asp:ListItem>
                                    <asp:ListItem>COPER                                </asp:ListItem>
                                    <asp:ListItem>CORDOBA                              </asp:ListItem>
                                    <asp:ListItem>CORDOBA                              </asp:ListItem>
                                    <asp:ListItem>CORDOBA                              </asp:ListItem>
                                    <asp:ListItem>CORINTO                              </asp:ListItem>
                                    <asp:ListItem>COROMORO                             </asp:ListItem>
                                    <asp:ListItem>COROZAL                              </asp:ListItem>
                                    <asp:ListItem>CORRALES                             </asp:ListItem>
                                    <asp:ListItem>COTA                                 </asp:ListItem>
                                    <asp:ListItem>COTORRA                              </asp:ListItem>
                                    <asp:ListItem>COVARACHIA                           </asp:ListItem>
                                    <asp:ListItem>COVEÑAS                              </asp:ListItem>
                                    <asp:ListItem>COYAIMA                              </asp:ListItem>
                                    <asp:ListItem>CRAVO NORTE                          </asp:ListItem>
                                    <asp:ListItem>CUASPUD-CARLOSAMA                    </asp:ListItem>
                                    <asp:ListItem>CUBARA                               </asp:ListItem>
                                    <asp:ListItem>CUBARRAL                             </asp:ListItem>
                                    <asp:ListItem>CUCAITA                              </asp:ListItem>
                                    <asp:ListItem>CUCUNUBA                             </asp:ListItem>
                                    <asp:ListItem>CUCUTA                               </asp:ListItem>
                                    <asp:ListItem>CUCUTILLA                            </asp:ListItem>
                                    <asp:ListItem>CUITIVA                              </asp:ListItem>
                                    <asp:ListItem>CUMARAL                              </asp:ListItem>
                                    <asp:ListItem>CUMARIBO                             </asp:ListItem>
                                    <asp:ListItem>CUMBAL                               </asp:ListItem>
                                    <asp:ListItem>CUMBITARA                            </asp:ListItem>
                                    <asp:ListItem>CUNDAY                               </asp:ListItem>
                                    <asp:ListItem>CURILLO                              </asp:ListItem>
                                    <asp:ListItem>CURITI                               </asp:ListItem>
                                    <asp:ListItem>CURUMANI                             </asp:ListItem>
                                    <asp:ListItem>DABEIBA                              </asp:ListItem>
                                    <asp:ListItem>DAGUA                                </asp:ListItem>
                                    <asp:ListItem>DIBULLA                              </asp:ListItem>
                                    <asp:ListItem>DISTRACCION                          </asp:ListItem>
                                    <asp:ListItem>DOLORES                              </asp:ListItem>
                                    <asp:ListItem>DON MATIAS                           </asp:ListItem>
                                    <asp:ListItem>DOSQUEBRADAS                         </asp:ListItem>
                                    <asp:ListItem>DUITAMA                              </asp:ListItem>
                                    <asp:ListItem>DURANIA                              </asp:ListItem>
                                    <asp:ListItem>EBEJICO                              </asp:ListItem>
                                    <asp:ListItem>EL AGUILA                            </asp:ListItem>
                                    <asp:ListItem>EL BAGRE                             </asp:ListItem>
                                    <asp:ListItem>EL BANCO                             </asp:ListItem>
                                    <asp:ListItem>EL CAIRO                             </asp:ListItem>
                                    <asp:ListItem>EL CALVARIO                          </asp:ListItem>
                                    <asp:ListItem>EL CARMEN                            </asp:ListItem>
                                    <asp:ListItem>EL CARMEN                            </asp:ListItem>
                                    <asp:ListItem>EL CARMEN                            </asp:ListItem>
                                    <asp:ListItem>EL CARMEN DE BOLIVAR                 </asp:ListItem>
                                    <asp:ListItem>EL CASTILLO                          </asp:ListItem>
                                    <asp:ListItem>EL CERRITO                           </asp:ListItem>
                                    <asp:ListItem>EL CHARCO                            </asp:ListItem>
                                    <asp:ListItem>EL COCUY                             </asp:ListItem>
                                    <asp:ListItem>EL COLEGIO                           </asp:ListItem>
                                    <asp:ListItem>EL COPEY                             </asp:ListItem>
                                    <asp:ListItem>EL DONCELLO                          </asp:ListItem>
                                    <asp:ListItem>EL DORADO                            </asp:ListItem>
                                    <asp:ListItem>EL DOVIO                             </asp:ListItem>
                                    <asp:ListItem>EL ESPINO                            </asp:ListItem>
                                    <asp:ListItem>EL GUACAMAYO                         </asp:ListItem>
                                    <asp:ListItem>EL GUAMO                             </asp:ListItem>
                                    <asp:ListItem>EL MOLINO                            </asp:ListItem>
                                    <asp:ListItem>EL PASO                              </asp:ListItem>
                                    <asp:ListItem>EL PAUJIL                            </asp:ListItem>
                                    <asp:ListItem>EL PEÑOL                             </asp:ListItem>
                                    <asp:ListItem>EL PEÑON                             </asp:ListItem>
                                    <asp:ListItem>EL PEÑON                             </asp:ListItem>
                                    <asp:ListItem>EL PEÑON                             </asp:ListItem>
                                    <asp:ListItem>EL PIÑON                             </asp:ListItem>
                                    <asp:ListItem>EL PLAYON                            </asp:ListItem>
                                    <asp:ListItem>EL RETEN                             </asp:ListItem>
                                    <asp:ListItem>EL RETORNO                           </asp:ListItem>
                                    <asp:ListItem>EL ROBLE                             </asp:ListItem>
                                    <asp:ListItem>EL ROSAL                             </asp:ListItem>
                                    <asp:ListItem>EL ROSARIO                           </asp:ListItem>
                                    <asp:ListItem>EL TABLON                            </asp:ListItem>
                                    <asp:ListItem>EL TAMBO                             </asp:ListItem>
                                    <asp:ListItem>EL TAMBO                             </asp:ListItem>
                                    <asp:ListItem>EL TARRA                             </asp:ListItem>
                                    <asp:ListItem>EL ZULIA                             </asp:ListItem>
                                    <asp:ListItem>ELIAS                                </asp:ListItem>
                                    <asp:ListItem>ENCINO                               </asp:ListItem>
                                    <asp:ListItem>ENCISO                               </asp:ListItem>
                                    <asp:ListItem>ENTRERRIOS                           </asp:ListItem>
                                    <asp:ListItem>ENVIGADO                             </asp:ListItem>
                                    <asp:ListItem>ESPINAL                              </asp:ListItem>
                                    <asp:ListItem>FACATATIVA                           </asp:ListItem>
                                    <asp:ListItem>FALAN                                </asp:ListItem>
                                    <asp:ListItem>FILADELFIA                           </asp:ListItem>
                                    <asp:ListItem>FILANDIA                             </asp:ListItem>
                                    <asp:ListItem>FIRAVITOBA                           </asp:ListItem>
                                    <asp:ListItem>FLANDES                              </asp:ListItem>
                                    <asp:ListItem>FLORENCIA                            </asp:ListItem>
                                    <asp:ListItem>FLORENCIA                            </asp:ListItem>
                                    <asp:ListItem>FLORESTA                             </asp:ListItem>
                                    <asp:ListItem>FLORIAN                              </asp:ListItem>
                                    <asp:ListItem>FLORIDA                              </asp:ListItem>
                                    <asp:ListItem>FLORIDABLANCA                        </asp:ListItem>
                                    <asp:ListItem>FOMEQUE                              </asp:ListItem>
                                    <asp:ListItem>FONSECA                              </asp:ListItem>
                                    <asp:ListItem>FORTUL                               </asp:ListItem>
                                    <asp:ListItem>FOSCA                                </asp:ListItem>
                                    <asp:ListItem>FRANCISCO PIZARRO                    </asp:ListItem>
                                    <asp:ListItem>FREDONIA                             </asp:ListItem>
                                    <asp:ListItem>FRESNO                               </asp:ListItem>
                                    <asp:ListItem>FRONTINO                             </asp:ListItem>
                                    <asp:ListItem>FUENTE DE ORO                        </asp:ListItem>
                                    <asp:ListItem>FUNDACION                            </asp:ListItem>
                                    <asp:ListItem>FUNES                                </asp:ListItem>
                                    <asp:ListItem>FUNZA                                </asp:ListItem>
                                    <asp:ListItem>FUQUENE                              </asp:ListItem>
                                    <asp:ListItem>FUSAGASUGA                           </asp:ListItem>
                                    <asp:ListItem>GACHALA                              </asp:ListItem>
                                    <asp:ListItem>GACHANCIPA                           </asp:ListItem>
                                    <asp:ListItem>GACHANTIVA                           </asp:ListItem>
                                    <asp:ListItem>GACHETA                              </asp:ListItem>
                                    <asp:ListItem>GALAN                                </asp:ListItem>
                                    <asp:ListItem>GALAPA                               </asp:ListItem>
                                    <asp:ListItem>GALERAS                              </asp:ListItem>
                                    <asp:ListItem>GAMA                                 </asp:ListItem>
                                    <asp:ListItem>GAMARRA                              </asp:ListItem>
                                    <asp:ListItem>GAMBITA                              </asp:ListItem>
                                    <asp:ListItem>GAMEZA                               </asp:ListItem>
                                    <asp:ListItem>GARAGOA                              </asp:ListItem>
                                    <asp:ListItem>GARZON                               </asp:ListItem>
                                    <asp:ListItem>GENOVA                               </asp:ListItem>
                                    <asp:ListItem>GIGANTE                              </asp:ListItem>
                                    <asp:ListItem>GINEBRA                              </asp:ListItem>
                                    <asp:ListItem>GIRALDO                              </asp:ListItem>
                                    <asp:ListItem>GIRARDOT                             </asp:ListItem>
                                    <asp:ListItem>GIRARDOTA                            </asp:ListItem>
                                    <asp:ListItem>GIRON                                </asp:ListItem>
                                    <asp:ListItem>GOMEZ PLATA                          </asp:ListItem>
                                    <asp:ListItem>GONZALEZ                             </asp:ListItem>
                                    <asp:ListItem>GRAMALOTE                            </asp:ListItem>
                                    <asp:ListItem>GRANADA                              </asp:ListItem>
                                    <asp:ListItem>GRANADA                              </asp:ListItem>
                                    <asp:ListItem>GRANADA                              </asp:ListItem>
                                    <asp:ListItem>GUACA                                </asp:ListItem>
                                    <asp:ListItem>GUACAMAYAS                           </asp:ListItem>
                                    <asp:ListItem>GUACARI                              </asp:ListItem>
                                    <asp:ListItem>GUACHETA                             </asp:ListItem>
                                    <asp:ListItem>GUACHUCAL                            </asp:ListItem>
                                    <asp:ListItem>GUADALUPE                            </asp:ListItem>
                                    <asp:ListItem>GUADALUPE                            </asp:ListItem>
                                    <asp:ListItem>GUADALUPE                            </asp:ListItem>
                                    <asp:ListItem>GUADUAS                              </asp:ListItem>
                                    <asp:ListItem>GUAITARILLA                          </asp:ListItem>
                                    <asp:ListItem>GUALMATAN                            </asp:ListItem>
                                    <asp:ListItem>GUAMAL                               </asp:ListItem>
                                    <asp:ListItem>GUAMAL                               </asp:ListItem>
                                    <asp:ListItem>GUAMO                                </asp:ListItem>
                                    <asp:ListItem>GUAPI                                </asp:ListItem>
                                    <asp:ListItem>GUAPOTA                              </asp:ListItem>
                                    <asp:ListItem>GUARANDA                             </asp:ListItem>
                                    <asp:ListItem>GUARNE                               </asp:ListItem>
                                    <asp:ListItem>GUASCA                               </asp:ListItem>
                                    <asp:ListItem>GUATAPE                              </asp:ListItem>
                                    <asp:ListItem>GUATAQUI                             </asp:ListItem>
                                    <asp:ListItem>GUATAVITA                            </asp:ListItem>
                                    <asp:ListItem>GUATEQUE                             </asp:ListItem>
                                    <asp:ListItem>GUATICA                              </asp:ListItem>
                                    <asp:ListItem>GUAVATA                              </asp:ListItem>
                                    <asp:ListItem>GUAYABAL DE SIQUIMA                  </asp:ListItem>
                                    <asp:ListItem>GUAYABETAL                           </asp:ListItem>
                                    <asp:ListItem>GUAYATA                              </asp:ListItem>
                                    <asp:ListItem>GUEPSA                               </asp:ListItem>
                                    <asp:ListItem>GUICAN                               </asp:ListItem>
                                    <asp:ListItem>GUTIERREZ                            </asp:ListItem>
                                    <asp:ListItem>HACARI                               </asp:ListItem>
                                    <asp:ListItem>HATILLO DE LOBA                      </asp:ListItem>
                                    <asp:ListItem>HATO                                 </asp:ListItem>
                                    <asp:ListItem>HATO COROZAL                         </asp:ListItem>
                                    <asp:ListItem>HATONUEVO                            </asp:ListItem>
                                    <asp:ListItem>HELICONIA                            </asp:ListItem>
                                    <asp:ListItem>HERRAN                               </asp:ListItem>
                                    <asp:ListItem>HERVEO                               </asp:ListItem>
                                    <asp:ListItem>HISPANIA                             </asp:ListItem>
                                    <asp:ListItem>HOBO                                 </asp:ListItem>
                                    <asp:ListItem>HONDA                                </asp:ListItem>
                                    <asp:ListItem>IBAGUE                               </asp:ListItem>
                                    <asp:ListItem>ICONONZO                             </asp:ListItem>
                                    <asp:ListItem>ILES                                 </asp:ListItem>
                                    <asp:ListItem>IMUES                                </asp:ListItem>
                                    <asp:ListItem>INZA                                 </asp:ListItem>
                                    <asp:ListItem>IPIALES                              </asp:ListItem>
                                    <asp:ListItem>IQUIRA                               </asp:ListItem>
                                    <asp:ListItem>ISNOS                                </asp:ListItem>
                                    <asp:ListItem>ISTMINA                              </asp:ListItem>
                                    <asp:ListItem>ITAGUI                               </asp:ListItem>
                                    <asp:ListItem>ITUANGO                              </asp:ListItem>
                                    <asp:ListItem>IZA                                  </asp:ListItem>
                                    <asp:ListItem>JAMBALO                              </asp:ListItem>
                                    <asp:ListItem>JAMUNDI                              </asp:ListItem>
                                    <asp:ListItem>JARDIN                               </asp:ListItem>
                                    <asp:ListItem>JENESANO                             </asp:ListItem>
                                    <asp:ListItem>JERICO                               </asp:ListItem>
                                    <asp:ListItem>JERICO                               </asp:ListItem>
                                    <asp:ListItem>JERUSALEN                            </asp:ListItem>
                                    <asp:ListItem>JESUS MARIA                          </asp:ListItem>
                                    <asp:ListItem>JORDAN                               </asp:ListItem>
                                    <asp:ListItem>JUAN DE ACOSTA                       </asp:ListItem>
                                    <asp:ListItem>JUNIN                                </asp:ListItem>
                                    <asp:ListItem>JURADO                               </asp:ListItem>
                                    <asp:ListItem>LA APARTADA                          </asp:ListItem>
                                    <asp:ListItem>LA ARGENTINA                         </asp:ListItem>
                                    <asp:ListItem>LA BELLEZA                           </asp:ListItem>
                                    <asp:ListItem>LA CALERA                            </asp:ListItem>
                                    <asp:ListItem>LA CAPILLA                           </asp:ListItem>
                                    <asp:ListItem>LA CEJA                              </asp:ListItem>
                                    <asp:ListItem>LA CELIA                             </asp:ListItem>
                                    <asp:ListItem>LA CRUZ                              </asp:ListItem>
                                    <asp:ListItem>LA CUMBRE                            </asp:ListItem>
                                    <asp:ListItem>LA DORADA                            </asp:ListItem>
                                    <asp:ListItem>LA ESPERANZA                         </asp:ListItem>
                                    <asp:ListItem>LA ESTRELLA                          </asp:ListItem>
                                    <asp:ListItem>LA FLORIDA                           </asp:ListItem>
                                    <asp:ListItem>LA GLORIA                            </asp:ListItem>
                                    <asp:ListItem>LA JAGUA DE IBIRICO                  </asp:ListItem>
                                    <asp:ListItem>LA JAGUA DEL PILAR                   </asp:ListItem>
                                    <asp:ListItem>LA LLANADA                           </asp:ListItem>
                                    <asp:ListItem>LA MACARENA                          </asp:ListItem>
                                    <asp:ListItem>LA MERCED                            </asp:ListItem>
                                    <asp:ListItem>LA MESA                              </asp:ListItem>
                                    <asp:ListItem>LA MONTAÑITA                         </asp:ListItem>
                                    <asp:ListItem>LA PALMA                             </asp:ListItem>
                                    <asp:ListItem>LA PAZ                               </asp:ListItem>
                                    <asp:ListItem>LA PEÑA                              </asp:ListItem>
                                    <asp:ListItem>LA PINTADA                           </asp:ListItem>
                                    <asp:ListItem>LA PLATA                             </asp:ListItem>
                                    <asp:ListItem>LA PLAYA                             </asp:ListItem>
                                    <asp:ListItem>LA PRIMAVERA                         </asp:ListItem>
                                    <asp:ListItem>LA SALINA                            </asp:ListItem>
                                    <asp:ListItem>LA SIERRA                            </asp:ListItem>
                                    <asp:ListItem>LA TEBAIDA                           </asp:ListItem>
                                    <asp:ListItem>LA TOLA                              </asp:ListItem>
                                    <asp:ListItem>LA UNION                             </asp:ListItem>
                                    <asp:ListItem>LA UNION                             </asp:ListItem>
                                    <asp:ListItem>LA UNION                             </asp:ListItem>
                                    <asp:ListItem>LA UNION                             </asp:ListItem>
                                    <asp:ListItem>LA URIBE                             </asp:ListItem>
                                    <asp:ListItem>LA UVITA                             </asp:ListItem>
                                    <asp:ListItem>LA VEGA                              </asp:ListItem>
                                    <asp:ListItem>LA VEGA                              </asp:ListItem>
                                    <asp:ListItem>LA VICTORIA                          </asp:ListItem>
                                    <asp:ListItem>LA VICTORIA                          </asp:ListItem>
                                    <asp:ListItem>LA VIRGINIA                          </asp:ListItem>
                                    <asp:ListItem>LABATECA                             </asp:ListItem>
                                    <asp:ListItem>LABRANZAGRANDE                       </asp:ListItem>
                                    <asp:ListItem>LANDAZURI                            </asp:ListItem>
                                    <asp:ListItem>LEBRIJA                              </asp:ListItem>
                                    <asp:ListItem>LEIVA                                </asp:ListItem>
                                    <asp:ListItem>LEJANIAS                             </asp:ListItem>
                                    <asp:ListItem>LENGUAZAQUE                          </asp:ListItem>
                                    <asp:ListItem>LERIDA                               </asp:ListItem>
                                    <asp:ListItem>LETICIA                              </asp:ListItem>
                                    <asp:ListItem>LIBANO                               </asp:ListItem>
                                    <asp:ListItem>LIBORINA                             </asp:ListItem>
                                    <asp:ListItem>LINARES                              </asp:ListItem>
                                    <asp:ListItem>LITORAL DEL SAN JUAN                 </asp:ListItem>
                                    <asp:ListItem>LLORO                                </asp:ListItem>
                                    <asp:ListItem>LOPEZ                                </asp:ListItem>
                                    <asp:ListItem>LORICA                               </asp:ListItem>
                                    <asp:ListItem>LOS ANDES                            </asp:ListItem>
                                    <asp:ListItem>LOS CORDOBAS                         </asp:ListItem>
                                    <asp:ListItem>LOS PALMITOS                         </asp:ListItem>
                                    <asp:ListItem>LOS PATIOS                           </asp:ListItem>
                                    <asp:ListItem>LOS SANTOS                           </asp:ListItem>
                                    <asp:ListItem>LOURDES                              </asp:ListItem>
                                    <asp:ListItem>LURUACO                              </asp:ListItem>
                                    <asp:ListItem>MACANAL                              </asp:ListItem>
                                    <asp:ListItem>MACARAVITA                           </asp:ListItem>
                                    <asp:ListItem>MACEO                                </asp:ListItem>
                                    <asp:ListItem>MACHETA                              </asp:ListItem>
                                    <asp:ListItem>MADRID                               </asp:ListItem>
                                    <asp:ListItem>MAGANGUE                             </asp:ListItem>
                                    <asp:ListItem>MAGUI-PAYAN                          </asp:ListItem>
                                    <asp:ListItem>MAHATES                              </asp:ListItem>
                                    <asp:ListItem>MAICAO                               </asp:ListItem>
                                    <asp:ListItem>MAJAGUAL                             </asp:ListItem>
                                    <asp:ListItem>MALAGA                               </asp:ListItem>
                                    <asp:ListItem>MALAMBO                              </asp:ListItem>
                                    <asp:ListItem>MALLAMA                              </asp:ListItem>
                                    <asp:ListItem>MANATI                               </asp:ListItem>
                                    <asp:ListItem>MANAURE                              </asp:ListItem>
                                    <asp:ListItem>MANAURE                              </asp:ListItem>
                                    <asp:ListItem>MANI                                 </asp:ListItem>
                                    <asp:ListItem>MANIZALES                            </asp:ListItem>
                                    <asp:ListItem>MANTA                                </asp:ListItem>
                                    <asp:ListItem>MANZANARES                           </asp:ListItem>
                                    <asp:ListItem>MAPIRIPAN                            </asp:ListItem>
                                    <asp:ListItem>MARGARITA                            </asp:ListItem>
                                    <asp:ListItem>MARIA LA BAJA                        </asp:ListItem>
                                    <asp:ListItem>MARINILLA                            </asp:ListItem>
                                    <asp:ListItem>MARIPI                               </asp:ListItem>
                                    <asp:ListItem>MARIQUITA                            </asp:ListItem>
                                    <asp:ListItem>MARMATO                              </asp:ListItem>
                                    <asp:ListItem>MARQUETALIA                          </asp:ListItem>
                                    <asp:ListItem>MARSELLA                             </asp:ListItem>
                                    <asp:ListItem>MARULANDA                            </asp:ListItem>
                                    <asp:ListItem>MATANZA                              </asp:ListItem>
                                    <asp:ListItem>MEDELLIN                             </asp:ListItem>
                                    <asp:ListItem>MEDINA                               </asp:ListItem>
                                    <asp:ListItem>MEDIO ATRATO                         </asp:ListItem>
                                    <asp:ListItem>MEDIO BAUDO                          </asp:ListItem>
                                    <asp:ListItem>MEDIO SAN JUAN                       </asp:ListItem>
                                    <asp:ListItem>MELGAR                               </asp:ListItem>
                                    <asp:ListItem>MERCADERES                           </asp:ListItem>
                                    <asp:ListItem>MESETAS                              </asp:ListItem>
                                    <asp:ListItem>MILAN                                </asp:ListItem>
                                    <asp:ListItem>MIRAFLORES                           </asp:ListItem>
                                    <asp:ListItem>MIRAFLORES                           </asp:ListItem>
                                    <asp:ListItem>MIRANDA                              </asp:ListItem>
                                    <asp:ListItem>MISTRATO                             </asp:ListItem>
                                    <asp:ListItem>MITU                                 </asp:ListItem>
                                    <asp:ListItem>MOCOA                                </asp:ListItem>
                                    <asp:ListItem>MOGOTES                              </asp:ListItem>
                                    <asp:ListItem>MOLAGAVITA                           </asp:ListItem>
                                    <asp:ListItem>MOMIL                                </asp:ListItem>
                                    <asp:ListItem>MOMPOS                               </asp:ListItem>
                                    <asp:ListItem>MONGUA                               </asp:ListItem>
                                    <asp:ListItem>MONGUI                               </asp:ListItem>
                                    <asp:ListItem>MONIQUIRA                            </asp:ListItem>
                                    <asp:ListItem>MONTEBELLO                           </asp:ListItem>
                                    <asp:ListItem>MONTECRISTO                          </asp:ListItem>
                                    <asp:ListItem>MONTELIBANO                          </asp:ListItem>
                                    <asp:ListItem>MONTENEGRO                           </asp:ListItem>
                                    <asp:ListItem>MONTERIA                             </asp:ListItem>
                                    <asp:ListItem>MONTERREY                            </asp:ListItem>
                                    <asp:ListItem>MOÑITOS                              </asp:ListItem>
                                    <asp:ListItem>MORALES                              </asp:ListItem>
                                    <asp:ListItem>MORALES                              </asp:ListItem>
                                    <asp:ListItem>MORELIA                              </asp:ListItem>
                                    <asp:ListItem>MORROA                               </asp:ListItem>
                                    <asp:ListItem>MOSQUERA                             </asp:ListItem>
                                    <asp:ListItem>MOSQUERA                             </asp:ListItem>
                                    <asp:ListItem>MOTAVITA                             </asp:ListItem>
                                    <asp:ListItem>MURILLO                              </asp:ListItem>
                                    <asp:ListItem>MURINDO                              </asp:ListItem>
                                    <asp:ListItem>MUTATA                               </asp:ListItem>
                                    <asp:ListItem>MUTISCUA                             </asp:ListItem>
                                    <asp:ListItem>MUZO                                 </asp:ListItem>
                                    <asp:ListItem>NARIÑO                               </asp:ListItem>
                                    <asp:ListItem>NARIÑO                               </asp:ListItem>
                                    <asp:ListItem>NARIÑO                               </asp:ListItem>
                                    <asp:ListItem>NATAGA                               </asp:ListItem>
                                    <asp:ListItem>NATAGAIMA                            </asp:ListItem>
                                    <asp:ListItem>NECHI                                </asp:ListItem>
                                    <asp:ListItem>NECOCLI                              </asp:ListItem>
                                    <asp:ListItem>NEIRA                                </asp:ListItem>
                                    <asp:ListItem>NEIVA                                </asp:ListItem>
                                    <asp:ListItem>NEMOCON                              </asp:ListItem>
                                    <asp:ListItem>NILO                                 </asp:ListItem>
                                    <asp:ListItem>NIMAIMA                              </asp:ListItem>
                                    <asp:ListItem>NOBSA                                </asp:ListItem>
                                    <asp:ListItem>NOCAIMA                              </asp:ListItem>
                                    <asp:ListItem>NORCASIA                             </asp:ListItem>
                                    <asp:ListItem>NOVITA                               </asp:ListItem>
                                    <asp:ListItem>NUEVA GRANADA                        </asp:ListItem>
                                    <asp:ListItem>NUEVO COLON                          </asp:ListItem>
                                    <asp:ListItem>NUNCHIA                              </asp:ListItem>
                                    <asp:ListItem>NUQUI                                </asp:ListItem>
                                    <asp:ListItem>OBANDO                               </asp:ListItem>
                                    <asp:ListItem>OCAMONTE                             </asp:ListItem>
                                    <asp:ListItem>OCAÑA                                </asp:ListItem>
                                    <asp:ListItem>OIBA                                 </asp:ListItem>
                                    <asp:ListItem>OICATA                               </asp:ListItem>
                                    <asp:ListItem>OLAYA                                </asp:ListItem>
                                    <asp:ListItem>OLAYA HERRERA                        </asp:ListItem>
                                    <asp:ListItem>ONZAGA                               </asp:ListItem>
                                    <asp:ListItem>OPORAPA                              </asp:ListItem>
                                    <asp:ListItem>ORITO                                </asp:ListItem>
                                    <asp:ListItem>OROCUE                               </asp:ListItem>
                                    <asp:ListItem>ORTEGA                               </asp:ListItem>
                                    <asp:ListItem>OSPINA                               </asp:ListItem>
                                    <asp:ListItem>OTANCHE                              </asp:ListItem>
                                    <asp:ListItem>OVEJAS                               </asp:ListItem>
                                    <asp:ListItem>PACHAVITA                            </asp:ListItem>
                                    <asp:ListItem>PACHO                                </asp:ListItem>
                                    <asp:ListItem>PACORA                               </asp:ListItem>
                                    <asp:ListItem>PADILLA                              </asp:ListItem>
                                    <asp:ListItem>PAEZ                                 </asp:ListItem>
                                    <asp:ListItem>PAEZ                                 </asp:ListItem>
                                    <asp:ListItem>PAICOL                               </asp:ListItem>
                                    <asp:ListItem>PAILITAS                             </asp:ListItem>
                                    <asp:ListItem>PAIME                                </asp:ListItem>
                                    <asp:ListItem>PAIPA                                </asp:ListItem>
                                    <asp:ListItem>PAJARITO                             </asp:ListItem>
                                    <asp:ListItem>PALERMO                              </asp:ListItem>
                                    <asp:ListItem>PALESTINA                            </asp:ListItem>
                                    <asp:ListItem>PALESTINA                            </asp:ListItem>
                                    <asp:ListItem>PALMAR                               </asp:ListItem>
                                    <asp:ListItem>PALMAR DE VARELA                     </asp:ListItem>
                                    <asp:ListItem>PALMAS DEL SOCORRO                   </asp:ListItem>
                                    <asp:ListItem>PALMIRA                              </asp:ListItem>
                                    <asp:ListItem>PALMITO                              </asp:ListItem>
                                    <asp:ListItem>PALOCABILDO                          </asp:ListItem>
                                    <asp:ListItem>PAMPLONA                             </asp:ListItem>
                                    <asp:ListItem>PAMPLONITA                           </asp:ListItem>
                                    <asp:ListItem>PANDI                                </asp:ListItem>
                                    <asp:ListItem>PANQUEBA                             </asp:ListItem>
                                    <asp:ListItem>PARAMO                               </asp:ListItem>
                                    <asp:ListItem>PARATEBUENO                          </asp:ListItem>
                                    <asp:ListItem>PASCA                                </asp:ListItem>
                                    <asp:ListItem>PASTO                                </asp:ListItem>
                                    <asp:ListItem>PATIA (EL BORDO)                     </asp:ListItem>
                                    <asp:ListItem>PAUNA                                </asp:ListItem>
                                    <asp:ListItem>PAYA                                 </asp:ListItem>
                                    <asp:ListItem>PAZ DE ARIPORO                       </asp:ListItem>
                                    <asp:ListItem>PAZ DEL RIO                          </asp:ListItem>
                                    <asp:ListItem>PEDRAZA                              </asp:ListItem>
                                    <asp:ListItem>PELAYA                               </asp:ListItem>
                                    <asp:ListItem>PENSILVANIA                          </asp:ListItem>
                                    <asp:ListItem>PEÑOL                                </asp:ListItem>
                                    <asp:ListItem>PEQUE                                </asp:ListItem>
                                    <asp:ListItem>PEREIRA                              </asp:ListItem>
                                    <asp:ListItem>PESCA                                </asp:ListItem>
                                    <asp:ListItem>PIAMONTE                             </asp:ListItem>
                                    <asp:ListItem>PIEDECUESTA                          </asp:ListItem>
                                    <asp:ListItem>PIEDRAS                              </asp:ListItem>
                                    <asp:ListItem>PIENDAMO                             </asp:ListItem>
                                    <asp:ListItem>PIJAO                                </asp:ListItem>
                                    <asp:ListItem>PIJIÑO DEL CARMEN                    </asp:ListItem>
                                    <asp:ListItem>PINCHOTE                             </asp:ListItem>
                                    <asp:ListItem>PINILLOS                             </asp:ListItem>
                                    <asp:ListItem>PIOJO                                </asp:ListItem>
                                    <asp:ListItem>PISBA                                </asp:ListItem>
                                    <asp:ListItem>PITAL                                </asp:ListItem>
                                    <asp:ListItem>PITALITO                             </asp:ListItem>
                                    <asp:ListItem>PIVIJAY                              </asp:ListItem>
                                    <asp:ListItem>PLANADAS                             </asp:ListItem>
                                    <asp:ListItem>PLANETA RICA                         </asp:ListItem>
                                    <asp:ListItem>PLATO                                </asp:ListItem>
                                    <asp:ListItem>POLICARPA                            </asp:ListItem>
                                    <asp:ListItem>POLO NUEVO                           </asp:ListItem>
                                    <asp:ListItem>PONEDERA                             </asp:ListItem>
                                    <asp:ListItem>POPAYAN                              </asp:ListItem>
                                    <asp:ListItem>PORE                                 </asp:ListItem>
                                    <asp:ListItem>POTOSI                               </asp:ListItem>
                                    <asp:ListItem>PRADERA                              </asp:ListItem>
                                    <asp:ListItem>PRADO                                </asp:ListItem>
                                    <asp:ListItem>PROVIDENCIA                          </asp:ListItem>
                                    <asp:ListItem>PROVIDENCIA                          </asp:ListItem>
                                    <asp:ListItem>PUEBLO BELLO                         </asp:ListItem>
                                    <asp:ListItem>PUEBLO NUEVO                         </asp:ListItem>
                                    <asp:ListItem>PUEBLO RICO                          </asp:ListItem>
                                    <asp:ListItem>PUEBLORRICO                          </asp:ListItem>
                                    <asp:ListItem>PUEBLOVIEJO                          </asp:ListItem>
                                    <asp:ListItem>PUENTE NACIONAL                      </asp:ListItem>
                                    <asp:ListItem>PUERRES                              </asp:ListItem>
                                    <asp:ListItem>PUERTO ASIS                          </asp:ListItem>
                                    <asp:ListItem>PUERTO BERRIO                        </asp:ListItem>
                                    <asp:ListItem>PUERTO BOYACA                        </asp:ListItem>
                                    <asp:ListItem>PUERTO CARREÑO                       </asp:ListItem>
                                    <asp:ListItem>PUERTO CAYCEDO                       </asp:ListItem>
                                    <asp:ListItem>PUERTO COLOMBIA                      </asp:ListItem>
                                    <asp:ListItem>PUERTO CONCORDIA                     </asp:ListItem>
                                    <asp:ListItem>PUERTO ESCONDIDO                     </asp:ListItem>
                                    <asp:ListItem>PUERTO GAITAN                        </asp:ListItem>
                                    <asp:ListItem>PUERTO GUZMAN                        </asp:ListItem>
                                    <asp:ListItem>PUERTO INIRIDA                       </asp:ListItem>
                                    <asp:ListItem>PUERTO LEGUIZAMO                     </asp:ListItem>
                                    <asp:ListItem>PUERTO LIBERTADOR                    </asp:ListItem>
                                    <asp:ListItem>PUERTO LLERAS                        </asp:ListItem>
                                    <asp:ListItem>PUERTO LOPEZ                         </asp:ListItem>
                                    <asp:ListItem>PUERTO NARE                          </asp:ListItem>
                                    <asp:ListItem>PUERTO NARIÑO                        </asp:ListItem>
                                    <asp:ListItem>PUERTO PARRA                         </asp:ListItem>
                                    <asp:ListItem>PUERTO RICO                          </asp:ListItem>
                                    <asp:ListItem>PUERTO RICO                          </asp:ListItem>
                                    <asp:ListItem>PUERTO RONDON                        </asp:ListItem>
                                    <asp:ListItem>PUERTO SALGAR                        </asp:ListItem>
                                    <asp:ListItem>PUERTO SANTANDER                     </asp:ListItem>
                                    <asp:ListItem>PUERTO TEJADA                        </asp:ListItem>
                                    <asp:ListItem>PUERTO TRIUNFO                       </asp:ListItem>
                                    <asp:ListItem>PUERTO WILCHES                       </asp:ListItem>
                                    <asp:ListItem>PULI                                 </asp:ListItem>
                                    <asp:ListItem>PUPIALES                             </asp:ListItem>
                                    <asp:ListItem>PURACE                               </asp:ListItem>
                                    <asp:ListItem>PURIFICACION                         </asp:ListItem>
                                    <asp:ListItem>PURISIMA                             </asp:ListItem>
                                    <asp:ListItem>QUEBRADANEGRA                        </asp:ListItem>
                                    <asp:ListItem>QUETAME                              </asp:ListItem>
                                    <asp:ListItem>QUIBDO                               </asp:ListItem>
                                    <asp:ListItem>QUIMBAYA                             </asp:ListItem>
                                    <asp:ListItem>QUINCHIA                             </asp:ListItem>
                                    <asp:ListItem>QUIPAMA                              </asp:ListItem>
                                    <asp:ListItem>QUIPILE                              </asp:ListItem>
                                    <asp:ListItem>RAFAEL REYES                         </asp:ListItem>
                                    <asp:ListItem>RAGONVALIA                           </asp:ListItem>
                                    <asp:ListItem>RAMIRIQUI                            </asp:ListItem>
                                    <asp:ListItem>RAQUIRA                              </asp:ListItem>
                                    <asp:ListItem>RECETOR                              </asp:ListItem>
                                    <asp:ListItem>REGIDOR                              </asp:ListItem>
                                    <asp:ListItem>REMEDIOS                             </asp:ListItem>
                                    <asp:ListItem>REMOLINO                             </asp:ListItem>
                                    <asp:ListItem>REPELON                              </asp:ListItem>
                                    <asp:ListItem>RESTREPO                             </asp:ListItem>
                                    <asp:ListItem>RESTREPO                             </asp:ListItem>
                                    <asp:ListItem>RETIRO                               </asp:ListItem>
                                    <asp:ListItem>RICAURTE                             </asp:ListItem>
                                    <asp:ListItem>RICAURTE                             </asp:ListItem>
                                    <asp:ListItem>RIO DE ORO                           </asp:ListItem>
                                    <asp:ListItem>RIO IRO                              </asp:ListItem>
                                    <asp:ListItem>RIO QUITO                            </asp:ListItem>
                                    <asp:ListItem>RIO VIEJO                            </asp:ListItem>
                                    <asp:ListItem>RIOBLANCO                            </asp:ListItem>
                                    <asp:ListItem>RIOFRIO                              </asp:ListItem>
                                    <asp:ListItem>RIOHACHA                             </asp:ListItem>
                                    <asp:ListItem>RIONEGRO                             </asp:ListItem>
                                    <asp:ListItem>RIONEGRO                             </asp:ListItem>
                                    <asp:ListItem>RIOSUCIO                             </asp:ListItem>
                                    <asp:ListItem>RIOSUCIO                             </asp:ListItem>
                                    <asp:ListItem>RISARALDA                            </asp:ListItem>
                                    <asp:ListItem>RIVERA                               </asp:ListItem>
                                    <asp:ListItem>ROBERTO PAYAN                        </asp:ListItem>
                                    <asp:ListItem>ROBLES (LA PAZ)                      </asp:ListItem>
                                    <asp:ListItem>ROLDANILLO                           </asp:ListItem>
                                    <asp:ListItem>RONCESVALLES                         </asp:ListItem>
                                    <asp:ListItem>RONDON                               </asp:ListItem>
                                    <asp:ListItem>ROSAS                                </asp:ListItem>
                                    <asp:ListItem>ROVIRA                               </asp:ListItem>
                                    <asp:ListItem>SABANA DE TORRES                     </asp:ListItem>
                                    <asp:ListItem>SABANAGRANDE                         </asp:ListItem>
                                    <asp:ListItem>SABANALARGA                          </asp:ListItem>
                                    <asp:ListItem>SABANALARGA                          </asp:ListItem>
                                    <asp:ListItem>SABANALARGA                          </asp:ListItem>
                                    <asp:ListItem>SABANAS DE SAN ANGEL                 </asp:ListItem>
                                    <asp:ListItem>SABANETA                             </asp:ListItem>
                                    <asp:ListItem>SABOYA                               </asp:ListItem>
                                    <asp:ListItem>SACAMA                               </asp:ListItem>
                                    <asp:ListItem>SACHICA                              </asp:ListItem>
                                    <asp:ListItem>SAHAGUN                              </asp:ListItem>
                                    <asp:ListItem>SALADOBLANCO                         </asp:ListItem>
                                    <asp:ListItem>SALAMINA                             </asp:ListItem>
                                    <asp:ListItem>SALAMINA                             </asp:ListItem>
                                    <asp:ListItem>SALAZAR                              </asp:ListItem>
                                    <asp:ListItem>SALDAÑA                              </asp:ListItem>
                                    <asp:ListItem>SALENTO                              </asp:ListItem>
                                    <asp:ListItem>SALGAR                               </asp:ListItem>
                                    <asp:ListItem>SAMACA                               </asp:ListItem>
                                    <asp:ListItem>SAMANA                               </asp:ListItem>
                                    <asp:ListItem>SAMANIEGO                            </asp:ListItem>
                                    <asp:ListItem>SAMPUES                              </asp:ListItem>
                                    <asp:ListItem>SAN  ANTONIO DEL  TEQUENDAMA         </asp:ListItem>
                                    <asp:ListItem>SAN  VICENTE DEL CAGUAN              </asp:ListItem>
                                    <asp:ListItem>SAN AGUSTIN                          </asp:ListItem>
                                    <asp:ListItem>SAN ALBERTO                          </asp:ListItem>
                                    <asp:ListItem>SAN ANDRES                           </asp:ListItem>
                                    <asp:ListItem>SAN ANDRES                           </asp:ListItem>
                                    <asp:ListItem>SAN ANDRES                           </asp:ListItem>
                                    <asp:ListItem>SAN ANDRES SOTAVENTO                 </asp:ListItem>
                                    <asp:ListItem>SAN ANTERO                           </asp:ListItem>
                                    <asp:ListItem>SAN ANTONIO                          </asp:ListItem>
                                    <asp:ListItem>SAN BENITO                           </asp:ListItem>
                                    <asp:ListItem>SAN BENITO ABAD                      </asp:ListItem>
                                    <asp:ListItem>SAN BERNARDO                         </asp:ListItem>
                                    <asp:ListItem>SAN BERNARDO                         </asp:ListItem>
                                    <asp:ListItem>SAN BERNARDO VIENTO                  </asp:ListItem>
                                    <asp:ListItem>SAN CALIXTO                          </asp:ListItem>
                                    <asp:ListItem>SAN CARLOS                           </asp:ListItem>
                                    <asp:ListItem>SAN CARLOS                           </asp:ListItem>
                                    <asp:ListItem>SAN CARLOS DE GUAROA                 </asp:ListItem>
                                    <asp:ListItem>SAN CAYETANO                         </asp:ListItem>
                                    <asp:ListItem>SAN CAYETANO                         </asp:ListItem>
                                    <asp:ListItem>SAN CRISTOBAL                        </asp:ListItem>
                                    <asp:ListItem>SAN DIEGO                            </asp:ListItem>
                                    <asp:ListItem>SAN EDUARDO                          </asp:ListItem>
                                    <asp:ListItem>SAN ESTANISLAO                       </asp:ListItem>
                                    <asp:ListItem>SAN FERNANDO                         </asp:ListItem>
                                    <asp:ListItem>SAN FRANCISCO                        </asp:ListItem>
                                    <asp:ListItem>SAN FRANCISCO                        </asp:ListItem>
                                    <asp:ListItem>SAN FRANCISCO                        </asp:ListItem>
                                    <asp:ListItem>SAN GIL                              </asp:ListItem>
                                    <asp:ListItem>SAN JACINTO                          </asp:ListItem>
                                    <asp:ListItem>SAN JACINTO DEL CAUCA                </asp:ListItem>
                                    <asp:ListItem>SAN JERONIMO                         </asp:ListItem>
                                    <asp:ListItem>SAN JOAQUIN                          </asp:ListItem>
                                    <asp:ListItem>SAN JOSE                             </asp:ListItem>
                                    <asp:ListItem>SAN JOSE DE FRAGUA                   </asp:ListItem>
                                    <asp:ListItem>SAN JOSE DE LA MONTAÑA               </asp:ListItem>
                                    <asp:ListItem>SAN JOSE DE MIRANDA                  </asp:ListItem>
                                    <asp:ListItem>SAN JOSE DE PARE                     </asp:ListItem>
                                    <asp:ListItem>SAN JOSE DEL GUAVIARE                </asp:ListItem>
                                    <asp:ListItem>SAN JOSE DEL PALMAR                  </asp:ListItem>
                                    <asp:ListItem>SAN JUAN DE ARAMA                    </asp:ListItem>
                                    <asp:ListItem>SAN JUAN DE BETULIA                  </asp:ListItem>
                                    <asp:ListItem>SAN JUAN DE NEPOMUCENO               </asp:ListItem>
                                    <asp:ListItem>SAN JUAN DE RIOSECO                  </asp:ListItem>
                                    <asp:ListItem>SAN JUAN DE URABA                    </asp:ListItem>
                                    <asp:ListItem>SAN JUAN DEL CESAR                   </asp:ListItem>
                                    <asp:ListItem>SAN JUANITO                          </asp:ListItem>
                                    <asp:ListItem>SAN LORENZO                          </asp:ListItem>
                                    <asp:ListItem>SAN LUIS                             </asp:ListItem>
                                    <asp:ListItem>SAN LUIS                             </asp:ListItem>
                                    <asp:ListItem>SAN LUIS DE GACENO                   </asp:ListItem>
                                    <asp:ListItem>SAN LUIS DE PALENQUE                 </asp:ListItem>
                                    <asp:ListItem>SAN MARCOS                           </asp:ListItem>
                                    <asp:ListItem>SAN MARTIN                           </asp:ListItem>
                                    <asp:ListItem>SAN MARTIN                           </asp:ListItem>
                                    <asp:ListItem>SAN MARTIN DE LOBA                   </asp:ListItem>
                                    <asp:ListItem>SAN MATEO                            </asp:ListItem>
                                    <asp:ListItem>SAN MIGUEL                           </asp:ListItem>
                                    <asp:ListItem>SAN MIGUEL                           </asp:ListItem>
                                    <asp:ListItem>SAN MIGUEL DE SEMA                   </asp:ListItem>
                                    <asp:ListItem>SAN ONOFRE                           </asp:ListItem>
                                    <asp:ListItem>SAN PABLO                            </asp:ListItem>
                                    <asp:ListItem>SAN PABLO                            </asp:ListItem>
                                    <asp:ListItem>SAN PABLO DE BORBUR                  </asp:ListItem>
                                    <asp:ListItem>SAN PEDRO                            </asp:ListItem>
                                    <asp:ListItem>SAN PEDRO                            </asp:ListItem>
                                    <asp:ListItem>SAN PEDRO                            </asp:ListItem>
                                    <asp:ListItem>SAN PEDRO DE CARTAGO                 </asp:ListItem>
                                    <asp:ListItem>SAN PEDRO DE URABA                   </asp:ListItem>
                                    <asp:ListItem>SAN PELAYO                           </asp:ListItem>
                                    <asp:ListItem>SAN RAFAEL                           </asp:ListItem>
                                    <asp:ListItem>SAN ROQUE                            </asp:ListItem>
                                    <asp:ListItem>SAN SEBASTIAN                        </asp:ListItem>
                                    <asp:ListItem>SAN SEBASTIAN DE BUENAVISTA          </asp:ListItem>
                                    <asp:ListItem>SAN VICENTE                          </asp:ListItem>
                                    <asp:ListItem>SAN VICENTE DE CHUCURI               </asp:ListItem>
                                    <asp:ListItem>SAN ZENON                            </asp:ListItem>
                                    <asp:ListItem>SANDONA                              </asp:ListItem>
                                    <asp:ListItem>SANTA ANA                            </asp:ListItem>
                                    <asp:ListItem>SANTA BARBARA                        </asp:ListItem>
                                    <asp:ListItem>SANTA BARBARA                        </asp:ListItem>
                                    <asp:ListItem>SANTA BARBARA                        </asp:ListItem>
                                    <asp:ListItem>SANTA BARBARA DE PINTO               </asp:ListItem>
                                    <asp:ListItem>SANTA CATALINA                       </asp:ListItem>
                                    <asp:ListItem>SANTA HELENA                         </asp:ListItem>
                                    <asp:ListItem>SANTA ISABEL                         </asp:ListItem>
                                    <asp:ListItem>SANTA LUCIA                          </asp:ListItem>
                                    <asp:ListItem>SANTA MARIA                          </asp:ListItem>
                                    <asp:ListItem>SANTA MARIA                          </asp:ListItem>
                                    <asp:ListItem>SANTA MARTA                          </asp:ListItem>
                                    <asp:ListItem>SANTA ROSA                           </asp:ListItem>
                                    <asp:ListItem>SANTA ROSA                           </asp:ListItem>
                                    <asp:ListItem>SANTA ROSA DE CABAL                  </asp:ListItem>
                                    <asp:ListItem>SANTA ROSA DE OSOS                   </asp:ListItem>
                                    <asp:ListItem>SANTA ROSA DE VITERBO                </asp:ListItem>
                                    <asp:ListItem>SANTA ROSA DEL SUR                   </asp:ListItem>
                                    <asp:ListItem>SANTA ROSALIA                        </asp:ListItem>
                                    <asp:ListItem>SANTA SOFIA                          </asp:ListItem>
                                    <asp:ListItem>SANTACRUZ                            </asp:ListItem>
                                    <asp:ListItem>SANTANA                              </asp:ListItem>
                                    <asp:ListItem>SANTANDER DE QUILICHAO               </asp:ListItem>
                                    <asp:ListItem>SANTIAGO                             </asp:ListItem>
                                    <asp:ListItem>SANTIAGO                             </asp:ListItem>
                                    <asp:ListItem>SANTO DOMINGO                        </asp:ListItem>
                                    <asp:ListItem>SANTO TOMAS                          </asp:ListItem>
                                    <asp:ListItem>SANTUARIO                            </asp:ListItem>
                                    <asp:ListItem>SANTUARIO                            </asp:ListItem>
                                    <asp:ListItem>SAPUYES                              </asp:ListItem>
                                    <asp:ListItem>SARAVENA                             </asp:ListItem>
                                    <asp:ListItem>SARDINATA                            </asp:ListItem>
                                    <asp:ListItem>SASAIMA                              </asp:ListItem>
                                    <asp:ListItem>SATIVANORTE                          </asp:ListItem>
                                    <asp:ListItem>SATIVASUR                            </asp:ListItem>
                                    <asp:ListItem>SEGOVIA                              </asp:ListItem>
                                    <asp:ListItem>SESQUILE                             </asp:ListItem>
                                    <asp:ListItem>SEVILLA                              </asp:ListItem>
                                    <asp:ListItem>SIACHOQUE                            </asp:ListItem>
                                    <asp:ListItem>SIBATE                               </asp:ListItem>
                                    <asp:ListItem>SIBUNDOY                             </asp:ListItem>
                                    <asp:ListItem>SILOS                                </asp:ListItem>
                                    <asp:ListItem>SILVANIA                             </asp:ListItem>
                                    <asp:ListItem>SILVIA                               </asp:ListItem>
                                    <asp:ListItem>SIMACOTA                             </asp:ListItem>
                                    <asp:ListItem>SIMIJACA                             </asp:ListItem>
                                    <asp:ListItem>SIMITI                               </asp:ListItem>
                                    <asp:ListItem>SINCE                                </asp:ListItem>
                                    <asp:ListItem>SINCELEJO                            </asp:ListItem>
                                    <asp:ListItem>SIPI                                 </asp:ListItem>
                                    <asp:ListItem>SITIONUEVO                           </asp:ListItem>
                                    <asp:ListItem>SOACHA                               </asp:ListItem>
                                    <asp:ListItem>SOATA                                </asp:ListItem>
                                    <asp:ListItem>SOCHA                                </asp:ListItem>
                                    <asp:ListItem>SOCORRO                              </asp:ListItem>
                                    <asp:ListItem>SOCOTA                               </asp:ListItem>
                                    <asp:ListItem>SOGAMOSO                             </asp:ListItem>
                                    <asp:ListItem>SOLANO                               </asp:ListItem>
                                    <asp:ListItem>SOLEDAD                              </asp:ListItem>
                                    <asp:ListItem>SOLITA                               </asp:ListItem>
                                    <asp:ListItem>SOMONDOCO                            </asp:ListItem>
                                    <asp:ListItem>SONSON                               </asp:ListItem>
                                    <asp:ListItem>SOPETRAN                             </asp:ListItem>
                                    <asp:ListItem>SOPLAVIENTO                          </asp:ListItem>
                                    <asp:ListItem>SOPO                                 </asp:ListItem>
                                    <asp:ListItem>SORA                                 </asp:ListItem>
                                    <asp:ListItem>SORACA                               </asp:ListItem>
                                    <asp:ListItem>SOTAQUIRA                            </asp:ListItem>
                                    <asp:ListItem>SOTARA                               </asp:ListItem>
                                    <asp:ListItem>SUAITA                               </asp:ListItem>
                                    <asp:ListItem>SUAN                                 </asp:ListItem>
                                    <asp:ListItem>SUAREZ                               </asp:ListItem>
                                    <asp:ListItem>SUAREZ                               </asp:ListItem>
                                    <asp:ListItem>SUAZA                                </asp:ListItem>
                                    <asp:ListItem>SUBACHOQUE                           </asp:ListItem>
                                    <asp:ListItem>SUCRE                                </asp:ListItem>
                                    <asp:ListItem>SUCRE                                </asp:ListItem>
                                    <asp:ListItem>SUCRE                                </asp:ListItem>
                                    <asp:ListItem>SUESCA                               </asp:ListItem>
                                    <asp:ListItem>SUPATA                               </asp:ListItem>
                                    <asp:ListItem>SUPIA                                </asp:ListItem>
                                    <asp:ListItem>SURATA                               </asp:ListItem>
                                    <asp:ListItem>SUSA                                 </asp:ListItem>
                                    <asp:ListItem>SUSACON                              </asp:ListItem>
                                    <asp:ListItem>SUTAMARCHAN                          </asp:ListItem>
                                    <asp:ListItem>SUTATAUSA                            </asp:ListItem>
                                    <asp:ListItem>SUTATENZA                            </asp:ListItem>
                                    <asp:ListItem>TABIO                                </asp:ListItem>
                                    <asp:ListItem>TADO                                 </asp:ListItem>
                                    <asp:ListItem>TALAIGUA NUEVO                       </asp:ListItem>
                                    <asp:ListItem>TAMALAMEQUE                          </asp:ListItem>
                                    <asp:ListItem>TAMARA                               </asp:ListItem>
                                    <asp:ListItem>TAME                                 </asp:ListItem>
                                    <asp:ListItem>TAMESIS                              </asp:ListItem>
                                    <asp:ListItem>TAMINANGO                            </asp:ListItem>
                                    <asp:ListItem>TANGUA                               </asp:ListItem>
                                    <asp:ListItem>TARAIRA                              </asp:ListItem>
                                    <asp:ListItem>TARAZA                               </asp:ListItem>
                                    <asp:ListItem>TARQUI                               </asp:ListItem>
                                    <asp:ListItem>TARSO                                </asp:ListItem>
                                    <asp:ListItem>TASCO                                </asp:ListItem>
                                    <asp:ListItem>TAURAMENA                            </asp:ListItem>
                                    <asp:ListItem>TAUSA                                </asp:ListItem>
                                    <asp:ListItem>TELLO                                </asp:ListItem>
                                    <asp:ListItem>TENA                                 </asp:ListItem>
                                    <asp:ListItem>TENERIFE                             </asp:ListItem>
                                    <asp:ListItem>TENJO                                </asp:ListItem>
                                    <asp:ListItem>TENZA                                </asp:ListItem>
                                    <asp:ListItem>TEORAMA                              </asp:ListItem>
                                    <asp:ListItem>TERUEL                               </asp:ListItem>
                                    <asp:ListItem>TESALIA                              </asp:ListItem>
                                    <asp:ListItem>TIBACUY                              </asp:ListItem>
                                    <asp:ListItem>TIBANA                               </asp:ListItem>
                                    <asp:ListItem>TIBASOSA                             </asp:ListItem>
                                    <asp:ListItem>TIBIRITA                             </asp:ListItem>
                                    <asp:ListItem>TIBU                                 </asp:ListItem>
                                    <asp:ListItem>TIERRALTA                            </asp:ListItem>
                                    <asp:ListItem>TIMANA                               </asp:ListItem>
                                    <asp:ListItem>TIMBIO                               </asp:ListItem>
                                    <asp:ListItem>TIMBIQUI                             </asp:ListItem>
                                    <asp:ListItem>TINJACA                              </asp:ListItem>
                                    <asp:ListItem>TIPACOQUE                            </asp:ListItem>
                                    <asp:ListItem>TIQUISIO                             </asp:ListItem>
                                    <asp:ListItem>TITIRIBI                             </asp:ListItem>
                                    <asp:ListItem>TOCA                                 </asp:ListItem>
                                    <asp:ListItem>TOCAIMA                              </asp:ListItem>
                                    <asp:ListItem>TOCANCIPA                            </asp:ListItem>
                                    <asp:ListItem>TOGUI                                </asp:ListItem>
                                    <asp:ListItem>TOLEDO                               </asp:ListItem>
                                    <asp:ListItem>TOLEDO                               </asp:ListItem>
                                    <asp:ListItem>TOLU                                 </asp:ListItem>
                                    <asp:ListItem>TOLUVIEJO                            </asp:ListItem>
                                    <asp:ListItem>TONA                                 </asp:ListItem>
                                    <asp:ListItem>TOPAGA                               </asp:ListItem>
                                    <asp:ListItem>TOPAIPI                              </asp:ListItem>
                                    <asp:ListItem>TORIBIO                              </asp:ListItem>
                                    <asp:ListItem>TORO                                 </asp:ListItem>
                                    <asp:ListItem>TOTA                                 </asp:ListItem>
                                    <asp:ListItem>TOTORO                               </asp:ListItem>
                                    <asp:ListItem>TRINIDAD                             </asp:ListItem>
                                    <asp:ListItem>TRUJILLO                             </asp:ListItem>
                                    <asp:ListItem>TUBARA                               </asp:ListItem>
                                    <asp:ListItem>TULUA                                </asp:ListItem>
                                    <asp:ListItem>TUMACO                               </asp:ListItem>
                                    <asp:ListItem>TUNJA                                </asp:ListItem>
                                    <asp:ListItem>TUNUNGUA                             </asp:ListItem>
                                    <asp:ListItem>TUQUERRES                            </asp:ListItem>
                                    <asp:ListItem>TURBACO                              </asp:ListItem>
                                    <asp:ListItem>TURBANA                              </asp:ListItem>
                                    <asp:ListItem>TURBO                                </asp:ListItem>
                                    <asp:ListItem>TURMEQUE                             </asp:ListItem>
                                    <asp:ListItem>TUTA                                 </asp:ListItem>
                                    <asp:ListItem>TUTASA                               </asp:ListItem>
                                    <asp:ListItem>UBALA                                </asp:ListItem>
                                    <asp:ListItem>UBAQUE                               </asp:ListItem>
                                    <asp:ListItem>UBATE                                </asp:ListItem>
                                    <asp:ListItem>ULLOA                                </asp:ListItem>
                                    <asp:ListItem>UMBITA                               </asp:ListItem>
                                    <asp:ListItem>UNE                                  </asp:ListItem>
                                    <asp:ListItem>UNGUIA                               </asp:ListItem>
                                    <asp:ListItem>UNION PANAMERICANA                   </asp:ListItem>
                                    <asp:ListItem>URAMITA                              </asp:ListItem>
                                    <asp:ListItem>URIBIA                               </asp:ListItem>
                                    <asp:ListItem>URRAO                                </asp:ListItem>
                                    <asp:ListItem>URUMITA                              </asp:ListItem>
                                    <asp:ListItem>USIACURI                             </asp:ListItem>
                                    <asp:ListItem>UTICA                                </asp:ListItem>
                                    <asp:ListItem>VALDIVIA                             </asp:ListItem>
                                    <asp:ListItem>VALENCIA                             </asp:ListItem>
                                    <asp:ListItem>VALLE DE S JUAN                      </asp:ListItem>
                                    <asp:ListItem>VALLE DEL GUAMUEZ                    </asp:ListItem>
                                    <asp:ListItem>VALLE SAN JOSE                       </asp:ListItem>
                                    <asp:ListItem>VALLEDUPAR                           </asp:ListItem>
                                    <asp:ListItem>VALPARAISO                           </asp:ListItem>
                                    <asp:ListItem>VALPARAISO                           </asp:ListItem>
                                    <asp:ListItem>VEGACHI                              </asp:ListItem>
                                    <asp:ListItem>VELEZ                                </asp:ListItem>
                                    <asp:ListItem>VENADILLO                            </asp:ListItem>
                                    <asp:ListItem>VENECIA                              </asp:ListItem>
                                    <asp:ListItem>VENECIA (OSPINA PEREZ)               </asp:ListItem>
                                    <asp:ListItem>VENTAQUEMADA                         </asp:ListItem>
                                    <asp:ListItem>VERGARA                              </asp:ListItem>
                                    <asp:ListItem>VERSALLES                            </asp:ListItem>
                                    <asp:ListItem>VETAS                                </asp:ListItem>
                                    <asp:ListItem>VIANI                                </asp:ListItem>
                                    <asp:ListItem>VICTORIA                             </asp:ListItem>
                                    <asp:ListItem>VIGIA DEL FUERTE                     </asp:ListItem>
                                    <asp:ListItem>VIJES                                </asp:ListItem>
                                    <asp:ListItem>VILLA DE LEYVA                       </asp:ListItem>
                                    <asp:ListItem>VILLA DEL ROSARIO                    </asp:ListItem>
                                    <asp:ListItem>VILLA RICA                           </asp:ListItem>
                                    <asp:ListItem>VILLACARO                            </asp:ListItem>
                                    <asp:ListItem>VILLAGARZON                          </asp:ListItem>
                                    <asp:ListItem>VILLAGOMEZ                           </asp:ListItem>
                                    <asp:ListItem>VILLAHERMOSA                         </asp:ListItem>
                                    <asp:ListItem>VILLAMARIA                           </asp:ListItem>
                                    <asp:ListItem>VILLANUEVA                           </asp:ListItem>
                                    <asp:ListItem>VILLANUEVA                           </asp:ListItem>
                                    <asp:ListItem>VILLANUEVA                           </asp:ListItem>
                                    <asp:ListItem>VILLANUEVA                           </asp:ListItem>
                                    <asp:ListItem>VILLAPINZON                          </asp:ListItem>
                                    <asp:ListItem>VILLARRICA                           </asp:ListItem>
                                    <asp:ListItem>VILLAVICENCIO                        </asp:ListItem>
                                    <asp:ListItem>VILLAVIEJA                           </asp:ListItem>
                                    <asp:ListItem>VILLETA                              </asp:ListItem>
                                    <asp:ListItem>VIOTA                                </asp:ListItem>
                                    <asp:ListItem>VIRACACHA                            </asp:ListItem>
                                    <asp:ListItem>VISTA HERMOSA                        </asp:ListItem>
                                    <asp:ListItem>VITERBO                              </asp:ListItem>
                                    <asp:ListItem>YACOPI                               </asp:ListItem>
                                    <asp:ListItem>YACUANQUER                           </asp:ListItem>
                                    <asp:ListItem>YAGUARA                              </asp:ListItem>
                                    <asp:ListItem>YALI                                 </asp:ListItem>
                                    <asp:ListItem>YARUMAL                              </asp:ListItem>
                                    <asp:ListItem>YOLOMBO                              </asp:ListItem>
                                    <asp:ListItem>YONDO                                </asp:ListItem>
                                    <asp:ListItem>YOPAL                                </asp:ListItem>
                                    <asp:ListItem>YOTOCO                               </asp:ListItem>
                                    <asp:ListItem>YUMBO                                </asp:ListItem>
                                    <asp:ListItem>ZAMBRANO                             </asp:ListItem>
                                    <asp:ListItem>ZAPATOCA                             </asp:ListItem>
                                    <asp:ListItem>ZAPAYAN                              </asp:ListItem>
                                    <asp:ListItem>ZARAGOZA                             </asp:ListItem>
                                    <asp:ListItem>ZARZAL                               </asp:ListItem>
                                    <asp:ListItem>ZETAQUIRA                            </asp:ListItem>
                                    <asp:ListItem>ZIPACON                              </asp:ListItem>
                                    <asp:ListItem>ZIPAQUIRA                            </asp:ListItem>
                                    <asp:ListItem>ZONA BANANERA                        </asp:ListItem>


                                    </asp:DropDownList>


                                </td>
                                <td>
                                   
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style41"><asp:Label id="lblCalle" Text="Calle:" AssociatedControlID="txtCalle" Runat="server" CssClass="labelParametros" /></td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style41">
                                    <asp:TextBox ID="txtCalle" runat="server" MaxLength="150" Text="Calle 50 A "></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="ReqValCalle" runat="server" 
                                        ControlToValidate="txtCalle" ForeColor="Red" SetFocusOnError="True">Se Requiere la Calle</asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style41">
                                    <asp:Label id="lblNumero" Text="Numero:" AssociatedControlID="txtNumero" Runat="server" CssClass="labelParametros" />
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style41">
                                    <asp:TextBox ID="txtNumero" runat="server" MaxLength="5" Text="40"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="ReqValNumero" runat="server" 
                                        ControlToValidate="txtNumero" ForeColor="Red" SetFocusOnError="True">Se Requiere el Número</asp:RequiredFieldValidator>
                                   
                                    
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        <br />
                        <br /><br />
                        
                        <br />
                        <br /><br />
                        
                        <br />
                    </asp:Panel>
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepElectrica" runat="server" 
                    Title="Direccion Electrica">
                    <asp:Label id="lblDirElectrica" CssClass="labelTitulo"  Text="Direccion Electrica"  Runat="server" /> 
                    <asp:Panel ID="PanelDirElectrica" runat="server" Height="235px" >
                        <br />
                        <table style="width:100%;">
                            <tr>
                                <td class="style42">
                                    <asp:Label ID="lblSubEstacion" runat="server" 
                                        AssociatedControlID="txtSubEstacion" CssClass="labelParametros" 
                                        Text="SubEstación:"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style42">
                                    <asp:TextBox ID="txtSubEstacion" runat="server" MaxLength="200" 
                                        Text="Las Lomas"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="ReqValSubEsta" runat="server" 
                                        ControlToValidate="txtSubEstacion" ForeColor="Red" SetFocusOnError="True">Se Requiere la SubEstación</asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style42">
                                    <asp:Label ID="lblCircuito" runat="server" AssociatedControlID="txtCircuito" 
                                        CssClass="labelParametros" Text="Circuito:"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style42">
                                    <asp:TextBox ID="txtCircuito" runat="server" MaxLength="200" Text="14"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="ReqValCircuito" runat="server" 
                                        ControlToValidate="txtCircuito" ForeColor="Red" SetFocusOnError="True">Se Requiere el Circuito</asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style42">
                                    <asp:Label ID="lblTramo" runat="server" AssociatedControlID="txtTramo" 
                                        CssClass="labelParametros" Text="Tramo:"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style42">
                                    <asp:TextBox ID="txtTramo" runat="server" MaxLength="100" Text="20"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="ReqValTramo" runat="server" 
                                        ControlToValidate="txtTramo" ForeColor="Red" SetFocusOnError="True">Se Requiere el Tramo</asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                        
                    </asp:Panel>
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepGPS" runat="server" Title="Direccion GPS">
                    <br />
                    <asp:Label id="lblDirGPS" CssClass="labelTitulo"  Text="Direccion GPS"  Runat="server" /> 
                    <asp:Panel ID="PanelDirGPS" runat="server" >
                        <br />
                        <table style="width:100%;">
                            <tr>
                                <td class="style43">
                                    <asp:Label ID="lblLatitud" runat="server" AssociatedControlID="txtLatitud" 
                                        CssClass="labelParametros" Text="Latitud:"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style43">
                                    <asp:TextBox ID="txtLatitud" runat="server" Text="15.0" MaxLength="6"  Width="60px"></asp:TextBox> 
                                </td>
                                <td>
                                    Formato  0° to (+/–)90°  </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style43">
                                    <asp:Label ID="lblLongitud" runat="server" AssociatedControlID="txtLongitud" 
                                        CssClass="labelParametros" Text="Longitud:"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style43">
                                    <asp:TextBox ID="txtLongitud" runat="server" Text="20.0" MaxLength="6"  Width="60px"></asp:TextBox>
                                </td>
                                <td>
                                    Formato 0° to (+/–)180°.</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                        <br />
                        
                       
                    </asp:Panel>
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepParametrosAdicionales" runat="server" 
                    Title="Prms Adicionales">
                    <asp:Label id="lblParAd" CssClass="labelTitulo"  Text="Parametros Adicionales"  Runat="server" /> 
                    <br />
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td width="35%">
                                <asp:Label ID="lblCanalRF" runat="server" AssociatedControlID="txtCanalRF" 
                                    CssClass="labelParametros" Text="Canal RF:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="35%">
                              <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
                            </asp:ScriptManager>
                             <asp:TextBox ID="txtCanalRF" runat="server" MaxLength="2" Width="49px" >1</asp:TextBox>
                                <asp:NumericUpDownExtender runat="server" TargetButtonUpID="" 
                            TargetButtonDownID="" ServiceUpMethod="" ServiceDownPath="" 
                            ServiceDownMethod="" Minimum="0" Maximum="9" RefValues="" Width="50" Tag="" 
                            Enabled="True" TargetControlID="txtCanalRF" ID="NumericUpDownExtenderCanalRF">
                            </asp:NumericUpDownExtender>
                                <asp:Label ID="lblCanalRF0" runat="server" AssociatedControlID="txtCanalRF" 
                                    CssClass="labelParametros" Text=" (1-10)"></asp:Label>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValCanal" runat="server" 
                                    ControlToValidate="txtCanalRF" ForeColor="Red" SetFocusOnError="True">Se Requiere el Canal RF</asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="RegExpValCanal" runat="server" 
                                    ControlToValidate="txtCanalRF" ForeColor="Red" SetFocusOnError="True" 
                                    ValidationExpression="[0-9]{1,2}">Valor Incorrecto del Canal RF</asp:RegularExpressionValidator>
                                <br />    
                                <asp:RangeValidator ID="RanValCanal" runat="server" ControlToValidate="txtCanalRF"
                            ForeColor="Red" MaximumValue="9" MinimumValue="0" SetFocusOnError="True" Type="Integer"
                            ErrorMessage="Valor Incorrecto del Canal (1-10)" ValidationGroup="edicionFWT">*</asp:RangeValidator>
                            </td>
                        </tr>
                        <tr>
                            <td width="35%">
                                <asp:Label ID="lblNUmeroMaximoFCI" runat="server" 
                                    AssociatedControlID="txtNumeroMaximoFCI" CssClass="labelParametros" 
                                    Text="Número Máximo FCI:"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td width="35%">
                                <asp:TextBox ID="txtNumeroMaximoFCI" runat="server" Text="18"  MaxLength="2" CssClass="textBoxHora"></asp:TextBox>
                                <asp:Label ID="lblNUmeroMaximoFCI0" runat="server" AssociatedControlID="txtNumeroMaximoFCI" CssClass="labelParametros" Text=" (1-18)"></asp:Label>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="ReqValQtyFci" runat="server" 
                                    ControlToValidate="txtNumeroMaximoFCI" ForeColor="Red" SetFocusOnError="True">Se Requiere Máximo de FCIs</asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="RegExValQtyFci" runat="server" 
                                    ControlToValidate="txtNumeroMaximoFCI" ForeColor="Red" SetFocusOnError="True" 
                                    ValidationExpression="[0-9]{1,2}">Valor Incorrecto en Número de FCIs</asp:RegularExpressionValidator>
                                <br />
                                <asp:RangeValidator ID="RanValQtyFci" runat="server" 
                                    ControlToValidate="txtNumeroMaximoFCI" ForeColor="Red" MaximumValue="18" 
                                    MinimumValue="1" SetFocusOnError="True" Type="Integer">Valor Incorrecto en Número Máximo de FCI (1-18)</asp:RangeValidator>
                            </td>
                        </tr>
                    </table>
                    <br />
                        <asp:Label id="lblVecesNoReportar" Text="Veces sin Reportar:" 
                            AssociatedControlID="txtVecesNoReportar" Runat="server" 
                            CssClass="labelParametros" Visible="False" />
                        <br />
                        <asp:TextBox id="txtVecesNoReportar"  Runat="server" Text="10" 
                            CssClass="textBoxHora" MaxLength="2" Visible="False" /> 
                    
               </asp:WizardStep>
               <asp:WizardStep ID="WizardStepDatosIngresados" runat="server" Title="Datos Ingresados" StepType="Finish" >
                <asp:Label id="lblDatosIng" CssClass="labelTitulo"  Text="Estos son los datos ingresados para crear el concentrador:"  Runat="server" /> 
                <br />
                <br />
                
                <%-- El sufijo BD en el nombre de estos controles indica que estos datos se van a grabar en base de datos --%>
                                      
                   <div style="float:left;padding:10px;">
                       Serial =
                       <asp:Label ID="lblSerialBD" runat="server" />
                       <br />
                       Periodo reporte =
                       <asp:Label ID="lblPeriodoRepBD" runat="server" />
                       &nbsp;<br />
                       <br />
                       APN =
                       <asp:Label ID="lblAPNBD" runat="server" />
                       <br />
                       Usuario =
                       <asp:Label ID="lblUserBD" runat="server" />
                       <br />
                       Password =
                       <asp:Label ID="lblPwdBD" runat="server" />
                       <br />
                       <br />
                       Dirección ip Gestión =
                       <asp:Label ID="lblDirIpGesBD" runat="server" />
                       <br />
                       Puerto Gestión =
                       <asp:Label ID="lblPtoGesBD" runat="server" />
                       <br />
                       Dirección ip SCADA =
                       <asp:Label ID="lblDirIpSCADABD" runat="server" />
                       <br />
                       Puerto SCADA =
                       <asp:Label ID="lblPtoSCADABD" runat="server" />
                   </div >
                
                  <div style="float:left;padding:10px;"  >
                       Ciudad =
                       <asp:Label ID="lblCiudadBD" runat="server" />
                       <br />
                       Calle =
                       <asp:Label ID="lblCalleBD" runat="server" />
                       <br />
                       Número =
                       <asp:Label ID="lblNumeroBD" runat="server" />
                       <br />
                       <br />
                       Subestación =
                       <asp:Label ID="lblSubEsBD" runat="server" />
                       <br />
                       Circuito =
                       <asp:Label ID="lblCircuitoBD" runat="server" />
                       <br />
                       Tramo =
                       <asp:Label ID="lblTramoBD" runat="server" />
                       <br />
                       <br />
                       Latitud =
                       <asp:Label ID="lblLatitudBD" runat="server" />
                       <br />
                       Longitud =
                       <asp:Label ID="lblLongitudBD" runat="server" />
                       <br />
                       <br />
                       Canal RF =
                       <asp:Label ID="lblCanalRFBD" runat="server" />
                       <br />
                       <!--  Veces sin reportarse =  -->
                       <asp:Label ID="lblVecesNoBD" runat="server" Visible="false" />
                       Número Máximo de FCIs =
                       <asp:Label ID="lblNumeroMaximoFCIBD" runat="server" />
                     </div  >
                  <br />
                   <div style="float:left;padding:10px;">
                       <asp:Label ID="Label1" CssClass="labelTitulo" Text="De click en Finalizar para crear el Concentrador."
                           runat="server" />
                   </div >
                 
               </asp:WizardStep>
               <asp:WizardStep  ID="WizardStepConcentradorIngresado" runat="server" 
                    Title="Concentrador Ingresado" StepType="Complete"> 
               <center><asp:Label id="lblConcentradorIngresado" CssClass="labelTitulo" Runat="server" /></center> 
               
               </asp:WizardStep>

            </WizardSteps>
        </asp:Wizard>
        </div>
              
    </div>
    </form>
</body>
</html>
