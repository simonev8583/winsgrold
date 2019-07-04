<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SistemaGestionRedes.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<link href="Styles/Site.css" rel="stylesheet" type="text/css" />
    <title></title>
</head>
<script language="javascript" type="text/javascript">

    function WindowCompleta() {
        if (window.parent.length > 0) {
            window.parent.location = "/Login.aspx";
        }
        return;
    }

</script>
<body onload="WindowCompleta();" style="background-color:#696969;">
    <form id="form1" runat="server">
    <div>
    
       
     
       
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td style="height:600px;" valign="middle" align="center">
                        <asp:Login ID="LoginSGR" runat="server" BackColor="#E3EAEB" BorderColor="#E6E2D8"
                            meta:resourceKey="LoginControl"
                            BorderStyle="Solid" BorderWidth="1px" 
                            DestinationPageUrl="~/HomeFrames.htm" DisplayRememberMe="False"
                            Font-Names="Verdana" Font-Size="1em" UserNameLabelText="Usuario:" LoginButtonText="Iniciar"
                            BorderPadding="4" ForeColor="#333333" TextLayout="TextOnTop" 
                            RememberMeSet="True" CssClass="textInUsuario" PasswordLabelText="Contraseña:"
                            FailureText="El intento de conexión no fue correcto. Inténtelo de nuevo."
                            PasswordRequiredErrorMessage="La contraseña es obligatoria."
                            RememberMeText="Recordármelo la próxima vez."
                            UserNameRequiredErrorMessage="El nombre de usuario es obligatorio."
                            TitleText="Iniciar sesión"
                            onloggingin="LoginSGR_LoggingIn" onloggedin="LoginSGR_LoggedIn">
                            <CheckBoxStyle BorderColor="#006600" />
                            <InstructionTextStyle Font-Italic="True" ForeColor="Red" 
                                Font-Names="Microsoft Sans Serif" Font-Size="10px" />
                            <LoginButtonStyle BackColor="#E3EAEB" BorderColor="#C5BBAF" BorderStyle="Ridge" BorderWidth="1px"
                                Font-Names="Verdana" Font-Size="0.8em" ForeColor="#1C5E55" />
                            <TextBoxStyle BorderStyle="Solid" Width="150px" Font-Size="0.8em" />
                            <TitleTextStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="#FFFFFF" Font-Size="0.9em" />
                        </asp:Login>
                    </td>
                </tr>
            </table>
      
    </div>
    <asp:LinkButton ID="LinkButton1" runat="server" 
        PostBackUrl="~/TestWinIdentity.aspx" Visible="False">TWinIdentity</asp:LinkButton>
    </form>
</body>
</html>
