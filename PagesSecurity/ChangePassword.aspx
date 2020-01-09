<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="SistemaGestionRedes.ChangePassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
</head>
<body>
    <p>
        &nbsp;</p>
    <form id="form1" runat="server">
    <div class="rightDiv">
        <center>
            <asp:ChangePassword ID="ChangePasswordSGR" runat="server" BackColor="#E3EAEB" BorderColor="#E6E2D8"
                BorderStyle="Solid" BorderWidth="1px"
                Font-Names="Verdana" Font-Size="0.8em" SuccessPageUrl="~/seccionE.aspx" 
                BorderPadding="5" CancelButtonText="" CancelButtonType="Link" 
                ChangePasswordButtonType="Link">
                <CancelButtonStyle BackColor="White" BorderColor="#C5BBAF" BorderStyle="Solid" BorderWidth="1px"
                    Font-Names="Verdana" Font-Size="0.8em" ForeColor="#0b304f" />
                <ChangePasswordButtonStyle BackColor="White" BorderColor="#C5BBAF" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" 
                    ForeColor="#0b304f" Font-Bold="True" />
                <ContinueButtonStyle BackColor="White" BorderColor="#C5BBAF" BorderStyle="Solid"
                    BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#0b304f" />
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                <LabelStyle Font-Bold="True" />
                <PasswordHintStyle Font-Italic="True" ForeColor="#0b304f" />
                <TextBoxStyle Font-Size="0.8em" />
                <TitleTextStyle BackColor="#0b304f" Font-Bold="True" ForeColor="#FFFFFF" Font-Size="0.9em" />
            </asp:ChangePassword>
            <br />
        </center>
    </div>
  
    
    </div>
    </form>
</body>
</html>
