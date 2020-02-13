<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditFWT.aspx.cs" Inherits="SistemaGestionRedes.EditFWT" ViewStateMode="Enabled" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
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
    <style type="text/css">
        .style3 {
            width: 4%;
        }

        .turnOnLight {
            animation: blink 1s linear infinite;
        }

        .turnOffLight {
            animation: blink 1s linear infinite;
        }

        @keyframes blink {
            50% {
                opacity: .5;
            }

            75% {
                opacity: .75;
            }

            100% {
                opacity: 1;
            }
        }

        .withoutColor {
            background-color: Transparent;
            background-repeat: no-repeat;
            border: none;
            cursor: pointer;
            overflow: hidden;
            outline: none;
        }

        .modal-backdrop.fade.in {
            opacity: 0.5;
        }

        .modal {
            position: relative;
            width: auto;
            margin-left: auto;
        }
        .centrar {
            position:relative;
            margin-left: 30%;
            margin-right:30%;
        }
    </style>
    <script type="text/javascript">
        function fnClickOK(sender, e) {
            __doPostBack(sender, e);
        }
        function OcultarLabelLecturaOnline() {

            var etiqueta = document.getElementById('lblLecturaOnlineEstadoFWT');
            if (etiqueta) { etiqueta.style.display = 'none'; }


            //document.getElementById('lblLecturaOnlineEstadoFWT').style.display = 'none'; //Se oculta en codigo cliente 
            //form1.lblLecturaOnlineEstadoFWT.visible = false;
            //javascript: window.open("http://www.microsoft.com");

        }
        function VerProcesamientoParametrosFWT() {

            var imagen = document.getElementById('imgEstadoFWT');
            if (imagen) { imagen.style.display = 'inherit'; }




        }
        function flasher() {

            if (document.getElementById("lblMsgErrQtySixIncompatibles")) {

                var d = document.getElementById("lblMsgErrQtySixIncompatibles");

                if (d.value != '') {
                    d.style.color = (d.style.color == 'red' ? 'white' : 'red');
                    setTimeout('flasher()', 1000);
                }
            }

        }

        function showPreguntaFwActDevRT(msgPregunta) {
            return confirm(msgPregunta);
        }

    </script>
    <script>
        function validateSerialArix(idArix, command) {
            sweetAlert({
                title: command + " ARIX",
                text: "Escriba el serial del ARIX para activar comando:",
                type: "input",
                showCancelButton: true,
                closeOnConfirm: false,
                animation: "slide-from-top",
                inputPlaceholder: "Serial",
            },
            function (inputValue) {
                if (inputValue === false) return false;

                if (inputValue === "") {
                    swal.showInputError("Debes escribir el serial");
                    return false
                }
                if (inputValue !== "") {
                    document.getElementById('<%=labelIdArix.ClientID %>').value = idArix;
                    document.getElementById('<%=labelText.ClientID %>').value = inputValue;
                    document.getElementById('<%=labelCommand.ClientID %>').value = command;                       
                    if (inputValue.substring(0, 2).toLocaleLowerCase() == "RI".toLocaleLowerCase() && inputValue.length == 8) {
                        setTimeout(sweetAlert('Datos confirmados', 'Comando en ejecución...', 'info'), 500)                        
                    }
                    document.getElementById("ButtonCommands").click();
                }
                
            })
        }

        function validateSerialArixWithoutParams(idArix, command) {
            document.getElementById('<%=labelIdArix.ClientID %>').value = idArix;
            document.getElementById('<%=labelCommand.ClientID %>').value = command; 
            setTimeout(sweetAlert('Enviando comando', 'Comando en ejecución...', 'info'), 500)
            document.getElementById("ButtonCommandsWithoutParams").click();
        }
    </script>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.0/sweetalert.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.0/sweetalert.min.css"
        rel="stylesheet" type="text/css" />
