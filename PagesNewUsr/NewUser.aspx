<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewUser.aspx.cs" Inherits="SistemaGestionRedes.PagesNewUsr.NewUser" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style3
        {
            height: 18px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <br>
    
        <table width="100%">
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center">
                    <asp:CreateUserWizard ID="CrearUsuarioWz" runat="server" BackColor="#E3EAEB" 
                        BorderColor="#E6E2D8" BorderStyle="Solid" BorderWidth="1px" 
                        CssClass="textInUsuario" Font-Names="Verdana" Font-Size="0.8em" 
                        CompleteSuccessText="<%$ Resources:TextCompleteSuccessText %>" 
                        CreateUserButtonText="<%$ Resources:TextCreateUserButtonText %>" oncreateduser="CrearUsuarioWz_CreatedUser" 
                        RequireEmail="False" 
                        UnknownErrorMessage="<%$ Resources:TextUnknownErrorMessage %>" 
                        UserNameLabelText="<%$ Resources:TextUserNameLabelText %>" LoginCreatedUser="False">
                        <ContinueButtonStyle BackColor="White" BorderColor="#C5BBAF" 
                            BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
                            ForeColor="#1C5E55" />
                        <CreateUserButtonStyle BackColor="White" BorderColor="#C5BBAF" 
                            BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
                            ForeColor="#1C5E55" />
                        <TitleTextStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <WizardSteps>
                            <asp:CreateUserWizardStep runat="server" Title="<%$ Resources:TextTitle %>" >
                                <ContentTemplate>
                                    <table style="font-family:Verdana;font-size:100%;">
                                        <tr>
                                            <td align="center" colspan="2" 
                                                style="color:White;background-color:#1C5E55;font-weight:bold;">
                                                <asp:Literal ID="Literal1" Text="<%$ Resources:TextTitleTable %>" runat="server"></asp:Literal></td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="UserNameLabel" runat="server" Text="<%$ Resources:TextLblNombreusuario %>" AssociatedControlID="UserName"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                                    ControlToValidate="UserName" 
                                                    ErrorMessage="<%$ Resources:UserNameRequiredMsgErr %>" 
                                                    ValidationGroup="CrearUsuarioWz">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="PasswordLabel" runat="server" Text="<%$ Resources:TextContrasena %>" AssociatedControlID="Password"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                                    ControlToValidate="Password" ErrorMessage="<%$ Resources:PasswordRequiredMsgErr %>" 
                                                    ValidationGroup="CrearUsuarioWz">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="ConfirmPasswordLabel" runat="server" Text="<%$ Resources:TextConfirmarContrasena %>" 
                                                    AssociatedControlID="ConfirmPassword"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" 
                                                    ControlToValidate="ConfirmPassword" 
                                                    ErrorMessage="<%$ Resources:ConfirmPasswordRequiredMsgErr %>" 
                                                    ValidationGroup="CrearUsuarioWz">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="lblTipoUsr" runat="server" Text="<%$ Resources:TextTipoUsuario %>"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="DDListTipoUsuario" runat="server" 
                                                    DataSourceID="SqlDSRoles" DataTextField="RoleNameVisual" 
                                                    DataValueField="RoleName" ondatabound="DDListTipoUsuario_DataBound">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question" 
                                                    Visible="False">Pregunta de seguridad:</asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="Question" runat="server" Visible="False"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" 
                                                    ControlToValidate="Question" 
                                                    ErrorMessage="La pregunta de seguridad es obligatoria." 
                                                    ToolTip="La pregunta de seguridad es obligatoria." 
                                                    ValidationGroup="CrearUsuarioWz" Enabled="False">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer" 
                                                    Visible="False">Respuesta de seguridad:</asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="Answer" runat="server" Visible="False"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" 
                                                    ControlToValidate="Answer" 
                                                    ErrorMessage="La respuesta de seguridad es obligatoria." 
                                                    ToolTip="La respuesta de seguridad es obligatoria." 
                                                    ValidationGroup="CrearUsuarioWz" Enabled="False">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <asp:CompareValidator ID="PasswordCompare" runat="server" 
                                                    ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                                                    Display="Dynamic" 
                                                    ErrorMessage="<%$ Resources:PasswordCompareMsgErr %>" 
                                                    ValidationGroup="CrearUsuarioWz"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" style="color:Red;">
                                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:CreateUserWizardStep>
                            <asp:CompleteWizardStep runat="server" />
                        </WizardSteps>
                        <HeaderStyle BackColor="#666666" BorderColor="#E6E2D8" BorderStyle="Solid" 
                            BorderWidth="2px" Font-Bold="True" Font-Size="0.9em" ForeColor="White" 
                            HorizontalAlign="Center" />
                        <NavigationButtonStyle BackColor="White" BorderColor="#C5BBAF" 
                            BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
                            ForeColor="#1C5E55" />
                        <SideBarButtonStyle ForeColor="White" />
                        <SideBarStyle BackColor="#1C5E55" Font-Size="0.9em" VerticalAlign="Top" />
                        <StepStyle BorderWidth="0px" />
                    </asp:CreateUserWizard>
                    <br />
                </td>
            </tr>
            <tr>
                <td align="left" class="style3">
                    <asp:SqlDataSource ID="SqlDSRoles" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>" 
                        SelectCommand="select MtRolesLenguajes.RoleNameVisual, aspnet_Roles.RoleName
                                from aspnet_Roles join MtRolesLenguajes on (aspnet_Roles.RoleId = MtRolesLenguajes.RoleId)
                                where MtRolesLenguajes.Codlang = @IdLang
                                order by aspnet_Roles.RoleName asc">
                        <SelectParameters>
                            <asp:Parameter Name="IdLang" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            </table>
    
    </div>
    </form>
</body>
</html>
