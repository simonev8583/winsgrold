<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetallePrmsFCI.aspx.cs" Inherits="SistemaGestionRedes.PagesEquipment.DetallePrmsFCI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
<style type="text/css">
 
 .labelTitulo
 {
 	font-weight:bold;
 }
 
 .textBoxHora
 {
     width:20px;
 }

 fieldset
{
    margin: 1em 0px;
    padding: 1em;
    border: 1px solid #ccc;
}

legend 
{
    font-size: 1.1em;
    font-weight: 600;
    padding: 2px 4px 8px 4px;
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        <table width="100%">
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <br />

            <table style="width: 100%;" border="0">
               <tr>
                    <td align="center" bgcolor="#eeeeee" colspan="4" >
                       <font><strong><asp:Literal ID="Literal2" Text="<%$ Resources:TextTittleParametros %>" runat="server"></asp:Literal></strong></font>    
                    </td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#eeeeee">
                        <asp:Label ID="Label1" Text="<%$ Resources:TextTittleModoDisparo %>" runat="server" />
                    </td>
                   
                    <td align="center" bgcolor="#eeeeee">
                        <asp:Label ID="Label3" Text="<%$ Resources:TextTittleValorFalla %>" runat="server" />
                    </td>
                    
                    <td align="center" bgcolor="#eeeeee" colspan="2">
                        <asp:Label ID="Label12"  Text="<%$ Resources:TextTittleResetModes %>" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="center"  valign="middle"  >
                         
                         <table style="width: 70%;" border="0">
                         <tr>
                         <td align=left >
                                <asp:RadioButton ID="rdButModoProporcional" Text="<%$ Resources:TextModoDisparoProporcional %>" GroupName="modoDisparo"
                                 runat="server" AutoPostBack="true" Enabled="False"  />
                                <br />
                                <br />
                                <asp:RadioButton ID="rdButModoPorIncremento" Text="<%$ Resources:TextModoDisparoIncremental %>" GroupName="modoDisparo"
                                    runat="server" AutoPostBack="true" Enabled="False"  />
                                <br />
                                <br />
                                <asp:RadioButton ID="rdButModoPorValorFijo" Text="<%$ Resources:TextModoDisparoValorFijo %>" GroupName="modoDisparo"
                                    runat="server" AutoPostBack="true" Enabled="False"  />
                                <br />
                                <br />
                                <asp:RadioButton ID="rdButModoPorAutoRango" Text="<%$ Resources:TextModoDisparoAutorango %>" GroupName="modoDisparo"
                                    runat="server" AutoPostBack="true" Enabled="False"  />
                         </td>
                         </tr>
                         </table>
                    
                    </td>
                    <td align="center" valign="middle" >
                        <asp:Label ID="lblNombreValorFalla" CssClass="labelTitulo" runat="server" Text="DeltaI (di/dt) : " /><br />
                        <asp:TextBox ID="txtValorFalla" runat="server" CssClass="textBoxHora" 
                            Width="40px" MaxLength="4" ViewStateMode="Enabled" Enabled="False"></asp:TextBox>
                        <br />
                        <asp:Label runat="server" Text="2-100 Veces" Font-Size="11px" ID="lblUnids"></asp:Label>
                        <br />
                        
                        &nbsp;<asp:Label ID="Label5" runat="server" Text="Aqui Hay Val Objs" Visible="False"></asp:Label>
                        <br />
                        
                    </td>
               
                    
                    <td colspan="2" >
                       
                         <fieldset > <legend><asp:Literal ID="Literal3" Text="<%$ Resources:TextModosResetPorTiempo %>" runat="server"></asp:Literal></legend>
                            <center>
                            <table style="width: 80%;" border="0">
                            <tr>
                                <td align="right" style="width:40%;" >
                                    <asp:Literal ID="Literal4" Text="<%$ Resources:TextModosResetPorTiempoHabilitado %>" runat="server"></asp:Literal>:
                                </td>
                                <td align="left" style="width:40%;" >
                                <asp:CheckBox ID="chkBoxRepTiempo" runat="server" Enabled="False" />
                                </td>
                            </tr>
                            <tr>
                                <td  align="right" style="width:40%;">
                                    <asp:Literal ID="Literal5" Text="<%$ Resources:TextModosResetPorTiempoTpoFallaTemp %>" runat="server"></asp:Literal>:
                                </td>
                                <td  align="left" style="width:40%;">
                                        <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoIndicacionFallatemp"
                                     Width="40px" MaxLength="5" ToolTip="Tiempo Indicación Falla Temporal" 
                                            Enabled="False"></asp:TextBox>
                                &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextosGlobales,TextoSegundos %>" Font-Size="11px" ID="Label8"></asp:Label>
                                &nbsp;&nbsp;&nbsp;<!-- El tiempo se recibe en segundos maximo un dia 1440 minutos   --></td>
                            </tr>
                             <tr>
                                <td align="right" style="width:40%;" >
                                    <asp:Literal ID="Literal6" Text="<%$ Resources:TextModosResetPorTiempoTpoFallaPerm %>" runat="server"></asp:Literal>:
                                </td>
                                <td align="left" style="width:40%;">
                                            <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoReposicion" 
                                        Width="40px" MaxLength="5" ToolTip="Tiempo Reposición" Enabled="False"></asp:TextBox>
                                    &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextosGlobales,TextoSegundos %>" Font-Size="11px" ID="Label11"></asp:Label>
                                    &nbsp;&nbsp;&nbsp;</td>
                            </tr>
                            </table>
                            </center>
                        
                         </fieldset> 
                     
                            <fieldset > <legend><asp:Literal ID="Literal7" Text="<%$ Resources:TextModosResetPorTension %>" runat="server"></asp:Literal></legend> 
                            <center>
                            <table style="width: 80%;" border="0">
                            <tr>
                                <td align="right" style="width:40%;" >
                                    <asp:Literal ID="Literal8" Text="<%$ Resources:TextModosResetPorTensionHabilitado %>" runat="server"></asp:Literal>
                                </td>
                                <td align="left" style="width:40%;" >
                                <asp:CheckBox ID="chkBoxRepTension" runat="server" Enabled="False" />
                                </td>
                            </tr>
                            <tr>
                                <td  align="right" style="width:40%;">
                                    <asp:Literal ID="Literal9" Text="<%$ Resources:TextModosResetPorTensionToleraciaTension %>" runat="server"></asp:Literal>:
                                </td>
                                <td  align="left" style="width:40%;">
                                            <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtToleranciaTensionReposicion"
                                     Width="30px" MaxLength="3" ToolTip="Tolerancia Tensión Reposición. " Enabled="False"></asp:TextBox>
                                &nbsp;<asp:Label runat="server" Text="%" Font-Size="12px" ID="Label7"></asp:Label>
                                &nbsp;&nbsp;&nbsp;</td>
                            </tr>
                             <tr>
                                <td align="right" style="width:40%;">
                                    <asp:Literal ID="Literal10" Text="<%$ Resources:TextModosResetPorTensionTiemporetardoVal %>" runat="server"></asp:Literal>:
                                </td>
                                <td align="left" style="width:40%;" >
                                           <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoRetardoValidacionTension"
                                     Width="30px" MaxLength="3" ToolTip="Tiempo Retardo Validación Tensión" 
                                               Enabled="False"></asp:TextBox>
                                &nbsp;<asp:Label runat="server" 
                                               Text="<%$ Resources:TextModosResetPorTensionUnidsTiemporetardo %>" 
                                               Font-Size="11px" ID="Label13"></asp:Label>
                                &nbsp;&nbsp;&nbsp;</td>
                            </tr>
                            </table>
                                    </center>                
                      


                        </fieldset>
                         <fieldset > <legend><asp:Literal ID="Literal11" Text="<%$ Resources:TextModosResetPorImanCte %>" runat="server"></asp:Literal></legend> 

                         <center>
                            <table style="width: 80%;" border="0">
                            <tr>
                                <td align="right" style="width:40%;" >
                                    <asp:Literal ID="Literal12" Text="<%$ Resources:TextModosResetPorImanCteHabilitado %>" runat="server"></asp:Literal>
                                </td>
                                <td align="left" style="width:40%;" >
                                <asp:CheckBox ID="chkBoxRepMagneto" runat="server" Enabled="False" Text="<%$ Resources:TextModosResetPorImanCtePorIman %>" /><br />
                                 <asp:CheckBox ID="chkBoxRepCorriente" runat="server" Text="<%$ Resources:TextModosResetPorImanCtePorCorriente %>" 
                                        Enabled="False" />
                                </td>
                            </tr>


                            </table>

                       </center>
                       
                        </fieldset>

                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center" bgcolor="#eeeeee">
                       <asp:Literal ID="Literal13" Text="<%$ Resources:TextTittleTiempos %>" runat="server"></asp:Literal>
                    </td>
                    
                    <td colspan="2" align="center" bgcolor="#eeeeee">
                       <asp:Literal ID="Literal16" Text="<%$ Resources:TextTittleActivaciones %>" runat="server"></asp:Literal> 
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top">
                        <asp:Literal ID="Literal14" Text="<%$ Resources:TextTittleTiemposInrushProteccion %>" runat="server"></asp:Literal> 
                    </td>
                    <td valign="top">
                        <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoProteccionInRush"
                             Width="30px" MaxLength="3" ToolTip="Tiempo Protección InRush" 
                            Enabled="False"></asp:TextBox>
                        &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextTittleTiemposUnidsInrushProteccion %>" Font-Size="11px" ID="Label10"></asp:Label>
                        &nbsp;&nbsp;&nbsp;</td>
                   
                    <td>
                       
                        <asp:Literal ID="Literal17" Text="<%$ Resources:TextTittleActivacionesReloj %>" runat="server"></asp:Literal>
                        <br />
                        <asp:Literal ID="Literal18" Text="<%$ Resources:TextTittleActivacionesFallaTemporal %>" runat="server"></asp:Literal>
                    </td>
                    <td>
                       
                            <asp:CheckBox ID="chkBoxHabReloj" runat="server" Checked="true" 
                                Enabled="false" />
                            <br />
                            <asp:CheckBox ID="chkBoxHabFallaTrans" runat="server" Enabled="False" />
                    </td>
                </tr>
                  <tr>
                    <td align="left" valign="top">
                         <asp:Literal ID="Literal15" Text="<%$ Resources:TextTittleTiemposValidacionFalla %>" runat="server"></asp:Literal>
                    </td>
                    <td valign="top">
                      <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoValFalla" 
                            Width="30px" MaxLength="3" Enabled="False"></asp:TextBox>&nbsp;
                            <asp:Label runat="server" Text="<%$ Resources:TextTittleTiemposUnidsValidacionFalla %>" Font-Size="11px" ID="Label6"></asp:Label>
                        &nbsp;&nbsp;&nbsp;</td>

                    <td colspan="2"  align="center" bgcolor="#eeeeee">
                        <asp:Literal ID="Literal19" Text="<%$ Resources:TextTittleCorrientes %>" runat="server"></asp:Literal> 
                    </td>
                   
                  
                       
                    
                </tr>
                <tr>
                    <td align="left" valign="top">
                     </td>
                    <td valign="top">
                      
                    </td>
                    <td>
                        <asp:Literal ID="Literal20" Text="<%$ Resources:TextTittleCorrientesCorrienteAbsoluta %>" runat="server"></asp:Literal>
                    </td>
                   
                    <td>
                       
                      <asp:TextBox ID="txtCorrienteAbsolutaDisparo" runat="server" 
                            CssClass="textBoxHora" MaxLength="4"  
                            ToolTip="Corriente Absoluta Disparo" Width="40px" Enabled="False"></asp:TextBox>
                        &nbsp;<asp:Label ID="Label14" runat="server" Text="<%$ Resources:TextTittleCorrientesUnidsCteAbsoluta %>"></asp:Label>
                        &nbsp;&nbsp;&nbsp;</tr>
                <tr>
                    <td colspan="2" align="center" bgcolor="#eeeeee">
                     <asp:Label ID="Label20"  Text="<%$ Resources:TextTittleAutonomiaBatNormal %>" runat="server" />
                        
                    </td>
                    <td colspan="2" align="center" bgcolor="#eeeeee">
                        
                    <asp:Label ID="Label4"  Text="<%$ Resources:TextTittleAutonomiaBatDestello %>" runat="server" />
                        
                    </td>
                </tr>
                <tr>
                    <td valign =top  >
                        <asp:Literal ID="Literal21" Text="<%$ Resources:TextTittleAutonomiaEnfuncionamiento %>" runat="server"></asp:Literal>:
                    </td>
                    <td valign =top>
                         <asp:Button ID="btnCalcularAutNormal" runat="server" 
                            Text="<%$ Resources:TextTittleAutonomiaBotonAutonomiaNormal %>" Height="26px" 
                             /><br />
                        <asp:Label ID="lblAutonomiaFuncionamiento" runat="server" /><br />
                        <asp:Label ID="lblAutonomiaFuncionamientoDias" runat="server" /><br />
                        <asp:Label ID="lblAutonomiaFuncionamientoAnios" runat="server" />
                       
                       
                    </td>
                    <td valign =top>
                        <asp:Literal ID="Literal22" Text="<%$ Resources:TextTittleAutonomiaBatDestelloLabel %>" runat="server"></asp:Literal>
                    </td>
                    <td valign =top>
                        <asp:Button ID="btnCalcAutonoBat" runat="server" Height="26px"
                             Text="<%$ Resources:TextTittleAutonomiaBatDestelloEstimar %>"  /><br />
                            <asp:Label ID="lblAutonomiaBattInst" runat="server" /><br />
                            <asp:Label ID="lblAutonomiaBattInstDias" runat="server" /><br />
                            <asp:Label ID="lblAutonomiaBattInstAnios" runat="server" />
                        
                    </td>
                    
                </tr>
                                <tr>
                    <td colspan="2" >
                        &nbsp;</td>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td >
                        <asp:Literal ID="Literal23" Text="<%$ Resources:TextTittleAutonomiaBatNormalRetriesComms %>" runat="server"></asp:Literal>
                        
                    </td>
                    <td >
                     <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtNumeroReintentosComunicaciones"
                             MaxLength="2" Width="30px" ToolTip="Número Reintentos Comunicaciones" 
                            Enabled="False"></asp:TextBox>
                        &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextTittleAutonomiaBatNormalUnidsRetries %>" ID="Label15"></asp:Label>
                        &nbsp;&nbsp;&nbsp;</td>
                    <td >
                        <asp:Label ID="Label22" runat="server" Text="<%$ Resources:TextTittleAutonomiaBatDestelloDurDestello %>"></asp:Label>
                    </td>
                    <td>
                       
                        <asp:TextBox ID="txtTiempoFlashIndicacion" runat="server" 
                            CssClass="textBoxHora" MaxLength="3"  
                            Width="30px" Enabled="False"></asp:TextBox>
                        <asp:Literal ID="Literal25" Text="<%$ Resources:TextTittleAutonomiaBatDestelloUnidsDurDestello %>" runat="server"></asp:Literal>  &nbsp;&nbsp;
                    </td>
                   
                </tr>
                <tr>
                    <td>
                        <asp:Literal ID="Literal24" Text="<%$ Resources:TextTittleAutonomiaBatNormalConnectPeriod %>" runat="server"></asp:Literal> 
                    </td>
                                            
                    </td>
                    <td>
                        
                   <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtSegundosProximaComunicacion"
                             Width="40px" MaxLength="4" ToolTip="Segundos para Proxima Comunicación" 
                            Enabled="False"></asp:TextBox>
                        &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextTittleAutonomiaBatNormalUnidsConnectPeriod %>" ID="Label16"></asp:Label>
                        &nbsp;&nbsp;&nbsp;</td>
                    <td>
                         <asp:Literal ID="Literal26" Text="<%$ Resources:TextTittleAutonomiaBatDestelloTpoEntreDeste %>" runat="server"></asp:Literal>
                    </td>
                    <td>
                        <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtTiempoEntreFlashIndicacion"
                             Width="30px" MaxLength="2" Enabled="False"></asp:TextBox>
                        &nbsp;<asp:Label runat="server" Text="<%$ Resources:TextTittleAutonomiaBatDestelloUnidsEntreDes %>" Font-Size="11px" ID="Label9"></asp:Label>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    
                </tr>
                <tr>
                
                    <td colspan="2" align="right" bgcolor="#eeeeee">
                        <asp:Literal ID="Literal27" Text="<%$ Resources:TextCapacidadBateria %>" runat="server"></asp:Literal>
                    
                    </td>
                    <td colspan ="2" bgcolor="#eeeeee">
                          <asp:TextBox runat="server" CssClass="textBoxHora" ID="txtCapacidadBateria" MaxLength="5"
                             Width="60px" ToolTip="Capacidad Bateria Instalada" Enabled="False"></asp:TextBox>
                        &nbsp;<asp:Label runat="server" Text="mA/h" ID="Label17"></asp:Label>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    
                </tr>
                
            </table>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
        <br />
    
    </div>
    </form>
</body>
</html>