</head>
<body onload="flasher();">
    <form id="form1" runat="server">
        <div class="rightDiv">
            <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
            </asp:ScriptManager>
            <div class="centerDiv">
                <!-- Modal con info del FWT fechas .... -->
                <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    
                        <div class="card">
                            <div class="card-header">
                                <h5 id="exampleModalLongTitle">Información extra concentrador:
                                    <asp:Label ID="Label6" runat="server" /></h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="card-body centrar">                               
                                    <div class="row">
                                        <strong><asp:Label ID="Label7" runat="server" Text="<%$ Resources:TextFechaMatriculaGestion %>"></asp:Label>:</strong>
                                        <asp:Label ID="lblFechaRegistroGestion" runat="server"></asp:Label>
                                    </div>
                                    <div class="row">
                                        <strong><asp:Label ID="Label29" runat="server" Text="<%$ Resources:TextFechaInstalacion %>"></asp:Label>:</strong>
                                        <asp:Label ID="lblFechaInstalacion" runat="server"></asp:Label>
                                    </div>
                                    <div class="row">
                                        <strong><asp:Label ID="Label43" runat="server" Text="<%$ Resources:TextFechaUltimaConeccion %>"></asp:Label>:</strong>
                                        <asp:Label ID="lblFechaUltimaComunicacion" runat="server"></asp:Label>
                                    </div>
                                    <div class="row">
                                       <strong> <asp:Label ID="Label17" runat="server" Text="<%$ Resources:TextFechaUltimoEnvio %>"></asp:Label>:</strong>
                                        <asp:Label ID="lblFechaUltimoEnvio" runat="server"></asp:Label>
                                    </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-outline-info" data-dismiss="modal">Listo</button>
                            </div>
                        </div>
                    
                </div>


                <table style="width: 100%;" border="0">
                    <tr>
                        <td align="center" bgcolor="#eeeeee">
                            <button type="button" class="btn btn-outline-info" data-toggle="modal" data-target="#exampleModalCenter" data-placement="top" title="Click para ver información extra del concentrador">
                                <i class="fa fa-info fa-1x" runat="server"></i>
                            </button>
                            <font><strong>
                                <asp:Literal ID="Literal1" Text="<%$ Resources:TextosGlobales,TextoSerialFWT %>" runat="server"></asp:Literal></strong></font>:
                        <asp:Label ID="lblId" runat="server" Visible="false" />
                            <asp:Label ID="lblSerial" runat="server" />
                            &nbsp;
                        
                        </td>
                    </tr>
                </table>
                <br />

                <table style="width: 100%;" border="0">
                    <!--<tr>
                        <td align="center" bgcolor="#eeeeee">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="tmrComAct" EventName="Tick" />
                                </Triggers>
                                <ContentTemplate>
                                    <font><strong>
                                <asp:Literal ID="Literal2" Text="<%$ Resources:TextTittleEstadoConcentrador %>" runat="server"></asp:Literal></strong></font>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:Timer ID="tmrComAct" runat="server" Interval="2000" OnTick="tmrComAct_Tick">
                            </asp:Timer>

                        </td>
                    </tr>-->
                </table>
                <asp:UpdatePanel ID="upPanelLeerEstadoOnline" runat="server">
                    <ContentTemplate>
                        <div class="col-md-12 row">
                            <div class="card card-body col-md-4">
                                <div class="row" style="padding-left:20px">
                                    <strong><asp:Label ID="Labe140" runat="server" Text="Comunicación : "></asp:Label></strong>
                                    <asp:Label ID="fwtIsOn" runat="server"></asp:Label>
                                </div>
                                <div class="row" style="padding-left:20px">
                                    <strong><asp:Label ID="Label33" runat="server" Text="IMEI : "></asp:Label></strong>
                                    <asp:Label ID="lblIMEI" runat="server"></asp:Label>
                                </div>
                                <div class="row" style="padding-left:20px">
                                    <strong><asp:Label ID="Label39" runat="server" Text="IMSI : "></asp:Label></strong>
                                    <asp:Label ID="lblIMSI" runat="server"></asp:Label>
                                </div>
                                <div class="row" style="padding-left:20px">
                                    <strong><asp:Label ID="Label36" runat="server" Text="<%$ Resources:TextNivelSenal %>"></asp:Label>:</strong>
                                <asp:Label ID="lblNivelSenal" runat="server"></asp:Label>
                                    <div class="col-12">
                                    </div>
                                    <div>
                                        <table style="background-color: #0b304f;">
                                            <tr>
                                                <td width="100">
                                                    <asp:Image ID="ImgNivelSenal" src="../Images/barGreen.GIF" Width="50%"
                                                        Height="10px" runat="server" Visible="False" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="card card-body col-md-4">
                                <div class="row" style="padding-left:20px">
                                    <strong><asp:Label ID="Label34" runat="server" Text="<%$ Resources:TextVoltajeBateria %>"></asp:Label>:</strong>
                                <asp:Label ID="lblVoltBatt" runat="server"></asp:Label>
                                </div>
                                <div class="row" style="padding-left:20px">
                                    <strong><asp:Label ID="Label37" runat="server" Text="<%$ Resources:TextVoltajeCargador %>"></asp:Label>:</strong>
                                <asp:Label ID="lblVoltCargador" runat="server"></asp:Label>
                                </div>
                                <div class="row" style="padding-left:20px">
                                    <strong><asp:Label ID="Label38" runat="server" Text="<%$ Resources:TextVoltagePanel %>"></asp:Label>:</strong>
                                <asp:Label ID="lblVoltPanel" runat="server"></asp:Label>
                                </div>
                                <div class="row" style="padding-left:20px">
                                    <strong><asp:Label ID="Label42" runat="server" Text="<%$ Resources:TextTemperatura %>"></asp:Label></strong>
                                    <asp:Label ID="lblTemperatura" runat="server"></asp:Label>
                                </div>
                            </div>

                            <div class="card card-body col-md-4">
                                <div class="row" style="padding-left:20px">
                                    <strong><asp:Label ID="Label35" runat="server" Text="<%$ Resources:TextVersionPrograma %>"></asp:Label>:</strong>
                                    <asp:Label ID="lblVerPrograma" runat="server"></asp:Label>
                                </div>
                                <div class="row" style="padding-left:20px">
                                    <strong><asp:Label ID="Label40" runat="server" Text="<%$ Resources:TextVersionMonitor %>"></asp:Label>:</strong>
                                    <asp:Label ID="lblVerMonitor" runat="server"></asp:Label>
                                </div>
                                <div class="row" style="padding-left:20px">
                                    <strong><asp:Label ID="Label41" runat="server" Text="<%$ Resources:TextVersionFwModulo %>"></asp:Label>:</strong>
                                    <asp:Label ID="lblVerFirmwModulo" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>

                        <table style="width: 100%;" border="0">
                            <tr>
                                <td align="right" width="36%" bgcolor="#CCCCCC">
                                    <asp:Button ID="butLeerEstadoFWTOnLine" runat="server" Text="<%$ Resources:TextBotonLeerEstadoOnline %>"
                                        Style="height: 26px" Enabled="False" ToolTip="<%$ Resources:TextToolTipBotonLeerEstado %>"
                                        OnClick="butLeerEstadoFWTOnLine_Click"
                                        OnClientClick="OcultarLabelLecturaOnline()" CssClass="TextBoton" />
                                </td>
                                <td align="center" bgcolor="#CCCCCC">
                                    <asp:UpdateProgress ID="upProgLeerEstadoOnline" runat="server" AssociatedUpdatePanelID="upPanelLeerEstadoOnline">
                                        <ProgressTemplate>
                                            <asp:Literal ID="Literal3" Text="<%$ Resources:TextLeyendoEstadoOnLine %>" runat="server"></asp:Literal>
                                            <asp:Image ID="imgLeerEstadoOnline" runat="server" ImageUrl="~/Images/roller.gif" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                                <td align="left" width="39%" bgcolor="#CCCCCC">
                                    <asp:Label ID="lblLecturaOnlineEstadoFWT" runat="server" Text="" ForeColor="Red"
                                        Font-Bold="True" Visible="False"></asp:Label><br />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:UpdatePanel ID="upPanelResetFWT" runat="server">
                    <ContentTemplate>
                        <table style="width: 100%;" border="0">
                            <tr>
                                <td align="right" width="36%" bgcolor="#CCCCCC">
                                    <asp:Button ID="btnWriteResetFwt" runat="server" Text="<%$ Resources:TextBotonbtnWriteResetFwt %>"
                                        Style="height: 26px" Enabled="False" ToolTip="<%$ Resources:TextToolTipBotonbtnWriteResetFwt %>"
                                        OnClientClick="<%$ Resources: TextJavaScriptSendReset %>"
                                        CssClass="TextBoton" OnClick="btnWriteResetFwt_Click" />
                                </td>
                                <td align="center" bgcolor="#CCCCCC">
                                    <asp:UpdateProgress ID="upProgWriteResetFwt" runat="server" AssociatedUpdatePanelID="upPanelResetFWT">
                                        <ProgressTemplate>
                                            <asp:Literal ID="literalResetEnviando" Text="<%$ Resources:TextEnviandoResetFwt %>" runat="server"></asp:Literal>
                                            <asp:Image ID="imgWriteResetFwt" runat="server" ImageUrl="~/Images/roller.gif" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                                <td align="left" width="39%" bgcolor="#CCCCCC">
                                    <asp:Label ID="lblResetOnLineFWT" runat="server" Text="" ForeColor="Red"
                                        Font-Bold="True" Visible="False"></asp:Label><br />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <div >
                    <asp:HiddenField ID="labelIdArix" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="labelText" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="labelCommand" runat="server"></asp:HiddenField>
                    <asp:Button ID="ButtonCommands" runat="server" OnClick="ExecCommandWithParams" CssClass="hide" />
                    <asp:Button ID="ButtonCommandsWithoutParams" runat="server" OnClick="ExecCommandWithoutParams" CssClass="hide" />
                </div>

                <table style="width: 100%;" border="0">
                    <tr>
                        <td align="center" bgcolor="#eeeeee">
                            <font><strong>
                            <asp:Literal ID="Literal11" Text="<%$ Resources:TextArixRegistrados %>" runat="server"></asp:Literal></strong></font>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" width="100%">
                            <asp:GridView ID="ListArixByFwt" runat="server" AutoGenerateColumns="False"
                                BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px"
                                CellPadding="4" DataSourceID="SqlArixFromFWT" ForeColor="Black"
                                GridLines="Vertical" OnRowDataBound="ListArixByFwt_RowDataBound"
                                OnRowCommand="ListArixByFwt_RowCommand">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField DataField="Serial" HeaderText="<%$ Resources:TextHeaderSerialDevRt %>"
                                        SortExpression="Serial" />
                                    <asp:BoundField DataField="Identificador" HeaderText="<%$ Resources:TextHeaderIdentificador %>"
                                        SortExpression="Identificador" />
                                    <asp:TemplateField HeaderText="<%$ Resources:TextHeaderAbrir %>">
                                        <ItemTemplate>
                                            <asp:Button runat="server" ID="btnAbrirArix" Text="" ToolTip="<%$ Resources:TextToolTipAbrirArix %>"
                                                CommandName="ABRIR" CssClass="TextBoton" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<%$ Resources:TextHeaderCerrar %>">
                                        <ItemTemplate>
                                            <asp:Button runat="server" ID="btnCerrarArix" Text="" ToolTip="<%$ Resources:TextToolTipCerrarArix %>"
                                                CommandName="CERRAR" CssClass="TextBoton" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<%$ Resources:TextHeaderEstado %>">
                                        <ItemTemplate>
                                            <asp:Button runat="server" ID="btnEstadoArix" Text="" ToolTip="<%$ Resources:TextToolTipEstadoArix %>"
                                                CommandName="ESTADO" CssClass="TextBoton" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<%$ Resources:TextHeaderReinicio %>">
                                        <ItemTemplate>
                                            <asp:Button runat="server" ID="btnReinicioArix" Text="" ToolTip="<%$ Resources:TextToolTipReinicioArix %>"
                                                CommandName="REINICIAR" CssClass="TextBoton" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<%$ Resources:TextHeaderAskClock %>">
                                        <ItemTemplate>
                                            <asp:Button runat="server" ID="btnAskClockArix" Text="" ToolTip="<%$ Resources:TextToolTipAskClockArix %>"
                                                CommandName="PREGUNTAR RELOJ" CssClass="TextBoton" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<%$ Resources:TextHeaderUpdClock %>">
                                        <ItemTemplate>
                                            <asp:Button runat="server" ID="btnUpdClockArix" Text="" ToolTip="<%$ Resources:TextToolTipUpdClockArix %>"
                                                CommandName="ACTUALIZAR RELOJ" CssClass="TextBoton" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                                <FooterStyle BackColor="#0b304f" />
                                <HeaderStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle BackColor="#F7F7DE" />
                                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                                <SortedAscendingHeaderStyle BackColor="#848384" />
                                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                                <SortedDescendingHeaderStyle BackColor="#575357" />
                                <SortedAscendingCellStyle BackColor="#FBFBF2"></SortedAscendingCellStyle>
                                <SortedAscendingHeaderStyle BackColor="#848384"></SortedAscendingHeaderStyle>
                                <SortedDescendingCellStyle BackColor="#EAEAD3"></SortedDescendingCellStyle>
                                <SortedDescendingHeaderStyle BackColor="#575357"></SortedDescendingHeaderStyle>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlArixFromFWT" runat="server"
                                ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>"
                                SelectCommand="select arix.Id, arix.Serial, arix.Identificador From ARIXs arix Inner Join FWTs fwt on (fwt.Id = arix.FWTId) Where fwt.Serial = @serialFwt">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblSerial" Name="serialFwt"
                                        PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <div class="alert alert-info">
                            <td align="center" width="100%">
                                <asp:UpdatePanel ID="ProgressUpdLabelApertura" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:Label ID="LabelApertura" runat="server" Text="<%$ Resources:TextSinArixRegistrados %>"></asp:Label>
                                        <asp:Label ID="LabelCerrado" runat="server" Text=""></asp:Label>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </div>

                    </tr>
                </table>

                <table style="width: 100%;" border="0">
                    <tr>
                        <td align="center" bgcolor="#eeeeee">
                            <font><strong>
                                <asp:Literal ID="Literal4" Text="<%$ Resources:TextEquiposMatriculados %>" runat="server"></asp:Literal></strong></font>

                        </td>
                    </tr>
                </table>
                <table style="width: 100%;" border="0">
                    <tr>
                        <td align="right" width="45%">
                            <asp:Label ID="Label1" runat="server" Text="<%$ Resources:TextequiposDisponibles %>"></asp:Label>:
                        <br />
                            <asp:DropDownList ID="ddlFCIsAll" runat="server" CssClass="listInUsuario">
                            </asp:DropDownList>
                        </td>
                        <td align="center" width="10%">
                            <asp:Button ID="butAddFCI" runat="server" Text=">>" OnClick="butAddFCI_Click" />
                            <br />
                            <asp:Button ID="butRemoveFCI" runat="server" Text="<<" OnClick="butRemoveFCI_Click" />
                        </td>
                        <td align="left" width="45%">
                            <table width="100%">
                                <tr>
                                    <td align="center" colspan="2" width="100%">
                                        <asp:Label ID="Label2" runat="server" Text="<%$ Resources:TextEquiposGestionados %>"></asp:Label>:
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" width="15%">
                                        <asp:ListBox ID="listBoxFCIsPropios" runat="server" CssClass="listInUsuario" Height="70px"></asp:ListBox>
                                    </td>
                                    <td align="left" width="85%">
                                        <asp:Button ID="btnClearFCI" runat="server" CssClass="TextBoton"
                                            OnClick="btnClearFCI_Click" Text="Clear"
                                            OnClientClick="<%$ Resources:TextJavaScriptClearBoton %>"
                                            ToolTip="<%$ Resources:TextToolTipBotonClear %>"
                                            Enabled="False" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" width="100%">
                                        <asp:Label ID="lblMsgErrSeleccionFCIClear" runat="server" Font-Size="11px" ForeColor="Red"> </asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblPrivateTypeDeviceForDelete" runat="server" Visible="false"> </asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" width="100%">
                                        <asp:UpdatePanel ID="updatePanelVerificarQtySix" runat="server">
                                            <ContentTemplate>
                                                <asp:Label ID="lblMsgErrQtySixIncompatibles" runat="server" Font-Size="11px" ForeColor="Red" Visible="false">
                                                </asp:Label>
                                                <asp:Timer ID="timerQtySixIncompatible" runat="server" Enabled="False"
                                                    Interval="20000" OnTick="timerQtySixIncompatible_Tick">
                                                </asp:Timer>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                </table>

                <table border="0" width="100%">
                    <tr>
                        <td align="center" bgcolor="#eeeeee" width="100%">
                            <font><strong>
                                <asp:Literal ID="Literal10" Text="<%$ Resources:TextTittleAdminFirmwareDevRt %>" runat="server"></asp:Literal></strong></font>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" width="100%">
                            <asp:Label ID="Label5" runat="server"
                                Text="<%$ Resources:TextTittleFirmwareCargadoDEVRT %>" Font-Bold="True"
                                Font-Italic="False" Font-Size="11px"></asp:Label>
                            <asp:Label ID="lblVersionFwDevRTCargado" runat="server" Text="" Font-Bold="True" Font-Italic="False" Font-Size="11px"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                        <td align="center" valign="top" style="width: 50%;">
                            <asp:UpdatePanel ID="upPanelActFirmwareDevicesFci" runat="server">
                                <ContentTemplate>
                                    <asp:Timer ID="tmrActFirmwareDevFci" runat="server" Enabled="false" Interval="1000"
                                        OnTick="tmrActFirmware_TickFci">
                                    </asp:Timer>
                                    <asp:Label ID="lblEstadoACTFirmwareDevFci" runat="server" /><br />
                                    <asp:Label ID="lblPorcentajeActFirmwareDevFci" runat="server" Visible="False" /><br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="background-color: #B5CCFF;">
                                        <tr>
                                            <td width="100" align="left">
                                                <asp:Image ID="ImgPorcActFirmwareDevFci" src="../Images/bar.GIF" Width="50%"
                                                    Height="10px" runat="server" Visible="False" /></td>
                                        </tr>
                                    </table>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdateProgress ID="upProgActParametrosOnlineDevFci" AssociatedUpdatePanelID="upPanelActFirmwareDevicesFci" runat="server">
                                <ProgressTemplate>
                                    <asp:Label ID="lblEnviandoFirmwareDevFci" runat="server" Text="<%$ Resources:TextEnviandoFirmware %>"></asp:Label>
                                    <asp:Image ID="imgEnviandoDevFci" runat="server" ImageUrl="~/Images/roller.gif" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" width="100%">
                            <asp:Label ID="Label18" runat="server"
                                Text="<%$ Resources:TextTittleFirmwareCargadoDEVRT_ARIX %>" Font-Bold="True"
                                Font-Italic="False" Font-Size="11px"></asp:Label>
                            <asp:Label ID="lblVersionFwDevRTCargadoARIX" runat="server" Text="" Font-Bold="True" Font-Italic="False" Font-Size="11px"></asp:Label>


                        </td>

                    </tr>
                    <tr>

                        <td align="center" valign="top" style="width: 50%;">
                            <asp:UpdatePanel ID="upPanelActFirmwareDevices" runat="server">
                                <ContentTemplate>
                                    <asp:Timer ID="tmrActFirmwareDev" runat="server" Enabled="false" Interval="1000"
                                        OnTick="tmrActFirmware_TickArix">
                                    </asp:Timer>
                                    <asp:Label ID="lblEstadoACTFirmwareDev" runat="server" /><br />
                                    <asp:Label ID="lblPorcentajeActFirmwareDev" runat="server" Visible="False" /><br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="background-color: #B5CCFF;">
                                        <tr>
                                            <td width="100" align="left">
                                                <asp:Image ID="ImgPorcActFirmwareDev" src="../Images/bar.GIF" Width="50%"
                                                    Height="10px" runat="server" Visible="False" /></td>
                                        </tr>
                                    </table>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdateProgress ID="upProgActParametrosOnlineDev" AssociatedUpdatePanelID="upPanelActFirmwareDevices" runat="server">
                                <ProgressTemplate>
                                    <asp:Label ID="lblEnviandoFirmwareDev" runat="server" Text="<%$ Resources:TextEnviandoFirmware %>"></asp:Label>
                                    <asp:Image ID="imgEnviandoDev" runat="server" ImageUrl="~/Images/roller.gif" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" width="100%">
                            <asp:GridView ID="GVEquiposRemotos" runat="server" AutoGenerateColumns="False"
                                BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px"
                                CellPadding="4" DataSourceID="SqlDSDevsRT" ForeColor="Black"
                                GridLines="Vertical" OnRowDataBound="GVEquiposRemotos_RowDataBound"
                                OnRowCommand="GVEquiposRemotos_RowCommand">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField DataField="Serial" HeaderText="<%$ Resources:TextHeaderSerialDevRt %>"
                                        SortExpression="Serial" />
                                    <asp:BoundField DataField="VersionFw" HeaderText="<%$ Resources:TextHeaderVersionFw %>"
                                        SortExpression="VersionFw" />
                                    <asp:BoundField DataField="Portje" HeaderText="<%$ Resources:TextHeaderPorcentajeUpgrade %>"
                                        SortExpression="Portje" />
                                    <asp:BoundField DataField="FechaSolicitudToProxVersionFW"
                                        HeaderText="<%$ Resources:TextHeaderFechaSolicitud %>"
                                        SortExpression="FechaSolicitudToProxVersionFW" />

                                    <%--                                <asp:BoundField DataField="Activar" HeaderText="<%$ Resources:TextHeaderActivar %>" ReadOnly="True" 
                                    SortExpression="Activar" />--%>

                                    <%--<asp:ButtonField DataTextField="Activar" SortExpression="Activar" HeaderText="<%$ Resources:TextHeaderActivar %>" 
                                    Text="Activar" />--%>

                                    <asp:TemplateField HeaderText="<%$ Resources:TextHeaderActivar %>">
                                        <ItemTemplate>
                                            <%--<asp:HyperLink ID="lnkActivar" runat="server" ToolTip="<%$ Resources:TextToolTipActivarFwDevRt %>">[Activar]</asp:HyperLink>
                                        <asp:LinkButton ID="lnkActivar" runat="server" ToolTip="<%$ Resources:TextToolTipActivarFwDevRt %>" OnClientClick="return showalert();">[Activar]</asp:LinkButton>
                                        <asp:LinkButton ID="lnkActivar" runat="server" ToolTip="<%$ Resources:TextToolTipActivarFwDevRt %>">[Activar]</asp:LinkButton>--%>
                                            <asp:Button runat="server" ID="btnActivar" Text="" ToolTip="<%$ Resources:TextToolTipActivarFwDevRt %>"
                                                CommandName="Activar" CssClass="TextBoton" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="<%$ Resources:TextHeaderCancelar %>">
                                        <ItemTemplate>
                                            <asp:Button runat="server" ID="btnCancelar" Text="" ToolTip="<%$ Resources:TextToolTipCancelarFwDevRt %>"
                                                CommandName="Cancelar" CssClass="TextBoton" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                                <FooterStyle BackColor="#0b304f" />
                                <HeaderStyle BackColor="#0b304f" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle BackColor="#F7F7DE" />
                                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                                <SortedAscendingHeaderStyle BackColor="#848384" />
                                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                                <SortedDescendingHeaderStyle BackColor="#575357" />
                                <SortedAscendingCellStyle BackColor="#FBFBF2"></SortedAscendingCellStyle>
                                <SortedAscendingHeaderStyle BackColor="#848384"></SortedAscendingHeaderStyle>
                                <SortedDescendingCellStyle BackColor="#EAEAD3"></SortedDescendingCellStyle>
                                <SortedDescendingHeaderStyle BackColor="#575357"></SortedDescendingHeaderStyle>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDSDevsRT" runat="server"
                                ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>"
                                SelectCommand="pa_consultar_DEVsRT_admin_firmware"
                                SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblSerial" Name="serialFwt"
                                        PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>

                <br />
                <section class="col-md-12 row">
                    <div class="card bg-light col-md-3 text-black  centerDiv" style="background: #F8F9FA; text-align: right; padding: 0px 15px; border-bottom: 0px; border-right: 0px; border-left: 1px solid rgba(0,0,0,.125); border-radius: .25rem;">
                        <div class="card bg-light  text-black centerDiv" style="border-bottom: 0px; border-right: 0px; border-left: 0px;">
                            <div class="card-header" align="center">
                                <font><strong>
                                <asp:Literal ID="Literal8" Text="<%$ Resources:TextTittleUbicacion %>" runat="server"></asp:Literal></strong></font>
                            </div>
                            <div class="card-body">
                                <div class="form-group pull-left">
                                    <asp:Label ID="Label8" runat="server" Text="<%$ Resources:TextosGlobales,TextoCalleKra %>" CssClass="col-form-label col-sm-3"></asp:Label>

                                    <asp:TextBox runat="server" ID="txtCalle"
                                        CssClass="form-control" Height="30px" Width="80px"></asp:TextBox>
                                    &nbsp;
                        <asp:RequiredFieldValidator ID="ReqValCalle" runat="server" ControlToValidate="txtCalle"
                            ForeColor="Red" SetFocusOnError="True" ErrorMessage="<%$ Resources:ReqValCalleMsgErr %>"
                            ValidationGroup="datosBasicos">*</asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group pull-left">
                                    <asp:Label ID="Label9" runat="server" Text="<%$ Resources:TextosGlobales,TextoNumeroDireccion %>" CssClass="col-form-label col-sm-4"></asp:Label>

                                    <asp:TextBox runat="server" ID="txtNumero"
                                        CssClass="form-control" Height="30px" Width="80px"></asp:TextBox>
                                    &nbsp;
                        <asp:RequiredFieldValidator ID="ReqValNumero" runat="server" ControlToValidate="txtNumero"
                            ForeColor="Red" SetFocusOnError="True"
                            ErrorMessage="<%$ Resources:ReqValNumeroMsgErr %>" ValidationGroup="datosBasicos">*</asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group pull-left">
                                    <asp:Label ID="Label13" runat="server" Text="<%$ Resources:TextosGlobales,TextoLatitud %>" CssClass="col-form-label col-sm-4"></asp:Label>

                                    <asp:TextBox runat="server" ID="txtLatitud" CssClass="form-control"
                                        MaxLength="6" Height="30px" Width="80px"></asp:TextBox>
                                </div>
                                <div class="form-group pull-left">
                                    <asp:Label ID="Label14" runat="server" Text="<%$ Resources:TextosGlobales,TextoLongitud %>" CssClass="col-form-label col-sm-4"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtLongitud"
                                        CssClass="form-control" MaxLength="6" Height="30px" Width="80px"></asp:TextBox>
                                </div>
                                <div class="form-group pull-left">
                                    <asp:Label ID="Label54" runat="server" Text="<%$ Resources:TextosGlobales,TextCiudad %>"
                                        CssClass="col-form-label col-sm-4"></asp:Label>
                                    <asp:DropDownList ID="txtCiudad" runat="server" Width="120px"
                                        OnDataBound="txtCiudad_DataBound">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="card bg-light  text-black  centerDiv" style="border-bottom: 0px; border-right: 0px; border-left: 0px;">
                            <div class="card-header" align="center">
                                <font><strong>
                                <asp:Literal ID="Literal5" Text="<%$ Resources:TextGestionElectrica %>" runat="server"></asp:Literal></strong></font>
                            </div>
                            <div class="card-body">
                                <div class="form-group pull-left">
                                    <asp:Label ID="Label11" runat="server" Text="<%$ Resources:TextosGlobales,TextoCircuito %>" CssClass="col-form-label col-sm-4"></asp:Label>

                                    <asp:TextBox runat="server" ID="txtCircuito"
                                        CssClass="form-control" Height="30px" Width="80px"></asp:TextBox>
                                    &nbsp;<asp:RequiredFieldValidator ID="ReqValCircuito" runat="server" ControlToValidate="txtCircuito"
                                        ForeColor="Red" SetFocusOnError="True" ErrorMessage="<%$ Resources:ReqValCircuitoMsgErr %>"
                                        ValidationGroup="datosBasicos">*</asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group pull-left">
                                    <asp:Label ID="Label12" runat="server" Text="<%$ Resources:TextosGlobales,TextoSeccionTramo %>"
                                        CssClass="col-form-label col-sm-4"></asp:Label>

                                    <asp:TextBox runat="server" ID="txtTramo"
                                        CssClass="form-control" Height="30px" Width="80px"></asp:TextBox>
                                    &nbsp;<asp:RequiredFieldValidator ID="ReqValTramo" runat="server" ControlToValidate="txtTramo"
                                        ForeColor="Red" SetFocusOnError="True" ErrorMessage="<%$ Resources:ReqValTramoMsgErr %>"
                                        ValidationGroup="datosBasicos">*</asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group pull-left">
                                    <asp:Label ID="Label72" runat="server" Text="<%$ Resources:TextosGlobales,TextoNodo %>" CssClass="col-form-label col-sm-4"></asp:Label>

                                    <asp:TextBox runat="server" ID="txtNodo"
                                        CssClass="form-control" Height="30px" Width="80px"></asp:TextBox>
                                </div>
                                <div class="form-group pull-left">
                                    <asp:Label ID="Label74" runat="server" Text="<%$ Resources:TextosGlobales,TextoCodigoFWT %>" CssClass="col-form-label col-sm-5"></asp:Label>

                                    <asp:TextBox ID="txtCodigoCorporativo" runat="server" CssClass="form-control"
                                        MaxLength="50" Height="30px" Width="80px"></asp:TextBox>
                                </div>
                                <div class="form-group pull-left row">
                                    <asp:Label ID="Label10" runat="server" Text="<%$ Resources:TextosGlobales,TextoSubestacion %>"
                                        CssClass="col-form-label"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtSubEstacion" Height="30px"
                                        CssClass="form-control col-sm-7" TextMode="MultiLine"></asp:TextBox>
                                    &nbsp;<asp:RequiredFieldValidator ID="ReqValSubEsta" runat="server" ControlToValidate="txtSubEstacion"
                                        ForeColor="Red" SetFocusOnError="True" ErrorMessage="<%$ Resources:ReqValSubEstaMsgErr %>"
                                        ValidationGroup="datosBasicos">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card bg-light col-md-9 text-black  centerDiv" style="border-bottom: 0px solid rgba(0,0,0,.125);">
                        <div class="card-header" align="center">
                            <font><strong>
                                <asp:Literal ID="Literal7" Text="<%$ Resources:TextTittleConectividad %>" runat="server"></asp:Literal></strong></font>
                        </div>
                        <div class="card-body">
                            <asp:ValidationSummary ID="ValSumDatosNoActualizables" runat="server"
                                CssClass="TextError" ValidationGroup="datosBasicos" />
                            <div class="form-group row">
                                <div class="col-md-4">
                                    <asp:Label ID="Label22" runat="server" Text="<%$ Resources:TextDirIp %>"
                                        CssClass="col-form-label col-sm-2"></asp:Label>

                                    <asp:TextBox ID="txtIpGestion" runat="server" CssClass="form-control"
                                        MaxLength="15" OnTextChanged="TextBox_TextChanged" Height="30px" Width="120px"></asp:TextBox>
                                    &nbsp;<asp:RequiredFieldValidator ID="ReqValIPGestion" runat="server"
                                        ControlToValidate="txtIpGestion" ErrorMessage="<%$ Resources:ReqValIPGestionMsgErr %>"
                                        ForeColor="Red" SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValIPGestion" runat="server"
                                        ControlToValidate="txtIpGestion" ErrorMessage="<%$ Resources:RegExValIPGestionMsgErr %>"
                                        ForeColor="Red" SetFocusOnError="True"
                                        ValidationExpression="\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"
                                        ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>

                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label23" runat="server" Text="<%$ Resources:TextPuerto %>"
                                        CssClass="col-form-label col-sm-2"></asp:Label>

                                    <asp:TextBox ID="txtPuertoGestion" runat="server" CssClass="form-control"
                                        MaxLength="5" OnTextChanged="TextBox_TextChanged" Height="30px" Width="80px"></asp:TextBox>
                                    &nbsp;
                        <asp:RequiredFieldValidator ID="ReqValGestion" runat="server"
                            ControlToValidate="txtPuertoGestion"
                            ErrorMessage="<%$ Resources:ReqValGestionMsgErr %>" ForeColor="Red"
                            SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExpValPtoGestion" runat="server"
                                        ControlToValidate="txtPuertoGestion"
                                        ErrorMessage="<%$ Resources:RegExpValPtoGestionMsgErr %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationExpression="[0-9]{4,5}"
                                        ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValPtoGestion" runat="server"
                                        ControlToValidate="txtPuertoGestion"
                                        ErrorMessage="<%$ Resources:RanValPtoGestion %>" ForeColor="Red"
                                        MaximumValue="65535" MinimumValue="1025" SetFocusOnError="True"
                                        ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label76" runat="server" Text="<%$ Resources:TextDirIpAlternativa %>"
                                        CssClass="col-form-label col-sm-2"></asp:Label>
                                    <asp:TextBox ID="txtIpGestionAlternativa" runat="server" CssClass="form-control"
                                        MaxLength="15" OnTextChanged="TextBox_TextChanged" Height="30px" Width="120px" ToolTip="<%$ Resources:ToolTipGestionAlternativa %>"></asp:TextBox>

                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValIPGestionAlternativa" runat="server"
                                        ControlToValidate="txtIpGestionAlternativa" ErrorMessage="<%$ Resources:RegExValIPGestionMsgErr1 %>"
                                        ForeColor="Red" SetFocusOnError="True"
                                        ValidationExpression="\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"
                                        ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>&nbsp;
                                </div>

                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">
                                    <asp:Label ID="Label4" runat="server" Text="<%$ Resources:TextPuertoAlternativo %>"
                                        CssClass="col-form-label col-sm-2"></asp:Label>
                                    <asp:TextBox ID="txtPuertoGestionAlternativo" runat="server" CssClass="form-control"
                                        MaxLength="5" OnTextChanged="TextBox_TextChanged" Height="30px" Width="80px"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label20" runat="server" Text="<%$ Resources:TextUsuarioAPN %>" CssClass="col-form-label col-sm-2"></asp:Label>
                                    <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control"
                                        OnTextChanged="TextBox_TextChanged" Height="30px" Width="80px"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label19" runat="server" Text="APN" CssClass="col-form-label col-sm-2"></asp:Label>
                                    <asp:TextBox ID="txtAPN" runat="server" CssClass="form-control"
                                        OnTextChanged="TextBox_TextChanged" Height="30px" Width="160px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqValAPN" runat="server"
                                        ControlToValidate="txtAPN" ErrorMessage="<%$ Resources:ReqValAPNMsgErr %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                                </div>

                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">
                                    <asp:Label ID="Label21" runat="server" Text="Password" CssClass="col-form-label col-sm-2"></asp:Label>
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"
                                        OnTextChanged="TextBox_TextChanged" Height="30px" Width="80px"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label28" runat="server" Text="Repeat" CssClass="col-form-label col-sm-2"></asp:Label>
                                    <asp:TextBox ID="txtRePassword" runat="server" CssClass="form-control"
                                        OnTextChanged="TextBox_TextChanged" Height="30px" Width="80px"></asp:TextBox>
                                    <asp:CompareValidator ID="CompValRePWD" runat="server"
                                        ControlToCompare="txtPassword" ControlToValidate="txtRePassword"
                                        ErrorMessage="<%$ Resources:CompValRePWDMsgErr %>" ForeColor="Red"
                                        ValidationGroup="edicionFWT">*</asp:CompareValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label66" runat="server" Text="<%$ Resources:TextBandaGSM %>" CssClass="col-form-label col-sm-2"></asp:Label>
                                    <asp:DropDownList ID="prmDDLBandaGsm" runat="server" Font-Size="11px"
                                        OnSelectedIndexChanged="TextBox_TextChanged" Width="100px">
                                        <asp:ListItem Value="0">PGSM_MODE</asp:ListItem>
                                        <asp:ListItem Value="1">DCS_MODE</asp:ListItem>
                                        <asp:ListItem Value="2">PCS_MODE</asp:ListItem>
                                        <asp:ListItem Value="3">EGSM_DCS_MODE</asp:ListItem>
                                        <asp:ListItem Value="4">GSM850_PCS_MODE</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">
                                    <asp:Label ID="Label46" runat="server" Text="<%$ Resources:TextIntentosPaquetes %>"
                                        CssClass="col-form-label col-sm-2"></asp:Label>

                                    <asp:TextBox ID="txtMaxNumeroReintentosPack" runat="server"
                                        CssClass="form-control" MaxLength="3" OnTextChanged="TextBox_TextChanged"
                                        Height="30px" Width="80px"
                                        ToolTip="<%$ Resources:ToolTiptxtMaxNumeroReintentosPack %>"></asp:TextBox>
                                    <br />
                                    <asp:Label ID="Label47" runat="server" Font-Size="12px" Text="(0-255)"
                                        CssClass="col-form-label col-sm-2" Style="bottom: 15px; color: #808080"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValTxtMaxNumeroReintentosPack"
                                        runat="server" ControlToValidate="txtMaxNumeroReintentosPack"
                                        ErrorMessage="<%$ Resources:ReqValTxtMaxNumeroReintentosPack %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExTxtMaxNumeroReintentosPack"
                                        runat="server" ControlToValidate="txtMaxNumeroReintentosPack"
                                        ErrorMessage="<%$ Resources:RegExTxtMaxNumeroReintentosPack %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                        ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValTxtMaxNumeroReintentosPack" runat="server"
                                        ControlToValidate="txtMaxNumeroReintentosPack"
                                        ErrorMessage="<%$ Resources:RanValTxtMaxNumeroReintentosPack %>"
                                        ForeColor="Red" MaximumValue="255" MinimumValue="0" SetFocusOnError="True"
                                        Type="Integer" ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label44" runat="server"
                                        Text="<%$ Resources:TextAntesReconexion %>" CssClass="col-form-label col-sm-2"></asp:Label>

                                    <asp:TextBox ID="txtSecondsBeforeRetryConnection" runat="server"
                                        CssClass="form-control" MaxLength="3" OnTextChanged="TextBox_TextChanged"
                                        Height="30px" Width="80px"></asp:TextBox>
                                    <br />
                                    <asp:Label ID="Label45" runat="server" Font-Size="12px" Text="(1-520)s"
                                        CssClass="col-form-label col-sm-2" Style="bottom: 15px; color: #808080"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValSecsBefore" runat="server"
                                        ControlToValidate="txtSecondsBeforeRetryConnection"
                                        ErrorMessage="<%$ Resources:ReqValSecsBeforeMsgErr %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExSecsBefore" runat="server"
                                        ControlToValidate="txtSecondsBeforeRetryConnection"
                                        ErrorMessage="<%$ Resources:RegExSecsBeforeMsgErr %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                        ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValSecsBefore" runat="server"
                                        ControlToValidate="txtSecondsBeforeRetryConnection"
                                        ErrorMessage="<%$ Resources:RanValSecsBeforeMsgErr %>" ForeColor="Red"
                                        MaximumValue="520" MinimumValue="1" SetFocusOnError="True" Type="Integer"
                                        ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label48" runat="server" Text="<%$ Resources:TextEsperaPaquete %>"
                                        CssClass="col-form-label col-sm-2"></asp:Label>

                                    <asp:TextBox ID="txtTiempoEsperaPaqueteDeSGR" runat="server" OnTextChanged="TextBox_TextChanged"
                                        CssClass="form-control" MaxLength="3" Height="30px" Width="80px"
                                        ToolTip="<%$ Resources:ToolTiptxtTiempoEsperaPaqueteDeSGR %>"></asp:TextBox>
                                    <br />
                                    <asp:Label ID="Label49" runat="server" Text="(1-520)s" Font-Size="12px"
                                        CssClass="col-form-label col-sm-2" Style="bottom: 15px; color: #808080"></asp:Label>

                                    <asp:RequiredFieldValidator ID="ReqValTxtTiempoEsperaPaqueteDeSGR" runat="server" ControlToValidate="txtTiempoEsperaPaqueteDeSGR"
                                        ForeColor="Red" SetFocusOnError="True" ErrorMessage="<%$ Resources:ReqValTxtTiempoEsperaPaqueteDeSGRMsgErr %>"
                                        ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>

                                    &nbsp;<asp:RegularExpressionValidator ID="RegExtxtTiempoEsperaPaqueteDeSGR" runat="server"
                                        ControlToValidate="txtTiempoEsperaPaqueteDeSGR" ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                        ErrorMessage="<%$ Resources:RegExtxtTiempoEsperaPaqueteDeSGRMsgErr %>" ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>

                                    &nbsp;<asp:RangeValidator ID="RanValtxtTiempoEsperaPaqueteDeSGR" runat="server" ControlToValidate="txtTiempoEsperaPaqueteDeSGR"
                                        ForeColor="Red" MaximumValue="520" MinimumValue="1" SetFocusOnError="True"
                                        ErrorMessage="<%$ Resources:RanValtxtTiempoEsperaPaqueteDeSGRMsgErr %>"
                                        ValidationGroup="edicionFWT" Type="Integer">*</asp:RangeValidator>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">
                                    <asp:Label ID="Label52" runat="server"
                                        Text="<%$ Resources:TextPeriodoReporte %>" CssClass="col-form-label col-sm-2"></asp:Label>
                                    <asp:TextBox ID="txtPeriodoReporteSeg" runat="server" CssClass="form-control"
                                        MaxLength="5" OnTextChanged="TextBox_TextChanged" Height="30px" Width="80px"></asp:TextBox>
                                    <br />
                                    <asp:Label ID="Label53" runat="server" Font-Size="12px" Text="(60-86400)s"
                                        CssClass="col-form-label col-sm-2" Style="bottom: 15px; color: #808080"></asp:Label>
                                    &nbsp;<asp:RequiredFieldValidator ID="ReqValtxtPeriodoReporteSeg" runat="server"
                                        ControlToValidate="txtPeriodoReporteSeg"
                                        ErrorMessage="<%$ Resources:ReqValtxtPeriodoReporteSegMsgErr %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExtxtPeriodoReporteSeg" runat="server"
                                        ControlToValidate="txtPeriodoReporteSeg"
                                        ErrorMessage="<%$ Resources:RegExtxtPeriodoReporteSegMsgErr %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationExpression="[0-9]{2,5}"
                                        ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValtxtPeriodoReporteSeg" runat="server"
                                        ControlToValidate="txtPeriodoReporteSeg"
                                        ErrorMessage="<%$ Resources:RanValtxtPeriodoReporteSegMsgErr %>" ForeColor="Red"
                                        MaximumValue="86400" MinimumValue="60" SetFocusOnError="True" Type="Integer"
                                        ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label50" runat="server"
                                        Text="<%$ Resources:TextIntentosConexion %>" CssClass="col-form-label col-sm-2"></asp:Label>

                                    <asp:TextBox ID="txtMaxNumeroReintentosConexionToSGR" runat="server"
                                        CssClass="form-control" MaxLength="3" OnTextChanged="TextBox_TextChanged"
                                        Height="30px" Width="80px"></asp:TextBox>
                                    <br />
                                    <asp:Label ID="Label51" runat="server" Font-Size="12px" Text="(0-255)"
                                        CssClass="col-form-label col-sm-2" Style="bottom: 15px; color: #808080"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqValtxtMaxNumeroReintentosConexionToSGR"
                                        runat="server" ControlToValidate="txtMaxNumeroReintentosConexionToSGR"
                                        ErrorMessage="<%$ Resources:ReqValtxtMaxNumeroReintentosConexionToSGRMsgErr %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExtxtMaxNumeroReintentosConexionToSGR"
                                        runat="server" ControlToValidate="txtMaxNumeroReintentosConexionToSGR"
                                        ErrorMessage="<%$ Resources:RegExtxtMaxNumeroReintentosConexionToSGRMsgErr %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationExpression="[0-9]{1,3}"
                                        ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValtxtMaxNumeroReintentosConexionToSGR"
                                        runat="server" ControlToValidate="txtMaxNumeroReintentosConexionToSGR"
                                        ErrorMessage="<%$ Resources:RanValtxtMaxNumeroReintentosConexionToSGRMsgErr %>" ForeColor="Red"
                                        MaximumValue="255" MinimumValue="0" SetFocusOnError="True" Type="Integer"
                                        ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label15" runat="server" Text="<%$ Resources:TextCanalRF %>" CssClass="col-form-label col-sm-2"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtCanalRF" OnTextChanged="TextBox_TextChanged" CssClass="form-control"
                                        MaxLength="2" Height="30px" Width="80px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqValCanal" runat="server" ControlToValidate="txtCanalRF"
                                        ForeColor="Red" SetFocusOnError="True" ErrorMessage="<%$ Resources:ReqValCanalMsgErr %>"
                                        ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExpValCanal" runat="server" ControlToValidate="txtCanalRF"
                                        ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{1,2}"
                                        ErrorMessage="<%$ Resources:RegExpValCanalMsgErr %>" ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValCanal" runat="server" ControlToValidate="txtCanalRF"
                                        ForeColor="Red" MaximumValue="9" MinimumValue="0" SetFocusOnError="True" Type="Integer"
                                        ErrorMessage="<%$ Resources:RanValCanalMsgErr %>" ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">
                                    <asp:Label ID="Label16" runat="server" Text="<%$ Resources:TextCantidadFCIs %>"
                                        CssClass="col-form-label col-sm-2"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtNumeroMaximoFCI" CssClass="form-control" OnTextChanged="TextBox_TextChanged"
                                        Height="30px" Width="80px" MaxLength="2"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqValQtyFci" runat="server" ControlToValidate="txtNumeroMaximoFCI"
                                        ForeColor="Red" SetFocusOnError="True" ErrorMessage="<%$ Resources:ReqValQtyFciMsgErr %>"
                                        ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValQtyFci" runat="server" ControlToValidate="txtNumeroMaximoFCI"
                                        ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-6]{1,2}" ErrorMessage="<%$ Resources:RegExValQtyFciMsgErr %>"
                                        ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValQtyFci" runat="server" ControlToValidate="txtNumeroMaximoFCI"
                                        ForeColor="Red" MaximumValue="9" MinimumValue="0" SetFocusOnError="True" Type="Integer"
                                        ErrorMessage="<%$ Resources:RanValQtyFciMsgErr %>"
                                        ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="lblPrmQtySix" runat="server" Text="<%$ Resources:TextCantidadSIXs %>"
                                        CssClass="col-form-label col-sm-2"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtNumeroMaximoSIX" CssClass="form-control" OnTextChanged="TextBox_TextChanged"
                                        Height="30px" Width="80px" MaxLength="2">0</asp:TextBox>
                                    &nbsp;<asp:RequiredFieldValidator ID="ReqValQtySix" runat="server" ControlToValidate="txtNumeroMaximoSIX"
                                        ForeColor="Red" SetFocusOnError="True" ErrorMessage="<%$ Resources:ReqValQtySixMsgErr %>"
                                        ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                                    &nbsp;<asp:RegularExpressionValidator ID="RegExValQtySix" runat="server" ControlToValidate="txtNumeroMaximoSIX"
                                        ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-6]{1,2}" ErrorMessage="<%$ Resources:RegExValQtySixMsgErr %>"
                                        ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValQtySix" runat="server" ControlToValidate="txtNumeroMaximoSIX"
                                        ForeColor="Red" MaximumValue="6" MinimumValue="0" SetFocusOnError="True" Type="Integer"
                                        ErrorMessage="<%$ Resources:RanValQtySixMsgErr %>"
                                        ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                    &nbsp;<asp:CustomValidator ID="CusValMaxSixs" runat="server"
                                        ControlToValidate="txtNumeroMaximoFCI"
                                        ErrorMessage="<%$ Resources:CusValMaxSixsMsgErr %>"
                                        ForeColor="Red" OnServerValidate="CusValMaxSixs_ServerValidate"
                                        SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:CustomValidator>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="lblLeerCteSix" runat="server" Text="<%$ Resources:TextLeerCteSix %>" CssClass="col-form-label col-sm-2" Visible="true"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtPrmReporteCteSix" CssClass="form-control" OnTextChanged="TextBox_TextChanged" Height="30px" Width="80px" MaxLength="4" Visible="true"></asp:TextBox>
                                    <br />
                                    <asp:Label ID="Label71" runat="server" Text="(10-480)S" Font-Size="12px" CssClass="col-form-label col-sm-2" Style="bottom: 15px; color: #808080"></asp:Label>

                                    <asp:RegularExpressionValidator ID="ReExReporteCteSix" runat="server"
                                        ControlToValidate="txtPrmReporteCteSix"
                                        ErrorMessage="<%$ Resources:ReExReporteCteSixMsgErr %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationExpression="[0-9]{2,3}"
                                        ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                    &nbsp;<asp:RangeValidator ID="RanValReporteCteSix" runat="server"
                                        ControlToValidate="txtPrmReporteCteSix"
                                        ErrorMessage="<%$ Resources:RanValReporteCteSixMsgErr %>" ForeColor="Red"
                                        MaximumValue="480" MinimumValue="10" SetFocusOnError="True" Type="Integer"
                                        ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                    &nbsp;<asp:RequiredFieldValidator ID="ReqReporteCteSix" runat="server"
                                        ControlToValidate="txtPrmReporteCteSix"
                                        ErrorMessage="<%$ Resources:ReqReporteCteSixMsgErr %>" ForeColor="Red"
                                        SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="card bg-light  text-black col-md-12 centerDiv">
                                <div class="card-header" align="center">
                                    <font><strong>
                                <asp:Literal ID="Literal6" Text="IEC104" runat="server"></asp:Literal></strong></font>
                                </div>
                                <div class="card-body">
                                    <div class="form-group">
                                        <asp:Label ID="Label65" runat="server" Text="ASDU IEC104"
                                            CssClass="col-form-label col-sm-2"></asp:Label>
                                        <asp:TextBox ID="txtASDU" runat="server" CssClass="form-control"
                                            OnTextChanged="TextBox_TextChanged" Width="58px" MaxLength="5"></asp:TextBox>

                                        &nbsp;&nbsp;<asp:RequiredFieldValidator ID="ReqValASDU" runat="server" ControlToValidate="txtASDU"
                                            ErrorMessage="<%$ Resources:ReqValASDUMsgErr %>" Font-Size="8pt" ForeColor="Red"
                                            SetFocusOnError="True" ValidationGroup="edicionASDU">*</asp:RequiredFieldValidator>
                                        &nbsp;<asp:RegularExpressionValidator ID="RegExValASDU" runat="server" ControlToValidate="txtASDU"
                                            ErrorMessage="<%$ Resources:RegExValASDUMsgErr %>" Font-Size="9pt" ForeColor="Red"
                                            SetFocusOnError="True" ValidationExpression="[0-9]{1,5}"
                                            ValidationGroup="edicionASDU">*</asp:RegularExpressionValidator>
                                        &nbsp;<asp:RangeValidator ID="RangValASDU" runat="server" ControlToValidate="txtASDU"
                                            ErrorMessage="<%$ Resources:RangValASDUMsgErr %>" Font-Size="9pt" ForeColor="Red"
                                            MaximumValue="65535" MinimumValue="0" SetFocusOnError="True" Type="Integer"
                                            ValidationGroup="edicionASDU">*</asp:RangeValidator>
                                        &nbsp;<asp:Label ID="lblErrorValAsdu" runat="server" Font-Size="11px" ForeColor="Red" Visible="False"></asp:Label>

                                        &nbsp;<br />

                                        <asp:Label ID="lblMsgCosoftAsdu" runat="server" Font-Size="11px"
                                            ForeColor="Red" Visible="False" CssClass="col-form-label col-sm-2"></asp:Label>
                                    </div>
                                    <div class="form-group">
                                        <asp:Label ID="Label75" runat="server" Text="<%$ Resources:TextCanalIec104 %>"
                                            CssClass="col-form-label col-sm-2"></asp:Label>
                                        <asp:DropDownList ID="ddListCanalesIEC" runat="server" Font-Size="11px">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group pull-right ">
                                        <asp:Button ID="btnAsduSet" runat="server" CssClass="btn btn-outline-info btn-lg"
                                            OnClick="btnAsduSet_Click" Text="<%$ Resources:TextBotonAsignar %>" ValidationGroup="edicionASDU" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 pull-right"
                        style="background: #F8F9FA; text-align: right; padding: 0px 15px; border-bottom: 1px solid rgba(0,0,0,.125); border-right: 1px solid rgba(0,0,0,.125); border-left: 1px solid rgba(0,0,0,.125); border-radius: .25rem;">
                        <asp:Button ID="btnSaveInfoNoActualizable" runat="server" CssClass="btn btn-outline-info btn-lg"
                            OnClick="btnSaveInfoNoActualizable_Click" Text="<%$ Resources:TextBotonGuardar %>"
                            ValidationGroup="datosBasicos" />
                    </div>
                </section>
                <br />
                <section class="col-md-12 row">
                    <div class="card bg-light  text-black col-md-4 centerDiv">
                        <div class="card-header" align="center">
                            <font><strong>
                                <asp:Literal ID="Literal13" Text="<%$ Resources:TextTittleParametrosFuentes %>" runat="server"></asp:Literal></strong></font>

                        </div>
                        <div class="card-body">

                            <!--col-form-label col-sm-2    form-control   -->

                            <div class="form-group">
                                <asp:Label ID="Label55" runat="server" Text="<%$ Resources:TextVoltajeMinCargador %>"
                                    CssClass="col-form-label col-sm-2"></asp:Label>

                                <asp:TextBox ID="txtPrmVoltajeMinNivelCargador" runat="server" OnTextChanged="TextBox_TextChanged"
                                    CssClass="form-control" MaxLength="4" Height="30px" Width="80px"></asp:TextBox>
                                <br />
                                <asp:Label ID="Label60" runat="server" Text="(11-16,5)V" Font-Size="12px"
                                    class="col-form-label col-sm-2" Style="bottom: 18px; color: #808080"></asp:Label>


                                &nbsp;<asp:RegularExpressionValidator ID="RegExVolMinCargador" runat="server"
                                    ControlToValidate="txtPrmVoltajeMinNivelCargador"
                                    ErrorMessage="<%$ Resources:RegExVolMinCargadorMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationExpression="^([0-9]*|\d*\,\d{1})$"
                                    ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValVoltajeMinCargador" runat="server"
                                    ControlToValidate="txtPrmVoltajeMinNivelCargador"
                                    ErrorMessage="<%$ Resources:RanValVoltajeMinCargadorMsgErr %>" ForeColor="Red"
                                    MaximumValue="16,5" MinimumValue="11" SetFocusOnError="True" Type="Double"
                                    ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                &nbsp;<asp:RequiredFieldValidator ID="ReqValVoltajeMinCargador" runat="server"
                                    ControlToValidate="txtPrmVoltajeMinNivelCargador"
                                    ErrorMessage="<%$ Resources:ReqValVoltajeMinCargadorMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label58" runat="server" Text="<%$ Resources:TextVoltajeBatBaja %>"
                                    CssClass="col-form-label col-sm-2"></asp:Label>
                                <asp:TextBox ID="txtPrmVoltajeLowBatt" runat="server" CssClass="form-control" OnTextChanged="TextBox_TextChanged"
                                    MaxLength="4" Height="30px" Width="80px"></asp:TextBox>
                                <br />
                                <asp:Label ID="Label63" runat="server" Text="(11,8-12,3)V" Font-Size="12px"
                                    class="col-form-label col-sm-2" Style="bottom: 18px; color: #808080"></asp:Label>
                                <asp:RegularExpressionValidator ID="RegExBateriaBaja" runat="server"
                                    ControlToValidate="txtPrmVoltajeLowBatt"
                                    ErrorMessage="<%$ Resources:RegExBateriaBajaMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationExpression="^([0-9]*|\d*\,\d{1})$"
                                    ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValVoltajeBateriaBaja" runat="server"
                                    ControlToValidate="txtPrmVoltajeLowBatt"
                                    ErrorMessage="<%$ Resources:RanValVoltajeBateriaBajaMsgErr %>" ForeColor="Red"
                                    MaximumValue="12,3" MinimumValue="11,8" SetFocusOnError="True" Type="Double"
                                    ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                &nbsp;<asp:RequiredFieldValidator ID="ReqValVoltajeBateriaBaja" runat="server"
                                    ControlToValidate="txtPrmVoltajeLowBatt"
                                    ErrorMessage="<%$ Resources:ReqValVoltajeBateriaBajaMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label56" runat="server" Text="<%$ Resources:TextVoltajeMinPanel %>"
                                    CssClass="col-form-label col-sm-2"></asp:Label>
                                <asp:TextBox ID="txtPrmVoltajeMinNivelPanel" runat="server" OnTextChanged="TextBox_TextChanged"
                                    CssClass="form-control" MaxLength="3" Height="30px" Width="80px"></asp:TextBox>
                                <br />
                                <asp:Label ID="Label61" runat="server" Text="(2,0-3,0)V" Font-Size="12px"
                                    class="col-form-label col-sm-2" Style="bottom: 18px; color: #808080"></asp:Label>
                                &nbsp;<asp:RegularExpressionValidator ID="RegExVoltajeMinPanel" runat="server"
                                    ControlToValidate="txtPrmVoltajeMinNivelPanel"
                                    ErrorMessage="<%$ Resources:RegExVoltajeMinPanelMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationExpression="^([0-9]*|\d*\,\d{1})$"
                                    ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValVoltajeMinPanel" runat="server"
                                    ControlToValidate="txtPrmVoltajeMinNivelPanel"
                                    ErrorMessage="<%$ Resources:RanValVoltajeMinPanelMsgErr %>" ForeColor="Red"
                                    MaximumValue="3,0" MinimumValue="2,0" SetFocusOnError="True" Type="Double"
                                    ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                &nbsp;<asp:RequiredFieldValidator ID="ReqValVoltajeMinPanel" runat="server"
                                    ControlToValidate="txtPrmVoltajeMinNivelPanel"
                                    ErrorMessage="<%$ Resources:ReqValVoltajeMinPanelMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label59" runat="server" Text="<%$ Resources:TextCorrienteBateria %>"
                                    CssClass="col-form-label col-sm-2"></asp:Label>
                                <asp:TextBox ID="txtPrmCorrienteBateria" runat="server" OnTextChanged="TextBox_TextChanged"
                                    CssClass="form-control" MaxLength="2" Height="30px" Width="80px"></asp:TextBox>
                                <br />
                                <asp:Label ID="Label64" runat="server" Text="(7-10)A" class="col-form-label col-sm-2" Style="bottom: 18px; color: #808080" Font-Size="12px"></asp:Label>
                                &nbsp;<asp:RegularExpressionValidator ID="RegExCteBateria" runat="server"
                                    ControlToValidate="txtPrmCorrienteBateria"
                                    ErrorMessage="<%$ Resources:RegExCteBateriaMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationExpression="[0-9]{1,2}"
                                    ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValCorrienteBateria" runat="server"
                                    ControlToValidate="txtPrmCorrienteBateria"
                                    ErrorMessage="<%$ Resources:RanValCorrienteBateriaMsgErr %>" ForeColor="Red"
                                    MaximumValue="10" MinimumValue="7" SetFocusOnError="True" Type="Integer"
                                    ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                &nbsp;<asp:RequiredFieldValidator ID="ReqValCorrienteBateria" runat="server"
                                    ControlToValidate="txtPrmCorrienteBateria"
                                    ErrorMessage="<%$ Resources:ReqValCorrienteBateriaMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="Label57" runat="server" Text="<%$ Resources:TextVoltajeMinBateria %>"
                                    CssClass="col-form-label col-sm-2"></asp:Label>
                                <asp:TextBox ID="txtPrmvoltajeMinBateria" runat="server" OnTextChanged="TextBox_TextChanged"
                                    CssClass="form-control" MaxLength="4" Height="30px" Width="80px"></asp:TextBox>
                                <br />
                                <asp:Label ID="Label62" runat="server" Text="(11,7-12)V" Font-Size="12px"
                                    class="col-form-label col-sm-2" Style="bottom: 18px; color: #808080"></asp:Label>
                                &nbsp;<asp:RegularExpressionValidator ID="RegExVoltajeMinBateria" runat="server"
                                    ControlToValidate="txtPrmvoltajeMinBateria"
                                    ErrorMessage="<%$ Resources:RegExVoltajeMinBateriaMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationExpression="^([0-9]*|\d*\,\d{1})$"
                                    ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValVoltajeMinBateria" runat="server"
                                    ControlToValidate="txtPrmvoltajeMinBateria"
                                    ErrorMessage="<%$ Resources:RanValVoltajeMinBateriaMsgErr %>" ForeColor="Red"
                                    MaximumValue="12" MinimumValue="11,7" SetFocusOnError="True" Type="Double"
                                    ValidationGroup="edicionFWT">*</asp:RangeValidator>
                                &nbsp;<asp:RequiredFieldValidator ID="ReqValVoltajeMinBateria" runat="server"
                                    ControlToValidate="txtPrmvoltajeMinBateria"
                                    ErrorMessage="<%$ Resources:ReqValVoltajeMinBateriaMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label67" runat="server" Text="<%$ Resources:TextRevisarFuentes %>"
                                    CssClass="col-form-label col-sm-2"></asp:Label>
                                <asp:TextBox ID="txtPrmPeriodoRevisionFuentes" runat="server" OnTextChanged="TextBox_TextChanged"
                                    CssClass="form-control" MaxLength="4" Height="30px" Width="80px"></asp:TextBox>
                                <br />
                                <asp:Label ID="Label69" runat="server" Text="(5-60)S" Font-Size="12px"
                                    class="col-form-label col-sm-2" Style="bottom: 18px; color: #808080"></asp:Label>
                                &nbsp;<asp:RegularExpressionValidator ID="RegExRevisarFuentes" runat="server"
                                    ControlToValidate="txtPrmPeriodoRevisionFuentes"
                                    ErrorMessage="<%$ Resources:RegExRevisarFuentesMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationExpression="[0-9]{1,2}"
                                    ValidationGroup="edicionFWT">*</asp:RegularExpressionValidator>
                                &nbsp;<asp:RangeValidator ID="RanValRevisionFuentes" runat="server"
                                    ControlToValidate="txtPrmPeriodoRevisionFuentes"
                                    ErrorMessage="<%$ Resources:RanValRevisionFuentesMsgErr %>" ForeColor="Red"
                                    MaximumValue="60" MinimumValue="5" SetFocusOnError="True" Type="Integer"
                                    ValidationGroup="edicionFWT">*</asp:RangeValidator>

                                &nbsp;<asp:RequiredFieldValidator ID="ReqRevisarFuentes" runat="server"
                                    ControlToValidate="txtPrmPeriodoRevisionFuentes"
                                    ErrorMessage="<%$ Resources:ReqRevisarFuentesMsgErr %>" ForeColor="Red"
                                    SetFocusOnError="True" ValidationGroup="edicionFWT">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label68" runat="server" Text="<%$ Resources:TextProcCargaBateria %>"
                                    CssClass="col-form-label col-sm-2"></asp:Label>
                                <asp:CheckBox ID="prmChkProcesoCargaBateria" runat="server"
                                    OnCheckedChanged="TextBox_TextChanged" />
                            </div>


                        </div>
                    </div>
                </section>
                <br />
                <table border="0" width="100%">
                    <tr>
                        <td valign="top" width="6%">
                            <asp:Label ID="Label24" runat="server" Font-Size="12px" Text="Dir IP SCADA"
                                Visible="False"></asp:Label>
                        </td>
                        <td valign="top" width="24%">
                            <asp:TextBox ID="txtIpSCADA" runat="server" CssClass="textInUsuario"
                                MaxLength="15" OnTextChanged="TextBox_TextChanged" Visible="False" Width="95px"></asp:TextBox>
                            &nbsp;
                        <asp:RequiredFieldValidator ID="ReqValIPScada" runat="server"
                            ControlToValidate="txtIpSCADA" ErrorMessage="Se Requiere IP de Scada"
                            ForeColor="Red" SetFocusOnError="True" ValidationGroup="edicionFWT"
                            Enabled="False">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegExValIPScada" runat="server"
                                ControlToValidate="txtIpSCADA" ErrorMessage="IP de Scada Incorrecta"
                                ForeColor="Red" SetFocusOnError="True"
                                ValidationExpression="\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"
                                ValidationGroup="edicionFWT" Enabled="False">*</asp:RegularExpressionValidator>
                        </td>
                        <td valign="top" width="6%">
                            <asp:Label ID="Label25" runat="server" Font-Size="12px" Text="Puerto SCADA"
                                Visible="False"></asp:Label>
                        </td>
                        <td valign="top" width="14%">
                            <asp:TextBox ID="txtPuertoSCADA" runat="server" CssClass="textInUsuario"
                                MaxLength="5" OnTextChanged="TextBox_TextChanged" Width="50px"
                                Visible="False"></asp:TextBox>
                            &nbsp;
                        <asp:RequiredFieldValidator ID="ReqValPtoScada" runat="server"
                            ControlToValidate="txtPuertoSCADA" ErrorMessage="Se Requiere Puerto de Scada"
                            ForeColor="Red" SetFocusOnError="True" ValidationGroup="edicionFWT"
                            Enabled="False">*</asp:RequiredFieldValidator>
                            &nbsp;<asp:RegularExpressionValidator ID="RegExpValPtoScada" runat="server"
                                ControlToValidate="txtPuertoSCADA" ErrorMessage="Puerto de Scada Incorrecto"
                                ForeColor="Red" SetFocusOnError="True" ValidationExpression="[0-9]{4,5}"
                                ValidationGroup="edicionFWT" Enabled="False">*</asp:RegularExpressionValidator>
                            &nbsp;<asp:RangeValidator ID="RanValPtoScada" runat="server"
                                ControlToValidate="txtPuertoSCADA"
                                ErrorMessage="Mal Definido el Pto Scada (1025-65535)" ForeColor="Red"
                                MaximumValue="65535" MinimumValue="1025" SetFocusOnError="True"
                                ValidationGroup="edicionFWT" Enabled="False">*</asp:RangeValidator>
                        </td>
                        <td valign="top" class="style3" width="4%">
                            <asp:Label ID="Label27" runat="server" Font-Size="12px"
                                Text="Veces sin Reportar" Visible="False"></asp:Label>
                        </td>
                        <td valign="top" width="20%">
                            <asp:TextBox ID="txtVecesNoReportar" runat="server" CssClass="textBoxHora"
                                MaxLength="2" OnTextChanged="TextBox_TextChanged" Visible="False"></asp:TextBox>
                        </td>
                    </tr>
                </table>

                <table width="100%">
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:UpdatePanel ID="UpPanelHistorialPrms" runat="server">
                                <ContentTemplate>
                                    &nbsp;<asp:Label ID="Label73" runat="server" CssClass="txtLabelPrms"
                                        Text="<%$ Resources:TextHistoriaActPrms %>"></asp:Label>:
                                <asp:DropDownList ID="DDLFechasActualizacionesPrms" runat="server"
                                    AutoPostBack="True" CssClass="textInUsuario"
                                    OnSelectedIndexChanged="DDLFechasActualizacionesPrms_SelectedIndexChanged"
                                    Width="200px">
                                </asp:DropDownList>
                                    &nbsp;<asp:HyperLink ID="HyperLinkVerPrmsHistorico" runat="server"
                                        BorderStyle="Outset" Target="_blank" Text="<%$ Resources:TextVerValoresHistoricos %>"
                                        ToolTip="<%$ Resources:TextToolTipValoresHistoricos %>"></asp:HyperLink>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>

            </div>

            <div class="centerDiv" align="center">
                <table style="width: 100%;">
                    <tr>
                        <td align="center">
                            <center>
                                <asp:Label ID="lblEstadoActualizacion" runat="server" Text="" ForeColor="Red"
                                    Font-Bold="True" Visible="False"></asp:Label></center>
                            <center>
                                <asp:ValidationSummary ID="ValSumEdicionFWT" runat="server" Font-Size="12px" ForeColor="Red"
                                    ValidationGroup="edicionFWT" />
                            </center>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%;" border="0">
                    <tr>
                        <td align="center" bgcolor="#eeeeee">
                            <font><strong>
                                <asp:Literal ID="Literal9" Text="<%$ Resources:TextTittleActualizaciones %>" runat="server"></asp:Literal></strong></font>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%;" border="0">
                    <tr>
                        <td align="center" style="width: 50%;">
                            <asp:Label ID="Label30" CssClass="labelTitulo" Text="<%$ Resources:TextTittleParametros %>" runat="server" />
                        </td>
                        <td align="center" style="width: 50%;">
                            <asp:Label ID="Label31" CssClass="labelTitulo" Text="<%$ Resources:TextTittleFirmware %>" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="top" style="width: 50%;">
                            <asp:UpdatePanel ID="upPanelEstadoParametros" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblEstadoFWT" runat="server" />
                                    &nbsp;
                                        <asp:Image ID="imgEstadoFWT" runat="server" ImageUrl="~/Images/roller.gif" />
                                    <asp:Timer ID="tmrActualizacionEstadoFWT" runat="server" Enabled="false"
                                        Interval="2000" OnTick="tmrActualizacionEstadoFWT_Tick">
                                    </asp:Timer>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <br />
                        </td>
                        <td align="center" valign="top" style="width: 50%;">
                            <asp:UpdatePanel ID="upPanelActFirmware" runat="server">
                                <ContentTemplate>
                                    <asp:Timer ID="tmrActFirmware" runat="server" Enabled="false" Interval="1000"
                                        OnTick="tmrActFirmware_Tick">
                                    </asp:Timer>
                                    <asp:Label ID="lblEstadoACTFirmware" runat="server" /><br />
                                    <asp:Label ID="lblPorcentajeActFirmware" runat="server" Visible="False" /><br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="background-color: #B5CCFF;">
                                        <tr>
                                            <td width="100" align="left">
                                                <asp:Image ID="imgPorcActFirmware" src="../Images/bar.GIF" Width="50%"
                                                    Height="10px" runat="server" Visible="False" /></td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdateProgress ID="upProgActParametrosOnline" AssociatedUpdatePanelID="upPanelActFirmware" runat="server">
                                <ProgressTemplate>
                                    <asp:Label ID="Label3" runat="server" Text="<%$ Resources:TextEnviandoFirmware %>"></asp:Label>
                                    <asp:Image ID="imgEnviando" runat="server" ImageUrl="~/Images/roller.gif" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%;" border="0">
                    <tr>
                        <td colspan="5" align="center">
                            <asp:Label ID="lblEstadoActualizacionOnline" runat="server" Text="" ForeColor="Red"
                                Font-Bold="True" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%;" align="center" valign="top">
                            <asp:Button ID="butUpdate" runat="server" Text="Enviar" OnClick="butUpdate_Click"
                                ValidationGroup="edicionFWT" Style="height: 26px" Visible="False" />
                        </td>
                        <td style="width: 20%;" align="center" valign="top">
                            <asp:Button ID="butUpdateOnline" runat="server" Text="<%$ Resources:TextBotonEnviar %>"
                                ValidationGroup="edicionFWT" Style="height: 26px"
                                OnClick="butUpdateOnline_Click" Enabled="False"
                                ToolTip="<%$ Resources:TextToolTipBotonEnviar %>" />
                        </td>
                        <td style="width: 20%;" align="center" valign="top">
                            <asp:Button ID="butLeerParamOnline" runat="server" Text="<%$ Resources:TextBotonLeerPrmsOnLine %>"
                                Style="height: 26px"
                                Enabled="False"
                                ToolTip="<%$ Resources:TextToolTipBotonLeerPrmsOnline %>"
                                OnClick="butLeerParamOnline_Click" />
                            <asp:Timer ID="tmrActivarBotones" runat="server" Enabled="False" Interval="500"
                                OnTick="tmrActivarBotones_Tick">
                            </asp:Timer>
                        </td>
                        <td style="width: 20%;" align="center" valign="top">
                            <asp:Button ID="butDelete" runat="server" Text="<%$ Resources:TextBotonBorrar %>"
                                OnClientClick="<%$ Resources:TextJSBotonBorrar %>"
                                OnClick="butDelete_Click" />
                        </td>
                        <td style="width: 20%;" align="center" valign="top">
                            <asp:Button ID="butCancelar" runat="server" Text="Cancelar" OnClick="butCancelar_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <asp:SqlDataSource ID="SqlDSCiudades" runat="server"
                                ConnectionString="<%$ ConnectionStrings:SistemaGestionRemotoConnectionString %>"
                                SelectCommand="select NombreCiudad from MtCiudades where Pais = @pais order by NombreCiudad ASC">
                                <SelectParameters>
                                    <asp:Parameter Name="pais" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</body>
</html>






