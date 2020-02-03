<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SistemaGestionRedes.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="Styles/stylesLogin.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <title>SGR Management System </title>
      <link rel="icon" href="Styles/Images/Celsalogopng.png">
</head>
<script language="javascript" type="text/javascript">

    function WindowCompleta() {
        if (window.parent.length > 0) {
            window.parent.location = "/Login.aspx";
        }
        return;
    }

</script>





<body onload="WindowCompleta();" style="background-color: #0b304f;">
    <form id="form1" runat="server">
        <div>
            <div class="formBody">
                <div class="box">
                    <h1 style="text-align: center">Iniciar Sesión</h1>
                    <asp:Login ID="LoginSGR2" runat="server" meta:resourceKey="LoginControl"
                        DestinationPageUrl="~/HomeFrames.htm" DisplayRememberMe="False"
                        RememberMeSet="True" CssClass="input-group "
                        OnLoggingIn="LoginSGR_LoggingIn" OnLoggedIn="LoginSGR_LoggedIn">
                        <CheckBoxStyle BorderColor="#006600" />
                        <InstructionTextStyle Font-Italic="True" ForeColor="Red"
                            Font-Names="Microsoft Sans Serif" Font-Size="10px" />
                        <LoginButtonStyle />
                        <TextBoxStyle />
                        <TitleTextStyle />
                    </asp:Login>
                    <div class="logo">
                        <img class="img-responsive" src="Styles/Images/LOGO-CELSA-2018.SVG" alt="Celsa">
                    </div>
                </div>
            </div>
            <!-- 
            <row>
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
                                Font-Names="Verdana" Font-Size="0.8em" ForeColor="#0b304f" />
                            <TextBoxStyle BorderStyle="Solid" Width="150px" Font-Size="0.8em" />
                            <TitleTextStyle BackColor="#0b304f" Font-Bold="True" ForeColor="#FFFFFF" Font-Size="0.9em" />
                        </asp:Login>
                    </td>
                </tr>
            </table>
       </row> -->


        </div>
        <asp:LinkButton ID="LinkButton1" runat="server"
            PostBackUrl="~/TestWinIdentity.aspx" Visible="False">TWinIdentity</asp:LinkButton>
    </form>
</body>
</html>
