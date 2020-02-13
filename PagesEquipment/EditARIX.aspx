<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditARIX.aspx.cs" Inherits="SistemaGestionRedes.EditARIX" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=16.1.0.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
    <script>
        function showContent(typeAnswer, message, messagePpal) {
            toastr.options = {
                "closeButton": true,
                "debug": false,
                "progressBar": true,
                "preventDuplicates": false,
                "positionClass": "toast-top-right",
                "showDuration": "400",
                "hideDuration": "1000",
                "timeOut": "7000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }
            toastr[typeAnswer](message, messagePpal);

        }
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="rightDiv">
            <div class=" centerDiv">

                <table style="width: 100%;" border="0">
                    <tr>
                        <td>
                            <asp:Label ID="lblId" runat="server" Visible="false" />
                        </td>
                    </tr>
                </table>

                 <div>
                     <h3 style="text-align:center">
                        <asp:Label ID="serialARIX" runat="server"></asp:Label>
                      </h3>                     
                 </div>

                <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:CollapsiblePanelExtender ID="CollapsiblePanelOperacionGeneral" runat="server"
                    TargetControlID="ContentOperacionGeneral"
                    ExpandControlID="TitleOperacionGeneral"
                    CollapseControlID="TitleOperacionGeneral"
                    Collapsed="False"
                    TextLabelID="LabelMostrarActual"
                    ExpandedText="<%$ Resources:ExpandOperacionGeneral %>"
                    CollapsedText="<%$ Resources:CollapseOperacionGeneral %>"
                    ImageControlID="ImageActual"
                    ExpandedImage="~/Images/collapse.jpg"
                    CollapsedImage="~/Images/expand.jpg"
                    SuppressPostBack="true"></asp:CollapsiblePanelExtender>
                <asp:Panel ID="TitleOperacionGeneral" runat="server" CssClass="collapsePanelHeader styleCollapse">
                    <asp:Image ID="ImageActual" runat="server" ImageUrl="~/Images/expand.jpg" />
                    &nbsp;<asp:Label ID="lblTextTitleOperacionGeneral" runat="server" Text="<%$ Resources:lblTextTitleOperacionGeneral %>"></asp:Label>&nbsp;&nbsp;
                </asp:Panel>
                <asp:Panel ID="ContentOperacionGeneral" runat="server">
                    <fieldset>
                        <center>
                            <table class="tableClass">
                        <thead class="itemHeader">
                            <tr>
                                <th>&nbsp;<asp:Label ID="LabelOpGeneral_modoOperacion" runat="server" Text="<%$ Resources:lblOpGeneral_modoOperacion %>"></asp:Label>&nbsp;&nbsp;
                                </th>

                                <th>&nbsp;<asp:Label ID="LabelOpGeneral_porcentajeHisteresis" runat="server" Text="<%$ Resources:lblOpGeneral_porcentajeHisteresis %>"></asp:Label>&nbsp;&nbsp;
                                    <br />
                                    <span>(10% - 90%)</span>
                                </th>

                                <th>&nbsp;<asp:Label ID="LabelOpGeneral_ciclosVerifResetDismCorrFalla" runat="server" Text="<%$ Resources:lblOpGeneral_ciclosVerifResetDismCorrFalla %>"></asp:Label>&nbsp;&nbsp;
                                    <br />
                                    <span>(1 - 10)</span>
                                </th>
                            </tr>
                        </thead>
                        <tbody class="itemBody">
                            <tr>
                                <td>
                                    <asp:ListBox ID="listBoxModoOperacion" runat="server" Height="70px" Width="200px">
                                        <asp:ListItem Value="0" Text="<%$ Resources:TextoModoOperacion_Reconectador %>"></asp:ListItem>
                                        <asp:ListItem Value="1" disabled="disabled" Text="<%$ Resources:TextoModoOperacion_Seccionalizador %>"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="<%$ Resources:TextoModoOperacion_SinReconexion %>"></asp:ListItem>
                                    </asp:ListBox>
                                </td>

                                <td>
                                    <asp:TextBox ID="txtOpGeneral_porcentajeHisteresis" runat="server"
                                        CssClass="textInUsuario styleInput" MaxLength="3" Width="50px"></asp:TextBox>
                                    <br />
                                    <asp:rangevalidator ID="Rangevalidator1" errormessage="Favor ingrese valor entre 10-90." forecolor="Red" 
                                    controltovalidate="txtOpGeneral_porcentajeHisteresis" minimumvalue="10" maximumvalue="90" runat="server" Type="Integer">
                                    </asp:rangevalidator>
                                </td>

                                <td>
                                    <asp:TextBox ID="txtOpGeneral_ciclosVerifResetDismCorrFalla" runat="server" 
                                        CssClass="textInUsuario styleInput" MaxLength="2" Width="40px"></asp:TextBox>
                                    <br />
                                    <asp:rangevalidator ID="Rangevalidator2" errormessage="Favor ingrese valor entre 1-10." forecolor="Red" 
                                    controltovalidate="txtOpGeneral_ciclosVerifResetDismCorrFalla" minimumvalue="1" maximumvalue="10" runat="server" Type="Integer">
                                    </asp:rangevalidator>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                        </center>
                    </fieldset>
                    <br />
                    <fieldset>
                        <center>
                            <table class="tableClass">
                        <thead class="itemHeader">
                            <tr>
                                <th>
                                &nbsp;<asp:Label ID="LabelOpGeneral_frecOperacion" runat="server" Text="<%$ Resources:lblOpGeneral_frecOperacion %>"></asp:Label>&nbsp;&nbsp;
                                </th>

                                <th>
                                    &nbsp;<asp:Label ID="LabelOpGeneral_habilitarFuncionalidadInrush" runat="server" Text="<%$ Resources:lblOpGeneral_habilitarFuncionalidadInrush %>"></asp:Label>&nbsp;&nbsp;
                                </th>

                                <th>&nbsp;<asp:Label ID="LabelOpGeneral_modOperacionFinVidaUtil" runat="server" Text="<%$ Resources:lblOpGeneral_modOperacionFinVidaUtil %>"></asp:Label>&nbsp;&nbsp;
                                </th>
                            </tr>
                        </thead>
                        <tbody class="itemBody">
                            <tr>
                                <td>
                                    <asp:ListBox ID="listBoxFrecOperacion" runat="server" Height="40px" Width="70px">
                                        <asp:ListItem Value="0" Text="<%$ Resources:TextoFrecOperacion_50Hz %>"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="<%$ Resources:TextoFrecOperacion_60Hz %>"></asp:ListItem>
                                    </asp:ListBox>
                                </td>

                                <td>
                                    <asp:CheckBox ID="chkBoxOpGeneral_habilitarInrush" runat="server" />
                                </td>

                                <td>
                                    <asp:ListBox ID="listBoxmodOperacionFinVidaUtil" runat="server" Height="70px" Width="130px">
                                        <asp:ListItem Value="0" Text="<%$ Resources:TextoEstadoCerrado %>"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="<%$ Resources:TextoEstadoAbierto %>"></asp:ListItem>
                                        <asp:ListItem Value="2" disabled="disabled" Text="<%$ Resources:TextoSeccionalizador %>"></asp:ListItem>
                                    </asp:ListBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                        </center>
                    </fieldset>
                    <br />
                    <fieldset>
                        <center>
                            <table class="tableClass">
                        <thead class="itemHeader">
                            <tr>
                                <th>
                                    &nbsp;<asp:Label ID="LabelOpGeneral_modoInrush" runat="server" Text="<%$ Resources:lblOpGeneral_modoInrush %>"></asp:Label>&nbsp;&nbsp;
                                </th>

                                <th>
                                    &nbsp;<asp:Label ID="LabelOpGeneral_corrInrush" runat="server" Text="<%$ Resources:lblOpGeneral_corrInrush %>"></asp:Label>&nbsp;&nbsp;
                                    <br />
                                    <span>(10A - 6500A)</span>
                                </th>

                                <th>
                                    &nbsp;<asp:Label ID="LabelOpGeneral_porcentaje2doArmonicoInrush" runat="server" Text="<%$ Resources:lblOpGeneral_porcentaje2doArmonicoInrush %>"></asp:Label>&nbsp;&nbsp;
                                    <br />
                                    <span>(10% - 20%)</span>
                                </th>
                            </tr>
                        </thead>
                        <tbody class="itemBody">
                            <tr>
                                <td>
                                    <asp:ListBox ID="listBoxmodoInrush" runat="server" Height="50px" Width="150px">
                                        <asp:ListItem Value="0" Text="<%$ Resources:TextoInrush0 %>"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="<%$ Resources:TextoInrush1 %>"></asp:ListItem>
                                    </asp:ListBox>
                                </td>

                                <td>
                                    <asp:TextBox ID="txtOpGeneral_corrInrush" runat="server"
                                                 CssClass="textInUsuario styleInput" MaxLength="5" Width="70px"></asp:TextBox>
                                    <br />
                                    <asp:rangevalidator ID="Rangevalidator3" errormessage="Favor ingrese valor entre 10-6500." forecolor="Red" 
                                    controltovalidate="txtOpGeneral_corrInrush" minimumvalue="10" maximumvalue="6500" runat="server" Type="Integer">
                                    </asp:rangevalidator>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtOpGeneral_porcentaje2doArmonicoInrush" runat="server"
                                                 CssClass="textInUsuario styleInput" MaxLength="2" Width="50px"></asp:TextBox>
                                    <br />
                                    <asp:rangevalidator ID="Rangevalidator4" errormessage="Favor ingrese valor entre 10-20." forecolor="Red" 
                                    controltovalidate="txtOpGeneral_porcentaje2doArmonicoInrush" minimumvalue="10" maximumvalue="20" runat="server" Type="Integer">
                                    </asp:rangevalidator>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                        </center>
                    </fieldset>
                    <br />
                    <fieldset>
                        <center>
                            <table class="tableClass">
                        <thead class="itemHeader">
                            <tr>
                                <th>
                                    &nbsp;<asp:Label ID="LabelOpGeneral_tiempoDeValidacionInrush" runat="server" Text="<%$ Resources:lblOpGeneral_tiempoDeValidacionInrush %>"></asp:Label>&nbsp;&nbsp;
                                    <br />
                                    <span>(10ms - 60.000ms)</span>
                                </th>

                                <th>
                                    &nbsp;<asp:Label ID="LabelOpGeneral_tiempoSostenimientoInrush" runat="server" Text="<%$ Resources:lblOpGeneral_tiempoSostenimientoInrush %>"></asp:Label>&nbsp;&nbsp;
                                    <br />
                                    <span>(10ms - 60.000ms)</span>
                                </th>

                            </tr>
                        </thead>
                        <tbody class="itemBody">
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtOpGeneral_tiempoDeValidacionInrush" runat="server"
                                                 CssClass="textInUsuario styleInput" MaxLength="5" Width="70px"></asp:TextBox>
                                    <br />
                                    <asp:rangevalidator ID="Rangevalidator5" errormessage="Favor ingrese valor entre 10-60.000." forecolor="Red" 
                                    controltovalidate="txtOpGeneral_tiempoDeValidacionInrush" minimumvalue="10" maximumvalue="60000" runat="server" Type="Integer">
                                    </asp:rangevalidator>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtOpGeneral_tiempoSostenimientoInrush" runat="server"
                                                 CssClass="textInUsuario styleInput" MaxLength="5" Width="70px"></asp:TextBox>
                                    <br />
                                    <asp:rangevalidator ID="Rangevalidator6" errormessage="Favor ingrese valor entre 10-60.000." forecolor="Red" 
                                    controltovalidate="txtOpGeneral_tiempoSostenimientoInrush" minimumvalue="10" maximumvalue="60000" runat="server" Type="Integer">
                                    </asp:rangevalidator>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                        </center>
                    </fieldset>
                </asp:Panel>

                <br />

                <asp:CollapsiblePanelExtender ID="CollapsiblePanelOperacionReconectador" runat="server"
                    TargetControlID="ContentOperacionReconectador"
                    ExpandControlID="TitleOperacionReconectador"
                    CollapseControlID="TitleOperacionReconectador"
                    Collapsed="True"
                    TextLabelID="LabelMostrarActual"
                    ExpandedText="<%$ Resources:ExpandOperacionGeneral %>"
                    CollapsedText="<%$ Resources:CollapseOperacionGeneral %>"
                    ImageControlID="ImageReconectador"
                    ExpandedImage="~/Images/collapse.jpg"
                    CollapsedImage="~/Images/expand.jpg"
                    SuppressPostBack="true"></asp:CollapsiblePanelExtender>
                <asp:Panel ID="TitleOperacionReconectador" runat="server" CssClass="collapsePanelHeader styleCollapse">
                    <asp:Image ID="ImageReconectador" runat="server" ImageUrl="~/Images/expand.jpg" />
                    &nbsp;<asp:Label ID="lblTextTitleOperacionReconectador" runat="server" Text="<%$ Resources:lblTextTitleOperacionReconectador %>"></asp:Label>&nbsp;&nbsp;
                </asp:Panel>
                <asp:Panel ID="ContentOperacionReconectador" runat="server">
                    <fieldset>
                        <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelOpReconectador_numRecierres" runat="server" Text="<%$ Resources:lblOpReconectador_numRecierres %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(1 - 4)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="LabelOpReconectador_corrMaxAbsoluta" runat="server" Text="<%$ Resources:lblOpReconectador_corrMaxAbsoluta %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(10A - 6500A)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="LabelOpReconectador_tiempoDefDisparoCorrMaxAbs" runat="server" Text="<%$ Resources:lblOpReconectador_tiempoDefDisparoCorrMaxAbs %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtOpReconectador_numRecierres" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="2" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator7" errormessage="Favor ingrese valor entre 1-4." forecolor="Red" 
                                            controltovalidate="txtOpReconectador_numRecierres" minimumvalue="1" maximumvalue="4" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOpReconectador_corrMaxAbsolutas" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator8" errormessage="Favor ingrese valor entre 10-6500." forecolor="Red" 
                                            controltovalidate="txtOpReconectador_corrMaxAbsolutas" minimumvalue="10" maximumvalue="6500" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtOpReconectador_tiempoDefDisparoCorrMaxAbs" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator9" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtOpReconectador_tiempoDefDisparoCorrMaxAbs" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset>
                        <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelOpReconectador_resetTimeAfterLockout" runat="server" Text="<%$ Resources:lblOpReconectador_resetTimeAfterLockout %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <!--<span>(1 - 120)</span>-->
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="LabelOpReconectador_resetTimeLockout" runat="server" Text="<%$ Resources:lblOpReconectador_resetTimeLockout %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span> </span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="LabelOpReconectador_corrMaxCapacidadRIX" runat="server" Text="<%$ Resources:lblOpReconectador_corrMaxCapacidadRIX %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span> </span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtOpReconectador_resetTimeAfterLockout" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="3" Width="50px" disabled="disabled"></asp:TextBox>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtOpReconectador_resetTimeLockout" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px" disabled="disabled"></asp:TextBox>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtOpReconectador_corrMaxCapacidadRIX" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px" disabled="disabled"></asp:TextBox>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                    </fieldset>

                    <section>
                    </section>
                </asp:Panel>

                <br />

                <asp:CollapsiblePanelExtender ID="CollapsiblePanelOperacionModoDisparo" runat="server"
                    TargetControlID="ContentOperacionModoDisparo"
                    ExpandControlID="TitleOperacionModoDisparo"
                    CollapseControlID="TitleOperacionModoDisparo"
                    Collapsed="True"
                    TextLabelID="LabelMostrarActual"
                    ExpandedText="<%$ Resources:ExpandOperacionGeneral %>"
                    CollapsedText="<%$ Resources:CollapseOperacionGeneral %>"
                    ImageControlID="ImageModoDisparo"
                    ExpandedImage="~/Images/collapse.jpg"
                    CollapsedImage="~/Images/expand.jpg"
                    SuppressPostBack="true"></asp:CollapsiblePanelExtender>
                <asp:Panel ID="TitleOperacionModoDisparo" runat="server" CssClass="collapsePanelHeader styleCollapse">
                    <asp:Image ID="ImageModoDisparo" runat="server" ImageUrl="~/Images/expand.jpg" />
                    &nbsp;<asp:Label ID="lblTextTitleOperacionModoDisparo" runat="server" Text="<%$ Resources:lblTextTitleOperacionModoDisparo %>"></asp:Label>&nbsp;&nbsp;
                </asp:Panel>
                <asp:Panel ID="ContentOperacionModoDisparo" runat="server">

                    <asp:CollapsiblePanelExtender ID="CollapsiblePanelDisparo1" runat="server"
                        TargetControlID="ContentOperacionDisparo1"
                        ExpandControlID="TitleOperacionDisparo1"
                        CollapseControlID="TitleOperacionDisparo1"
                        Collapsed="True"
                        TextLabelID="LabelMostrarActual"
                        ExpandedText="<%$ Resources:ExpandOperacionGeneral %>"
                        CollapsedText="<%$ Resources:CollapseOperacionGeneral %>"
                        ImageControlID="ImageDisparo1"
                        ExpandedImage="~/Images/collapse.jpg"
                        CollapsedImage="~/Images/expand.jpg"
                        SuppressPostBack="true"></asp:CollapsiblePanelExtender>
                    <asp:Panel ID="TitleOperacionDisparo1" runat="server" CssClass="collapsePanelHeader styleCollapseDisparo">
                        <asp:Image ID="ImageDisparo1" runat="server" ImageUrl="~/Images/expand.jpg" />
                        &nbsp;<asp:Label ID="lblTextTitleOperacionDisparo1" runat="server" Text="<%$ Resources:lblTextTitleOperacionDisparo1 %>"></asp:Label>&nbsp;&nbsp;
                    </asp:Panel>
                    <asp:Panel ID="ContentOperacionDisparo1" runat="server">
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_tipoOperacion" runat="server" Text="<%$ Resources:lblOpGeneral_modoOperacion %>"></asp:Label>&nbsp;&nbsp;
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_tipoReset" runat="server" Text="<%$ Resources:lblDisp1_tipoReset %>"></asp:Label>&nbsp;&nbsp;
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_habilitaModificadores" runat="server" Text="<%$ Resources:lblDisparo1_habilitaModificadores %>"></asp:Label>&nbsp;&nbsp;
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:ListBox ID="listBoxDisparo1_tipoOperacion" runat="server" Height="70px" Width="100px">
                                            <asp:ListItem Value="0" Text="<%$ Resources:TextoDisparo1_TiempoDefinido %>"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="<%$ Resources:TextoDisparo1_IECNI %>"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="<%$ Resources:TextoDisparo1_IECVI %>"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="<%$ Resources:TextoDisparo1_IECEI %>"></asp:ListItem>
                                            <asp:ListItem Value="4" Text="<%$ Resources:TextoDisparo1_IECLTI %>"></asp:ListItem>
                                            <asp:ListItem Value="5" Text="<%$ Resources:TextoDisparo1_ANSIMI %>"></asp:ListItem>
                                            <asp:ListItem Value="6" Text="<%$ Resources:TextoDisparo1_ANSIVI %>"></asp:ListItem>
                                            <asp:ListItem Value="7" Text="<%$ Resources:TextoDisparo1_ANSIEI %>"></asp:ListItem>
                                        </asp:ListBox>
                                    </td>

                                    <td>
                                        <asp:ListBox ID="listBoxDisparo1_tipoReset" runat="server" Height="40px" Width="100px">
                                            <asp:ListItem Value="0" Text="<%$ Resources:TextoDisparo1_TiempoFijo %>"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="<%$ Resources:TextoDisparo1_Curva %>"></asp:ListItem>
                                        </asp:ListBox>
                                    </td>
                                    
                                    <td>
                                        <asp:CheckBox ID="checkDisparo1_habilitaModificadores" runat="server" />
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_corrArranque" runat="server" Text="<%$ Resources:lblDisparo1_corrArranque %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(3A - 6500A)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_modCorrMaxActuacion" runat="server" Text="<%$ Resources:lblDisparo1_modCorrMaxActuacion %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(10A - 6500A)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_modTd" runat="server" Text="<%$ Resources:lblDisparo1_modTd %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(0,01 - 9)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo1_corrArranque" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator11" errormessage="Favor ingrese valor entre 3-6500." forecolor="Red" 
                                            controltovalidate="txtDisparo1_corrArranque" minimumvalue="3" maximumvalue="6500" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo1_modCorrMaxActuacion" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator16" errormessage="Favor ingrese valor entre 10-6500." forecolor="Red" 
                                            controltovalidate="txtDisparo1_modCorrMaxActuacion" minimumvalue="10" maximumvalue="6500" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo1_modTd" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator21" errormessage="Favor ingrese valor entre 0,01-9." forecolor="Red" 
                                            controltovalidate="txtDisparo1_modTd" minimumvalue="0,01" maximumvalue="9" runat="server" Type="Double">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_tiempoDisparoDefinido" runat="server" Text="<%$ Resources:lblDisparo1_tiempoDisparoDefinido %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_tiempoResetCiclo" runat="server" Text="<%$ Resources:lblDisparo1_tiempoResetCiclo %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(1s - 300s)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_tiempoApertura" runat="server" Text="<%$ Resources:lblDisparo1_tiempoApertura %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(500ms - 30.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo1_tiempoDisparoDefinido" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator26" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo1_tiempoDisparoDefinido" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo1_tiempoResetCiclo" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="3" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator31" errormessage="Favor ingrese valor entre 1-300." forecolor="Red" 
                                            controltovalidate="txtDisparo1_tiempoResetCiclo" minimumvalue="1" maximumvalue="300" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo1_tiempoApertura" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator36" errormessage="Favor ingrese valor entre 500-30.000." forecolor="Red" 
                                            controltovalidate="txtDisparo1_tiempoApertura" minimumvalue="500" maximumvalue="30000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_modTiempoMaxRespuesta" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoMaxRespuesta %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(10ms - 60.000ms)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_modTiempoMinRespuesta" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoMinRespuesta %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_modTiempoDefIMaxAct" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoDefIMaxAct %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo1_modTiempoMaxRespuesta" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator41" errormessage="Favor ingrese valor entre 10-60.000." forecolor="Red" 
                                            controltovalidate="txtDisparo1_modTiempoMaxRespuesta" minimumvalue="10" maximumvalue="60000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo1_modTiempoMinRespuesta" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator50" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo1_modTiempoMinRespuesta" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo1_modTiempoDefIMaxAct" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator51" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo1_modTiempoDefIMaxAct" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo1_modRetardoAdicional" runat="server" Text="<%$ Resources:lblDisparo1_modRetardoAdicional %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(0ms - 10.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo1_modRetardoAdicional" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator60" errormessage="Favor ingrese valor entre 0-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo1_modRetardoAdicional" minimumvalue="0" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                    </asp:Panel>

                    <asp:CollapsiblePanelExtender ID="CollapsiblePanelDisparo2" runat="server"
                        TargetControlID="ContentOperacionDisparo2"
                        ExpandControlID="TitleOperacionDisparo2"
                        CollapseControlID="TitleOperacionDisparo2"
                        Collapsed="True"
                        TextLabelID="LabelMostrarActual"
                        ExpandedText="<%$ Resources:ExpandOperacionGeneral %>"
                        CollapsedText="<%$ Resources:CollapseOperacionGeneral %>"
                        ImageControlID="ImageDisparo2"
                        ExpandedImage="~/Images/collapse.jpg"
                        CollapsedImage="~/Images/expand.jpg"
                        SuppressPostBack="true"></asp:CollapsiblePanelExtender>
                    <asp:Panel ID="TitleOperacionDisparo2" runat="server" CssClass="collapsePanelHeader styleCollapseDisparo">
                        <asp:Image ID="ImageDisparo2" runat="server" ImageUrl="~/Images/expand.jpg" />
                        &nbsp;<asp:Label ID="lblTextTitleOperacionDisparo2" runat="server" Text="<%$ Resources:lblTextTitleOperacionDisparo2 %>"></asp:Label>&nbsp;&nbsp;
                    </asp:Panel>
                    <asp:Panel ID="ContentOperacionDisparo2" runat="server">
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo2_tipoOperacion" runat="server" Text="<%$ Resources:lblOpGeneral_modoOperacion %>"></asp:Label>&nbsp;&nbsp;
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo2_tipoReset" runat="server" Text="<%$ Resources:lblDisp1_tipoReset %>"></asp:Label>&nbsp;&nbsp;
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="LabelDisparo2_habilitaModificadores" runat="server" Text="<%$ Resources:lblDisparo1_habilitaModificadores %>"></asp:Label>&nbsp;&nbsp;
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:ListBox ID="listBoxDisparo2_tipoOperacion" runat="server" Height="70px" Width="100px">
                                            <asp:ListItem Value="0" Text="<%$ Resources:TextoDisparo1_TiempoDefinido %>"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="<%$ Resources:TextoDisparo1_IECNI %>"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="<%$ Resources:TextoDisparo1_IECVI %>"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="<%$ Resources:TextoDisparo1_IECEI %>"></asp:ListItem>
                                            <asp:ListItem Value="4" Text="<%$ Resources:TextoDisparo1_IECLTI %>"></asp:ListItem>
                                            <asp:ListItem Value="5" Text="<%$ Resources:TextoDisparo1_ANSIMI %>"></asp:ListItem>
                                            <asp:ListItem Value="6" Text="<%$ Resources:TextoDisparo1_ANSIVI %>"></asp:ListItem>
                                            <asp:ListItem Value="7" Text="<%$ Resources:TextoDisparo1_ANSIEI %>"></asp:ListItem>
                                        </asp:ListBox>
                                    </td>

                                    <td>
                                        <asp:ListBox ID="listBoxDisparo2_tipoReset" runat="server" Height="40px" Width="100px">
                                            <asp:ListItem Value="0" Text="<%$ Resources:TextoDisparo1_TiempoFijo %>"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="<%$ Resources:TextoDisparo1_Curva %>"></asp:ListItem>
                                        </asp:ListBox>
                                    </td>
                                    
                                    <td>
                                        <asp:CheckBox ID="checkDisparo2_habilitaModificadores" runat="server" />
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label4" runat="server" Text="<%$ Resources:lblDisparo1_corrArranque %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(3A - 6500A)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label5" runat="server" Text="<%$ Resources:lblDisparo1_modCorrMaxActuacion %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(10A - 6500A)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label6" runat="server" Text="<%$ Resources:lblDisparo1_modTd %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(0,01 - 9)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo2_corrArranque" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator12" errormessage="Favor ingrese valor entre 3-6500." forecolor="Red" 
                                            controltovalidate="txtDisparo2_corrArranque" minimumvalue="3" maximumvalue="6500" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo2_modCorrMaxActuacion" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator17" errormessage="Favor ingrese valor entre 10-6500." forecolor="Red" 
                                            controltovalidate="txtDisparo2_modCorrMaxActuacion" minimumvalue="10" maximumvalue="6500" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo2_modTd" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator22" errormessage="Favor ingrese valor entre 0,01-9." forecolor="Red" 
                                            controltovalidate="txtDisparo2_modTd" minimumvalue="0,01" maximumvalue="9" runat="server" Type="Double">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label7" runat="server" Text="<%$ Resources:lblDisparo1_tiempoDisparoDefinido %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label8" runat="server" Text="<%$ Resources:lblDisparo1_tiempoResetCiclo %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(1s - 300s)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label9" runat="server" Text="<%$ Resources:lblDisparo1_tiempoApertura %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(500ms - 30.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo2_tiempoDisparoDefinido" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator27" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo2_tiempoDisparoDefinido" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo2_tiempoResetCiclo" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="3" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator32" errormessage="Favor ingrese valor entre 1-300." forecolor="Red" 
                                            controltovalidate="txtDisparo2_tiempoResetCiclo" minimumvalue="1" maximumvalue="300" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo2_tiempoApertura" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator37" errormessage="Favor ingrese valor entre 500-30.000." forecolor="Red" 
                                            controltovalidate="txtDisparo2_tiempoApertura" minimumvalue="500" maximumvalue="30000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label10" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoMaxRespuesta %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(10ms - 60.000ms)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label11" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoMinRespuesta %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label12" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoDefIMaxAct %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo2_modTiempoMaxRespuesta" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator42" errormessage="Favor ingrese valor entre 10-60.000." forecolor="Red" 
                                            controltovalidate="txtDisparo2_modTiempoMaxRespuesta" minimumvalue="10" maximumvalue="60000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo2_modTiempoMinRespuesta" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator49" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo2_modTiempoMinRespuesta" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo2_modTiempoDefIMaxAct" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator52" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo2_modTiempoDefIMaxAct" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label13" runat="server" Text="<%$ Resources:lblDisparo1_modRetardoAdicional %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(0ms - 10.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo2_modRetardoAdicional" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator59" errormessage="Favor ingrese valor entre 0-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo2_modRetardoAdicional" minimumvalue="0" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                    </asp:Panel>

                    <asp:CollapsiblePanelExtender ID="CollapsiblePanelDisparo3" runat="server"
                        TargetControlID="ContentOperacionDisparo3"
                        ExpandControlID="TitleOperacionDisparo3"
                        CollapseControlID="TitleOperacionDisparo3"
                        Collapsed="True"
                        TextLabelID="LabelMostrarActual"
                        ExpandedText="<%$ Resources:ExpandOperacionGeneral %>"
                        CollapsedText="<%$ Resources:CollapseOperacionGeneral %>"
                        ImageControlID="ImageDisparo3"
                        ExpandedImage="~/Images/collapse.jpg"
                        CollapsedImage="~/Images/expand.jpg"
                        SuppressPostBack="true"></asp:CollapsiblePanelExtender>
                    <asp:Panel ID="TitleOperacionDisparo3" runat="server" CssClass="collapsePanelHeader styleCollapseDisparo">
                        <asp:Image ID="ImageDisparo3" runat="server" ImageUrl="~/Images/expand.jpg" />
                        &nbsp;<asp:Label ID="lblTextTitleOperacionDisparo3" runat="server" Text="<%$ Resources:lblTextTitleOperacionDisparo3 %>"></asp:Label>&nbsp;&nbsp;
                    </asp:Panel>
                    <asp:Panel ID="ContentOperacionDisparo3" runat="server">
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label1" runat="server" Text="<%$ Resources:lblOpGeneral_modoOperacion %>"></asp:Label>&nbsp;&nbsp;
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label2" runat="server" Text="<%$ Resources:lblDisp1_tipoReset %>"></asp:Label>&nbsp;&nbsp;
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label3" runat="server" Text="<%$ Resources:lblDisparo1_habilitaModificadores %>"></asp:Label>&nbsp;&nbsp;
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:ListBox ID="listBoxDisparo3_tipoOperacion" runat="server" Height="70px" Width="100px">
                                            <asp:ListItem Value="0" Text="<%$ Resources:TextoDisparo1_TiempoDefinido %>"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="<%$ Resources:TextoDisparo1_IECNI %>"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="<%$ Resources:TextoDisparo1_IECVI %>"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="<%$ Resources:TextoDisparo1_IECEI %>"></asp:ListItem>
                                            <asp:ListItem Value="4" Text="<%$ Resources:TextoDisparo1_IECLTI %>"></asp:ListItem>
                                            <asp:ListItem Value="5" Text="<%$ Resources:TextoDisparo1_ANSIMI %>"></asp:ListItem>
                                            <asp:ListItem Value="6" Text="<%$ Resources:TextoDisparo1_ANSIVI %>"></asp:ListItem>
                                            <asp:ListItem Value="7" Text="<%$ Resources:TextoDisparo1_ANSIEI %>"></asp:ListItem>
                                        </asp:ListBox>
                                    </td>

                                    <td>
                                        <asp:ListBox ID="listBoxDisparo3_tipoReset" runat="server" Height="40px" Width="100px">
                                            <asp:ListItem Value="0" Text="<%$ Resources:TextoDisparo1_TiempoFijo %>"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="<%$ Resources:TextoDisparo1_Curva %>"></asp:ListItem>
                                        </asp:ListBox>
                                    </td>
                                    
                                    <td>
                                        <asp:CheckBox ID="checkDisparo3_habilitaModificadores" runat="server" />
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label14" runat="server" Text="<%$ Resources:lblDisparo1_corrArranque %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(3A - 6500A)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label15" runat="server" Text="<%$ Resources:lblDisparo1_modCorrMaxActuacion %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(10A - 6500A)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label16" runat="server" Text="<%$ Resources:lblDisparo1_modTd %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(0,01 - 9)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo3_corrArranque" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator13" errormessage="Favor ingrese valor entre 3-6500." forecolor="Red" 
                                            controltovalidate="txtDisparo3_corrArranque" minimumvalue="3" maximumvalue="6500" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo3_modCorrMaxActuacion" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator18" errormessage="Favor ingrese valor entre 10-6500." forecolor="Red" 
                                            controltovalidate="txtDisparo3_modCorrMaxActuacion" minimumvalue="10" maximumvalue="6500" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo3_modTd" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator23" errormessage="Favor ingrese valor entre 0,01-9." forecolor="Red" 
                                            controltovalidate="txtDisparo3_modTd" minimumvalue="0,01" maximumvalue="9" runat="server" Type="Double">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label17" runat="server" Text="<%$ Resources:lblDisparo1_tiempoDisparoDefinido %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label18" runat="server" Text="<%$ Resources:lblDisparo1_tiempoResetCiclo %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(1s - 300s)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label19" runat="server" Text="<%$ Resources:lblDisparo1_tiempoApertura %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(500ms - 30.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo3_tiempoDisparoDefinido" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator28" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo3_tiempoDisparoDefinido" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo3_tiempoResetCiclo" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="3" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator33" errormessage="Favor ingrese valor entre 1-300." forecolor="Red" 
                                            controltovalidate="txtDisparo3_tiempoResetCiclo" minimumvalue="1" maximumvalue="300" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo3_tiempoApertura" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator38" errormessage="Favor ingrese valor entre 500-30.000." forecolor="Red" 
                                            controltovalidate="txtDisparo3_tiempoApertura" minimumvalue="500" maximumvalue="30000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label20" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoMaxRespuesta %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(10ms - 60.000ms)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label21" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoMinRespuesta %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label22" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoDefIMaxAct %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo3_modTiempoMaxRespuesta" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator43" errormessage="Favor ingrese valor entre 10-60.000." forecolor="Red" 
                                            controltovalidate="txtDisparo3_modTiempoMaxRespuesta" minimumvalue="10" maximumvalue="60000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo3_modTiempoMinRespuesta" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator48" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo3_modTiempoMinRespuesta" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo3_modTiempoDefIMaxAct" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator53" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo3_modTiempoDefIMaxAct" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label23" runat="server" Text="<%$ Resources:lblDisparo1_modRetardoAdicional %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(0ms - 10.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo3_modRetardoAdicional" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator58" errormessage="Favor ingrese valor entre 0-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo3_modRetardoAdicional" minimumvalue="0" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                    </asp:Panel>

                    <asp:CollapsiblePanelExtender ID="CollapsiblePanelDisparo4" runat="server"
                        TargetControlID="ContentOperacionDisparo4"
                        ExpandControlID="TitleOperacionDisparo4"
                        CollapseControlID="TitleOperacionDisparo4"
                        Collapsed="True"
                        TextLabelID="LabelMostrarActual"
                        ExpandedText="<%$ Resources:ExpandOperacionGeneral %>"
                        CollapsedText="<%$ Resources:CollapseOperacionGeneral %>"
                        ImageControlID="ImageDisparo4"
                        ExpandedImage="~/Images/collapse.jpg"
                        CollapsedImage="~/Images/expand.jpg"
                        SuppressPostBack="true"></asp:CollapsiblePanelExtender>
                    <asp:Panel ID="TitleOperacionDisparo4" runat="server" CssClass="collapsePanelHeader styleCollapseDisparo">
                        <asp:Image ID="ImageDisparo4" runat="server" ImageUrl="~/Images/expand.jpg" />
                        &nbsp;<asp:Label ID="lblTextTitleOperacionDisparo4" runat="server" Text="<%$ Resources:lblTextTitleOperacionDisparo4 %>"></asp:Label>&nbsp;&nbsp;
                    </asp:Panel>
                    <asp:Panel ID="ContentOperacionDisparo4" runat="server">
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label24" runat="server" Text="<%$ Resources:lblOpGeneral_modoOperacion %>"></asp:Label>&nbsp;&nbsp;
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label25" runat="server" Text="<%$ Resources:lblDisp1_tipoReset %>"></asp:Label>&nbsp;&nbsp;
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label26" runat="server" Text="<%$ Resources:lblDisparo1_habilitaModificadores %>"></asp:Label>&nbsp;&nbsp;
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:ListBox ID="listBoxDisparo4_tipoOperacion" runat="server" Height="70px" Width="100px">
                                            <asp:ListItem Value="0" Text="<%$ Resources:TextoDisparo1_TiempoDefinido %>"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="<%$ Resources:TextoDisparo1_IECNI %>"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="<%$ Resources:TextoDisparo1_IECVI %>"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="<%$ Resources:TextoDisparo1_IECEI %>"></asp:ListItem>
                                            <asp:ListItem Value="4" Text="<%$ Resources:TextoDisparo1_IECLTI %>"></asp:ListItem>
                                            <asp:ListItem Value="5" Text="<%$ Resources:TextoDisparo1_ANSIMI %>"></asp:ListItem>
                                            <asp:ListItem Value="6" Text="<%$ Resources:TextoDisparo1_ANSIVI %>"></asp:ListItem>
                                            <asp:ListItem Value="7" Text="<%$ Resources:TextoDisparo1_ANSIEI %>"></asp:ListItem>
                                        </asp:ListBox>
                                    </td>

                                    <td>
                                        <asp:ListBox ID="listBoxDisparo4_tipoReset" runat="server" Height="40px" Width="100px">
                                            <asp:ListItem Value="0" Text="<%$ Resources:TextoDisparo1_TiempoFijo %>"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="<%$ Resources:TextoDisparo1_Curva %>"></asp:ListItem>
                                        </asp:ListBox>
                                    </td>
                                    
                                    <td>
                                        <asp:CheckBox ID="checkDisparo4_habilitaModificadores" runat="server" />
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label27" runat="server" Text="<%$ Resources:lblDisparo1_corrArranque %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(3A - 6500A)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label28" runat="server" Text="<%$ Resources:lblDisparo1_modCorrMaxActuacion %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(10A - 6500A)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label29" runat="server" Text="<%$ Resources:lblDisparo1_modTd %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(0,01 - 9)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo4_corrArranque" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator14" errormessage="Favor ingrese valor entre 3-6500." forecolor="Red" 
                                            controltovalidate="txtDisparo4_corrArranque" minimumvalue="3" maximumvalue="6500" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo4_modCorrMaxActuacion" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator19" errormessage="Favor ingrese valor entre 10-6500." forecolor="Red" 
                                            controltovalidate="txtDisparo4_modCorrMaxActuacion" minimumvalue="10" maximumvalue="6500" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo4_modTd" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator24" errormessage="Favor ingrese valor entre 0,01-9." forecolor="Red" 
                                            controltovalidate="txtDisparo4_modTd" minimumvalue="0,01" maximumvalue="9" runat="server" Type="Double">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label30" runat="server" Text="<%$ Resources:lblDisparo1_tiempoDisparoDefinido %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label31" runat="server" Text="<%$ Resources:lblDisparo1_tiempoResetCiclo %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(1s - 300s)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label32" runat="server" Text="<%$ Resources:lblDisparo1_tiempoApertura %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(500ms - 30.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo4_tiempoDisparoDefinido" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator29" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo4_tiempoDisparoDefinido" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo4_tiempoResetCiclo" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="3" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator34" errormessage="Favor ingrese valor entre 1-300." forecolor="Red" 
                                            controltovalidate="txtDisparo4_tiempoResetCiclo" minimumvalue="1" maximumvalue="300" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo4_tiempoApertura" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator39" errormessage="Favor ingrese valor entre 500-30.000." forecolor="Red" 
                                            controltovalidate="txtDisparo4_tiempoApertura" minimumvalue="500" maximumvalue="30000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label33" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoMaxRespuesta %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(10ms - 60.000ms)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label34" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoMinRespuesta %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label35" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoDefIMaxAct %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo4_modTiempoMaxRespuesta" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator44" errormessage="Favor ingrese valor entre 10-60.000." forecolor="Red" 
                                            controltovalidate="txtDisparo4_modTiempoMaxRespuesta" minimumvalue="10" maximumvalue="60000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo4_modTiempoMinRespuesta" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator47" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo4_modTiempoMinRespuesta" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo4_modTiempoDefIMaxAct" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator54" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo4_modTiempoDefIMaxAct" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>

                                        &nbsp;<asp:Label ID="Label36" runat="server" Text="<%$ Resources:lblDisparo1_modRetardoAdicional %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(0ms - 10.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo4_modRetardoAdicional" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator57" errormessage="Favor ingrese valor entre 0-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo4_modRetardoAdicional" minimumvalue="0" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                    </asp:Panel>

                    <asp:CollapsiblePanelExtender ID="CollapsiblePanelDisparo5" runat="server"
                        TargetControlID="ContentOperacionDisparo5"
                        ExpandControlID="TitleOperacionDisparo5"
                        CollapseControlID="TitleOperacionDisparo5"
                        Collapsed="True"
                        TextLabelID="LabelMostrarActual"
                        ExpandedText="<%$ Resources:ExpandOperacionGeneral %>"
                        CollapsedText="<%$ Resources:CollapseOperacionGeneral %>"
                        ImageControlID="ImageDisparo5"
                        ExpandedImage="~/Images/collapse.jpg"
                        CollapsedImage="~/Images/expand.jpg"
                        SuppressPostBack="true"></asp:CollapsiblePanelExtender>
                    <asp:Panel ID="TitleOperacionDisparo5" runat="server" CssClass="collapsePanelHeader styleCollapseDisparo">
                        <asp:Image ID="ImageDisparo5" runat="server" ImageUrl="~/Images/expand.jpg" />
                        &nbsp;<asp:Label ID="lblTextTitleOperacionDisparo5" runat="server" Text="<%$ Resources:lblTextTitleOperacionDisparo5 %>"></asp:Label>&nbsp;&nbsp;
                    </asp:Panel>
                    <asp:Panel ID="ContentOperacionDisparo5" runat="server">
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label37" runat="server" Text="<%$ Resources:lblOpGeneral_modoOperacion %>"></asp:Label>&nbsp;&nbsp;
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label38" runat="server" Text="<%$ Resources:lblDisp1_tipoReset %>"></asp:Label>&nbsp;&nbsp;
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label39" runat="server" Text="<%$ Resources:lblDisparo1_habilitaModificadores %>"></asp:Label>&nbsp;&nbsp;
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:ListBox ID="listBoxDisparo5_tipoOperacion" runat="server" Height="70px" Width="100px">
                                            <asp:ListItem Value="0" Text="<%$ Resources:TextoDisparo1_TiempoDefinido %>"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="<%$ Resources:TextoDisparo1_IECNI %>"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="<%$ Resources:TextoDisparo1_IECVI %>"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="<%$ Resources:TextoDisparo1_IECEI %>"></asp:ListItem>
                                            <asp:ListItem Value="4" Text="<%$ Resources:TextoDisparo1_IECLTI %>"></asp:ListItem>
                                            <asp:ListItem Value="5" Text="<%$ Resources:TextoDisparo1_ANSIMI %>"></asp:ListItem>
                                            <asp:ListItem Value="6" Text="<%$ Resources:TextoDisparo1_ANSIVI %>"></asp:ListItem>
                                            <asp:ListItem Value="7" Text="<%$ Resources:TextoDisparo1_ANSIEI %>"></asp:ListItem>
                                        </asp:ListBox>
                                    </td>

                                    <td>
                                        <asp:ListBox ID="listBoxDisparo5_tipoReset" runat="server" Height="40px" Width="100px">
                                            <asp:ListItem Value="0" Text="<%$ Resources:TextoDisparo1_TiempoFijo %>"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="<%$ Resources:TextoDisparo1_Curva %>"></asp:ListItem>
                                        </asp:ListBox>
                                    </td>
                                    
                                    <td>
                                        <asp:CheckBox ID="checkDisparo5_habilitaModificadores" runat="server" />
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label40" runat="server" Text="<%$ Resources:lblDisparo1_corrArranque %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(3A - 6500A)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label41" runat="server" Text="<%$ Resources:lblDisparo1_modCorrMaxActuacion %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(10A - 6500A)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label42" runat="server" Text="<%$ Resources:lblDisparo1_modTd %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(0,01 - 9)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo5_corrArranque" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator15" errormessage="Favor ingrese valor entre 3-6500." forecolor="Red" 
                                            controltovalidate="txtDisparo5_corrArranque" minimumvalue="3" maximumvalue="6500" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo5_modCorrMaxActuacion" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator20" errormessage="Favor ingrese valor entre 10-6500." forecolor="Red" 
                                            controltovalidate="txtDisparo5_modCorrMaxActuacion" minimumvalue="10" maximumvalue="6500" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo5_modTd" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator25" errormessage="Favor ingrese valor entre 0,01-9." forecolor="Red" 
                                            controltovalidate="txtDisparo5_modTd" minimumvalue="0,01" maximumvalue="9" runat="server" Type="Double">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label43" runat="server" Text="<%$ Resources:lblDisparo1_tiempoDisparoDefinido %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label44" runat="server" Text="<%$ Resources:lblDisparo1_tiempoResetCiclo %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(1s - 300s)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label45" runat="server" Text="<%$ Resources:lblDisparo1_tiempoApertura %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(500ms - 30.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo5_tiempoDisparoDefinido" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator30" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo5_tiempoDisparoDefinido" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo5_tiempoResetCiclo" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="3" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator35" errormessage="Favor ingrese valor entre 1-300." forecolor="Red" 
                                            controltovalidate="txtDisparo5_tiempoResetCiclo" minimumvalue="1" maximumvalue="300" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo5_tiempoApertura" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator40" errormessage="Favor ingrese valor entre 500-30.000." forecolor="Red" 
                                            controltovalidate="txtDisparo5_tiempoApertura" minimumvalue="500" maximumvalue="30000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label46" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoMaxRespuesta %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(10ms - 60.000ms)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="Label47" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoMinRespuesta %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="Label48" runat="server" Text="<%$ Resources:lblDisparo1_modTiempoDefIMaxAct %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(20ms - 10.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo5_modTiempoMaxRespuesta" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator45" errormessage="Favor ingrese valor entre 10-60.000." forecolor="Red" 
                                            controltovalidate="txtDisparo5_modTiempoMaxRespuesta" minimumvalue="10" maximumvalue="60000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtDisparo5_modTiempoMinRespuesta" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator46" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo5_modTiempoMinRespuesta" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtDisparo5_modTiempoDefIMaxAct" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator55" errormessage="Favor ingrese valor entre 20-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo5_modTiempoDefIMaxAct" minimumvalue="20" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                        <fieldset>
                            <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="Label49" runat="server" Text="<%$ Resources:lblDisparo1_modRetardoAdicional %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(0ms - 10.000ms)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDisparo5_modRetardoAdicional" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator56" errormessage="Favor ingrese valor entre 0-10.000." forecolor="Red" 
                                            controltovalidate="txtDisparo5_modRetardoAdicional" minimumvalue="0" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                        </fieldset>
                    </asp:Panel>

                </asp:Panel>

                <br />

                <asp:CollapsiblePanelExtender ID="CollapsiblePanelParametrosEquipo" runat="server"
                    TargetControlID="ContentParametrosEquipo"
                    ExpandControlID="TitleParametrosEquipo"
                    CollapseControlID="TitleParametrosEquipo"
                    Collapsed="True"
                    TextLabelID="LabelMostrarActual"
                    ExpandedText="<%$ Resources:ExpandOperacionGeneral %>"
                    CollapsedText="<%$ Resources:CollapseOperacionGeneral %>"
                    ImageControlID="ImageHardware"
                    ExpandedImage="~/Images/collapse.jpg"
                    CollapsedImage="~/Images/expand.jpg"
                    SuppressPostBack="true"></asp:CollapsiblePanelExtender>
                <asp:Panel ID="TitleParametrosEquipo" runat="server" CssClass="collapsePanelHeader styleCollapse">
                    <asp:Image ID="ImageHardware" runat="server" ImageUrl="~/Images/expand.jpg" />
                    &nbsp;<asp:Label ID="lblTextTitleParametrosEquipo" runat="server" Text="<%$ Resources:lblTextTitleParametrosEquipo %>"></asp:Label>&nbsp;&nbsp;
                </asp:Panel>
                <asp:Panel ID="ContentParametrosEquipo" runat="server">
                    <fieldset>
                        <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelHardware_adcCargaLOWCapacitorDisparo" runat="server" Text="<%$ Resources:lblHardware_adcCargaLOWCapacitorDisparo %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(40v - 69v)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="LabelHardware_adcCargaOKCapacitorDisparo" runat="server" Text="<%$ Resources:lblHardware_adcCargaOKCapacitorDisparo %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(70v - 80v)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="LabelHardware_adcCargaLOWFuenteBaja" runat="server" Text="<%$ Resources:lblHardware_adcCargaLOWFuenteBaja %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(1,8v - 2,5v)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtHardware_adcCargaLOWCapacitorDisparo" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="3" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator61" errormessage="Favor ingrese valor entre 40-69." forecolor="Red" 
                                            controltovalidate="txtHardware_adcCargaLOWCapacitorDisparo" minimumvalue="40" maximumvalue="69" runat="server" Type="Double">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtHardware_adcCargaOKCapacitorDisparo" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="70px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator62" errormessage="Favor ingrese valor entre 70-80." forecolor="Red" 
                                            controltovalidate="txtHardware_adcCargaOKCapacitorDisparo" minimumvalue="70" maximumvalue="80" runat="server" Type="Double">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtHardware_adcCargaLOWFuenteBaja" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="70px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator63" errormessage="Favor ingrese valor entre 1,8-2,5" forecolor="Red" 
                                            controltovalidate="txtHardware_adcCargaLOWFuenteBaja" minimumvalue="1,8" maximumvalue="2,5" runat="server" Type="Double">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset>
                        <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelHardware_adcCargaOKFuenteBaja" runat="server" Text="<%$ Resources:lblHardware_adcCargaOKFuenteBaja %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(4,5v - 5,1v)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="LabelHardware_numOperacionesBotellaCercanoAlMax" runat="server" Text="<%$ Resources:lblHardware_numOperacionesBotellaCercanoAlMax %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(1000 - 8000)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="LabelHardware_numOperacionesBotellaLlegaAlMax" runat="server" Text="<%$ Resources:lblHardware_numOperacionesBotellaLlegaAlMax %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(8001 - 10.000)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtHardware_adcCargaOKFuenteBaja" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="70px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator64" errormessage="Favor ingrese valor entre 4,5-5,1" forecolor="Red" 
                                            controltovalidate="txtHardware_adcCargaOKFuenteBaja" minimumvalue="4,5" maximumvalue="5,1" runat="server" Type="Double">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtHardware_numOperacionesBotellaCercanoAlMax" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="70px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator65" errormessage="Favor ingrese valor entre 1000-8000" forecolor="Red" 
                                            controltovalidate="txtHardware_numOperacionesBotellaCercanoAlMax" minimumvalue="1000" maximumvalue="8000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtHardware_numOperacionesBotellaLlegaAlMax" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="5" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator66" errormessage="Favor ingrese valor entre 8001-10000" forecolor="Red" 
                                            controltovalidate="txtHardware_numOperacionesBotellaLlegaAlMax" minimumvalue="8001" maximumvalue="10000" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset>
                        <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelHardware_porcentDesgasteBotellaCercanoAlMax" runat="server" Text="<%$ Resources:lblHardware_porcentDesgasteBotellaCercanoAlMax %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(50% - 80%)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="LabelHardware_porcentDesgasteBotellaLlegaAlMax" runat="server" Text="<%$ Resources:lblHardware_porcentDesgasteBotellaLlegaAlMax %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(81% - 100%)</span>
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="LabelHardware_adcCorrMinParaAutoalimentacion50Hz" runat="server" Text="<%$ Resources:lblHardware_adcCorrMinParaAutoalimentacion50Hz %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(3A - 100A)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtHardware_porcentDesgasteBotellaCercanoAlMax" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="2" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator67" errormessage="Favor ingrese valor entre 50%-80%" forecolor="Red" 
                                            controltovalidate="txtHardware_porcentDesgasteBotellaCercanoAlMax" minimumvalue="50" maximumvalue="80" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtHardware_porcentDesgasteBotellaLlegaAlMax" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="3" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator68" errormessage="Favor ingrese valor entre 81%-100%" forecolor="Red" 
                                            controltovalidate="txtHardware_porcentDesgasteBotellaLlegaAlMax" minimumvalue="81" maximumvalue="100" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtHardware_adcCorrMinParaAutoalimentacion50Hz" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="3" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator69" errormessage="Favor ingrese valor entre 3-100" forecolor="Red" 
                                            controltovalidate="txtHardware_adcCorrMinParaAutoalimentacion50Hz" minimumvalue="3" maximumvalue="100" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset>
                        <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelHardware_adcCorrMinParaAutoalimentacion60Hz" runat="server" Text="<%$ Resources:lblHardware_adcCorrMinParaAutoalimentacion60Hz %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(3A - 100A)</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtHardware_adcCorrMinParaAutoalimentacion60Hz" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="3" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator70" errormessage="Favor ingrese valor entre 3-100" forecolor="Red" 
                                            controltovalidate="txtHardware_adcCorrMinParaAutoalimentacion60Hz" minimumvalue="3" maximumvalue="100" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                    </fieldset>
                </asp:Panel>

                <br />

                <asp:CollapsiblePanelExtender ID="CollapsiblePanelComunicacion" runat="server"
                    TargetControlID="ContentComunicacion"
                    ExpandControlID="TitleComunicacion"
                    CollapseControlID="TitleComunicacion"
                    Collapsed="True"
                    TextLabelID="LabelMostrarActual"
                    ExpandedText="<%$ Resources:ExpandOperacionGeneral %>"
                    CollapsedText="<%$ Resources:CollapseOperacionGeneral %>"
                    ImageControlID="ImageComunicacion"
                    ExpandedImage="~/Images/collapse.jpg"
                    CollapsedImage="~/Images/expand.jpg"
                    SuppressPostBack="true"></asp:CollapsiblePanelExtender>
                <asp:Panel ID="TitleComunicacion" runat="server" CssClass="collapsePanelHeader styleCollapse">
                    <asp:Image ID="ImageComunicacion" runat="server" ImageUrl="~/Images/expand.jpg" />
                    &nbsp;<asp:Label ID="lblTextTitleComunicacion" runat="server" Text="<%$ Resources:lblTextTitleComunicacion %>"></asp:Label>&nbsp;&nbsp;
                </asp:Panel>
                <asp:Panel ID="ContentComunicacion" runat="server">
                    <fieldset>
                        <center>
                            <table class="tableClass">
                                <thead class="itemHeader">
                                <tr>
                                    <th>
                                        &nbsp;<asp:Label ID="LabelComunicacion_canalComunicacionRF" runat="server" Text="<%$ Resources:lblComunicacion_canalComunicacionRF %>"></asp:Label>&nbsp;&nbsp;
                                        <br />
                                    <span>(0 - 9)</span>
                                    </th>

                                    <th>
                                        &nbsp;<asp:Label ID="LabelComunicacion_codigoDeGrupo" runat="server" Text="<%$ Resources:lblComunicacion_codigoDeGrupo %>"></asp:Label>&nbsp;&nbsp;<br />
                                    <span>(1 - 10)</span>                                    
                                    </th>
                                    
                                    <th>
                                        &nbsp;<asp:Label ID="LabelComunicacion_canalRfEnMHz" runat="server" Visible="false" Text="<%$ Resources:lblComunicacion_canalRfEnMHz %>"></asp:Label>&nbsp;&nbsp;
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="itemBody">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtComunicacion_canalComunicacionRF" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="1" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator71" errormessage="Favor ingrese valor entre 0-9" forecolor="Red" 
                                            controltovalidate="txtComunicacion_canalComunicacionRF" minimumvalue="0" maximumvalue="9" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtComunicacion_codigoDeGrupo" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="2" Width="50px"></asp:TextBox>
                                        <br />
                                        <asp:rangevalidator ID="Rangevalidator72" errormessage="Favor ingrese valor entre 1-10" forecolor="Red" 
                                            controltovalidate="txtComunicacion_codigoDeGrupo" minimumvalue="1" maximumvalue="10" runat="server" Type="Integer">
                                        </asp:rangevalidator>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtComunicacion_canalRfEnMHz" runat="server"
                                                     CssClass="textInUsuario styleInput" MaxLength="4" Width="50px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </center>
                    </fieldset>
                </asp:Panel>

                <br />

            </div>
            <div class="styleButton">
                <asp:Button ID="butActualizarParams" runat="server" Text="<%$ Resources:TextBotonLeerPrmOnline %>"
                    Enabled="False" OnClick="butActualizarParams_Click" />
            </div>
        </div>
    </form>
</body>
</html>
