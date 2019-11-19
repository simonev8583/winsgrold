<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TemplatesFWT.aspx.cs" Inherits="SistemaGestionRedes.TemplatesFWT" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="centerDiv" align="center">

    Id Plantilla Concentrador : <asp:DropDownList runat="server" 
            ID="ddlPlantillasFWT" 
            onselectedindexchanged="ddlPlantillasFWT_SelectedIndexChanged" AutoPostBack="true" ></asp:DropDownList> 
  
    </div>
    <br />
    <div class="centerDiv">
        <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ScriptManager>
       <center>
        <asp:TabContainer ID="tbContainerPlantillasConcentrador" runat="server" 
            ActiveTabIndex="2" Height="200px" Width="700px" BackColor="Silver" >

            <asp:TabPanel ID="tbPanelGeneral" runat="server" HeaderText="General">
                <ContentTemplate>
                    <div class="centerDiv">
                        <table style="width: 100%;">
                             <tr>
                                <td align="right" style="width: 50%;">
                                 
                                </td>
                                <td align="left">
                                  
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 50%;">
                                    <asp:Label ID="Label1" runat="server" Text="Nombre: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtNombre" runat="server" Width="120px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqValNombrePlantilla" runat="server" ControlToValidate="txtNombre"
                                        SetFocusOnError="True" ErrorMessage="Se Requiere Nombre de Plantilla" ValidationGroup="general"
                                        ForeColor="Red" Font-Size="11px">*</asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="CusValNombrePlantilla" runat="server" ControlToValidate="txtNombre"
                                        OnServerValidate="CheckNombreTemplate" SetFocusOnError="True" ErrorMessage="Nombre de Plantilla ya Existe"
                                        ValidationGroup="general" ForeColor="Red" Font-Size="11px">*</asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label2" runat="server" Text="Canal RF: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtCanalRF" runat="server" MaxLength="1" />
                                    <asp:Label ID="Label3" runat="server" Text="(0-9)"></asp:Label>
                                    <asp:NumericUpDownExtender ID="NumericUpDownExtenderCanalRF" runat="server" TargetControlID="txtCanalRF"
                                        Maximum="9" Minimum="0" Width="50">
                                    </asp:NumericUpDownExtender>
                                    <asp:RangeValidator ID="RanValCanal" runat="server" ControlToValidate="txtCanalRF"
                                        MaximumValue="9" MinimumValue="0" SetFocusOnError="True" Type="Integer" ErrorMessage="Valor Incorrecto del Canal (0-9)"
                                        ValidationGroup="general" ForeColor="Red" Font-Size="11px">*</asp:RangeValidator>
                                    <asp:RequiredFieldValidator ID="ReqValCanal" runat="server" ControlToValidate="txtCanalRF"
                                        SetFocusOnError="True" ErrorMessage="Se Requiere el Canal RF" ValidationGroup="general"
                                        ForeColor="Red" Font-Size="11px">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegExpValCanal" runat="server" ControlToValidate="txtCanalRF"
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,1}" ErrorMessage="Valor Incorrecto del Canal RF"
                                        ValidationGroup="general" ForeColor="Red" Font-Size="11px">*</asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <!--
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label23" runat="server" Text="Veces sin Reportar: "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtVecesNoReportar" runat="server" CssClass="textBoxHora" Width="30px" />

                            </td>
                        </tr>
                        -->
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label4" runat="server" Text="Número Máximo FCI:"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtNumeroMaximoFCI" runat="server" CssClass="textBoxHora" Width="30px" MaxLength="2" />
                                    <asp:Label ID="Label5" runat="server" Text="(1-18)"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValQtyFci" runat="server" ControlToValidate="txtNumeroMaximoFCI"
                                        SetFocusOnError="True" ErrorMessage="Se Requiere Máximo de FCIs" ValidationGroup="general"
                                        ForeColor="Red" Font-Size="11px">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegExValQtyFci" runat="server" ControlToValidate="txtNumeroMaximoFCI"
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,2}" ValidationGroup="general"
                                        ErrorMessage="Valor Incorrecto en Número de FCIs" ForeColor="Red" Font-Size="11px">*</asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RanValQtyFci" runat="server" ControlToValidate="txtNumeroMaximoFCI"
                                        MaximumValue="18" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="general"
                                        ErrorMessage="Valor Incorrecto en Número Máximo de FCI (1-18)" ForeColor="Red"
                                        Font-Size="11px">*</asp:RangeValidator>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">
                                    <asp:ValidationSummary ID="ValSumGeneral" runat="server" ValidationGroup="general"
                                        ForeColor="Red" Font-Size="11px" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:TabPanel>




            <asp:TabPanel ID="tbPanelGPRS" runat="server" HeaderText="GPRS">
                <ContentTemplate>
                
                    <div class="centerDiv">
                        <table style="width: 100%;">
                            <tr>
                                <td align="right" style="width: 50%;">
                                    <asp:Label ID="Label6" runat="server" Text="APN: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtAPN" runat="server" Width="200px" />
                                    <asp:RequiredFieldValidator ID="ReqValAPN" runat="server" ControlToValidate="txtAPN"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px" ErrorMessage="Se Requiere el APN"
                                        ValidationGroup="grupoGPRS">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label7" runat="server" Text="Usuario: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtUsuario" runat="server" Width="100px" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label8" runat="server" Text="Password: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtPassword" runat="server" Width="100px" />
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">
                                    <asp:ValidationSummary ID="ValSumGPRS" runat="server" ValidationGroup="grupoGPRS"
                                        ForeColor="Red" Font-Size="11px" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:TabPanel>



            <asp:TabPanel ID="tbPanelRed" runat="server" HeaderText="Red">
                <ContentTemplate>
                    <div class="centerDiv">
                        <table style="width: 100%;" border="0">
                            <tr>
                                <td align="right" style="width: 50%;">
                                    <asp:Label ID="Label9" runat="server" Text="Dirección ip Gestión: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtIpGestion" runat="server" Width="100px" MaxLength="15"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqValIPGestion" runat="server" ControlToValidate="txtIpGestion"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px" ErrorMessage="Se Requiere IP de Gestión"
                                        ValidationGroup="datosRed">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegExValIPGestion" runat="server" ControlToValidate="txtIpGestion"
                                        ForeColor="Red" SetFocusOnError="True" ValidationExpression="\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"
                                        Font-Size="11px" ErrorMessage="IP de Gestión Incorrecta" ValidationGroup="datosRed">*</asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label10" runat="server" Text="Puerto Gestión: "></asp:Label>
                                </td>
                                <td  align="left">
                                    <asp:TextBox ID="txtPuertoGestion" runat="server" Width="50px" MaxLength="5" />
                                    <asp:RequiredFieldValidator ID="ReqValGestion" runat="server" ControlToValidate="txtPuertoGestion"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px" ErrorMessage="Se Requiere Puerto de Gestión"
                                        ValidationGroup="datosRed">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegExpValPtoGestion" runat="server" ControlToValidate="txtPuertoGestion"
                                        ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{4,5}" Font-Size="11px"
                                        ErrorMessage="Puerto de Gestión Incorrecto" ValidationGroup="datosRed">*</asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RanValPtoGestion" runat="server" ControlToValidate="txtPuertoGestion"
                                        ForeColor="Red" MaximumValue="65535" MinimumValue="1025" SetFocusOnError="True"
                                        Font-Size="11px" ErrorMessage="Mal Definido el Pto Gestión (1025-65535)" ValidationGroup="datosRed">*</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label11" runat="server" Text="Dirección ip SCADA: "></asp:Label>
                                </td>
                                <td  align="left">
                                    <asp:TextBox ID="txtIpSCADA" runat="server" Width="100px" MaxLength="15"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqValIPScada" runat="server" ControlToValidate="txtIpSCADA"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px" ErrorMessage="Se Requiere IP de Scada"
                                        ValidationGroup="datosRed">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegExValIPScada" runat="server" ControlToValidate="txtIpSCADA"
                                        ForeColor="Red" SetFocusOnError="True" ValidationExpression="\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"
                                        Font-Size="11px" ErrorMessage="IP de Scada Incorrecta" ValidationGroup="datosRed">*</asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label12" runat="server" Text="Puerto SCADA: "></asp:Label>
                                </td>
                                <td  align="left">
                                    <asp:TextBox ID="txtPuertoSCADA" runat="server" Width="50px" MaxLength="5" />
                                    <asp:RequiredFieldValidator ID="ReqValPtoScada" runat="server" ControlToValidate="txtPuertoSCADA"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px" ErrorMessage="Se Requiere Puerto de Scada"
                                        ValidationGroup="datosRed">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegExpValPtoScada" runat="server" ControlToValidate="txtPuertoSCADA"
                                        ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{4,5}" Font-Size="11px"
                                        ErrorMessage="Puerto de Scada Incorrecto" ValidationGroup="datosRed">*</asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RanValPtoScada" runat="server" ControlToValidate="txtPuertoSCADA"
                                        ForeColor="Red" MaximumValue="65535" MinimumValue="1025" SetFocusOnError="True"
                                        Font-Size="11px" ErrorMessage="Mal Definido el Pto Scada (1025-65535)" ValidationGroup="datosRed">*</asp:RangeValidator>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">
                                    <asp:ValidationSummary ID="ValSumRed" runat="server" ValidationGroup="datosRed" ForeColor="Red"
                                        Font-Size="11px" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:TabPanel>




            <asp:TabPanel ID="tbPanelNomenclatura" runat="server" HeaderText="Dirección">
                <ContentTemplate>
           
                    <div class="centerDiv">
                        <table style="width: 100%;">
                            <tr>
                                <td align="right" style="width: 50%;">
                                    <asp:Label ID="Label13" runat="server" Text="Ciudad: "></asp:Label>
                                </td>
                                <td align="left" >
                                    <asp:TextBox ID="txtCiudad" runat="server" Width="150px" />
                                    <asp:RequiredFieldValidator ID="ReqValCiudad" runat="server" ControlToValidate="txtCiudad"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px" ErrorMessage="Se Requiere la Ciudad"
                                        ValidationGroup="datosNomenclatura">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label14" runat="server" Text="Calle: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtCalle" runat="server" Width="150px" />
                                    <asp:RequiredFieldValidator ID="ReqValCalle" runat="server" ControlToValidate="txtCalle"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px" ErrorMessage="Se Requiere la Calle"
                                        ValidationGroup="datosNomenclatura">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label15" runat="server" Text="Numero: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtNumero" runat="server" Width="100px" />
                                    <asp:RequiredFieldValidator ID="ReqValNumero" runat="server" ControlToValidate="txtNumero"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px" ErrorMessage="Se Requiere el Número"
                                        ValidationGroup="datosNomenclatura">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegExValNumero" runat="server" ControlToValidate="txtNumero"
                                        ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{1,5}" Font-Size="11px"
                                        ErrorMessage="Valor de Número Incorrecto" ValidationGroup="datosNomenclatura">*</asp:RegularExpressionValidator>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">
                                    <asp:ValidationSummary ID="ValSumNomenclatura" runat="server" ValidationGroup="datosNomenclatura"
                                        ForeColor="Red" Font-Size="11px" />
                                </td>
                            </tr>
                        </table>
                    </div>

                </ContentTemplate>
            </asp:TabPanel>



        
            <asp:TabPanel ID="tbPanelElectrica" runat="server" HeaderText="Localización Electrica">
                <ContentTemplate>
            
                    <div class="centerDiv">
                        <table style="width: 100%;">
                            <tr>
                                <td align="right" style="width: 50%;">
                                    <asp:Label ID="Label16" runat="server" Text="SubEstación: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtSubEstacion" runat="server" Width="150px" />
                                    <asp:RequiredFieldValidator ID="ReqValSubEsta" runat="server" ControlToValidate="txtSubEstacion"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px" ErrorMessage="Se Requiere la SubEstación"
                                        ValidationGroup="datosDirElectrica">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label17" runat="server" Text="Circuito: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtCircuito" runat="server" Width="150px" />
                                    <asp:RequiredFieldValidator ID="ReqValCircuito" runat="server" ControlToValidate="txtCircuito"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px" ErrorMessage="Se Requiere el Circuito"
                                        ValidationGroup="datosDirElectrica">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label18" runat="server" Text="Tramo: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtTramo" runat="server" Width="150px" />
                                    <asp:RequiredFieldValidator ID="ReqValTramo" runat="server" ControlToValidate="txtTramo"
                                        ForeColor="Red" SetFocusOnError="True" Font-Size="11px" ErrorMessage="Se Requiere el Tramo"
                                        ValidationGroup="datosDirElectrica">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">
                                    <asp:ValidationSummary ID="ValSumDirElectrica" runat="server" ValidationGroup="datosDirElectrica"
                                        ForeColor="Red" Font-Size="11px" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    
                </ContentTemplate>
            </asp:TabPanel>



            <asp:TabPanel ID="tbPanelGPS" runat="server" HeaderText="Localización GPS">
                <ContentTemplate>
                    <div class="centerDiv">
                        <table style="width: 100%;">
                            <tr>
                                <td align="right" style="width: 50%;">
                                    <asp:Label ID="Label19" runat="server" Text="Latitud: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtLatitud" runat="server" Width="100px" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label20" runat="server" Text="Longitud: "></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtLongitud" runat="server" Width="100px" />
                                </td>
                            </tr>
                        </table>
                    </div>
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
        
            <asp:Button ID="butActualizar" runat="server" Text="Actualizar" 
                onclick="butActualizar_Click" />
            &nbsp;&nbsp;
            <asp:Button ID="butDelete" runat="server" Text="Borrar" 
                OnClientClick="return confirm('Esta seguro de borrar la plantilla de Concentrador?');" 
                onclick="butDelete_Click" />
        
      
   
    </div>
    </form>
</body>
</html>
