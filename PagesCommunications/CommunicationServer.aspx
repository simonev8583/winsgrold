<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CommunicationServer.aspx.cs" Inherits="SistemaGestionRedes.CommunicationServer" %>
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
   
   
    <div class="rightDivMargLeft">
     <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
     </asp:ScriptManager>
     <asp:TabContainer ID="tbContainerServidorCom" runat="server" 
            ActiveTabIndex="0" Height="210px" BackColor="Silver" >
        <asp:TabPanel ID="tbPanelEstado" runat="server" HeaderText="Estado">
            <ContentTemplate>
             <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%;" >
                    <tr>
                        <td  style="width:40%;" >
                           
                           <center> <asp:Label ID="lblEstado" runat="server" Font-Bold="True"></asp:Label>
                           </center>
                          
                            <br>
                            <br></br>
                            <br>
                            <br></br>
                            <center>
                                <asp:Label ID="lblConexion" runat="server" Visible="False"></asp:Label>
                            </center>
                            <br>
                            <br></br>
                            <br>
                            <br></br>
                            <br>
                            <br></br>
                            <br>
                            <br></br>
                            </br>
                            </br>
                            </br>
                            </br>
                            </br>
                            </br>
                          
                        </td >
                    
                        <td style="width:30%;" align="center" valign="middle" >
                            <asp:Button ID="butIniciarComunicacion" runat="server" Height="153px" 
                            OnClick="butIniciarComunicacion_Click" Text="Iniciar Comunicación" 
                            Width="343px" Enabled="False"  />
                
                      
                        </td>
                        <td style="width:30%;" align="center" valign="middle" >
                            <asp:Button ID="butDetenerComunicacion" runat="server" Height="153px" 
                            OnClick="butDetenerComunicacion_Click" Text="Detener Comunicación" 
                            Width="343px" Enabled="False" />
                
                      
                        </td>

                    </tr>
                </table>
             
                    
                    
                    
                    
               
            </ContentTemplate>
        </asp:TabPanel>

        <asp:TabPanel ID="tbPanelConfiguracion" runat="server" HeaderText="Configuración">
        <ContentTemplate>
            
       <div class="centerDiv">
            <div style="float:left">
                 <asp:Label ID="Label2" runat="server" >Dirección Ip : </asp:Label><br />
                 <asp:Label ID="Label1" runat="server" >Puerto TCP : </asp:Label>
            </div>
            <div style="float:left">
                <asp:DropDownList ID="ddListIpsServidor" runat="server"> </asp:DropDownList><br />
                <asp:TextBox ID="txtBoxPuerto" runat="server" MaxLength="5" Width="77px">27375
                </asp:TextBox>
            </div>
           
        </div>
                   
                   <br/>
        </ContentTemplate>
        </asp:TabPanel>

          
        </asp:TabContainer>
    </div>



     
    </form>
</body>
</html>
