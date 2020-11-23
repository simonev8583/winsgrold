using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Messaging;
using System.Globalization;
using SGR.DataAccessLayer;
using SGR.BussinessLayer;
using SGR.UtilityLibrary;
using SCADA104.Definiciones;
using Celsa.ConexionMensajeria;

namespace SistemaGestionRedes
{
    public partial class EditFWT : System.Web.UI.Page
    {

        private static bool _verSix;
        private MessageQueue mqWebToSGR;  // Message queue en sentido Web -> cosoft
        private MessageQueue mqSGRToWeb;  // Message queue en sentido cosoft -> Web
        private int _codigoPais;
        private bool _equipoConectado;
        private int stateArix = -1;
        private string dataClock;
        /// <summary>
        /// Objeto que sirve para hacer un lock en el hilo actual 
        /// </summary>
        Object objLock = new Object();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
                _codigoPais = ConfigApp.CodigoPais;
                AdaptarAspectosCulturales();
                //ViewState["paginaAnterior"] = Request.UrlReferrer.ToString(); //Se almacena en una variable ViewState la dirección de la pagina anterior , esto se utiliza en el boton Cancelar
                string strId = Request.QueryString["Id"];
                lblId.Text = strId;
                LlenarValoresConcentrador(int.Parse(strId));
                LoadAllFCIs();
                LoadFCIsPropios(int.Parse(strId));
                _equipoConectado = AccesoDatosEF.ExisteConexionFWT(lblSerial.Text);
                ActivarBotones();
                LlenarComboFechasHistoricasParametros(int.Parse(strId));
                // butLeerEstadoFWTOnLine.OnClientClick = String.Format("fnClickOK('{0}','{1}')", OkButton.UniqueID, "");   //Necesario para que el boton butLeer haga postBack
                //  OkButton.OnClientClick = String.Format("fnClickOK('{0}','{1}')", OkButton.UniqueID, "");   //Necesario para que el boton OK del modalpopup haga postBack (llamando a updateonclick())
                _verSix = ConfigApp.VerSix;
                ConfigurarVisibilidadElementosSix();
                ControlarAutorizacionControles();                
            }
            //else
            //{
            //    if (Request.QueryString["serialdev"] != null)
            //    {
            //        string serialDevRT = "";
            //        serialDevRT = Request.QueryString["serialdev"];
            //        if (!serialDevRT.Equals(""))
            //        {
            //            //int i = 0;
            //            AccesoDatos dataBD = new AccesoDatos();
            //            dataBD.ActivarFirmwareUpgradeFWT_To_DEVRT(serialDevRT);
            //            GVEquiposRemotos.DataBind();
            //        }
            //    }
            //}
        }

        protected void ControlarAutorizacionControles()
        {
            //ATENCIÓN: Cada vez que se adicione un control en esta lista, se debe buscar o controlar en el resto del
            //código que no se haga una habilitación directa en otro sitio sin pasar por la función de control
            //de autorización UtilitariosWebGUI.HasAuthorization().

            butUpdate.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            butUpdateOnline.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            butAddFCI.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            butRemoveFCI.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            btnClearFCI.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User) & _equipoConectado;
            btnWriteResetFwt.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User) & _equipoConectado;
            btnSaveInfoNoActualizable.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            btnAsduSet.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            butDelete.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);

        }

        private void LlenarComboFechasHistoricasParametros(int idInternoEquipo)
        {

            DDLFechasActualizacionesPrms.Items.Clear();

            using (SistemaGestionRemotoContainer context = new SistemaGestionRemotoContainer())
            {
                var registros = from historia in context.HistorialParamsFWTs
                                where historia.IdFWT == idInternoEquipo
                                orderby historia.FechaConfirmacion descending
                                select historia;
                if (registros != null)
                {
                    if (registros.Count() > 0)
                    {
                        foreach (var reg in registros)
                        {
                            DDLFechasActualizacionesPrms.Items.Add(new ListItem(reg.FechaConfirmacion.ToString(), reg.FechaConfirmacion.Ticks.ToString()));
                        }
                    }
                }
            }

            if (DDLFechasActualizacionesPrms.Items.Count > 0)
            {
                HyperLinkVerPrmsHistorico.Enabled = true;
                DDLFechasActualizacionesPrms.Enabled = true;
                DDLFechasActualizacionesPrms.SelectedIndex = 0;
                ConfigurarHyperLinkHistoricoParametros();
            }
            else
            {
                DDLFechasActualizacionesPrms.Enabled = false;
                HyperLinkVerPrmsHistorico.Enabled = false;
            }
        }


        private void ConfigurarHyperLinkHistoricoParametros()
        {
            string idEquipo = lblId.Text;
            string fechaTick = DDLFechasActualizacionesPrms.SelectedValue;
            HyperLinkVerPrmsHistorico.NavigateUrl = "DetallePrmsFWT.aspx?IdInterno=" + idEquipo + "&" + "Fecha=" + fechaTick;
        }


        protected void AdaptarAspectosCulturales()
        {
            NumberFormatInfo nfi = CultureInfo.CurrentCulture.NumberFormat;

            //RanValVoltajeMinCargador
            RanValVoltajeMinCargador.MaximumValue = RanValVoltajeMinCargador.MaximumValue.Replace(",", nfi.NumberDecimalSeparator);
            RanValVoltajeMinCargador.MinimumValue = RanValVoltajeMinCargador.MinimumValue.Replace(",", nfi.NumberDecimalSeparator);
            RegExVolMinCargador.ValidationExpression = RegExVolMinCargador.ValidationExpression.Replace(",", nfi.NumberDecimalSeparator);

            //RanValVoltajeMinPanel
            RanValVoltajeMinPanel.MaximumValue = RanValVoltajeMinPanel.MaximumValue.Replace(",", nfi.NumberDecimalSeparator);
            RanValVoltajeMinPanel.MinimumValue = RanValVoltajeMinPanel.MinimumValue.Replace(",", nfi.NumberDecimalSeparator);
            RegExVoltajeMinPanel.ValidationExpression = RegExVoltajeMinPanel.ValidationExpression.Replace(",", nfi.NumberDecimalSeparator);

            //RanValVoltajeMinBateria
            RanValVoltajeMinBateria.MaximumValue = RanValVoltajeMinBateria.MaximumValue.Replace(",", nfi.NumberDecimalSeparator);
            RanValVoltajeMinBateria.MinimumValue = RanValVoltajeMinBateria.MinimumValue.Replace(",", nfi.NumberDecimalSeparator);
            RegExVoltajeMinBateria.ValidationExpression = RegExVoltajeMinBateria.ValidationExpression.Replace(",", nfi.NumberDecimalSeparator);

            //RanValVoltajeBateriaBaja
            RanValVoltajeBateriaBaja.MaximumValue = RanValVoltajeBateriaBaja.MaximumValue.Replace(",", nfi.NumberDecimalSeparator);
            RanValVoltajeBateriaBaja.MinimumValue = RanValVoltajeBateriaBaja.MinimumValue.Replace(",", nfi.NumberDecimalSeparator);
            RegExBateriaBaja.ValidationExpression = RegExBateriaBaja.ValidationExpression.Replace(",", nfi.NumberDecimalSeparator);

            //Llenar combo de ciudades
            SqlDSCiudades.SelectParameters["pais"].DefaultValue = _codigoPais.ToString();
            txtCiudad.DataSourceID = "SqlDSCiudades";
            txtCiudad.DataValueField = "NombreCiudad";
            txtCiudad.DataTextField = "NombreCiudad";
            txtCiudad.DataBind();

        }

        /// <summary>
        /// Metodo que se ejecuta cuando el valor de un control cambió 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void TextBox_TextChanged(object sender, EventArgs e)
        {
            Control cntrl = (Control)sender; //Control es la base class de todos los aps net server controls 
            string strViewStCntrlChgd = (string)ViewState["controlesChanged"];
            if ((ViewState["controlesChanged"] == null) || (strViewStCntrlChgd.IndexOf(cntrl.ID) < 0)) //No se van a agregar controles duplicados , 
                                                                                                       //no debe existir cntrl.ID en el viewState  , se utiliza orelse (||) de C#
            {                                                                                            //para que no vaya a existir problemas de null reference.
                ViewState["controlesChanged"] = ViewState["controlesChanged"] + "*" + cntrl.ID;  //Aca se almacenan los Ids de los controles que cambiaron , separados por *
            }
        }



        /// <summary>
        /// Realiza el intercambio de paquetes messagequeueOnline y actualiza la interfaz GUI segun el caso .
        /// </summary>
        private bool RealizarComunicacionMessageQueueOnline(ComandosUsuario comandoUser, byte? idFCI = null, int? idArix = null, string param = null, int newAsdu = 0)
        {
            bool exito = false;
            //Algunos settings..
            lblLecturaOnlineEstadoFWT.Visible = comandoUser == ComandosUsuario.ReadStateFWT ? true : false;
            lblResetOnLineFWT.Visible = (comandoUser == ComandosUsuario.ResetFWT) ? true : false;
            lblMsgErrSeleccionFCIClear.Visible = comandoUser == ComandosUsuario.ClearFCI ? true : false;
            lblEstadoActualizacionOnline.Visible = (comandoUser == ComandosUsuario.ActParamFWT || comandoUser == ComandosUsuario.ReadParamFWT) ? true : false;
            lblMsgCosoftAsdu.Visible = comandoUser == ComandosUsuario.AsignacionAsduFWT ? true : false;

            InicializarMessageQueues();
            MensajeComandoMQOnline msgComando = new MensajeComandoMQOnline();  //Se crea un comando de usuario para enviar .
            msgComando.SerialFWT = lblSerial.Text;
            msgComando.numeroASDU = newAsdu;
            msgComando.CanalIEC104 = comandoUser == ComandosUsuario.AsignacionAsduFWT ? int.Parse(ddListCanalesIEC.SelectedValue) : 0;
            msgComando.Comando = comandoUser;
            msgComando.IdFCI = idFCI;
            msgComando.IdARIX = idArix;
            msgComando.Param = param;
            FormatearMensajeColaRecepcion();
            mqWebToSGR.Send(msgComando);
            try
            {
                System.Messaging.Message msg = mqSGRToWeb.Receive(new TimeSpan(0, 0, 30)); //Espera Máximo 20 segs sincronicamente para recibir respuesta
                MensajeRespuestasMQOnline msgRespuesta = (MensajeRespuestasMQOnline)msg.Body;

                if (msgRespuesta.Respuesta == RespuestasSvrCom.NotConnected)
                {
                    //lblEstadoActualizacionOnline.Text = "FWT No Conectado";
                    lblEstadoActualizacionOnline.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(RespuestasSvrCom.NotConnected);
                    lblLecturaOnlineEstadoFWT.Text = lblEstadoActualizacionOnline.Text;
                    lblResetOnLineFWT.Text = lblEstadoActualizacionOnline.Text;
                    lblMsgErrSeleccionFCIClear.Text = lblEstadoActualizacionOnline.Text;
                    lblMsgCosoftAsdu.Text = lblEstadoActualizacionOnline.Text;
                }
                else if (msgRespuesta.Respuesta == RespuestasSvrCom.MsgQueueExceptionComunicaciones)
                {
                    //lblEstadoActualizacionOnline.Text = "MessageQueueException en servidor comunicaciones  : " + (string)msgRespuesta.Datos;
                    lblEstadoActualizacionOnline.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(RespuestasSvrCom.MsgQueueExceptionComunicaciones);
                    lblLecturaOnlineEstadoFWT.Text = lblEstadoActualizacionOnline.Text;
                    lblResetOnLineFWT.Text = lblEstadoActualizacionOnline.Text;
                    lblMsgErrSeleccionFCIClear.Text = lblEstadoActualizacionOnline.Text;
                    lblMsgCosoftAsdu.Text = lblEstadoActualizacionOnline.Text;
                }
                else
                {
                    if (msgRespuesta.SerialFWT == lblSerial.Text)
                    {
                        switch (comandoUser)
                        {
                            case ComandosUsuario.AsignacionAsduFWT:
                                lblMsgCosoftAsdu.Text = (string)this.GetLocalResourceObject("lblMsgCosoftAsduNotifyOk"); //"Notificación a FWT OnLine OK.";
                                break;

                            case ComandosUsuario.ActParamFWT:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.OK)
                                {
                                    lblEstadoActualizacionOnline.Text = (string)this.GetLocalResourceObject("lblEstadoActualizacionOnlinePrmsActOnLine"); //"Parametros Actualizados Online";
                                    lblEstadoFWT.Text = (string)this.GetLocalResourceObject("TextlblEstadoFWTDatosOK"); //"DATOS ACTUALIZADOS.";
                                    lblEstadoActualizacion.Visible = false; //No se muestra , ya se actualizó .
                                }
                                else
                                {
                                    //lblEstadoActualizacionOnline.Text = "Se recibió otra respuesta para este serial :  " + msgRespuesta.Respuesta.ToString();
                                    lblEstadoActualizacionOnline.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(msgRespuesta.Respuesta);
                                }
                                break;

                            case ComandosUsuario.ClearFCI:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.OK)
                                {
                                    lblMsgErrSeleccionFCIClear.Text = (string)this.GetLocalResourceObject("lblMsgErrSeleccionFCIClearBorradoOk"); //"Borrado permanente de FCI exitoso";
                                    butRemoveFCI_Click(butRemoveFCI, null);
                                    exito = true;
                                }
                                else
                                {
                                    if (TypeOfDevice.IsArix(lblPrivateTypeDeviceForDelete.Text))
                                    {
                                        lblMsgErrSeleccionFCIClear.Text = (string)this.GetLocalResourceObject("lblMsgErrSeleccionFCIClearBorradoOk"); //"Borrado permanente de Dispositivo exitoso";

                                        using (var db = new SistemaGestionRemotoContainer())
                                        {
                                            ARIX arix = db.ARIXs.SingleOrDefault(x => x.Serial == lblPrivateTypeDeviceForDelete.Text);
                                            if (arix != null)
                                            {
                                                arix.FWTId = null;
                                                db.SaveChanges();
                                            }
                                        }
                                        butRemoveFCI_Click(butRemoveFCI, null);
                                        exito = true;
                                    }
                                    else
                                    {
                                        //lblEstadoActualizacionOnline.Text = "Se recibió otra respuesta para este serial :  " + msgRespuesta.Respuesta.ToString();
                                        lblMsgErrSeleccionFCIClear.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(msgRespuesta.Respuesta);
                                    }

                                }
                                break;

                            case ComandosUsuario.ResetFWT:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.OK)
                                {
                                    lblResetOnLineFWT.Text = (string)this.GetLocalResourceObject("TextlblResetOnLineFWTCmdOk");
                                }
                                else
                                {
                                    lblResetOnLineFWT.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(msgRespuesta.Respuesta);
                                }
                                break;

                            case ComandosUsuario.ReadParamFWT:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.DATOS) //La respuesta debe ser datos .
                                {
                                    LlenarValoresConcentrador(int.Parse(lblId.Text)); //SE llenan todos los datos del concentrador pues ya en base de datos cosoft actualizó los parametros.
                                    lblEstadoActualizacionOnline.Text = (string)this.GetLocalResourceObject("lblEstadoActualizacionOnlinePrmsRecibidos"); //"Se recibieron los parametros del FWT. ";
                                    lblEstadoActualizacion.Visible = false; //No se muestra , ya se actualizó .
                                }
                                else
                                {

                                    //lblEstadoActualizacionOnline.Text = "Se recibió otra respuesta para este serial :  " + msgRespuesta.Respuesta.ToString();
                                    lblEstadoActualizacionOnline.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(msgRespuesta.Respuesta);
                                }
                                break;

                            case ComandosUsuario.ReadStateFWT:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.DATOS) //La respuesta debe ser datos .
                                {
                                    LlenarValoresConcentrador(int.Parse(lblId.Text)); //SE llenan todos los datos del concentrador pues ya en base de datos cosoft actualizó los parametros.
                                    lblLecturaOnlineEstadoFWT.Text = (string)this.GetLocalResourceObject("lblLecturaOnlineEstadoFWTEstadoOk"); //"Estado FWT recibido.";
                                    lblEstadoActualizacion.Visible = false; //No se muestra , ya se actualizó .

                                }
                                else
                                {
                                    //lblLecturaOnlineEstadoFWT.Text = "Se recibió otra respuesta para este serial :  " + msgRespuesta.Respuesta.ToString();
                                    lblLecturaOnlineEstadoFWT.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(msgRespuesta.Respuesta);

                                }
                                break;
                            case ComandosUsuario.OpenARIX:
                                var respuesta = msgRespuesta.Respuesta;
                                if (respuesta == RespuestasSvrCom.OK)
                                {
                                    stateArix = 1;
                                    exito = true;
                                }
                                else if (respuesta == RespuestasSvrCom.ErrorSendingRequest)
                                {
                                    /*Ya estaba Abierto*/
                                    stateArix = 0;
                                    exito = true;
                                }
                                break;
                            case ComandosUsuario.CloseARIX:
                                var respuestaCerrado = msgRespuesta.Respuesta;
                                if (respuestaCerrado == RespuestasSvrCom.OK)
                                {
                                    stateArix = 1;
                                    exito = true;
                                }
                                else if (respuestaCerrado == RespuestasSvrCom.ErrorSendingRequest)
                                {
                                    /*Ya estaba Cerrado*/
                                    stateArix = 0;
                                    exito = true;
                                }
                                break;
                            case ComandosUsuario.IsOpenArix:
                                var respuestaEstadoArix = msgRespuesta.Respuesta;
                                if (respuestaEstadoArix == RespuestasSvrCom.SinInformacion)
                                {
                                    stateArix = -1;
                                    exito = true;
                                }
                                else if (respuestaEstadoArix == RespuestasSvrCom.OK)
                                {
                                    stateArix = 1;
                                    exito = true;
                                }
                                else if (respuestaEstadoArix == RespuestasSvrCom.FAIL)
                                {
                                    stateArix = 0;
                                    exito = true;
                                }
                                else if (respuestaEstadoArix == RespuestasSvrCom.NotRightAnswer)
                                {
                                    // Error enviando el comando
                                    exito = false;
                                    stateArix = -1;
                                }
                                else if (respuestaEstadoArix == RespuestasSvrCom.ErrorSendingRequest)
                                {
                                    // No se ejecuto el comando
                                    exito = false;
                                    stateArix = -2;
                                }
                                break;
                            case ComandosUsuario.ResetArix:
                                var respuestaResetArix = msgRespuesta.Respuesta;
                                if (respuestaResetArix == RespuestasSvrCom.OK)
                                {
                                    exito = true;
                                }
                                break;
                            case ComandosUsuario.AskClockArix:
                                var respuestaClockArix = msgRespuesta.Respuesta;
                                if (respuestaClockArix == RespuestasSvrCom.DATOS)
                                {
                                    dataClock = msgRespuesta.Datos.ToString();
                                    exito = true;
                                }
                                break;
                            case ComandosUsuario.SincClockArix:
                                var respuestaUpClockArix = msgRespuesta.Respuesta;
                                if (respuestaUpClockArix == RespuestasSvrCom.OK)
                                {
                                    exito = true;
                                }
                                break;
                            case ComandosUsuario.ModeOperation:
                                var responseModeOperation = msgRespuesta.Respuesta;
                                if(responseModeOperation == RespuestasSvrCom.OK)
                                {
                                    exito = true;
                                }
                                break;

                        } //end of switch


                    }
                    else
                    {

                        lblEstadoActualizacionOnline.Text = (string)this.GetLocalResourceObject("lblEstadoActualizacionOnlineOtroSerial") + msgRespuesta.SerialFWT;
                        lblLecturaOnlineEstadoFWT.Text = lblEstadoActualizacionOnline.Text;
                        lblResetOnLineFWT.Text = lblEstadoActualizacionOnline.Text;
                        lblMsgErrSeleccionFCIClear.Text = lblEstadoActualizacionOnline.Text;
                        lblMsgCosoftAsdu.Text = lblEstadoActualizacionOnline.Text;
                    }

                }
            }
            catch (MessageQueueException mqExc)
            {
                if (msgComando.Comando == ComandosUsuario.AsignacionAsduFWT)
                {
                    lblEstadoActualizacionOnline.Text = "";
                    lblMsgCosoftAsdu.Text = (string)this.GetLocalResourceObject("lblMsgCosoftAsduCosoftNoRespondio"); //"No respondio el módulo de comunicaciones la notificación de cambio de ASDU.";
                }
                else
                {
                    //lblEstadoActualizacionOnline.Text = "MessageQueueException al recibir :" + mqExc.Message;
                    lblEstadoActualizacionOnline.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(RespuestasSvrCom.MsgQueueExceptionComunicaciones);
                    lblLecturaOnlineEstadoFWT.Text = lblEstadoActualizacionOnline.Text;
                    lblResetOnLineFWT.Text = lblEstadoActualizacionOnline.Text;
                    lblMsgErrSeleccionFCIClear.Text = lblEstadoActualizacionOnline.Text;
                    lblMsgCosoftAsdu.Text = lblEstadoActualizacionOnline.Text;
                }
            }

            return exito;

        }


        private void InicializarMessageQueues()
        {
            //string queueName = @".\private$\WEbToSGRServer";  //Queue de Envío
            string queueName = ConfigApp.QueueToCosoft;  //Queue de Envío

            if (MessageQueue.Exists(queueName))
            {
                mqWebToSGR = new MessageQueue(queueName);
            }
            else
            {
                mqWebToSGR = MessageQueue.Create(queueName);
            }

            //string queuePath = ".\\private$\\SGRServerToWeb";  //Queue de Recepción  
            string queuePath = ConfigApp.QueueFromCosoft;  //Queue de Recepción

            if (MessageQueue.Exists(queuePath))
            {
                mqSGRToWeb = new MessageQueue(queuePath);
            }
            else
            {
                mqSGRToWeb = MessageQueue.Create(queuePath);
            }
            mqWebToSGR.Purge(); //Importante que NO existan mensajes en las colas anteriormente . Verificar si se cambia esta politica        
            mqSGRToWeb.Purge();
        }


        private void FormatearMensajeColaRecepcion()
        {
            //Formato de mensaje de recepcion MensajeRespuestasMQOnline
            ((XmlMessageFormatter)mqSGRToWeb.Formatter).TargetTypes = new Type[1];
            ((XmlMessageFormatter)mqSGRToWeb.Formatter).TargetTypes[0] = (new MensajeRespuestasMQOnline()).GetType(); ; // Va a recibir MensajeRespuestasMQOnline
        }

        private void MostrarEstadoActualizacionFirmware(byte? estadoActFW, short? ContActFw, string serial)
        {
            EstadoActualizacionFirmware estado = (estadoActFW == null) ? EstadoActualizacionFirmware.SinProceso : (EstadoActualizacionFirmware)estadoActFW;
            double contadorActFW = (ContActFw == null) ? 0 : (double)ContActFw;
            switch (estado)
            {
                case EstadoActualizacionFirmware.Inicio:
                    lblEstadoACTFirmware.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwarePendienteIniciar"); //"PENDIENTE INICIAR ACTUALIZACIÓN FIRMWARE.";
                    tmrActFirmware.Enabled = true;
                    break;
                case EstadoActualizacionFirmware.Procesando:
                    lblEstadoACTFirmware.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwareActualizandoFW"); //"ACTUALIZANDO FIRMWARE.";
                    double porcActFware;
                    short maxContador = AccesoDatosEF.GetMaxContadorActualizacionFWT(serial);
                    porcActFware = ((contadorActFW / maxContador) * 100);
                    lblPorcentajeActFirmware.Text = porcActFware.ToString("F") + " % ";
                    lblPorcentajeActFirmware.Visible = true;
                    if ((porcActFware >= 0) && (porcActFware <= 100)) //ProgressBar
                    {
                        imgPorcActFirmware.Width = Unit.Percentage(porcActFware);
                    }
                    else
                    {   //Para que la barra no se salga del tamanio 
                        imgPorcActFirmware.Width = Unit.Percentage(100);
                    }

                    imgPorcActFirmware.ToolTip = contadorActFW.ToString() + "/" + maxContador.ToString() + " " + (string)this.GetLocalResourceObject("imgPorcActFirmwarePcksActualizados"); //" paquetes actualizados.";
                    imgPorcActFirmware.Visible = true;
                    tmrActFirmware.Enabled = true;
                    break;

                case EstadoActualizacionFirmware.Terminado:
                    lblEstadoACTFirmware.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwareActualizacionTerminada"); //"ACTUALIZACIÓN TERMINADA.";
                    tmrActFirmware.Enabled = true;
                    break;
                case EstadoActualizacionFirmware.SinProceso:
                    lblEstadoACTFirmware.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwareActualizado"); //"FIRMWARE ACTUALIZADO.";
                    lblPorcentajeActFirmware.Visible = false;
                    imgPorcActFirmware.Visible = false;
                    tmrActFirmware.Enabled = false;
                    break;

            }
        }

        private void VerificarMensajeQtySixIncompatible(bool numeroMaximoSIXs_Menor, bool numeroMaximoSIXs_Mayor)
        {
            lblMsgErrQtySixIncompatibles.Text = "";

            if (numeroMaximoSIXs_Menor)
            {
                lblMsgErrQtySixIncompatibles.Text = (string)this.GetLocalResourceObject("TextCantidadSIXs") + " " + (string)this.GetLocalResourceObject("TextQtySixMenor");
            }

            if (numeroMaximoSIXs_Mayor)
            {
                lblMsgErrQtySixIncompatibles.Text = (string)this.GetLocalResourceObject("TextCantidadSIXs") + " " + (string)this.GetLocalResourceObject("TextQtySixMayor");
            }

            if (!lblMsgErrQtySixIncompatibles.Text.Equals(""))
            {
                lblMsgErrQtySixIncompatibles.Visible = true;
                timerQtySixIncompatible.Enabled = true;
            }
            else
            {
                lblMsgErrQtySixIncompatibles.Visible = false;
                timerQtySixIncompatible.Enabled = false;
            }
        }

        /// <summary>
        /// Llena los datos del Concentrador respectivo .
        /// </summary>
        /// <param name="idConc">id del Concentrador</param>
        private void LlenarValoresConcentrador(int idConc)
        {
            using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
            {
                var registro = (from conc in bDatos.FWTs
                                where conc.Id == idConc
                                select conc).SingleOrDefault();
                if (registro != null)
                {
                    if (registro.PendienteRecibirParametros)
                    {
                        lblEstadoFWT.Text = (string)this.GetLocalResourceObject("TextlblEstadoFWTPendienteRecibir"); //"PENDIENTE RECIBIR PARAMETROS.";
                        tmrActualizacionEstadoFWT.Enabled = true; //Se va a estar chequeando si se actualizan los datos de parametros .
                        imgEstadoFWT.Visible = true;
                    }
                    else
                    {
                        if (registro.PendienteEnviarParametros)
                        {
                            lblEstadoFWT.Text = (string)this.GetLocalResourceObject("TextlblEstadoFWTPendienteEnviar"); //"PENDIENTE ENVIAR PARAMETROS.";
                            tmrActualizacionEstadoFWT.Enabled = true; //Se va a estar chequeando si se actualizan los datos de parametros .
                            imgEstadoFWT.Visible = true;
                        }
                        else
                        {
                            lblEstadoFWT.Text = (string)this.GetLocalResourceObject("TextlblEstadoFWTDatosOK"); //"DATOS ACTUALIZADOS.";
                            imgEstadoFWT.Visible = false;
                        }
                    }

                    MostrarEstadoActualizacionFirmware(registro.EstadoProcesoActFw, registro.ContActFw, registro.Serial);
                    MostrarEstadoActualizacionFirmwareDevices(registro.EstadoActFwARIX, registro.ContaActFwARIX, registro.Serial);
                    MostrarEstadoActualizacionFirmwareDevicesSix(registro.EstadoActFwSIX, registro.ContaActFwSIX, registro.Serial);
                    //MostrarEstadoActualizacionFirmwareDevicesFci(registro.EstadoActFwFCI, registro.ContaActFwFCI, registro.Serial);
                    lblSerial.Text = registro.Serial; //No se permite editar                                    



                    if (registro.FechaRegistroGestion == null)
                    {
                        lblFechaRegistroGestion.Text = "";
                    }
                    else
                    {
                        lblFechaRegistroGestion.Text = registro.FechaRegistroGestion.ToString("dd-MM-yyyy HH:mm:ss");
                    }

                    if (registro.FechaInstalacion == null)
                    {
                        lblFechaInstalacion.Text = "NO";
                    }
                    else
                    {
                        lblFechaInstalacion.Text = registro.FechaInstalacion.Value.ToString("dd-MM-yyyy HH:mm:ss");
                    }

                    if (registro.UltimaFechaInicializacion == null)
                    {
                        lblFechaUltimaComunicacion.Text = "NO";
                    }
                    else
                    {
                        lblFechaUltimaComunicacion.Text = registro.UltimaFechaInicializacion.Value.ToString("dd-MM-yyyy HH:mm:ss");
                    }

                    if (registro.FechaUltimoEnvio == null)
                    {
                        lblFechaUltimoEnvio.Text = "??";
                    }
                    else
                    {
                        lblFechaUltimoEnvio.Text = registro.FechaUltimoEnvio.Value.ToString("dd-MM-yyyy HH:mm:ss");
                    }

                    //formula para nivel de señal = (nivelsenal *2) - 113 
                    // 0 - 31 valores que llegan , la mejor senal es 31  , 99 es valor desconocido .
                    // 0 : -113 dBm ó menos
                    // 31: - 51 dBm ó más 
                    if (registro.NivelSenal != null)
                    {
                        if (registro.NivelSenal == "99")
                        {
                            lblNivelSenal.Text = (string)this.GetLocalResourceObject("lblNivelSenalDesconocido"); //"Desconocido ";
                        }
                        else
                        {
                            int nivelSenaldBm = (int.Parse(registro.NivelSenal) * 2) - 113;
                            lblNivelSenal.Text = nivelSenaldBm.ToString() + " dBm ";
                            // para mostrar el progressBar de nivel de senal , 100 % es 31   
                            int nivelSenalEntero = int.Parse(registro.NivelSenal);
                            int anchoProgressBar = (nivelSenalEntero * 100) / 31;


                            if ((anchoProgressBar >= 0) && (anchoProgressBar <= 100)) //ProgressBar
                            {
                                ImgNivelSenal.Width = Unit.Percentage(anchoProgressBar);
                            }
                            else
                            {   //Para que la barra no se salga del tamanio 
                                ImgNivelSenal.Width = Unit.Percentage(100);
                            }

                            if (nivelSenalEntero >= 25)
                            {
                                ImgNivelSenal.ToolTip = (string)this.GetLocalResourceObject("ImgNivelSenalBueno"); //"Nivel señal Bueno .";
                            }
                            else if (nivelSenalEntero >= 15)
                            {
                                ImgNivelSenal.ToolTip = (string)this.GetLocalResourceObject("ImgNivelSenalNormal"); //"Nivel señal Normal .";
                            }
                            else if (nivelSenalEntero >= 10)
                            {
                                ImgNivelSenal.ToolTip = (string)this.GetLocalResourceObject("ImgNivelSenalMalo"); //"Nivel señal Malo .";

                            }
                            else
                            {
                                ImgNivelSenal.ToolTip = (string)this.GetLocalResourceObject("ImgNivelSenalMuyMalo"); //"Nivel señal Muy Malo .";
                            }

                            ImgNivelSenal.Visible = true;

                        }


                    }



                    lblIMEI.Text = registro.IMEI;
                    lblIMSI.Text = registro.IMSI;
                    if (registro.VoltajeBatt != null)
                    {
                        if (registro.VoltajeBatt.Length > 1)//Los voltajes vienen en decimas de voltios , se muestran con un lugar decimal
                        {
                            lblVoltBatt.Text = registro.VoltajeBatt.Substring(0, registro.VoltajeBatt.Length - 1) + "," + registro.VoltajeBatt.Substring(registro.VoltajeBatt.Length - 1, 1);
                        }
                        else //Si es un solo digito se adiciona ,0
                        {
                            lblVoltBatt.Text = registro.VoltajeBatt + ",0";
                        }
                    }

                    if (registro.VoltajeCargador != null)
                    {
                        if (registro.VoltajeCargador.Length > 1)
                        {
                            lblVoltCargador.Text = registro.VoltajeCargador.Substring(0, registro.VoltajeCargador.Length - 1) + "," + registro.VoltajeCargador.Substring(registro.VoltajeCargador.Length - 1, 1);
                        }
                        else //Si es un solo digito se adiciona ,0
                        {
                            lblVoltCargador.Text = registro.VoltajeCargador + ",0";
                        }
                    }

                    if (registro.VoltajePanel != null)
                    {
                        if (registro.VoltajePanel.Length > 1)//Los voltajes vienen en decimas de voltios , se muestran con un lugar decimal
                        {
                            lblVoltPanel.Text = registro.VoltajePanel.Substring(0, registro.VoltajePanel.Length - 1) + "," + registro.VoltajePanel.Substring(registro.VoltajePanel.Length - 1, 1);
                        }
                        else //Si es un solo digito se adiciona ,0
                        {
                            lblVoltPanel.Text = registro.VoltajePanel + ",0";
                        }
                    }
                    //agregar el simbolo de Voltios
                    lblVoltBatt.Text += " V";
                    lblVoltCargador.Text += " V";
                    lblVoltPanel.Text += " V";

                    lblTemperatura.Text = registro.Temperatura + " °C ";

                    lblVerPrograma.Text = registro.VersionPrograma;
                    lblVerMonitor.Text = registro.VersionMonitor;
                    lblVerFirmwModulo.Text = registro.VersionFirmwareModulo;


                    txtAPN.Text = registro.ParamFWT.APN;
                    txtUsuario.Text = registro.ParamFWT.Usuario;
                    txtPassword.Text = registro.ParamFWT.Password;
                    txtRePassword.Text = registro.ParamFWT.Password;

                    //Direcciones y puertos GPRS
                    txtIpGestion.Text = registro.ParamFWT.DireccionIPGestion;
                    txtPuertoGestion.Text = registro.ParamFWT.PuertoGESTION.ToString();
                    txtIpGestionAlternativa.Text = registro.ParamFWT.DireccionIPSCADA;
                    txtPuertoGestionAlternativo.Text = registro.ParamFWT.PuertoSCADA.ToString();
                    //Estos campos estan realmente ocultos...
                    txtIpSCADA.Text = registro.ParamFWT.DireccionIPSCADA;
                    txtPuertoSCADA.Text = registro.ParamFWT.PuertoSCADA.ToString();

                    prmDDLBandaGsm.SelectedValue = registro.ParamFWT.BandaDeOperacionGSM.ToString();

                    //Ciudad:
                    if (registro.ParamFWT.DireccionNomenclatura.Ciudad != null)
                    {
                        try
                        {
                            txtCiudad.SelectedValue = registro.ParamFWT.DireccionNomenclatura.Ciudad;
                        }
                        catch (Exception exGral)
                        {
                            txtCiudad.SelectedIndex = 0;
                        }
                    }
                    //foreach (ListItem item in txtCiudad.Items) //txtCiudad es dropdownlist
                    //{
                    //    if (item.Text.Trim() == registro.ParamFWT.DireccionNomenclatura.Ciudad)
                    //    {
                    //        item.Selected = true;
                    //        break;
                    //    }

                    //}

                    txtCalle.Text = registro.ParamFWT.DireccionNomenclatura.CalleCarrera;
                    txtNumero.Text = registro.ParamFWT.DireccionNomenclatura.Numero.ToString();
                    txtSubEstacion.Text = registro.ParamFWT.DireccionElectrica.SubEstacion;
                    txtCircuito.Text = registro.ParamFWT.DireccionElectrica.Circuito;
                    txtTramo.Text = registro.ParamFWT.DireccionElectrica.Tramo;
                    txtNodo.Text = registro.ParamFWT.DireccionElectrica.Nodo;
                    txtCodigoCorporativo.Text = registro.Codigo;
                    txtLatitud.Text = registro.ParamFWT.DireccionGPS.Latitud.ToString();
                    txtLongitud.Text = registro.ParamFWT.DireccionGPS.Longitud.ToString();
                    txtCanalRF.Text = registro.ParamFWT.CanalRF.ToString();
                    txtVecesNoReportar.Text = registro.ParamFWT.VecesSinReportarse.ToString();
                    txtNumeroMaximoFCI.Text = registro.ParamFWT.NumeroMaximoFCIs.ToString();

                    //Exclusivo para FWT que maneja equipos SIXs
                    txtPrmReporteCteSix.Text = registro.ParamFWT.SegReporteCorrienteSIX.ToString();
                    txtNumeroMaximoSIX.Text = registro.ParamFWT.NumeroMaximoSIXs.ToString();

                    VerificarMensajeQtySixIncompatible(registro.NumeroMaximoSIXs_Menor, registro.NumeroMaximoSIXs_Mayor);


                    //Version firmware de equipos remotos cargado.
                    if (registro.VersionProgramaFCIUploaded == null)
                    {
                        lblVersionFwDevRTCargado.Text = "";
                    }
                    else
                    {
                        lblVersionFwDevRTCargado.Text = registro.VersionProgramaFCIUploaded;
                    }

                    //Version firmware de equipos remotos cargado.
                    if (registro.VersionProgramaARIXUploaded == null)
                    {
                        lblVersionFwDevRTCargadoARIX.Text = "";
                    }
                    else
                    {
                        lblVersionFwDevRTCargadoARIX.Text = registro.VersionProgramaARIXUploaded;
                    }
                    if(registro.VersionProgramaSIXUploaded == null)
                    {
                        lblVersionFwDevRTCargadoSIX.Text = "";
                    }
                    else
                    {
                        lblVersionFwDevRTCargadoSIX.Text = registro.VersionProgramaSIXUploaded;
                    }


                    //PARAMETROS FUNCIONALES DEL EQUIPO FWT 

                    //Parametros funcionales - Comunicación con SGR

                    txtSecondsBeforeRetryConnection.Text = registro.ParamFWT.SecondsBeforeRetryConnection.ToString();
                    txtMaxNumeroReintentosPack.Text = registro.ParamFWT.MaxNumeroReintentosPack.ToString();
                    txtTiempoEsperaPaqueteDeSGR.Text = registro.ParamFWT.TiempoEsperaPaqueteDeSGR.ToString();
                    txtMaxNumeroReintentosConexionToSGR.Text = registro.ParamFWT.MaxNumeroReintentosConexionToSGR.ToString();
                    txtPeriodoReporteSeg.Text = registro.ParamFWT.PeriodoReporteSeg.ToString();


                    //Parametros de Gestión bajo SCADA
                    txtASDU.Text = registro.ASDU.ToString();
                    int[] canales;
                    if (registro.Canal104 > 0)
                    {
                        canales = new int[] { (int)registro.Canal104 };
                    }
                    else
                    {
                        AccesoDatos dbObj = new AccesoDatos();
                        canales = dbObj.GetPosiblesCanalesIEC104(ConfigApp.MaxCanalesIEC104, ConfigApp.MaxEquiposCanalIEC104);
                    }
                    if (canales != null)
                    {
                        try
                        {
                            ddListCanalesIEC.DataSource = canales;
                            ddListCanalesIEC.DataBind();
                            //if (registro.Canal104.HasValue)
                            //{
                            //    if (registro.Canal104.Value > 0)
                            //    {
                            //        ddListCanalesIEC.SelectedValue = registro.Canal104.ToString();
                            //        ddListCanalesIEC.Enabled = false;
                            //    }
                            //    else
                            //    {
                            //        ddListCanalesIEC.SelectedValue = "";
                            //    }
                            //}
                            if (registro.Canal104 > 0)
                            {
                                ddListCanalesIEC.SelectedValue = registro.Canal104.ToString();
                                ddListCanalesIEC.Enabled = false;
                            }
                            else
                            {
                                ddListCanalesIEC.SelectedValue = "";
                            }
                        }
                        catch (ArgumentOutOfRangeException arOutEx)
                        {

                        }
                    }




                    //Parametros de Fuentes

                    //VoltajeCargador
                    decimal? prmVoltajeCargador = registro.PrmVoltajeMinNivelCargador;
                    if (prmVoltajeCargador == null)
                    {
                        txtPrmVoltajeMinNivelCargador.Text = "";
                    }
                    else
                    {
                        txtPrmVoltajeMinNivelCargador.Text = registro.PrmVoltajeMinNivelCargador.ToString();
                    }

                    //VoltajePanel
                    decimal? prmVoltajePanel = registro.PrmVoltajeMinNivelPanel;
                    if (prmVoltajePanel == null)
                    {
                        txtPrmVoltajeMinNivelPanel.Text = "";
                    }
                    else
                    {
                        txtPrmVoltajeMinNivelPanel.Text = registro.PrmVoltajeMinNivelPanel.ToString();
                    }

                    //MinBateria
                    decimal? prmVoltajeMinBateria = registro.PrmVoltajeMinBateria;
                    if (prmVoltajeMinBateria == null)
                    {
                        txtPrmvoltajeMinBateria.Text = "";
                    }
                    else
                    {
                        txtPrmvoltajeMinBateria.Text = registro.PrmVoltajeMinBateria.ToString();
                    }

                    //voltajeLowBatt
                    decimal? prmVoltajeLowBatt = registro.PrmVoltajeLowBatt;
                    if (prmVoltajeLowBatt == null)
                    {
                        txtPrmVoltajeLowBatt.Text = "";
                    }
                    else
                    {
                        txtPrmVoltajeLowBatt.Text = registro.PrmVoltajeLowBatt.ToString();
                    }

                    //Corriente Bateria
                    txtPrmCorrienteBateria.Text = registro.ParamFWT.CorrienteBateria.ToString();

                    txtPrmPeriodoRevisionFuentes.Text = registro.ParamFWT.PeriodoRevisionFtesEnSeg.ToString();
                    prmChkProcesoCargaBateria.Checked = registro.ParamFWT.ProcesoCargaBatHabilitado;
                }

            }
        }

        /// <summary>
        /// Carga todos los FCIs disponibles (Que no tienen Concentrador relacionado )en el dropdownlist ddlFCIsAll
        /// </summary>
        private void LoadAllFCIs()
        {
            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {
                ddlFCIsAll.DataSource = from fci in db.FCIs
                                        where fci.FWTId == null
                                        orderby fci.Id
                                        select new { Id = fci.Id, Ser = fci.Serial };
                ddlFCIsAll.DataTextField = "Ser";
                ddlFCIsAll.DataValueField = "Id";
                ddlFCIsAll.DataBind();

            }

        }

        /// <summary>
        /// Carga los FCIs que corresponden a este FWT
        /// </summary>
        /// <param name="idFWT"></param>
        private void LoadFCIsPropios(int idFWT)
        {
            bool existeSix = false;
            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {
                var consultaFCIs = from fci in db.FCIs
                                   where fci.FWTId == idFWT
                                   orderby fci.Serial ascending
                                   select fci;

                var consultaARIXs = from arix in db.ARIXs
                                    where arix.FWTId == idFWT
                                    orderby arix.Serial ascending
                                    select arix;
                foreach (var registro in consultaFCIs)
                {
                    listBoxFCIsPropios.Items.Add(new ListItem(registro.Serial, registro.Id.ToString()));
                    if (registro.TipoEquipo == 2) //Es un Six
                    {
                        existeSix = true;
                    }
                }

                foreach (var registro in consultaARIXs)
                {
                    listBoxFCIsPropios.Items.Add(new ListItem(registro.Serial, registro.Id.ToString()));
                    if (registro.TipoEquipo == 4) //Es un Arix
                    {
                        existeSix = true;
                    }
                }
            }
            ConfigurarParametroReporteCteSix(existeSix);
        }


        private void ConfigurarParametroReporteCteSix(bool existeAlMenosUnSix)
        {
            if (!existeAlMenosUnSix)
            {
                lblLeerCteSix.Visible = false;
                txtPrmReporteCteSix.Visible = false;
                Label71.Visible = false;
                ReExReporteCteSix.Enabled = false;
                RanValReporteCteSix.Enabled = false;
                ReqReporteCteSix.Enabled = false;
            }
        }

        /// <summary>
        /// Activa los botones de acuerdo a condiciones Online si existe una conexión para este FWT y segun el caso especifico de cada buton .
        /// </summary>
        private void ActivarBotones()
        {
            if (lblEstadoACTFirmware.Text.ToUpper() == (string)this.GetLocalResourceObject("lblEstadoACTFirmwareActualizandoFW")) //"ACTUALIZANDO FIRMWARE." todo se desactiva , los botones Online vienen por defecto desactivados .
            {
                butUpdate.Enabled = false;
                butDelete.Enabled = false;
            }
            else
            {
                if (_equipoConectado)
                {
                    butLeerEstadoFWTOnLine.Enabled = true;
                    btnClearFCI.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                    btnWriteResetFwt.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                    butUpdateOnline.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);

                    //Para que el boton se desactive cuando se le haga click y además permita continuar con el postback 
                    butUpdateOnline.Attributes.Add("onclick", "javascript:" + butUpdateOnline.ClientID + ".disabled=true;" + ClientScript.GetPostBackEventReference(butUpdateOnline, ""));
                    butLeerEstadoFWTOnLine.Attributes.Add("onclick", "javascript:" + butLeerEstadoFWTOnLine.ClientID + ".disabled=true;" + ClientScript.GetPostBackEventReference(butLeerEstadoFWTOnLine, ""));
                    butLeerParamOnline.Attributes.Add("onclick", "javascript:" + butLeerParamOnline.ClientID + ".disabled=true;" + ClientScript.GetPostBackEventReference(butLeerParamOnline, ""));
                    btnClearFCI.Attributes.Add("onclick", "javascript:" + btnClearFCI.ClientID + ".disabled=true;" + ClientScript.GetPostBackEventReference(btnClearFCI, ""));
                    btnWriteResetFwt.Attributes.Add("onclick", "javascript:" + btnWriteResetFwt.ClientID + ".disabled=true;" + ClientScript.GetPostBackEventReference(btnWriteResetFwt, ""));
                    //Se activa leer param Online si no esta pendiente por enviar parametros .
                    if (lblEstadoFWT.Text.ToUpper() != (string)this.GetLocalResourceObject("TextlblEstadoFWTPendienteEnviar")) //"PENDIENTE ENVIAR PARAMETROS."
                    {
                        butLeerParamOnline.Enabled = true;

                    }
                    else
                    {
                        butLeerParamOnline.Enabled = false;
                    }


                }
            }

        }


        /// <summary>
        /// Este metodo se dirige a la pagina anterior
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void butCancelar_Click(object sender, EventArgs e)
        {
            //object refUrl = ViewState["paginaAnterior"];
            //if (refUrl != null)
            //{
            //    Response.Redirect((string)refUrl);
            //}
            Response.Redirect("FWTsAll.aspx");
        }

        protected void butDelete_Click(object sender, EventArgs e)
        {
            if (listBoxFCIsPropios.Items.Count == 0)  //Si no tiene FCIs asociados se puede borrar este FWT 
            {
                using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
                {
                    try
                    {
                        FWT fwt = new FWT();                 //Se crea un objeto FWT
                        fwt.Id = Convert.ToInt32(lblId.Text);
                        bDatos.FWTs.Attach(fwt);    //se adjunta este objeto fwt a la colección de FWTs
                        AccesoDatosEF.SetDeleteProcessFWT(lblSerial.Text, true);

                        //Se borran los registros que pueda tener relacionado en  cascada
                        if (fwt.AlarmasFWTs.Count > 0)
                        {
                            fwt.AlarmasFWTs.Clear();
                        }

                        if (fwt.LlamadasCallToCallSets.Count > 0)
                        {
                            fwt.LlamadasCallToCallSets.Clear();
                        }

                        if (fwt.HistorialEstadosFWTs.Count > 0)
                        {
                            fwt.HistorialEstadosFWTs.Clear();
                        }

                        if (fwt.HistorialParamsFWTs.Count > 0)
                        {
                            fwt.HistorialParamsFWTs.Clear();
                        }

                        if (fwt.ConexionesFWTs.Count > 0)
                        {
                            fwt.ConexionesFWTs.Clear();
                        }

                        //if (fwt.ConexionesFWT != null) //Chequear si hay  conexion FWT 
                        //{
                        //    bDatos.ObjectStateManager.ChangeObjectState(fwt.ConexionesFWT, System.Data.EntityState.Deleted); //Se cambia el estado a deleted
                        //    bDatos.SaveChanges();
                        //}

                        bDatos.ObjectStateManager.ChangeObjectState(fwt, System.Data.EntityState.Deleted); //Se cambia el estado a deleted
                        bDatos.SaveChanges();    //Se guardan los cambios en el context Manager 
                        butCancelar_Click(this.butDelete, null);
                    }
                    catch (Exception exGral)
                    {
                        AccesoDatosEF.SetDeleteProcessFWT(lblSerial.Text, false);
                        Response.Write("<SCRIPT>alert('No es posible eliminar el Concentrador en este momento. Intentar en algunos minutos.');</SCRIPT>");
                        butRemoveFCI.Focus();
                    }
                }

            }
            else
            {
                Response.Write("<SCRIPT>alert('No es posible eliminar un Concentrador que gestione FCIs , puede hacer que este Concentrador NO gestione FCIs antes si lo desea .');</SCRIPT>");
                butRemoveFCI.Focus();
            }


        }

        protected void btnSaveInfoNoActualizable_Click(object sender, EventArgs e)
        {
            using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
            {
                int idFWT = Convert.ToInt32(lblId.Text);
                //Tenemos la consulta en LinqToSQL que nos selecciona este FWT
                var fwt = (from conc in bDatos.FWTs
                           where conc.Id == idFWT
                           select conc).SingleOrDefault();
                if (fwt != null)
                {
                    fwt.ParamFWT.DireccionNomenclatura.Ciudad = txtCiudad.SelectedValue.Trim(); //txtCiudad es un drpdownlist
                    fwt.ParamFWT.DireccionNomenclatura.CalleCarrera = txtCalle.Text;
                    fwt.ParamFWT.DireccionNomenclatura.Numero = txtNumero.Text;
                    fwt.ParamFWT.DireccionElectrica.SubEstacion = txtSubEstacion.Text;
                    fwt.ParamFWT.DireccionElectrica.Circuito = txtCircuito.Text;
                    fwt.ParamFWT.DireccionElectrica.Tramo = txtTramo.Text;
                    fwt.ParamFWT.DireccionElectrica.Nodo = txtNodo.Text;
                    fwt.Codigo = txtCodigoCorporativo.Text.Trim();
                    fwt.ParamFWT.DireccionGPS.Latitud = txtLatitud.Text;
                    fwt.ParamFWT.DireccionGPS.Longitud = txtLongitud.Text;
                    bDatos.SaveChanges();
                }
            }
        }

        private void ActualizarFWT()
        {
            byte apnUsado = 0;
            object refControlesCambiados = ViewState["controlesChanged"];
            if (refControlesCambiados != null)
            {
                using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
                {

                    int idFWT = Convert.ToInt32(lblId.Text);
                    //Tenemos la consulta en LinqToSQL que nos selecciona este FWT
                    var fwt = (from conc in bDatos.FWTs
                               where conc.Id == idFWT
                               select conc).SingleOrDefault();
                    if (fwt != null)
                    {
                        apnUsado = fwt.ParamFWT.UsaApn;
                        //ATENCION : Chequear cuales de todos los valores de controles de la pagina hacen que se necesite enviar actualización de parametros 
                        fwt.PendienteEnviarParametros = true;
                        lblEstadoFWT.Text = (string)this.GetLocalResourceObject("TextlblEstadoFWTPendienteEnviar"); //"PENDIENTE ENVIAR PARAMETROS.";
                        //vamos a verificar que controles cambiaron             
                        //Se define que control(es) cambió(aron) y se actualiza(n) en el modelo EF.
                        string[] arrayControlesCambiados = ((string)refControlesCambiados).Split(new string[] { "*" }, StringSplitOptions.RemoveEmptyEntries);
                        foreach (string strControlId in arrayControlesCambiados)
                        {
                            switch (strControlId)
                            {
                                case "txtAPN":
                                    fwt.ParamFWT.APN = txtAPN.Text;
                                    break;
                                case "txtUsuario":
                                    fwt.ParamFWT.Usuario = txtUsuario.Text;
                                    break;
                                case "txtPassword":
                                    fwt.ParamFWT.Password = txtPassword.Text;
                                    break;
                                case "txtIpGestion":
                                    fwt.ParamFWT.DireccionIPGestion = txtIpGestion.Text;
                                    break;
                                case "txtPuertoGestion":
                                    fwt.ParamFWT.PuertoGESTION = ushort.Parse(txtPuertoGestion.Text);
                                    break;
                                case "txtIpGestionAlternativa":
                                    string txtIpAlt = txtIpGestionAlternativa.Text.Trim();
                                    fwt.ParamFWT.DireccionIPSCADA = txtIpAlt;
                                    if (txtIpAlt.Equals(""))
                                    {
                                        fwt.ParamFWT.UsaIPAlternativa = false;
                                    }
                                    else
                                    {
                                        fwt.ParamFWT.UsaIPAlternativa = true;
                                    }
                                    break;
                                case "txtPuertoGestionAlternativo":
                                    ushort nuevoValor;
                                    string txtIpAlter = txtIpGestionAlternativa.Text.Trim();
                                    if (!txtIpAlter.Equals(""))
                                    {
                                        if (ushort.TryParse(txtPuertoGestionAlternativo.Text.Trim(), out nuevoValor))
                                        {
                                            fwt.ParamFWT.PuertoSCADA = nuevoValor;
                                        }
                                    }
                                    break;
                                //case "txtIpSCADA":
                                //    fwt.ParamFWT.DireccionIPSCADA = txtIpSCADA.Text;
                                //    break;
                                //case "txtPuertoSCADA":
                                //    fwt.ParamFWT.PuertoSCADA = short.Parse(txtPuertoSCADA.Text);
                                //    break;
                                //case "txtCiudad":
                                //    fwt.ParamFWT.DireccionNomenclatura.Ciudad = txtCiudad.SelectedValue.Trim(); //txtCiudad es un drpdownlist
                                //    break;
                                //case "txtCalle":
                                //    fwt.ParamFWT.DireccionNomenclatura.CalleCarrera = txtCalle.Text;
                                //    break;
                                //case "txtNumero":
                                //    fwt.ParamFWT.DireccionNomenclatura.Numero = txtNumero.Text;
                                //    break;
                                //case "txtSubEstacion":
                                //    fwt.ParamFWT.DireccionElectrica.SubEstacion = txtSubEstacion.Text;
                                //    break;
                                //case "txtCircuito":
                                //    fwt.ParamFWT.DireccionElectrica.Circuito = txtCircuito.Text;
                                //    break;
                                //case "txtTramo":
                                //    fwt.ParamFWT.DireccionElectrica.Tramo = txtTramo.Text;
                                //    break;
                                //case "txtNodo":
                                //    fwt.ParamFWT.DireccionElectrica.Nodo = txtNodo.Text;
                                //    break;
                                //case "txtLatitud":
                                //    fwt.ParamFWT.DireccionGPS.Latitud = txtLatitud.Text;
                                //    break;
                                //case "txtLongitud":
                                //    fwt.ParamFWT.DireccionGPS.Longitud = txtLongitud.Text;
                                //    break;
                                case "txtCanalRF":
                                    fwt.ParamFWT.CanalRF = byte.Parse(txtCanalRF.Text);
                                    break;
                                case "txtVecesNoReportar":
                                    fwt.ParamFWT.VecesSinReportarse = byte.Parse(txtVecesNoReportar.Text);
                                    break;
                                case "txtNumeroMaximoFCI":
                                    fwt.ParamFWT.NumeroMaximoFCIs = byte.Parse(txtNumeroMaximoFCI.Text);
                                    break;
                                case "txtNumeroMaximoSIX":
                                    var listArixByFWT = bDatos.ARIXs.Where(x => x.FWTId == fwt.Id);
                                    if (listArixByFWT.Count() > 0)
                                    {
                                        if (int.Parse(txtNumeroMaximoSIX.Text) <= 3 && int.Parse(txtNumeroMaximoSIX.Text) >= 0)
                                        {
                                            fwt.ParamFWT.NumeroMaximoSIXs = byte.Parse(txtNumeroMaximoSIX.Text);
                                        }
                                        else
                                        {
                                            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('warning','Se detectaron ARIX dentro del FWT, el máximo permitido son 3 ARIX', 'Número máximo SIX / ARIX');", true);
                                        }
                                    }
                                    else
                                    {
                                        fwt.ParamFWT.NumeroMaximoSIXs = byte.Parse(txtNumeroMaximoSIX.Text);
                                    }

                                    break;
                                case "listBoxFCIsPropios":
                                    ActualizarFCIsParaConcentrador();
                                    break;
                                case "txtSecondsBeforeRetryConnection":
                                    fwt.ParamFWT.SecondsBeforeRetryConnection = short.Parse(txtSecondsBeforeRetryConnection.Text);
                                    break;
                                case "txtMaxNumeroReintentosPack":
                                    fwt.ParamFWT.MaxNumeroReintentosPack = byte.Parse(txtMaxNumeroReintentosPack.Text);
                                    break;
                                case "txtTiempoEsperaPaqueteDeSGR":
                                    fwt.ParamFWT.TiempoEsperaPaqueteDeSGR = short.Parse(txtTiempoEsperaPaqueteDeSGR.Text);
                                    break;
                                case "txtMaxNumeroReintentosConexionToSGR":
                                    fwt.ParamFWT.MaxNumeroReintentosConexionToSGR = byte.Parse(txtMaxNumeroReintentosConexionToSGR.Text);
                                    break;
                                case "txtPeriodoReporteSeg":
                                    fwt.ParamFWT.PeriodoReporteSeg = int.Parse(txtPeriodoReporteSeg.Text);
                                    break;
                                case "txtPrmVoltajeMinNivelCargador":
                                    decimal valPrm = decimal.Parse(TransformarSeparadorDecimal(txtPrmVoltajeMinNivelCargador.Text));
                                    fwt.PrmVoltajeMinNivelCargador = valPrm;
                                    decimal prmCalculado = ((valPrm - 0.7m) / 9.2m) * (255m / 3.3m); //Formula según firmware
                                    fwt.ParamFWT.VoltajeMinNivelCargador = Utilitarios.FixToOneDecimalDigit(prmCalculado);
                                    break;
                                case "txtPrmVoltajeMinNivelPanel":
                                    decimal valPrmPanel = decimal.Parse(TransformarSeparadorDecimal(txtPrmVoltajeMinNivelPanel.Text));
                                    fwt.PrmVoltajeMinNivelPanel = valPrmPanel;
                                    decimal prmPanelCalculado = ((valPrmPanel - 0.7m) / 9.2m) * (255m / 3.3m); //Formula según firmware
                                    fwt.ParamFWT.VoltajeMinNivelPanel = Utilitarios.FixToOneDecimalDigit(prmPanelCalculado);
                                    break;
                                case "txtPrmvoltajeMinBateria":
                                    decimal valPrmMinBat = decimal.Parse(TransformarSeparadorDecimal(txtPrmvoltajeMinBateria.Text));
                                    fwt.PrmVoltajeMinBateria = valPrmMinBat;
                                    decimal prmMinBatCalculado = (valPrmMinBat / 4.77m) * (255m / 3.3m);
                                    fwt.ParamFWT.VoltajeMinBateria = Utilitarios.FixToOneDecimalDigit(prmMinBatCalculado);
                                    break;
                                case "txtPrmVoltajeLowBatt":
                                    decimal valPrmLowBatt = decimal.Parse(TransformarSeparadorDecimal(txtPrmVoltajeLowBatt.Text));
                                    fwt.PrmVoltajeLowBatt = valPrmLowBatt;
                                    decimal prmLowBattCalculado = (valPrmLowBatt / 4.77m) * (255m / 3.3m);
                                    fwt.ParamFWT.VoltajeLowBatt = Utilitarios.FixToOneDecimalDigit(prmLowBattCalculado);
                                    break;
                                case "txtPrmCorrienteBateria":
                                    fwt.ParamFWT.CorrienteBateria = byte.Parse(txtPrmCorrienteBateria.Text);
                                    break;
                                case "txtPrmReporteCteSix":
                                    fwt.ParamFWT.SegReporteCorrienteSIX = short.Parse(txtPrmReporteCteSix.Text);
                                    break;
                                case "prmDDLBandaGsm":
                                    fwt.ParamFWT.BandaDeOperacionGSM = byte.Parse(prmDDLBandaGsm.SelectedValue);
                                    break;
                                case "txtPrmPeriodoRevisionFuentes":
                                    fwt.ParamFWT.PeriodoRevisionFtesEnSeg = short.Parse(txtPrmPeriodoRevisionFuentes.Text);
                                    break;
                                case "prmChkProcesoCargaBateria":
                                    fwt.ParamFWT.ProcesoCargaBatHabilitado = prmChkProcesoCargaBateria.Checked;
                                    break;

                            }

                        }

                        if ((txtAPN.Text.Length <= 29) && (txtUsuario.Text.Length <= 15) && (txtPassword.Text.Length <= 15))
                        {
                            apnUsado = 0;
                        }
                        else
                        {
                            apnUsado = 1;
                        }

                        fwt.ParamFWT.UsaApn = apnUsado;
                        bDatos.SaveChanges();    //Se guardan los cambios en el context Manager 
                        lblEstadoActualizacion.Visible = true;
                        lblEstadoActualizacion.Text = (string)this.GetLocalResourceObject("lblEstadoActualizacionPendienteEnviarPrms"); //"PENDIENTE ENVIAR PARAMETROS.";
                        lblEstadoActualizacionOnline.Visible = false;
                        ViewState["controlesChanged"] = null;  // empieza desde cero los controles cambiados.
                        ViewState["ActualizadoOffline"] = true;
                        ActivarBotones();
                        imgEstadoFWT.Visible = true;
                        tmrActualizacionEstadoFWT.Enabled = true;
                    }
                }

            }
            else
            {
                lblEstadoActualizacion.Visible = true;
                lblEstadoActualizacion.Text = (string)this.GetLocalResourceObject("lblEstadoActualizacionNoCambiosEnFWT"); //"No realizó cambios en el Concentrador .";
            }
        }

        protected string TransformarSeparadorDecimal(string valorInput)
        {
            NumberFormatInfo nfi = CultureInfo.CurrentCulture.NumberFormat;

            return valorInput.Replace(",", nfi.NumberDecimalSeparator);
        }

        protected void butUpdate_Click(object sender, EventArgs e)
        {

            if (!ValidarPasswordAPN())
            {
                lblEstadoActualizacion.Visible = true;
                lblEstadoActualizacion.Text = (string)this.GetLocalResourceObject("lblEstadoActualizacionValoresPwdsDistintos"); //"Los dos valores de los passwords son distintos";
                txtPassword.Focus();
                return;
            }

            string strValidacion = DoValidacionConexionGPRSAlternativa();
            if (!strValidacion.Equals(""))
            {
                lblEstadoActualizacion.Visible = true;
                lblEstadoActualizacion.Text = strValidacion;
                return;
            }

            lblEstadoActualizacion.Text = "";
            ActualizarFWT();

            ////Los passwords no se pueden comparar con el CompareValidator Totalmente pues tambien puede ser vacios . Si un control está vacio no se activa comparevalidator .
            //if ((txtPassword.Text == "") || (txtRePassword.Text == ""))
            //{
            //    lblEstadoActualizacion.Text = "";
            //    if (txtRePassword.Text != txtPassword.Text)
            //    {
            //        lblEstadoActualizacion.Visible = true;
            //        lblEstadoActualizacion.Text = (string)this.GetLocalResourceObject("lblEstadoActualizacionValoresPwdsDistintos"); //"Los dos valores de los passwords son distintos";
            //        txtPassword.Focus();
            //    }
            //    else //Los dos son vacios , se actualiza 
            //    {
            //       ActualizarFWT();
            //    }
            //}
            //else
            //{
            //    lblEstadoActualizacion.Text = "";
            //    ActualizarFWT();

            //}
        }

        private bool ValidarPasswordAPN()
        {
            bool areOK = false;

            if (txtPassword.Text.Equals(txtRePassword.Text))
            {
                areOK = true;
            }

            return areOK;
        }

        private string DoValidacionConexionGPRSAlternativa()
        {
            string msgVal = "";

            if (!txtIpGestionAlternativa.Text.Trim().Equals(""))
            {
                ushort valPuerto;
                if (ushort.TryParse(txtPuertoGestionAlternativo.Text.Trim(), out valPuerto))
                {
                    if ((valPuerto < 1025) || (valPuerto > 65535))
                    {
                        msgVal = (string)this.GetLocalResourceObject("RanValPtoGestion1");
                    }
                }
                else
                {
                    msgVal = (string)this.GetLocalResourceObject("RegExpValPtoGestionMsgErr1");
                }
            }

            return msgVal;
        }

        private void ActualizarFCIsParaConcentrador()
        {
            using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
            {
                int idFWT = Convert.ToInt32(lblId.Text);
                //Consulta LinqToSQl de todos los FCIs que tienen a este concentrador como Gestor 
                var consulta = from fci in bDatos.FCIs
                               where fci.FWTId == idFWT
                               select fci;
                //Se quita la relación de estos FCIs al FWT
                foreach (FCI item in consulta)
                {
                    item.FWTId = null;
                }
                bDatos.SaveChanges();

                //Ahora hay que relacionar los FCIs que esten en la lista de propios con el id de este FWT
                foreach (ListItem item in listBoxFCIsPropios.Items)
                {
                    int idItem = int.Parse(item.Value);
                    var fciPropio = (from fci in bDatos.FCIs
                                     where fci.Id == idItem
                                     select fci).SingleOrDefault(); //Se escoge este especifico fci
                    if (fciPropio != null)
                    {
                        fciPropio.FWTId = int.Parse(lblId.Text);
                        bDatos.SaveChanges();
                    }

                }

            }

        }

        /// <summary>
        /// Adiciona un FCI de la lista de todos a la lista de los FCI de este concentrador y lo elimina de su lista original 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void butAddFCI_Click(object sender, EventArgs e)
        {
            if (ddlFCIsAll.SelectedItem != null)
            {
                listBoxFCIsPropios.Items.Add(new ListItem(ddlFCIsAll.SelectedItem.Text, ddlFCIsAll.SelectedItem.Value));
                ddlFCIsAll.Items.Remove(ddlFCIsAll.SelectedItem);
                UtilitariosWebGUI.SortListBox(ref listBoxFCIsPropios);
                TextBox_TextChanged(listBoxFCIsPropios, null); //Importante , se indica que cambió listBoxFCIsPropios
            }

        }

        protected void butRemoveFCI_Click(object sender, EventArgs e)
        {
            if (listBoxFCIsPropios.SelectedItem != null)
            {
                ddlFCIsAll.Items.Add(new ListItem(listBoxFCIsPropios.SelectedItem.Text, listBoxFCIsPropios.SelectedItem.Value));
                listBoxFCIsPropios.Items.Remove(listBoxFCIsPropios.SelectedItem);
                UtilitariosWebGUI.SortDropDownList(ref ddlFCIsAll);
                if (listBoxFCIsPropios.Items.Count > 0)//Para que la lista propia continue seleccionando items 
                {
                    listBoxFCIsPropios.SelectedIndex = 0;  //selecciona el primer item de la lista 
                }
                TextBox_TextChanged(listBoxFCIsPropios, null); //Importante , se indica que cambió listBoxFCIsPropios
            }
        }

        protected void butUpdateOnline_Click(object sender, EventArgs e)
        {
            this.Validate("edicionFWT");
            if (this.IsValid)
            {
                ViewState["ActualizadoOffline"] = false;  //antes de actualizar Online , se hace todo el proceso de Actualizar OffLine
                butUpdate_Click(sender, e);

                if ((bool)ViewState["ActualizadoOffline"]) //Si se pudo actualizar Offline , ya estan los datos en base datos .
                {
                    RealizarComunicacionMessageQueueOnline(ComandosUsuario.ActParamFWT);
                }
            }
        }

        protected void OkButton_Click(object sender, EventArgs e)
        {
            butUpdateOnline_Click(sender, e);
        }

        protected void butLeerParamOnline_Click(object sender, EventArgs e)
        {
            butLeerParamOnline.Enabled = false;
            RealizarComunicacionMessageQueueOnline(ComandosUsuario.ReadParamFWT);
            butLeerParamOnline.Enabled = true;
        }

        protected void tmrActFirmware_Tick(object sender, EventArgs e)
        {
            using (SistemaGestionRemotoContainer bData = new SistemaGestionRemotoContainer())
            {
                FWT fwt = bData.FWTs.SingleOrDefault(f => f.Serial == lblSerial.Text);
                if (fwt != null)
                {
                    MostrarEstadoActualizacionFirmware(fwt.EstadoProcesoActFw, fwt.ContActFw, fwt.Serial);
                }
            }
        }

        protected void butLeerEstadoFWTOnLine_Click(object sender, EventArgs e)
        {
            RealizarComunicacionMessageQueueOnline(ComandosUsuario.ReadStateFWT);
        }

        protected void btnWriteResetFwt_Click(object sender, EventArgs e)
        {
            RealizarComunicacionMessageQueueOnline(ComandosUsuario.ResetFWT);
        }

        protected void tmrActualizacionEstadoFWT_Tick(object sender, EventArgs e)
        {
            using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
            {

                var registro = (from conc in bDatos.FWTs
                                where conc.Serial == lblSerial.Text
                                select conc).SingleOrDefault();
                if (registro != null)
                {
                    if (registro.PendienteRecibirParametros)
                    {
                        lblEstadoFWT.Text = (string)this.GetLocalResourceObject("TextlblEstadoFWTPendienteRecibir"); //"PENDIENTE RECIBIR PARAMETROS.";
                    }
                    else
                    {
                        if (registro.PendienteEnviarParametros)
                        {
                            lblEstadoFWT.Text = (string)this.GetLocalResourceObject("TextlblEstadoFWTPendienteEnviar"); //"PENDIENTE ENVIAR PARAMETROS.";
                        }
                        else
                        {
                            tmrActualizacionEstadoFWT.Enabled = false;
                            lblEstadoFWT.Text = (string)this.GetLocalResourceObject("TextlblEstadoFWTDatosOK"); //"DATOS ACTUALIZADOS.";
                            imgEstadoFWT.Visible = false;
                            lblEstadoActualizacion.Visible = false;
                            lblEstadoActualizacionOnline.Visible = false;
                            tmrActivarBotones.Enabled = true;
                            LlenarComboFechasHistoricasParametros(registro.Id);
                        }
                    }
                }
            }
        }

        protected void tmrActivarBotones_Tick(object sender, EventArgs e)
        {
            if (lblEstadoFWT.Text.ToUpper() == (string)this.GetLocalResourceObject("TextlblEstadoFWTDatosOK")) //"DATOS ACTUALIZADOS."
            {
                butLeerParamOnline.Enabled = true;
                tmrActivarBotones.Enabled = false;

            }
            else
            {
                butLeerParamOnline.Enabled = false;
            }

        }

        protected void btnAsduSet_Click(object sender, EventArgs e)
        {
            string validacionGeneral;
            int idEquipo = int.Parse(lblId.Text);
            int asduAnterior = AccesoDatosEF.GetASDU(idEquipo);
            int asduDigitado;
            if (int.TryParse(txtASDU.Text, out asduDigitado))
            {
                TipoOperacionInWinScada? tipoOpFinal;
                validacionGeneral = ValidacionGeneralASDU(asduAnterior, asduDigitado, out tipoOpFinal);
                if (validacionGeneral == "")
                {
                    string strTexMsg;
                    int canalIECAsignado = int.Parse(ddListCanalesIEC.SelectedValue);
                    if (RealizarOperacionCompletaASDU(lblSerial.Text, asduDigitado, tipoOpFinal.Value, canalIECAsignado, out strTexMsg))
                    {
                        if (AccesoDatosEF.UpdateASDUCanal104(idEquipo, asduDigitado, canalIECAsignado))
                        {
                            strTexMsg = strTexMsg + " " + (string)this.GetLocalResourceObject("TextActAsduCanalOK"); //"Actualización ASDU/Canal OK";
                            RealizarComunicacionMessageQueueOnline(ComandosUsuario.AsignacionAsduFWT, null, asduDigitado);
                        }
                        else
                        {
                            strTexMsg = strTexMsg + " " + (string)this.GetLocalResourceObject("TextErrorAsduUpdateInDB"); //"Error actualizando ASDU en base de datos.";
                        }
                    }
                    lblErrorValAsdu.Text = strTexMsg;
                }
                else
                {
                    lblErrorValAsdu.Text = validacionGeneral;
                }
            }
            else
            {
                lblErrorValAsdu.Text = (string)this.GetLocalResourceObject("lblErrorValAsduBadAsdu"); //"Error con el valor ingresado del ASDU.";
            }
        }

        protected bool RealizarOperacionCompletaASDU(string serialEquipo, int newAsdu, TipoOperacionInWinScada tipoCmd, int canalIEC104, out string txtSalida)
        {
            bool exito = false;
            ConectorMQ conectorMsg;
            txtSalida = "";

            try
            {
                if (UtilsScada.InicializarConectorQueue(out conectorMsg))
                {
                    try
                    {
                        string txtRespuesta;
                        if (UtilsScada.CheckWinScadaService(conectorMsg, out txtRespuesta))
                        {
                            try
                            {
                                string txtFromWinScada;
                                if (EjecutarOperacionASDU(conectorMsg, serialEquipo, newAsdu, tipoCmd, canalIEC104, out txtFromWinScada))
                                {
                                    txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaOk"); //"Operación Exitosa.";
                                    exito = true;
                                }
                                else
                                {
                                    txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaWinScadaNoK") + txtFromWinScada; //"Operación en WinScada no exitosa: "
                                }
                            }
                            catch (EnvioMensajeException)
                            {
                                txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaErrMQSrvOp");
                            }
                            catch (InicioRecepcionException)
                            {
                                txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaWinScadaNotAvailable");
                            }
                        }
                        else
                        {
                            txtSalida = txtRespuesta;
                        }
                    }
                    catch (EnvioMensajeException)
                    {
                        txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaErrMQVerifyWinScada");
                    }
                    catch (InicioRecepcionException)
                    {
                        txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaWinScadaNotAvail");
                    }
                }
                else
                {
                    txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaErrColas");
                }
            }
            catch (FormatoPathColaException)
            {
                txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaErrNombresColas");
            }
            catch (CreacionColaException)
            {
                txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaCreandoColas");
            }
            catch (MessageQueueException)
            {
                txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaErrorInternoMQSrv");
            }

            return exito;
        }

        protected string ValidacionGeneralASDU(int asduAnterior, int asduDigitado, out TipoOperacionInWinScada? tipoOperacion)
        {
            string msgFinal = "";
            tipoOperacion = null;
            int idEquipo = int.Parse(lblId.Text);

            if (asduAnterior == asduDigitado)  //Caso: ASDU pasa de N --> N
            {
                msgFinal = (string)this.GetLocalResourceObject("TextValidarAsduIgualAnterior"); //"El valor del nuevo ASDU es igual al anterior.";
            }
            else if (asduAnterior > 0 && asduDigitado == 0) //Caso: ASDU pasa de N --> 0; Operacion = Eliminar Equipo
            {
                if (AccesoDatosEF.FWTHasFCIenScada(idEquipo))
                {
                    msgFinal = (string)this.GetLocalResourceObject("TextValidarAsduAunTieneEquipos"); //"Este FWT aún tiene FCIs habilitados para Scada.";
                }
                else
                {
                    tipoOperacion = TipoOperacionInWinScada.ELIMINAR_EQUIPO;
                }
            }
            else if (asduAnterior == 0 && asduDigitado > 0) //Caso: ASDU pasa de 0 --> N; Operacion = Creación Equipo
            {
                if (AccesoDatosEF.ExisteOtroAsdu(asduDigitado, idEquipo))
                {
                    msgFinal = (string)this.GetLocalResourceObject("TextValidarAsduYaExisteMismoAsdu"); //"Ya existe otro equipo con el mismo ASDU.";
                }
                else
                {
                    tipoOperacion = TipoOperacionInWinScada.CREAR_EQUIPO;
                }
            }
            else if (asduAnterior > 0 && asduDigitado > 0) //Caso: ASDU pasa de N --> M
            {
                msgFinal = (string)this.GetLocalResourceObject("TextValidarAsduNoCambioOtroAsdu"); //"No se permite cambiar a otro ASDU. Primero se requiere deshabilitarlo con valor a 0.";
            }

            return msgFinal;
        }

        /// <summary>
        /// Funcion para crear o eliminar equipos de la gestión a nivel de Scada.
        /// </summary>
        /// <param name="conector"></param>
        /// <param name="idEquipo"></param>
        /// <param name="newAsdu"></param>
        /// <param name="txtErr"></param>
        /// <returns></returns>
        protected bool EjecutarOperacionASDU(ConectorMQ conector, string serialEquipo, int newAsdu, TipoOperacionInWinScada tipoCmd, int canalIEC104, out string msgFromWScada)
        {
            bool exito = true;
            msgFromWScada = "";

            MessageToWinScada msgComando = new MessageToWinScada(serialEquipo, newAsdu, tipoCmd, TiposEquipo.FWT, canalIEC104);

            conector.EnviarMensaje(msgComando);
            System.Messaging.Message msgRta = conector.Recibir(UtilsScada.SEGS_WAIT_WINSCADA_QUEUE);
            RespuestaToWeb rta = (RespuestaToWeb)msgRta.Body;
            if (rta.Respuesta != RespuestaToWebSGR.OPERACION_OK)
            {
                exito = false;
                msgFromWScada = rta.TextoRespuesta;
            }

            return exito;
        }

        protected void btnClearFCI_Click(object sender, EventArgs e)
        {
            int idInterno;
            lblMsgErrSeleccionFCIClear.Text = "";
            string valueList = listBoxFCIsPropios.SelectedValue;
            string serialList = listBoxFCIsPropios.SelectedItem.Text;
            lblPrivateTypeDeviceForDelete.Text = serialList;


            if (valueList != "")
            {
                if (int.TryParse(valueList, out idInterno))
                {
                    byte? identificador;
                    if (TypeOfDevice.IsArix(serialList))
                    {
                        identificador = AccesoDatosEF.GetIdentificadorARIX(idInterno);
                    }
                    else
                    {
                        identificador = AccesoDatosEF.GetIdentificadorFCI(idInterno);
                    }
                    if (identificador.HasValue)
                    {
                        bool siBorrado = RealizarComunicacionMessageQueueOnline(ComandosUsuario.ClearFCI, identificador);
                        ComplementarMensajeClearEquipoSIX(siBorrado, serialList);
                    }
                    else
                    {
                        lblMsgErrSeleccionFCIClear.Text = (string)this.GetLocalResourceObject("lblMsgErrSeleccionFCIClearErrRecupIdEquipo"); //"Error al recuperar el Identificador del FCI dentro del FWT";
                    }

                }
                else
                {
                    lblMsgErrSeleccionFCIClear.Text = (string)this.GetLocalResourceObject("lblMsgErrSeleccionFCIClearErrManipulandoIdEquipo"); //"Error al manipular el Identificador del FCI";
                }
            }
            else
            {
                lblMsgErrSeleccionFCIClear.Text = (string)this.GetLocalResourceObject("lblMsgErrSeleccionFCIClearSeleccionarEquip"); //"Se debe seleccionar un FCI para esta operación";
            }

            lblMsgErrSeleccionFCIClear.Visible = (!lblMsgErrSeleccionFCIClear.Text.Equals("")) ? true : false;
        }

        protected void ComplementarMensajeClearEquipoSIX(bool fueBorrado, string serialDispositivo)
        {
            if (fueBorrado)
            {
                if (((TipoEquipoRed)UtilitariosWebGUI.GetTipoEquipo(serialDispositivo)) == TipoEquipoRed.SIXDG)
                {
                    lblMsgErrSeleccionFCIClear.Text = lblMsgErrSeleccionFCIClear.Text + ". " + (string)this.GetLocalResourceObject("TextRecordarAjustarQtySixPrm");
                }
            }
        }

        protected void DDLFechasActualizacionesPrms_SelectedIndexChanged(object sender, EventArgs e)
        {
            ConfigurarHyperLinkHistoricoParametros();
        }

        protected void ConfigurarVisibilidadElementosSix()
        {
            //if (!_verSix)
            //{
            //    Label16.Text = "Nro. Max FCIs";
            //}
            //else
            //{
            //    Label16.Text = "Nro. Max FCIs/SIXs";
            //}

            //Visualización del Prm máxima cantidad de SIX
            lblPrmQtySix.Visible = _verSix;
            txtNumeroMaximoSIX.Visible = _verSix;
            ReqValQtySix.Enabled = _verSix;
            RegExValQtySix.Enabled = _verSix;
            RanValQtySix.Enabled = _verSix;
            CusValMaxSixs.Enabled = _verSix;

            //Visualización del Prm período de lectura de corriente SIX
            lblLeerCteSix.Visible = _verSix;
            txtPrmReporteCteSix.Visible = _verSix;
            Label71.Visible = _verSix;
            ReExReporteCteSix.Enabled = _verSix;
            RanValReporteCteSix.Enabled = _verSix;
            ReqReporteCteSix.Enabled = _verSix;

        }

        protected void CusValMaxSixs_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (_verSix)
            {
                try
                {
                    byte nroFcis = byte.Parse(txtNumeroMaximoFCI.Text);
                    byte nroSixs = byte.Parse(txtNumeroMaximoSIX.Text);

                    if ((nroFcis + nroSixs) > 6)
                    {
                        args.IsValid = false;
                    }
                    else
                    {
                        args.IsValid = true;
                    }
                }
                catch (Exception gralEx)
                {
                    args.IsValid = true;
                }
            }
        }

        protected void txtCiudad_DataBound(object sender, EventArgs e)
        {
            txtCiudad.Items.Insert(0, "");
            txtCiudad.SelectedIndex = 0;
        }

        protected void timerQtySixIncompatible_Tick(object sender, EventArgs e)
        {
            bool datoMenor = false;
            bool datoMayor = false;
            using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
            {
                int idConc = int.Parse(lblId.Text);
                var registro = (from conc in bDatos.FWTs
                                where conc.Id == idConc
                                select new { menor = conc.NumeroMaximoSIXs_Menor, mayor = conc.NumeroMaximoSIXs_Mayor });

                if (registro != null)
                {
                    var datos = registro.SingleOrDefault();
                    datoMenor = datos.menor;
                    datoMayor = datos.mayor;
                }
            }
            VerificarMensajeQtySixIncompatible(datoMenor, datoMayor);

        }


        //Administración de la actualización remota de firmware para dispocitivos remotos

        #region Actualizacion Firmware DEVRTs


        protected void GVEquiposRemotos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Button bntObjCancel = (Button)e.Row.FindControl("btnCancelar");

                //Recuperar el valor de la consulta relacionado con la posibilidad de Activar o NO una actualización
                //hacia un equipo remoto.
                bool puedeActivar = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "Activar"));

                //Recuperar el valor del serial del equipo remoto..
                string serialDev = DataBinder.Eval(e.Row.DataItem, "Serial").ToString();

                //Recuperar el control tipo linkButton y configurarlo..
                //HyperLink linkObj = (HyperLink)e.Row.FindControl("lnkActivar");
                //LinkButton linkBtn = (LinkButton)e.Row.FindControl("lnkActivar");
                Button bntObj = (Button)e.Row.FindControl("btnActivar");

                //Segun la posibilidad de activar o no, se configura el control link.
                if (puedeActivar)
                {
                    bntObj.Text = (string)this.GetLocalResourceObject("TextActivarActFwDevRt");
                    bntObj.CommandArgument = serialDev;
                    bntObj.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);

                    bntObjCancel.Visible = false;

                    //linkObj.Text = (string)this.GetLocalResourceObject("TextActivarActFwDevRt");
                    //linkObj.NavigateUrl = "EditFWT.aspx?serialdev=" + serialDev + "&Id=" + lblId.Text;
                    //linkObj.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);

                    //linkBtn.Text = (string)this.GetLocalResourceObject("TextActivarActFwDevRt");
                    //linkBtn.PostBackUrl = "EditFWT.aspx?serialdev=" + serialDev + "&Id=" + lblId.Text;
                    //linkBtn.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                    //linkBtn.OnClientClick = "return showPreguntaFwActDevRT('" + (string)this.GetLocalResourceObject("TextPreguntaContinuarActFwDevRT") + "');";

                }
                else
                {
                    bntObj.Text = (string)this.GetLocalResourceObject("TextNoActivarActFwDevRt");
                    bntObj.CommandArgument = "";
                    bntObj.Enabled = false;


                    bntObjCancel.Text = (string)this.GetLocalResourceObject("TextCancelarActFwDevRt");
                    bntObjCancel.CommandArgument = serialDev;
                    bntObjCancel.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                    bntObjCancel.Visible = true;

                    //linkObj.Text = (string)this.GetLocalResourceObject("TextNoActivarActFwDevRt");
                    //linkObj.NavigateUrl = "";
                    //linkObj.Enabled = false;

                    //linkBtn.Text = (string)this.GetLocalResourceObject("TextNoActivarActFwDevRt");
                    //linkBtn.PostBackUrl = "";
                    //linkBtn.Enabled = false;
                }
            }
        }


        protected void GVEquiposRemotos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Activar"))
            {
                string serialDevRT = "";
                serialDevRT = e.CommandArgument.ToString();

                //int i = 0;
                AccesoDatos dataBD = new AccesoDatos();

                if (!serialDevRT.Equals(""))
                {
                    //Identificar si el serial del dispositivo pertenece a un FCI 
                    if (TypeOfDevice.IsFci(serialDevRT))
                    {
                        dataBD.ActivarFirmwareUpgradeFWT_To_DEVRT(serialDevRT);
                        GVEquiposRemotos.DataBind();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('info','Pronto se inicia la actualización.', 'Activar actualización FCI');", true);
                    }
                    //Identificar si el serial del dispositivo pertenece a un SIX 
                    else if (TypeOfDevice.IsSix(serialDevRT))
                    {
                        dataBD.ActivarFirmwareUpgradeFWT_To_DEVRT(serialDevRT);
                        GVEquiposRemotos.DataBind();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('info','Pronto se inicia la actualización.', 'Activar actualización SIX');", true);
                    }
                    //Identificar si el serial del dispositivo pertenece a un ARIX 
                    else if (TypeOfDevice.IsArix(serialDevRT))
                    {
                        //Crear servicio en cosoft que soporte la actualización del ARIX
                        dataBD.ActivarFirmwareUpgradeFWT_To_DEVRT_ARIX(serialDevRT);
                        GVEquiposRemotos.DataBind();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('info','Si el ARIX cuenta con más de 4.0v en el supercapacitor, se inicia la actualización.', 'Activar actualización ARIX');", true);
                    }
                }
            }
            if (e.CommandName.Equals("Cancelar"))
            {
                string serialDevRT = "";
                serialDevRT = e.CommandArgument.ToString();

                AccesoDatos dataBD = new AccesoDatos();

                if (!serialDevRT.Equals(""))
                {
                    if (TypeOfDevice.IsFci(serialDevRT))
                    {
                        using (var db = new SistemaGestionRemotoContainer())
                        {
                            FCI fci = db.FCIs.Where(x => x.Serial == serialDevRT).FirstOrDefault();
                            fci.ProximaVersionFW = "";
                            fci.PorcentajeToProxVersionFW = null;
                            fci.FechaSolicitudToProxVersionFW = null;

                            db.SaveChanges();
                        }
                        GVEquiposRemotos.DataBind();
                    }
                    else if (TypeOfDevice.IsSix(serialDevRT))
                    {
                        using (var db = new SistemaGestionRemotoContainer())
                        {
                            FCI fci = db.FCIs.Where(x => x.Serial == serialDevRT).FirstOrDefault();
                            fci.ProximaVersionFW = "";
                            fci.PorcentajeToProxVersionFW = null;
                            fci.FechaSolicitudToProxVersionFW = null;

                            db.SaveChanges();
                        }
                    }
                    else if (TypeOfDevice.IsArix(serialDevRT))
                    {
                        using (var db = new SistemaGestionRemotoContainer())
                        {
                            ARIX arix = db.ARIXs.Where(x => x.Serial == serialDevRT).FirstOrDefault();
                            arix.ProximaVersionFW = "";
                            arix.PorcentajeToProxVersionFW = null;
                            arix.FechaSolicitudToProxVersionFW = null;

                            db.SaveChanges();
                        }
                        GVEquiposRemotos.DataBind();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('info','Se habilitó de nuevo el botón para intentar de nuevo la actualización.', 'Cancelar actualización ARIX');", true);
                    }
                }
            }
        }

        #endregion

        #region ProgressBarDevices

        protected void tmrActFirmware_TickArix(object sender, EventArgs e)
        {
            using (SistemaGestionRemotoContainer bData = new SistemaGestionRemotoContainer())
            {
                FWT fwt = bData.FWTs.SingleOrDefault(f => f.Serial == lblSerial.Text);
                if (fwt != null)
                {
                    MostrarEstadoActualizacionFirmwareDevices(fwt.EstadoActFwARIX, fwt.ContaActFwARIX, fwt.Serial);
                }
            }
        }

        private void MostrarEstadoActualizacionFirmwareDevices(byte? estadoActFW, short? ContActFw, string serial)
        {
            EstadoActualizacionFirmware estado = (estadoActFW == null) ? EstadoActualizacionFirmware.SinProceso : (EstadoActualizacionFirmware)estadoActFW;
            double contadorActFW = (ContActFw == null) ? 0 : (double)ContActFw;
            switch (estado)
            {
                case EstadoActualizacionFirmware.Inicio:
                    lblEstadoACTFirmwareDev.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwarePendienteIniciarArix"); //"PENDIENTE INICIAR ACTUALIZACIÓN FIRMWARE.";
                    tmrActFirmwareDev.Enabled = true;
                    break;
                case EstadoActualizacionFirmware.Procesando:
                    lblEstadoACTFirmwareDev.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwareActualizandoArix"); //"ACTUALIZANDO FIRMWARE.";
                    double porcActFware;
                    ///Instancia capa datos COSOFT
                    var accesoDatosdatos = new AccesoDatos();
                    short maxContador = accesoDatosdatos.GetMaxContadorActualizacionFwDEVRT_ARIX(serial, 4);
                    porcActFware = ((contadorActFW / maxContador) * 100);
                    lblPorcentajeActFirmwareDev.Text = porcActFware.ToString("F") + " % ";
                    lblPorcentajeActFirmwareDev.Visible = true;
                    if ((porcActFware >= 0) && (porcActFware <= 100)) //ProgressBar
                    {
                        ImgPorcActFirmwareDev.Width = Unit.Percentage(porcActFware);
                    }
                    else
                    {   //Para que la barra no se salga del tamanio 
                        ImgPorcActFirmwareDev.Width = Unit.Percentage(100);
                    }

                    ImgPorcActFirmwareDev.ToolTip = contadorActFW.ToString() + "/" + maxContador.ToString() + " " + (string)this.GetLocalResourceObject("imgPorcActFirmwarePcksActualizados"); //" paquetes actualizados.";
                    ImgPorcActFirmwareDev.Visible = true;
                    tmrActFirmwareDev.Enabled = true;
                    break;

                case EstadoActualizacionFirmware.Terminado:
                    lblEstadoACTFirmwareDev.Visible = false;
                    lblPorcentajeActFirmwareDev.Visible = false;
                    ImgPorcActFirmwareDev.Visible = false;
                    tmrActFirmwareDev.Enabled = true;
                    break;
                case EstadoActualizacionFirmware.SinProceso:
                    lblEstadoACTFirmwareDev.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwareActualizado"); //"FIRMWARE ACTUALIZADO.";
                    lblPorcentajeActFirmwareDev.Visible = false;
                    ImgPorcActFirmwareDev.Visible = false;
                    tmrActFirmwareDev.Enabled = false;
                    break;
            }
        }

        protected void tmrActFirmware_TickSix(object sender, EventArgs e)
        {
            using (SistemaGestionRemotoContainer bData = new SistemaGestionRemotoContainer())
            {
                FWT fwt = bData.FWTs.SingleOrDefault(f => f.Serial == lblSerial.Text);
                if (fwt != null)
                {
                    MostrarEstadoActualizacionFirmwareDevicesSix(fwt.EstadoActFwSIX, fwt.ContaActFwSIX, fwt.Serial);
                }
            }
        }

        private void MostrarEstadoActualizacionFirmwareDevicesSix(byte? estadoActFW, short? ContActFw, string serial)
        {
            EstadoActualizacionFirmware estado = (estadoActFW == null) ? EstadoActualizacionFirmware.SinProceso : (EstadoActualizacionFirmware)estadoActFW;
            double contadorActFW = (ContActFw == null) ? 0 : (double)ContActFw;
            switch (estado)
            {
                case EstadoActualizacionFirmware.Inicio:
                    lblEstadoACTFirmwareDevSix.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwarePendienteIniciarSix"); //"PENDIENTE INICIAR ACTUALIZACIÓN FIRMWARE.";
                        tmrActFirmwareDevSix.Enabled = true;
                    break;
                case EstadoActualizacionFirmware.Procesando:
                    lblEstadoACTFirmwareDevSix.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwareActualizandoSix"); //"ACTUALIZANDO FIRMWARE.";
                    double porcActFware;
                    ///Instancia capa datos COSOFT
                    var accesoDatosdatos = new AccesoDatos();
                    short maxContador = accesoDatosdatos.GetMaxContadorActualizacionFwDEVRT_SIX(serial, 4);
                    porcActFware = ((contadorActFW / maxContador) * 100);
                    lblPorcentajeActFirmwareDevSix.Text = porcActFware.ToString("F") + " % ";
                    lblPorcentajeActFirmwareDevSix.Visible = true;
                    if ((porcActFware >= 0) && (porcActFware <= 100)) //ProgressBar
                    {
                        ImgPorcActFirmwareDevSix.Width = Unit.Percentage(porcActFware);
                    }
                    else
                    {   //Para que la barra no se salga del tamanio 
                        ImgPorcActFirmwareDevSix.Width = Unit.Percentage(100);
                    }

                    ImgPorcActFirmwareDevSix.ToolTip = contadorActFW.ToString() + "/" + maxContador.ToString() + " " + (string)this.GetLocalResourceObject("imgPorcActFirmwarePcksActualizados"); //" paquetes actualizados.";
                    ImgPorcActFirmwareDevSix.Visible = true;
                    tmrActFirmwareDevSix.Enabled = true;
                    break;

                case EstadoActualizacionFirmware.Terminado:
                    lblEstadoACTFirmwareDevSix.Visible = false;
                    lblPorcentajeActFirmwareDevSix.Visible = false;
                    ImgPorcActFirmwareDevSix.Visible = false;
                    tmrActFirmwareDevSix.Enabled = true;
                    break;
                case EstadoActualizacionFirmware.SinProceso:
                    lblEstadoACTFirmwareDevSix.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwareActualizado"); //"FIRMWARE ACTUALIZADO.";
                    lblPorcentajeActFirmwareDevSix.Visible = false;
                    ImgPorcActFirmwareDevSix.Visible = false;
                    tmrActFirmwareDevSix.Enabled = false;
                    break;
            }
        }

        protected void tmrActFirmware_TickFci(object sender, EventArgs e)
        {
            using (SistemaGestionRemotoContainer bData = new SistemaGestionRemotoContainer())
            {
                FWT fwt = bData.FWTs.SingleOrDefault(f => f.Serial == lblSerial.Text);
                if (fwt != null)
                {
                    MostrarEstadoActualizacionFirmwareDevicesFci(fwt.EstadoActFwFCI, fwt.ContaActFwFCI, fwt.Serial);
                }
            }
        }

        private void MostrarEstadoActualizacionFirmwareDevicesFci(byte? estadoActFW, short? ContActFw, string serial)
        {
            EstadoActualizacionFirmware estado = (estadoActFW == null) ? EstadoActualizacionFirmware.SinProceso : (EstadoActualizacionFirmware)estadoActFW;
            double contadorActFW = (ContActFw == null) ? 0 : (double)ContActFw;
            switch (estado)
            {
                case EstadoActualizacionFirmware.Inicio:
                    lblEstadoACTFirmwareDevFci.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwarePendienteIniciarFci"); //"PENDIENTE INICIAR ACTUALIZACIÓN FIRMWARE.";
                    tmrActFirmwareDevFci.Enabled = true;
                    break;
                case EstadoActualizacionFirmware.Procesando:
                    lblEstadoACTFirmwareDevFci.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwareActualizandoFci"); //"ACTUALIZANDO FIRMWARE.";
                    double porcActFware;
                    ///Instancia capa datos COSOFT
                    var accesoDatosdatos = new AccesoDatos();
                    const byte tipoFci = 1;
                    const byte tipoSix = 2;
                    byte tipoEquipo = TypeOfDevice.IsFci(serial) ? tipoFci : tipoSix; //
                    short maxContador = accesoDatosdatos.GetMaxContadorActualizacionFwDEVRT(serial, tipoEquipo);
                    porcActFware = ((contadorActFW / maxContador) * 100);
                    lblPorcentajeActFirmwareDevFci.Text = porcActFware.ToString("F") + " % ";
                    lblPorcentajeActFirmwareDevFci.Visible = true;
                    if ((porcActFware >= 0) && (porcActFware <= 100)) //ProgressBar
                    {
                        ImgPorcActFirmwareDevFci.Width = Unit.Percentage(porcActFware);
                    }
                    else
                    {   //Para que la barra no se salga del tamanio 
                        ImgPorcActFirmwareDevFci.Width = Unit.Percentage(100);
                    }

                    ImgPorcActFirmwareDevFci.ToolTip = contadorActFW.ToString() + "/" + maxContador.ToString() + " " + (string)this.GetLocalResourceObject("imgPorcActFirmwarePcksActualizados"); //" paquetes actualizados.";
                    ImgPorcActFirmwareDevFci.Visible = true;
                    tmrActFirmwareDevFci.Enabled = true;
                    break;

                case EstadoActualizacionFirmware.Terminado:
                    lblEstadoACTFirmwareDevFci.Visible = false;
                    lblPorcentajeActFirmwareDevFci.Visible = false;
                    ImgPorcActFirmwareDevFci.Visible = false;
                    tmrActFirmwareDevFci.Enabled = true;
                    break;
                case EstadoActualizacionFirmware.SinProceso:
                    lblEstadoACTFirmwareDevFci.Text = (string)this.GetLocalResourceObject("lblEstadoACTFirmwareActualizado"); //"FIRMWARE ACTUALIZADO.";
                    lblPorcentajeActFirmwareDevFci.Visible = false;
                    ImgPorcActFirmwareDevFci.Visible = false;
                    tmrActFirmwareDevFci.Enabled = false;
                    break;
            }
        }


        #endregion

        #region Commands online
        #region Open Close ARIX

        protected void ListArixByFwt_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string idArix = DataBinder.Eval(e.Row.DataItem, "Id").ToString();
                Button bntObjOpen = (Button)e.Row.FindControl("btnAbrirArix");
                Button bntObj = (Button)e.Row.FindControl("btnAbrirArix");
                bntObj.Text = (string)this.GetLocalResourceObject("TextAbrirArixRt");
                bntObj.CommandArgument = idArix;
                bntObj.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                //USAR ESTA LÍNEA CUANDO MANEJE EL ESTADO (PINTAR ABIERTOS Y CERRADOS)
                //e.Row.Style.Add("background", "yellow");
                bntObjOpen.Visible = true;

                Button bntObjClose = (Button)e.Row.FindControl("btnCerrarArix");
                Button bntObjC = (Button)e.Row.FindControl("btnCerrarArix");
                bntObjC.Text = (string)this.GetLocalResourceObject("TextCerrarArixRt");
                bntObjC.CommandArgument = idArix;
                bntObjC.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                bntObjClose.Visible = true;

                Button bntObjState = (Button)e.Row.FindControl("btnEstadoArix");
                Button bntObjS = (Button)e.Row.FindControl("btnEstadoArix");
                bntObjS.Text = (string)this.GetLocalResourceObject("TextEstadoArixRt");
                bntObjS.CommandArgument = idArix;
                bntObjS.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                bntObjState.Visible = true;

                Button bntObjReset = (Button)e.Row.FindControl("btnReinicioArix");
                Button bntObjR = (Button)e.Row.FindControl("btnReinicioArix");
                bntObjR.Text = (string)this.GetLocalResourceObject("TextReinicioArixRt");
                bntObjR.CommandArgument = idArix;
                bntObjR.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                bntObjReset.Visible = true;

                Button bntObjAskClock = (Button)e.Row.FindControl("btnAskClockArix");
                Button bntObjAc = (Button)e.Row.FindControl("btnAskClockArix");
                bntObjAc.Text = (string)this.GetLocalResourceObject("TextAskClockArixRt");
                bntObjAc.CommandArgument = idArix;
                bntObjAc.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                bntObjAskClock.Visible = true;

                Button bntObjUpdClock = (Button)e.Row.FindControl("btnUpdClockArix");
                Button bntObjupd = (Button)e.Row.FindControl("btnUpdClockArix");
                bntObjupd.Text = (string)this.GetLocalResourceObject("TextUpdClockArixRt");
                bntObjupd.CommandArgument = idArix;
                bntObjupd.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                bntObjUpdClock.Visible = true;

                Button btnUpdModeOperationArix = (Button)e.Row.FindControl("btnUpdModeOperationArix");
                Button btnUpdMOpe = (Button)e.Row.FindControl("btnUpdModeOperationArix");
                btnUpdMOpe.Text = (string)this.GetLocalResourceObject("TextModeOperation");
                btnUpdMOpe.CommandArgument = idArix;
                btnUpdMOpe.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);

                LabelApertura.Text = "";
                LabelCerrado.Text = "";
            }
        }

        /// <summary>
        /// Método qué se ejecuta cuando se da click en abrir ARIX
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ListArixByFwt_RowCommand(object sender, GridViewCommandEventArgs e)
        {            
            if (e.CommandName.Equals("ABRIR"))
            {
                int idArix = int.Parse(e.CommandArgument.ToString());
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", string.Format("validateSerialArix({0},'{1}'); ", idArix, e.CommandName), true);                
            }
            else if (e.CommandName.Equals("CERRAR"))
            {
                int idArix = int.Parse(e.CommandArgument.ToString());
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", string.Format("validateSerialArix({0},'{1}'); ", idArix, e.CommandName), true);               
            }            
            else if (e.CommandName.Equals("REINICIAR"))
            {
                int idArix = int.Parse(e.CommandArgument.ToString());
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", string.Format("validateSerialArix({0},'{1}'); ", idArix, e.CommandName), true);
            }
            else if (e.CommandName.Equals("ACTUALIZAR RELOJ"))
            {
                int idArix = int.Parse(e.CommandArgument.ToString());
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", string.Format("validateSerialArix({0},'{1}'); ", idArix, e.CommandName), true);
            }
            else if (e.CommandName.Equals("ESTADO"))
            {
                int idArix = int.Parse(e.CommandArgument.ToString());
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", string.Format("validateSerialArixWithoutParams({0},'{1}'); ", idArix, e.CommandName), true);
            }
            else if (e.CommandName.Equals("PREGUNTAR RELOJ"))
            {
                int idArix = int.Parse(e.CommandArgument.ToString());
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", string.Format("validateSerialArixWithoutParams({0},'{1}'); ", idArix, e.CommandName), true);                
            }
            else if (e.CommandName.Equals("MODO OPERACION"))
            {
                int idArix = int.Parse(e.CommandArgument.ToString());
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", string.Format("chooseOperationModeArix({0})", idArix), true);
            }
        }

        protected void btnCheckModeOperation(object sender, EventArgs e)
        {
            RadioButton radioButton = sender as RadioButton;
            int idArix = int.Parse(radioButton.GroupName); /*ListArixByFwt_RowDataBound se hace encapsulamiento del Id del ARIX en el grupo del RadioButton*/
            string idMode = radioButton.ID;
            bool isCheck = radioButton.Checked;
            string text = "MODO " + radioButton.Text.ToUpper();
            if (isCheck)
            {
                if (idMode == "checkModeAutomatic")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", string.Format("validateSerialArix({0},'{1}'); ", idArix, text), true);
                }
                else if (idMode == "checkModeWithouReconect")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", string.Format("validateSerialArix({0},'{1}'); ", idArix, text), true);
                }
                else if (idMode == "checkModeMaintenance")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", string.Format("validateSerialArix({0},'{1}'); ", idArix, text), true);
                }
                else /*No reconocio el modo de operación...*/
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Error ','No se reconoce el modo de operación que desea activar','error');", true);
                }
            }
            else
            {
                /*No esta check*/
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Error seleccionando opción','Debe escoger un modo de operación para ejecutar la acción','error');", true);
            }           
        }

        #endregion
        protected void btnChange_Click(object sender, EventArgs e)
        {
            Response.Write("Button Clicked");
        }

        public void ExecCommandWithoutParams(object sender, EventArgs e)
        {
            int idArix = int.Parse(labelIdArix.Value);
            string command = labelCommand.Value;

            switch (command)
            {
                case "ESTADO":
                    CommandState(idArix);
                    break;
                case "PREGUNTAR RELOJ":
                    CommandAskClock(idArix);
                    break;
            }
        }

        public void ExecCommandWithParams(object sender, EventArgs e)
        {
            int idArix = int.Parse(labelIdArix.Value);
            string serialArix = labelText.Value;
            string command = labelCommand.Value;
            string serial = "";

             using (var db = new SistemaGestionRemotoContainer())
             {
                 serial = db.ARIXs.SingleOrDefault(x => x.Id == idArix).Serial;
             }
             if (serial == "")
             {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('No se encontro el ARIX','Hubo un fallo procesando la solicitud, vuelva a intentarlo de nuevo','error');", true);                
            }
             if (serial.ToLower() == serialArix.ToLower())
             {
                switch (command)
                 {
                     case "REINICIAR":
                        CommandReset(idArix);
                         break;
                     case "ABRIR":
                        CommandOpen(idArix);
                         break;
                     case "CERRAR":
                        CommandClose(idArix);
                         break;
                    case "ACTUALIZAR RELOJ":
                        CommandUpdClock(idArix);
                        break;
                    case "MODO RECONECTADOR":
                        CommandCheckModeAutomatic(idArix);
                        break;
                    case "MODO SIN RECONEXIÓN":
                        CommandCheckModeWithoutReconect(idArix);
                        break;
                    case "MODO MANTENIMIENTO":
                        CommandCheckModeMaintenance(idArix); 
                        break;
                }
             }
             else
             {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Error validando campos','El serial que se ingresó, no coincide con el ARIX seleccionado!','error');", true);
            } 
        }        
        
        private void CommandReset(int idArix)
        {
            bool isReset = RealizarComunicacionMessageQueueOnline(ComandosUsuario.ResetArix, null, idArix);
            if (isReset)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Reiniciar ARIX','Se reinició el ARIX correctamente.','success');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Reiniciar ARIX','Falló el reinicio del ARIX, favor intente de nuevo.','warning');", true);
            }
        }

        private void CommandOpen(int idArix)
        {
            bool isOpen = RealizarComunicacionMessageQueueOnline(ComandosUsuario.OpenARIX, null, idArix);

            if (isOpen)
            {
                if (stateArix == 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Abrir ARIX','ARIX se encuentra abierto','warning');", true);
                }
                else if (stateArix == 1)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Abrir ARIX','ARIX abierto con éxito','success');", true);
                }
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Abrir ARIX','El FWT no respondío de forma esperada. favor consulte el estado del ARIX o vuelva a ejecutar el comando','error');", true);
            }
        }

        private void CommandClose(int idArix)
        {
            bool isClose = RealizarComunicacionMessageQueueOnline(ComandosUsuario.CloseARIX, null, idArix);

            if (isClose)
            {
                if (stateArix == 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Cerrar ARIX','ARIX se encuentra cerrado','warning');", true);
                }
                else if (stateArix == 1)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Cerrar ARIX','ARIX cerrado con éxito','success');", true);
                }
            }
            else
            {
                if (stateArix == -1)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Cerrar ARIX','El FWT no respondío de forma esperada. favor consulte el estado del ARIX o vuelva a ejecutar el comando','error');", true);
                }
                else if (stateArix == -2)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Cerrar ARIX','El FWT no respondío de forma esperada. favor consulte el estado del ARIX o vuelva a ejecutar el comando','error');", true);
                }
            }
        }

        private void CommandUpdClock(int idArix)
        {
            bool isAskClock = RealizarComunicacionMessageQueueOnline(ComandosUsuario.SincClockArix, null, idArix);
            if (isAskClock)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Actualizar fecha y hora ARIX','Se actualizó la fecha y hora del ARIX','success');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Actualizar fecha y hora ARIX','Falló la actualización de hora del ARIX, favor intente de nuevo.','warning');", true);
            }
        }

        private void CommandState(int idArix)
        {
            bool isState = RealizarComunicacionMessageQueueOnline(ComandosUsuario.IsOpenArix, null, idArix);
            if (isState)
            {
                if (stateArix == -1)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Consultar estado ARIX','Falló en el envío, intentar de nuevo para verificar estado', 'error');", true);
                }
                else if (stateArix == 1)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Consultar estado ARIX','ARIX se encuentra cerrado', 'success');", true);
                }
                else if (stateArix == 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Consultar estado ARIX','ARIX se encuentra abierto', 'success');", true);
                }
            }
            else
            {
                if (stateArix == -1)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Consultar estado ARIX','Error al ejecutar el comando de validación, click en botón validar estado', 'error');", true);
                }
                else if (stateArix == -2)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Consultar estado ARIX','Error al ejecutar el comando de validación, click en botón validar estado', 'error');", true);

                }
            }
        }

        private void CommandAskClock(int idArix)
        {
            bool isAskClock = RealizarComunicacionMessageQueueOnline(ComandosUsuario.AskClockArix, null, idArix);
            if (isAskClock)
            {                
                string mensaje = "Fecha y hora actual del ARIX: " + string.Format("{0:dd-MM-yyyy HH:mm:ss}", Convert.ToDateTime(dataClock).AddHours(0));
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", $"sweetAlert('Fecha y hora ARIX','Fecha y hora actual del ARIX: {dataClock}', 'success');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Fecha y hora ARIX','Falló la consulta de hora del ARIX, favor intente de nuevo.', 'warning');", true);
            }
        }

        private void CommandCheckModeAutomatic(int idArix)
        {
            bool isModeAuto = RealizarComunicacionMessageQueueOnline(ComandosUsuario.ModeOperation, null, idArix, "Automatico");
            if (isModeAuto)
            {
                string mensaje = "Fecha y hora actual del ARIX: " + string.Format("{0:dd-MM-yyyy HH:mm:ss}", Convert.ToDateTime(dataClock).AddHours(0));
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", $"sweetAlert('Modo operación Reaconectador','El ARIX se encuentra operando en modo RECONECTADOR', 'success');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Modo operación Reconectador','Falló la actualización del modo de operación del ARIX', 'error');", true);
            }
        }
        private void CommandCheckModeWithoutReconect(int idArix)
        {
            bool isModeAuto = RealizarComunicacionMessageQueueOnline(ComandosUsuario.ModeOperation, null, idArix, "Sin reconexión");
            if (isModeAuto)
            {
                string mensaje = "Fecha y hora actual del ARIX: " + string.Format("{0:dd-MM-yyyy HH:mm:ss}", Convert.ToDateTime(dataClock).AddHours(0));
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", $"sweetAlert('Modo operación sin reconexión','El ARIX se encuentra operando en modo SIN RECONEXIÓN', 'success');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Modo operación sin reconexión','Falló la actualización del modo de operación del ARIX', 'error');", true);
            }
        }
        private void CommandCheckModeMaintenance(int idArix)
        {
            bool isModeAuto = RealizarComunicacionMessageQueueOnline(ComandosUsuario.ModeOperation, null, idArix, "Mantenimiento");
            if (isModeAuto)
            {
                string mensaje = "Fecha y hora actual del ARIX: " + string.Format("{0:dd-MM-yyyy HH:mm:ss}", Convert.ToDateTime(dataClock).AddHours(0));
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", $"sweetAlert('Modo operación Mantenimiento','El ARIX se encuentra operando en modo MANTENIMIENTO', 'success');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Popup", "sweetAlert('Modo operación Mantenimiento','Falló la actualización del modo de operación del ARIX', 'error');", true);
            }
        }

#endregion
    }
}