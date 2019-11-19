<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetallePrmsFWT.aspx.cs" Inherits="SistemaGestionRedes.PagesEquipment.DetallePrmsFWT" %>

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
    <div>
    
        <br />


            <table border="0" width="100%">
                <tr>
                    <td align="center" bgcolor="#eeeeee" colspan="4" width="11%">
                        <font><strong><asp:Literal ID="Literal7" Text="<%$ Resources:TextTittleConectividad %>" runat="server"></asp:Literal></strong></font>
                    </td>
                </tr>
                <tr>
                    <td valign="top" width="11%" align="right">
                       
                        <asp:Label ID="Label22" runat="server" Text="<%$ Resources:TextDirIp %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                       
                    </td>
                    <td valign="top" width="11%">
                        <asp:TextBox ID="txtIpGestion" runat="server" CssClass="textInUsuario" 
                            MaxLength="15" Width="90px" 
                            Enabled="False"></asp:TextBox>
                        &nbsp;&nbsp;</td>
                    <td valign="top" width="18%" align="right">
                        
                      <asp:Label ID="Label48" runat="server" Text="<%$ Resources:TextEsperaPaquete %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                        
                    </td>
                    
                    <td valign="top" width="15%">
                        
                       <asp:TextBox ID="txtTiempoEsperaPaqueteDeSGR" runat="server"
                            CssClass="textInUsuario" MaxLength="3" Width="20px" 
                            
                            ToolTip="Tiempo en segundos que el FWT espera para recibir la respuesta de un paquete enviado al SGR ." 
                            Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label49" runat="server" Text="(1-520)S" Font-Size="9px" 
                            CssClass="txtLabelPrms"></asp:Label>

                        &nbsp;&nbsp;</td>

                    
                </tr>
                <tr>
                    <td valign="top" width="11%" align="right">
                      
                        <asp:Label ID="Label23" runat="server" Text="<%$ Resources:TextPuerto %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                      
                    </td>
                    <td valign="top" width="11%">
                       
                        <asp:TextBox ID="txtPuertoGestion" runat="server" CssClass="textInUsuario" 
                            MaxLength="5" Width="50px" 
                            Enabled="False"></asp:TextBox>
                        &nbsp;
                        &nbsp;&nbsp;</td>
                    <td valign="top" width="18%" align="right">
                        
                        <asp:Label ID="Label46" runat="server" Text="<%$ Resources:TextIntentosPaquetes %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                        
                    </td>
                    <td valign="top" width="15%">
                        
                        <asp:TextBox ID="txtMaxNumeroReintentosPack" runat="server" 
                            CssClass="textInUsuario" MaxLength="3" 
                             Width="20px" 
                            
                            ToolTip="Reintentos de reenvío de paquetes que no han recibido respuesta por parte del SGR , si se hacen los reintentos y no hay respuesta el FWT se desconecta ." 
                            Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label47" runat="server" Font-Size="9px" Text="(0-255)" 
                            CssClass="txtLabelPrms"></asp:Label>
                        &nbsp;&nbsp;</td>
                </tr>
                <tr>
                    <td valign="top" width="11%" align="right">
                       
                        <asp:Label ID="Label19" runat="server" Text="APN" CssClass="txtLabelPrms"></asp:Label>
                       
                    </td>
                    <td valign="top" width="11%">
                        
                        <asp:TextBox ID="txtAPN" runat="server" CssClass="textInUsuario" Width="100px" 
                            Enabled="False"></asp:TextBox>
                        &nbsp;</td>
                    <td valign="top" width="18%" align="right">
                       
                        <asp:Label ID="Label44" runat="server" 
                            Text="<%$ Resources:TextAntesReconexion %>" CssClass="txtLabelPrms"></asp:Label>
                       
                    </td>
                    <td valign="top" width="15%">
                        
                        <asp:TextBox ID="txtSecondsBeforeRetryConnection" runat="server" 
                            CssClass="textInUsuario" MaxLength="3" 
                             Width="20px" Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label45" runat="server" Font-Size="9px" Text="(1-520)S" 
                            CssClass="txtLabelPrms"></asp:Label>
                        &nbsp;&nbsp;</td>
                </tr>
                <tr>
                    <td valign="top" width="11%" align="right">
                        
                        <asp:Label ID="Label20" runat="server" Text="<%$ Resources:TextUsuarioAPN %>" CssClass="txtLabelPrms"></asp:Label>
                        
                    </td>
                    <td valign="top" width="11%">
                       
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="textInUsuario" 
                            Width="100px" Enabled="False"></asp:TextBox>
                       
                    </td>
                    <td valign="top" width="18%" align="right">
                        
                       
                        <asp:Label ID="Label50" runat="server" 
                            Text="<%$ Resources:TextIntentosConexion %>" CssClass="txtLabelPrms"></asp:Label>
                    </td>
                    <td valign="top" width="15%">
                        
                      
                        
                         <asp:TextBox ID="txtMaxNumeroReintentosConexionToSGR" runat="server" 
                            CssClass="textInUsuario" MaxLength="3" 
                             Width="20px" Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label51" runat="server" Font-Size="9px" Text="(0-255)" 
                             CssClass="txtLabelPrms"></asp:Label>
                        &nbsp;&nbsp;</td>
                </tr>
                <tr>
                    <td valign="top" width="11%" align="right">
                        
                        <asp:Label ID="Label21" runat="server" Text="Password" CssClass="txtLabelPrms"></asp:Label>
                        <br />
                        
                    </td>
                    <td valign="top" width="11%">
                        
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="textInUsuario" 
                            Width="90px" Enabled="False"></asp:TextBox>
                        &nbsp;
                        <br />
                        </td>
                    <td width="18%" align="right">
                       
                        
                       
                        <asp:Label ID="Label52" runat="server" 
                            Text="<%$ Resources:TextPeriodoReporte %>" CssClass="txtLabelPrms"></asp:Label>
                       
                        
                       
                    </td>
                    <td width="15%">
                        
                       
                        
                        <asp:TextBox ID="txtPeriodoReporteSeg" runat="server" CssClass="textInUsuario" 
                            MaxLength="5" Width="30%" 
                            Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label53" runat="server" Font-Size="9px" Text="(60-86400)S" 
                            CssClass="txtLabelPrms"></asp:Label>
                        &nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
                
               
                <tr>
                    <td valign="top" width="11%" align="right">
                        
                        <asp:Label ID="Label66" runat="server" Text="<%$ Resources:TextBandaGSM %>" CssClass="txtLabelPrms"></asp:Label>
                        
                    </td>
                    <td valign="top" width="11%">
                        
                        <asp:DropDownList ID="prmDDLBandaGsm" runat="server" Font-Size="11px" 
                            Width="100px" Enabled="False">
                            <asp:ListItem Value="0">PGSM_MODE</asp:ListItem>
                            <asp:ListItem Value="1">DCS_MODE</asp:ListItem>
                            <asp:ListItem Value="2">PCS_MODE</asp:ListItem>
                            <asp:ListItem Value="3">EGSM_DCS_MODE</asp:ListItem>
                            <asp:ListItem Value="4">GSM850_PCS_MODE</asp:ListItem>
                        </asp:DropDownList>
                        
                    </td>
                    <td width="18%" align="right">
                       
                        
                       
                        <asp:Label ID="Label15" runat="server" Text="<%$ Resources:TextCanalRF %>" CssClass="txtLabelPrms"></asp:Label>
                    </td>
                    <td width="15%">
                        
                       
                        
                        <asp:TextBox runat="server" ID="txtCanalRF" CssClass="textInUsuario"
                            MaxLength="2" Width="49px" Enabled="False"  ></asp:TextBox>
                    </td>
                </tr>
                
               
                <tr>
                    <td valign="top" width="11%" align="right">
                        
                        <asp:Label ID="Label70" runat="server" Text="<%$ Resources:TextLeerCteSix %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                        
                    </td>
                    <td valign="top" width="11%">
                        
                        <asp:TextBox runat="server" ID="txtPrmReporteCteSix" CssClass="textInUsuario"
                            Width="30px" MaxLength="4" Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label71" runat="server" Text="(10-480)S" 
                            Font-Size="9px"></asp:Label>

                        </td>
                    <td width="18%" align="right">
                       
                        
                       
                        <asp:Label ID="Label16" runat="server" Text="<%$ Resources:TextCantidadFCIs %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                    </td>
                    <td width="15%">
                        
                       
                        
                        <asp:TextBox runat="server" ID="txtNumeroMaximoFCI" CssClass="textInUsuario"
                            Width="30px" MaxLength="2" Enabled="False"></asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td valign="top" width="11%" align="right">
                        
                        
                    </td>
                    
                    <td valign="top" width="11%">
                        
                    </td>
                    
                    <td width="18%" align="right">
                        <asp:Label ID="lblPrmQtySix" runat="server" Text="<%$ Resources:TextCantidadSIXs %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                    </td>
                    <td width="15%">
                        
                        <asp:TextBox runat="server" ID="txtNumeroMaximoSIX" CssClass="textInUsuario" 
                            Width="30px" MaxLength="2">0</asp:TextBox>
                    </td>
                </tr>
                
               
                </table>
            <br />
        <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center" bgcolor="#EEEEEE" colspan="4" width="32%">
                        <font><strong><asp:Literal ID="Literal8" Text="<%$ Resources:TextTittleParametrosFuentes %>" runat="server"></asp:Literal></strong></font>
                    </td>
                    <td align="center" bgcolor="#EEEEEE" width="18%">
                        &nbsp;</td>
                    <td align="center" bgcolor="#EEEEEE" width="32%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="32%" align="right">
                        <asp:Label ID="Label55" runat="server" Text="<%$ Resources:TextVoltajeMinCargador %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                    </td>
                    <td width="18%">
                        <asp:TextBox ID="txtPrmVoltajeMinNivelCargador" runat="server"
                            CssClass="textInUsuario" MaxLength="4" Width="30px" Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label60" runat="server" Text="(11-16,5)V" 
                            CssClass="txtLabelPrms"></asp:Label>

                    &nbsp;&nbsp;&nbsp;</td>
                    <td width="18%" align="right">
                        <asp:Label ID="Label58" runat="server" Text="<%$ Resources:TextVoltajeBatBaja %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                    </td>
                    <td width="32%">
                        <asp:TextBox ID="txtPrmVoltajeLowBatt" runat="server" CssClass="textInUsuario"
                            MaxLength="4"  Width="30px" Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label63" runat="server" Text="(11,8-12,3)V" 
                            CssClass="txtLabelPrms"></asp:Label>

                    </td>
                </tr>
                <tr>
                    <td width="32%" align="right">
                        <asp:Label ID="Label56" runat="server" Text="<%$ Resources:TextVoltajeMinPanel %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                    </td>
                    <td width="18%">
                        <asp:TextBox ID="txtPrmVoltajeMinNivelPanel" runat="server" 
                            CssClass="textInUsuario" MaxLength="3"  Width="30px" Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label61" runat="server" Text="(2,0-3,0)V" 
                            CssClass="txtLabelPrms"></asp:Label>

                    &nbsp;&nbsp;&nbsp;</td>
                    <td width="18%" align="right">
                        <asp:Label ID="Label59" runat="server" Text="<%$ Resources:TextCorrienteBateria %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                    </td>
                    <td width="32%">
                        <asp:TextBox ID="txtPrmCorrienteBateria" runat="server" 
                            CssClass="textInUsuario" MaxLength="2"  Width="30px" Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label64" runat="server" Text="(7-10)A" CssClass="txtLabelPrms"></asp:Label>

                    </td>
                </tr>
                <tr>
                    <td width="32%" align="right">
                        <asp:Label ID="Label57" runat="server" Text="<%$ Resources:TextVoltajeMinBateria %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                    </td>
                    <td width="18%">
                        <asp:TextBox ID="txtPrmvoltajeMinBateria" runat="server"
                            CssClass="textInUsuario" MaxLength="4"  Width="30px" Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label62" runat="server" Text="(11,7-12)V" 
                            CssClass="txtLabelPrms"></asp:Label>

                    &nbsp;&nbsp;&nbsp;</td>
                    <td width="18%" align="right">
                        <asp:Label ID="Label67" runat="server" Text="<%$ Resources:TextRevisarFuentes %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                    </td>
                    <td width="32%">
                        <asp:TextBox ID="txtPrmPeriodoRevisionFuentes" runat="server" 
                            CssClass="textInUsuario" MaxLength="4"  Width="40px" Enabled="False"></asp:TextBox>
                        <asp:Label ID="Label69" runat="server" Text="(5-60)Segs" 
                            CssClass="txtLabelPrms"></asp:Label>

                    </td>
                </tr>
                <tr>
                    <td width="32%" align="right">
                        &nbsp;</td>
                    <td width="18%">

                    &nbsp;&nbsp;
                        &nbsp;
                        
                    </td>
                    <td width="18%" align="right">
                        <asp:Label ID="Label68" runat="server" Text="<%$ Resources:TextProcCargaBateria %>" 
                            CssClass="txtLabelPrms"></asp:Label>
                        
                    </td>
                    <td width="32%">
                        <asp:CheckBox ID="prmChkProcesoCargaBateria" runat="server" Enabled="False" />

                    </td>
                </tr>
                </table>
            <br />
            <table border="0" width="100%">
                <tr>
                 <td valign="top" width="6%" align="center" bgcolor="#EEEEEE" colspan="4" 
                        style="visibility: hidden">
                        <font><strong>SCADA</strong></font>
                    </td>
                </tr>
                
                <tr>
                 <td valign="top" width="6%">
                        <asp:Label ID="Label24" runat="server" Font-Size="12px" Text="Dir IP SCADA" 
                            Visible="False"></asp:Label>
                    </td>
                    <td valign="top" width="24%">
                        <asp:TextBox ID="txtIpSCADA" runat="server" CssClass="textInUsuario" 
                            MaxLength="15" Visible="False" 
                            Width="95px" Enabled="False"></asp:TextBox>
                        &nbsp;
                        &nbsp;</td>
                    <td valign="top" width="6%">
                        <asp:Label ID="Label25" runat="server" Font-Size="12px" Text="Puerto SCADA" 
                            Visible="False"></asp:Label>
                    </td>
                    <td valign="top" width="14%">
                        <asp:TextBox ID="txtPuertoSCADA" runat="server" CssClass="textInUsuario" 
                            MaxLength="5" Width="50px" 
                            Visible="False" Enabled="False"></asp:TextBox>
                        &nbsp;
                        &nbsp;&nbsp;</td>
                </tr>
                
            </table>
           
        <br />
    
    </div>
    </form>
    <p>
        &nbsp;</p>
</body>
</html>
