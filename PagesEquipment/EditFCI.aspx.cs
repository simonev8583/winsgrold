using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Messaging;
using SGR.DataAccessLayer;
using SGR.BussinessLayer;
using SCADA104.Definiciones;
using Celsa.ConexionMensajeria;

namespace SistemaGestionRedes
{
    public partial class EditFCI : System.Web.UI.Page
    {
        private MessageQueue mqWebToSGR;
        private MessageQueue mqSGRToWeb;
        private bool _fwtIsConnected = false;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //ViewState["paginaAnterior"] = Request.UrlReferrer.ToString(); //Se almacena en una variable ViewState la dirección de la pagina anterior , esto se utiliza en el boton Cancelar
                string strId = Request.QueryString["Id"];
                lblId.Text = strId;
                //LoadConcentradores();
                LlenarValoresFCI(int.Parse(strId));
                _fwtIsConnected = AccesoDatosEF.ExisteConexionFWT(lblTxtSerialFWT.Text);
                ActivarBotonesOnline();
                LlenarComboFechasHistoricasParametros(int.Parse(strId));
                ControlarAutorizacionControles();
            }
        }


        #region Metodos Auxiliares

        //dario: se comenta todo el método para no eliminarlo.
        //private void LoadConcentradores()
        //{
        //    using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
        //    {
        //        ddlConcentradores.DataSource = from conc in db.FWTs
        //                                       orderby conc.Id
        //                                       select new { Id = conc.Id, Ser = conc.Serial };
        //        ddlConcentradores.DataTextField = "Ser";
        //        ddlConcentradores.DataValueField = "Id";
        //        ddlConcentradores.DataBind();

        //    }

        //}

        protected void ControlarAutorizacionControles()
        {
            //ATENCIÓN: Cada vez que se adicione un control en esta lista, se debe buscar o controlar en el resto del
            //código que no se haga una habilitación directa en otro sitio sin pasar por la función de control
            //de autorización UtilitariosWebGUI.HasAuthorization().
            btnSaveInfoNoActualizable.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            btnSetScada.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            btnQuitScada.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            butUpdate.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            butUpdateOnline.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            butDelete.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            btnResetFCI.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User) & _fwtIsConnected;
            btnComandoTestFCI.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User) & _fwtIsConnected;
        }

        private void LlenarComboFechasHistoricasParametros(int idInternoEquipo)
        {

            DDLFechasActualizacionesPrms.Items.Clear();

            using (SistemaGestionRemotoContainer context = new SistemaGestionRemotoContainer())
            {
                var registros = from historia in context.HistoriaParamsFiSx
                                where historia.IdFiSx == idInternoEquipo
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
            HyperLinkVerPrmsHistorico.NavigateUrl = "DetallePrmsFCI.aspx?IdInterno=" + idEquipo + "&" + "Fecha=" + fechaTick;
        }


        private void LlenarValoresFCI(int idFCI)
        {
            using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
            {
                var consultaFCI = (from fci in bDatos.FCIs
                                   where fci.Id == idFCI
                                   select fci).SingleOrDefault(); //Es un unico Valor 
                if (consultaFCI.FWTId == null)//No tiene concentrador que lo gestione
                {
                    //ddlConcentradores.Items.Add(new ListItem("No tiene", ""));
                    //ddlConcentradores.SelectedIndex = ddlConcentradores.Items.Count - 1;
                    lblSerialFWT.Text = "";
                    btnSetScada.Enabled = false;
                    btnQuitScada.Enabled = false;
                    lblTextInScada.Visible = false;
                    lblTextOutScada.Visible = false;
                }
                else
                {
                    //for (int i = 0; i < ddlConcentradores.Items.Count; i++)
                    //{
                    //    if (ddlConcentradores.Items[i].Value  == consultaFCI.FWTId.ToString()) //En el value del ddlist esta el id del FWT
                    //    {   //Si se encontro el respectivo Concentrador en el dropdownlist se selecciona 
                    //        ddlConcentradores.SelectedIndex = i;
                    //        break;

                    //    }
                    //}
                    //ddlConcentradores.Items.Add(new ListItem("No tiene", ""));
                    lblSerialFWT.Text = consultaFCI.FWT.Serial;
                    SettingScadaBotones(consultaFCI.FWT.ASDU, consultaFCI.EnScada);
                    lblASDUFWT.Text = consultaFCI.FWT.ASDU.ToString();
                    //lblCanal104FWT.Text = consultaFCI.FWT.Canal104.HasValue ? consultaFCI.FWT.Canal104.ToString() : "0";
                    lblCanal104FWT.Text = consultaFCI.FWT.Canal104.ToString();
                }

                lblIdentificador.Text = consultaFCI.Identificador.ToString();

                if (consultaFCI.PendienteRecibirParametros)
                {
                    lblEstadoFCI.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteRecibir");
                    tmrActualizacionEstadoFCI.Enabled = true;
                    imgEstadoFCI.Visible = true;
                }
                else
                {
                    if (consultaFCI.PendienteConfirmarActualizacionParametros )
                    {
                        lblEstadoFCI.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteConfirmar");
                        tmrActualizacionEstadoFCI.Enabled = true;
                        imgEstadoFCI.Visible = true;
                    }else if (consultaFCI.PendienteEnviarParametros)
                    {
                        lblEstadoFCI.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteEnviar");
                        tmrActualizacionEstadoFCI.Enabled = true;
                        imgEstadoFCI.Visible = true;
                    }
                    else 
                    {
                        lblEstadoFCI.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIDatosOK");
                    }
                }

                //Valores de localización del FWT
                if (consultaFCI.FWTId != null)
                {
                    lblTxtSerialFWT.Text = consultaFCI.FWT.Serial;
                    lblTxtSubEstacionFWT.Text = consultaFCI.FWT.ParamFWT.DireccionElectrica.SubEstacion;
                    lblTxtCircuitoFWT.Text = consultaFCI.FWT.ParamFWT.DireccionElectrica.Circuito;
                    lblTxtTramoFWT.Text = consultaFCI.FWT.ParamFWT.DireccionElectrica.Tramo;
                    lblTxtNodoFWT.Text = consultaFCI.FWT.ParamFWT.DireccionElectrica.Nodo;
                }
                else
                {
                    lblTxtSerialFWT.Text = "";
                }


                //Identificar el tipo de circuito de alguno de los predeterminados:
                //Monofásico, Bifásico o Trifásico.
                foreach (ListItem item in listBoxTipoCircuito.Items)
                {
                    if (item.Value == consultaFCI.TipoCircuito.ToString())
                    {
                        item.Selected = true;
                        break;
                    }
                }

                //Llenar Fase
                ConfigurarFases(consultaFCI.Fase);

                //Asignar Circuito y Fase Original
                if (listBoxTipoCircuito.SelectedItem != null)
                {
                    lblCircuitoBDOrig.Text = listBoxTipoCircuito.SelectedItem.Text;
                }
                else
                {
                    lblCircuitoBDOrig.Text = "Monofásico";
                }

                if (DDListFases.SelectedItem != null)
                {
                    lblFaseBDOrig.Text = DDListFases.SelectedItem.Text;
                }
                else
                {
                    lblFaseBDOrig.Text = "N/A";
                }

                if (consultaFCI.FechaRegistroGestion == null)
                {
                    lblFechaRegistroGestion.Text = "";
                }
                else
                {
                    lblFechaRegistroGestion.Text = consultaFCI.FechaRegistroGestion.ToString() ;
                }

                if (consultaFCI.FechaInstalacion == null)
                {
                    lblFechaInstalacion.Text = "NO"; 
                }
                else
                {
                    lblFechaInstalacion.Text = consultaFCI.FechaInstalacion.ToString();
                }

                lblVersionFirmware.Text = consultaFCI.VersionProgramaSix;

               
                //Código del equipo
                txtCodigoEquipo.Text = consultaFCI.Codigo;


                switch (consultaFCI.ParamFCI.ModoDisparo)
                {
                    case 0:
                        rdButModoProporcional.Checked = true;
                        lblNombreValorFalla.Text = (string)this.GetLocalResourceObject("TextlblNombreValorFallaDeltaI");
                        lblUnids.Text = (string)this.GetLocalResourceObject("TextlblUnidsVeces");
                        break;
                    case 1:
                        rdButModoPorIncremento.Checked = true;
                        lblNombreValorFalla.Text = (string)this.GetLocalResourceObject("TextlblNombreValorFallaEscalon");
                        lblUnids.Text = "(10-1000)A";
                        break;
                    case 2:
                        rdButModoPorValorFijo.Checked = true;
                        lblNombreValorFalla.Text = (string)this.GetLocalResourceObject("TextlblNombreValorFallaCorriente");
                        lblUnids.Text = "(10-1000)A";
                        break;
                    case 3:
                        rdButModoPorAutoRango.Checked = true;
                        lblNombreValorFalla.Text = "N/A";
                        lblUnids.Text = "";
                        break;
                }

                rdButModoDisparo_CheckedChanged(this, null);   //Aca se puede invocar rdButModoDisparo_CheckedChanged para actualizar los validadores
                lblSerial.Text = consultaFCI.Serial;
                txtValorFalla.Text = consultaFCI.ParamFCI.ValorFalla.ToString();
                rblFrecuencia.SelectedValue = consultaFCI.ParamFCI.Frecuencia.ToString();
                chkBoxRepTiempo.Checked = consultaFCI.ParamFCI.ReposicionPorTiempo;
                chkBoxRepTension.Checked = consultaFCI.ParamFCI.ReposicionPorTension;
                chkBoxRepMagneto.Checked = consultaFCI.ParamFCI.ReposicionPorMagneto;
                chkBoxRepCorriente.Checked = consultaFCI.ParamFCI.ReposicionPorCorriente;
                chkBoxHabReloj.Checked = consultaFCI.ParamFCI.HabilitarReloj;
                chkBoxHabFallaTrans.Checked = consultaFCI.ParamFCI.HabilitarFallaTransitoria;
                txtTiempoValFalla.Text = consultaFCI.ParamFCI.TiempoValidacionFallaSegundos.ToString();
                txtToleranciaTensionReposicion.Text = consultaFCI.ParamFCI.ToleranciaTensionReposicion.ToString();
                txtTiempoReposicion.Text = consultaFCI.ParamFCI.TiempoReposicionSegundos.ToString();
                txtTiempoIndicacionFallatemp.Text = consultaFCI.ParamFCI.TiempoIndicacionFallaTemporalSegundos.ToString();  
                txtTiempoFlashIndicacion.Text = (consultaFCI.ParamFCI.TiempoFlashIndicacion8ms * 8).ToString(); //Se multiplica por 8 para mostrar (viene en multiplos)
                txtTiempoEntreFlashIndicacion.Text = consultaFCI.ParamFCI.TiermpoEntreFlashIndicacionSegundos.ToString();
                txtTiempoProteccionInRush.Text = consultaFCI.ParamFCI.TiempoProteccionInRushSegundos.ToString();
                txtTiempoRetardoValidacionTension.Text = consultaFCI.ParamFCI.TiempoRetardoValidacionTensionSegundos.ToString();
                txtCorrienteAbsolutaDisparo.Text = consultaFCI.ParamFCI.CorrienteAbsolutaDisparo.ToString();
                txtNumeroReintentosComunicaciones.Text = consultaFCI.ParamFCI.NumeroReintentosComunicacion.ToString();
                txtSegundosProximaComunicacion.Text = consultaFCI.ParamFCI.SegundosParaProximaComunicacion.ToString();
                txtCapacidadBateria.Text = consultaFCI.ParamFCI.CapacidadBateriaInstalada.ToString();



            }
        }

        private void SettingScadaBotones(int asduFWT, bool enScadaFCI)
        {
            if (asduFWT == 0)
            {
                btnSetScada.Enabled = false;
                btnQuitScada.Enabled = false;
                lblTextInScada.Visible = false;
                lblTextOutScada.Visible = true;
            }
            else
            {
                if (enScadaFCI)
                {
                    btnSetScada.Enabled = false;
                    btnQuitScada.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                    lblTextInScada.Visible = true;
                    lblTextOutScada.Visible = false;
                }
                else
                {
                    btnSetScada.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User); 
                    btnQuitScada.Enabled = false;
                    lblTextInScada.Visible = false;
                    lblTextOutScada.Visible = true;
                }
            }
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
            mqWebToSGR.Purge(); //Importante que NO existan mensajes en la cola anteriormente . Verificar si se cambia esta politica        
            mqSGRToWeb.Purge();
        }

        protected void ConfigurarFases(string valFase)
        {
            //dario: Ya no se requiere dependencia de la Fase según el tipo de circuito.

            //switch (listBoxTipoCircuito.SelectedValue)
            //{
            //    case "1":
            //        DDListFases.Enabled = false;
            //        break;

            //    case "2":
            //        DDListFases.Enabled = true;
            //        DDListFases.Items.Add(new ListItem("A", "A"));
            //        DDListFases.Items.Add(new ListItem("B", "B"));
            //        //OJO, seleccionar el que es....
            //        DDListFases.Items.FindByValue(valFase).Selected = true;
            //        break;

            //    case "3":
            //        DDListFases.Enabled = true;
            //        DDListFases.Items.Add(new ListItem("R", "R"));
            //        DDListFases.Items.Add(new ListItem("S", "S"));
            //        DDListFases.Items.Add(new ListItem("T", "T"));
            //        //OJO, seleccionar el que es....
            //        DDListFases.Items.FindByValue(valFase).Selected = true;
            //        break;

            //    default:
            //        break;
            //}

            if (DDListFases.Items.FindByValue(valFase) != null)
            {
                DDListFases.Items.FindByValue(valFase).Selected = true;
            }
        }

        /// <summary>
        /// Activa los botones Online segun el caso   .
        /// </summary>
        private void ActivarBotonesOnline()
        {
            //if (ddlConcentradores.SelectedItem.Text.ToUpper() != "NO TIENE" )
            if (lblTxtSerialFWT.Text != "")
            {
                //if (AccesoDatosEF.ExisteConexionFWT(ddlConcentradores.SelectedItem.Text))
                if (_fwtIsConnected)
                {
                    butUpdateOnline.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                    //Para que el boton se desactive cuando se le haga click y además permita continuar con el postback 
                    butUpdateOnline.Attributes.Add("onclick", "javascript:" + butUpdateOnline.ClientID + ".disabled=true;" + ClientScript.GetPostBackEventReference(butUpdateOnline, ""));
                    butLeerParamOnline.Attributes.Add("onclick", "javascript:" + butLeerParamOnline.ClientID + ".disabled=true;" + ClientScript.GetPostBackEventReference(butLeerParamOnline, ""));
                    butLeerEstadisticas.Enabled = true;
                    butLeerEstadisticasCorriente.Enabled = true;
                    btnResetFCI.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                    btnComandoTestFCI.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                    if (lblEstadoFCI.Text.ToUpper() != (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteEnviar"))
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

        protected string CalcularAutonomiaBateria()
        {
            double capBateria = (double)(double.Parse(txtCapacidadBateria.Text) / 1000d);
            double tpoDestello = (double)(double.Parse(txtTiempoFlashIndicacion.Text) / 1000d);
            double tpoEntreFlash = double.Parse(txtTiempoEntreFlashIndicacion.Text);

            double autonomia = (tpoEntreFlash * capBateria) / (0.14d * tpoDestello);

            int autoAproximada = (int)autonomia;

            return autoAproximada.ToString();
        }

        protected string CalcularAutonomiaBateriaFuncionamiento()
        {
             double capBateria = (double)(double.Parse(txtCapacidadBateria.Text) / 1000d);
             double consumoCircuitoMidiendo = 280d ; // Esto está en microAmperios uA
             double consumoRF = 14d ;//CONSUMO RF RX (mA)
             double tiempoRFPrendido = 5d ; //TIEMPO QUE DURA RF PRENDIDO (Seg)
             double nroReintentoComunic = double.Parse(txtNumeroReintentosComunicaciones.Text );
             double probabilidadReintentos = 0.2d ; //20 %
             double periodoReporteMinutos =  double.Parse(txtSegundosProximaComunicacion.Text) /60 ; 
             double capacidadBateriaPorcentaje = 0.9d ; //90 % 
            double autonomiaFuncionamiento =  capBateria/((consumoCircuitoMidiendo* 0.000001d )+((consumoRF*0.001*tiempoRFPrendido*nroReintentoComunic*probabilidadReintentos )/(periodoReporteMinutos*60))) *capacidadBateriaPorcentaje  ;
            int autoAproximada = (int)autonomiaFuncionamiento;

            return autoAproximada.ToString();
        }

        /// <summary>
        /// Realiza toda la comunicacion Online segun el caso , incluyendo el intercambio de MSMQ
        /// </summary>
        /// <param name="comandoUser"></param>
        private void RealizarComunicacionOnlineYMSMQ(ComandosUsuario comandoUser)
        {
            lblEstadoActualizacionOnline.Text = "";
            InicializarMessageQueues();

            //Se crea un comando de usuario para enviar .
            MensajeComandoMQOnline msgComando = new MensajeComandoMQOnline();
            //msgComando.SerialFWT = ddlConcentradores.SelectedItem.Text;
            msgComando.SerialFWT = lblTxtSerialFWT.Text;
            msgComando.IdFCI = byte.Parse(lblIdentificador.Text);
            msgComando.SerialFCI = lblSerial.Text;
            msgComando.Comando = comandoUser ;
            mqWebToSGR.Send(msgComando);

            //Formato de mensaje de recepcion MensajeRespuestasMQOnline
            ((XmlMessageFormatter)mqSGRToWeb.Formatter).TargetTypes = new Type[1];
            ((XmlMessageFormatter)mqSGRToWeb.Formatter).TargetTypes[0] = (new MensajeRespuestasMQOnline()).GetType(); ; // Va a recibir MensajeRespuestasMQOnline

            try
            {
                System.Messaging.Message msg = mqSGRToWeb.Receive(new TimeSpan(0, 0, 45)); //Espera Máximo 45 segs sincronicamente para recibir respuesta
                MensajeRespuestasMQOnline msgRespuesta = (MensajeRespuestasMQOnline)msg.Body;

                if (msgRespuesta.Respuesta == RespuestasSvrCom.NotConnected)
                {
                    //lblEstadoActualizacionOnline.Text = "FWT No Conectado";
                    lblEstadoActualizacionOnline.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(RespuestasSvrCom.NotConnected);
                }
                else if (msgRespuesta.Respuesta == RespuestasSvrCom.MsgQueueExceptionComunicaciones)
                {

                    //lblEstadoActualizacionOnline.Text = "MessageQueueException en servidor comunicaciones  : " + (string)msgRespuesta.Datos;
                    lblEstadoActualizacionOnline.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(RespuestasSvrCom.MsgQueueExceptionComunicaciones);
                }

                else
                {
                    //if (msgRespuesta.SerialFWT == ddlConcentradores.SelectedItem.Text)
                    if (msgRespuesta.SerialFWT == lblTxtSerialFWT.Text)
                    {
                        switch (comandoUser)
                        {
                            case ComandosUsuario.ActParamFCI:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.OK)
                                {
                                    lblEstadoActualizacionOnline.Text = (string)this.GetLocalResourceObject("TextlblEstActFCIOnLineOK");
                                    lblEstadoFCI.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteConfirmar");
                                    lblEstadoActualizacion.Visible = false; //No se muestra , ya se actualizó .
                                    imgEstadoFCI.Visible = true;
                                    tmrActualizacionEstadoFCI.Enabled = true; // Para que si llega la confirmacion de act de param este timer lo detecte .
                                }
                                else
                                {

                                    //lblEstadoActualizacionOnline.Text = "Se recibió otra respuesta para este serial :  " + msgRespuesta.Respuesta.ToString();
                                    lblEstadoActualizacionOnline.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(msgRespuesta.Respuesta);
                                }
                                break;

                            case ComandosUsuario.ReadParamFCI:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.DATOS)
                                {
                                    LlenarValoresFCI(int.Parse(lblId.Text)); //Se llenan los valores desde base de datos pues ya Cosoft los actualizó 
                                    lblEstadoActualizacionOnline.Text = (string)this.GetLocalResourceObject("TextlblEstActFCIOnLineRecibidos");
                                    lblEstadoActualizacion.Visible = false; //No se muestra 
                                }
                                else
                                {

                                    //lblEstadoActualizacionOnline.Text = "Se recibió otra respuesta para este serial :  " + msgRespuesta.Respuesta.ToString();
                                    lblEstadoActualizacionOnline.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(msgRespuesta.Respuesta);
                                }
                                break;

                            case ComandosUsuario.ReadStatisticsFCI:
                                //Hacer DataBind al DetailsView
                                SqlDSLastEstadistica.SelectParameters["SerialFCI"].DefaultValue = msgComando.SerialFCI;
                                DVUltEstadisticaFCI.DataBind();
                                if (DVUltEstadisticaFCI.Rows.Count > 0)
                                {
                                    if (msgRespuesta.Respuesta == RespuestasSvrCom.DATOS)
                                    {


                                        //Este código funciona y fue una prueba:
                                        //Permite tomar el dato exacto que llega del FWT.

                                        //if (msgRespuesta.EstadisticasFCI != null ) //Como es Nullable type , preguntar por HasValue y tomar la propiedad Value 
                                        //{
                                        //    lblStdContFallasTemp.Text = msgRespuesta.EstadisticasFCI.Value.ContFallasTemporales.ToString();
                                        //    lblStdContFallasPermanentes.Text = msgRespuesta.EstadisticasFCI.Value.ContFallasPermanentes.ToString();
                                        //    if (msgRespuesta.EstadisticasFCI.Value.Tension != null)
                                        //    {
                                        //        lblStdTension.Text = msgRespuesta.EstadisticasFCI.Value.Tension.Value.ToString();
                                        //    }
                                        //    else
                                        //    {
                                        //        lblStdTension.Text = "N/A";
                                        //    }
                                        //}


                                        lblEstadoActualizacion.Visible = false; //No se muestra
                                        lblEstadisticasActuales.Text = "Se visualiza nueva información";
                                    }
                                    else
                                    {

                                        //lblEstadisticasActuales.Text = "Se recibió otra respuesta :  " + msgRespuesta.Respuesta.ToString() + ". Se visualiza información anterior.";
                                        lblEstadisticasActuales.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(msgRespuesta.Respuesta) + ". Se visualiza información anterior.";
                                    }
                                }
                                else
                                {
                                    lblEstadisticasActuales.Text = "No existe aún información de estadísticas para este FCI.";
                                }
                                lblEstadisticasActuales.Visible = true;
                                break;

                            case ComandosUsuario.ReadCurrentStatisticsFCI:
                                break;

                            case ComandosUsuario.ResetFCI:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.OK)
                                {
                                    lblResetFCI.Text = (string)this.GetLocalResourceObject("TextResetFCIEnvioOK");
                                }
                                else
                                {
                                    lblResetFCI.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(msgRespuesta.Respuesta);
                                }
                                lblResetFCI.Visible = true;
                                break;

                            case ComandosUsuario.TestFCI:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.OK)
                                {
                                    lblTestFCI.Text = (string)this.GetLocalResourceObject("TextTestFCIEnvioOK");
                                }
                                else
                                {
                                    lblTestFCI.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(msgRespuesta.Respuesta);
                                }
                                lblTestFCI.Visible = true;
                                break;
                        }
                    }
                    else
                    {
                        lblEstadoActualizacionOnline.Text = (string)this.GetLocalResourceObject("TextlblEstActFCIOnLineOtroSerial") + msgRespuesta.SerialFWT;
                    }
                }

            }
            catch (MessageQueueException mqExc)
            {
                //lblEstadoActualizacionOnline.Text = "MessageQueueException al recibir :" + mqExc.Message;
                lblEstadoActualizacionOnline.Text = DescripcionEnumeraciones.GetRespuestasSvrComSpa(RespuestasSvrCom.MsgQueueExceptionComunicaciones);
            }

            lblEstadoActualizacionOnline.Visible = true;
        }

        //protected string MostrarValorTensionFriendly(object valTensionBDObj)
        //{

        //    if (valTensionBDObj != DBNull.Value)
        //    {
        //        bool tension = (bool)valTensionBDObj;
        //        if (tension)
        //        {
        //            return "Presencia";
        //        }
        //        else
        //        {
        //            return "Ausencia";
        //        }
        //    }
        //    else
        //    {
        //        return "N/A";
        //    }
        //}

        #endregion

        /// <summary>
        /// Carga todos los concentradores en el dropdownlist ddlConcentradores
        /// </summary>
        


        #region Metodos Eventos de Controles


        protected void rdButModoDisparo_CheckedChanged(object sender, EventArgs e)
        {
            txtValorFalla.Visible = true;
            if (rdButModoProporcional.Checked)
            {
                ReqValPropor.Enabled = true;
                RegExPropor.Enabled = true;
                RanValPropor.Enabled = true;
                ReqValIncre.Enabled = false;
                RegExValIncre.Enabled = false;
                RanValIncre.Enabled = false;
                ReqValFijo.Enabled = false;
                RegExValFijo.Enabled = false;
                RanValFijo.Enabled = false;
                lblNombreValorFalla.Text = (string)this.GetLocalResourceObject("TextlblNombreValorFallaDeltaI");
                //txtValorFalla.Text = "2"; //Valor por defecto Delta
                lblUnids.Visible = true;
                lblUnids.Text = (string)this.GetLocalResourceObject("TextlblUnidsVeces");
                txtValorFalla.Focus();

            }
            else if (rdButModoPorIncremento.Checked)
            {
                ReqValPropor.Enabled = false;
                RegExPropor.Enabled = false;
                RanValPropor.Enabled = false;
                ReqValIncre.Enabled = true;
                RegExValIncre.Enabled = true;
                RanValIncre.Enabled = true;
                ReqValFijo.Enabled = false;
                RegExValFijo.Enabled = false;
                RanValFijo.Enabled = false;
                lblNombreValorFalla.Text = (string)this.GetLocalResourceObject("TextlblNombreValorFallaEscalon");
                //txtValorFalla.Text = "10";
                lblUnids.Visible = true;
                lblUnids.Text = "(10-1000)A";
                txtValorFalla.Focus();

            }
            else if (rdButModoPorValorFijo.Checked)
            {
                ReqValPropor.Enabled = false;
                RegExPropor.Enabled = false;
                RanValPropor.Enabled = false;
                ReqValIncre.Enabled = false;
                RegExValIncre.Enabled = false;
                RanValIncre.Enabled = false;
                ReqValFijo.Enabled = true;
                RegExValFijo.Enabled = true;
                RanValFijo.Enabled = true;
                lblNombreValorFalla.Text = (string)this.GetLocalResourceObject("TextlblNombreValorFallaCorriente");
                //txtValorFalla.Text = "10";
                lblUnids.Visible = true;
                lblUnids.Text = "(10-1000)A";
                txtValorFalla.Focus();

            }
            else if (rdButModoPorAutoRango.Checked)
            {
                ReqValPropor.Enabled = false; //Se desactivan todos 
                RegExPropor.Enabled = false;
                RanValPropor.Enabled = false;
                ReqValIncre.Enabled = false;
                RegExValIncre.Enabled = false;
                RanValIncre.Enabled = false;
                ReqValFijo.Enabled = false;
                RegExValFijo.Enabled = false;
                RanValFijo.Enabled = false;
                lblNombreValorFalla.Text = "N/A";
                lblUnids.Text = "";
                lblUnids.Visible = false;
                txtValorFalla.Visible = false;


            }
        }

        protected void butCancelar_Click(object sender, EventArgs e)
        {
            //object urlAnt = ViewState["paginaAnterior"];
            //if (urlAnt != null)
            //{
            //    Response.Redirect((string)urlAnt);
            //}
            Response.Redirect("FCIsAll.aspx");

        }

        protected void butDelete_Click(object sender, EventArgs e)
        {
            using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
            {
                FCI fci = new FCI();
                fci.Id = Convert.ToInt32(lblId.Text);
                bDatos.FCIs.Attach(fci) ; //Para borrar posteriormente se utiliza attach
                //Pueden existir FCis que tengan alarmasFCi relacionadas .. se debe borrar en cascada ascendente 
                if (fci.AlarmasFCIs.Count > 0) 
                {
                    fci.AlarmasFCIs.Clear();       
                }

                if (fci.LogCorrienteFCIs.Count > 0)
                {
                    fci.LogCorrienteFCIs.Clear();
                }

                if (fci.EstadisticasFCIs.Count > 0 )
                {
                    fci.EstadisticasFCIs.Clear();
                }

                bDatos.ObjectStateManager.ChangeObjectState(fci, System.Data.EntityState.Deleted);
                bDatos.SaveChanges(); //se borra la fci
            }
            butCancelar_Click(this.butDelete, null);
        }

        protected void btnSaveInfoNoActualizable_Click(object sender, EventArgs e)
        {
            using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
            {
                int idFCI = Convert.ToInt32(lblId.Text);
                //seleccionamos este fci mediante una Lambda Expression
                FCI fci = bDatos.FCIs.SingleOrDefault(a => a.Id == idFCI);
                if (fci != null)
                {
                    fci.TipoCircuito = byte.Parse(listBoxTipoCircuito.SelectedValue);

                    if (DDListFases.SelectedValue == "")
                    {
                        fci.Fase = "";
                    }
                    else
                    {
                        fci.Fase = DDListFases.SelectedValue;
                    }

                    fci.Codigo = txtCodigoEquipo.Text.Trim();

                    bDatos.SaveChanges();
                }
            }
        }

        protected void butUpdate_Click(object sender, EventArgs e)
        {
            bool cambioPrmNoControlado = false;
            using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
            {
                int idFCI = Convert.ToInt32(lblId.Text);
                //seleccionamos este fci mediante una Lambda Expression
                FCI fci = bDatos.FCIs.SingleOrDefault(a => a.Id == idFCI);
                if (fci != null)
                {
                    //dario: ya no es necesario modificar el concentrador a un FCI
                    //if (ddlConcentradores.SelectedItem.Text.ToUpper() == "NO TIENE")
                    //{
                    //    fci.FWTId = null;
                    //}
                    //else
                    //{
                    //    fci.FWTId = int.Parse(ddlConcentradores.SelectedItem.Value);
                    //}

                    byte valFinalModoDisparo = 0;
                    if (rdButModoProporcional.Checked)
                    {
                        valFinalModoDisparo = 0;
                        //fci.ParamFCI.ModoDisparo = 0;
                    }
                    else if (rdButModoPorIncremento.Checked)
                    {
                        valFinalModoDisparo = 1;
                        //fci.ParamFCI.ModoDisparo = 1;
                    }
                    else if (rdButModoPorValorFijo.Checked)
                    {
                        valFinalModoDisparo = 2;
                        //fci.ParamFCI.ModoDisparo = 2;
                    }
                    else
                    {//Autorango
                        valFinalModoDisparo = 3;
                        //fci.ParamFCI.ModoDisparo = 3;
                    }
                    VerifyChangePrm(fci.ParamFCI.ModoDisparo, valFinalModoDisparo, ref cambioPrmNoControlado);
                    fci.ParamFCI.ModoDisparo = valFinalModoDisparo;

                    VerifyChangePrm(fci.ParamFCI.ReposicionPorTiempo, chkBoxRepTiempo.Checked, ref cambioPrmNoControlado);
                    fci.ParamFCI.ReposicionPorTiempo = chkBoxRepTiempo.Checked;

                    VerifyChangePrm(fci.ParamFCI.ReposicionPorTension, chkBoxRepTension.Checked, ref cambioPrmNoControlado);
                    fci.ParamFCI.ReposicionPorTension = chkBoxRepTension.Checked;

                    VerifyChangePrm(fci.ParamFCI.ReposicionPorMagneto, chkBoxRepMagneto.Checked, ref cambioPrmNoControlado);
                    fci.ParamFCI.ReposicionPorMagneto = chkBoxRepMagneto.Checked;

                    VerifyChangePrm(fci.ParamFCI.ReposicionPorCorriente, chkBoxRepCorriente.Checked, ref cambioPrmNoControlado);
                    fci.ParamFCI.ReposicionPorCorriente = chkBoxRepCorriente.Checked;

                    VerifyChangePrm(fci.ParamFCI.HabilitarReloj, chkBoxHabReloj.Checked, ref cambioPrmNoControlado);
                    fci.ParamFCI.HabilitarReloj = chkBoxHabReloj.Checked;

                    VerifyChangePrm(fci.ParamFCI.HabilitarFallaTransitoria, chkBoxHabFallaTrans.Checked, ref cambioPrmNoControlado);
                    fci.ParamFCI.HabilitarFallaTransitoria = chkBoxHabFallaTrans.Checked;

                    VerifyChangePrm(fci.ParamFCI.Frecuencia, rblFrecuencia.SelectedValue, ref cambioPrmNoControlado);
                    fci.ParamFCI.Frecuencia = Convert.ToBoolean(rblFrecuencia.SelectedValue);

                    object refControlesCambiados = ViewState["controlesChanged"];
                    if (refControlesCambiados != null || cambioPrmNoControlado)
                    {
                        //ATENCIÓN : Los anteriores controles (antes del if )  tambien influyen para que quede pendiente el envío de parametros
                        fci.PendienteEnviarParametros = true;
                        fci.PendienteConfirmarActualizacionParametros = false;
                        lblEstadoFCI.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteEnviar");
                        //Se define que control(es) cambió(aron) y se actualiza(n) en el modelo EF.
                        string[] arrayControlesCambiados = null;
                        if (refControlesCambiados != null)
                        {
                            arrayControlesCambiados = ((string)refControlesCambiados).Split(new string[] { "*" }, StringSplitOptions.RemoveEmptyEntries);
                        }
                        else
                        {
                            arrayControlesCambiados = new string[]{};
                        }
                         
                        foreach (string strControlId in arrayControlesCambiados)
                        {
                            switch (strControlId)
                            {
                                case "txtValorFalla":
                                    fci.ParamFCI.ValorFalla = short.Parse(txtValorFalla.Text);
                                    break;
                                case "txtTiempoValFalla":
                                    fci.ParamFCI.TiempoValidacionFallaSegundos = short.Parse(txtTiempoValFalla.Text);
                                    break;
                                case "txtToleranciaTensionReposicion":
                                    fci.ParamFCI.ToleranciaTensionReposicion = short.Parse(txtToleranciaTensionReposicion.Text);
                                    break;
                                case "txtTiempoReposicion":
                                    fci.ParamFCI.TiempoReposicionSegundos = int.Parse(txtTiempoReposicion.Text);
                                    break;
                                case "txtTiempoIndicacionFallatemp":
                                    fci.ParamFCI.TiempoIndicacionFallaTemporalSegundos = int.Parse(txtTiempoIndicacionFallatemp.Text);
                                    break;
                                case "txtTiempoFlashIndicacion":
                                    fci.ParamFCI.TiempoFlashIndicacion8ms = (byte)((byte.Parse(txtTiempoFlashIndicacion.Text)) / 8); //Lo que se muestra en GUI se divide por 8 
                                    break;
                                case "txtTiempoEntreFlashIndicacion":
                                    fci.ParamFCI.TiermpoEntreFlashIndicacionSegundos = byte.Parse(txtTiempoEntreFlashIndicacion.Text);
                                    break;
                                case "txtTiempoProteccionInRush":
                                    fci.ParamFCI.TiempoProteccionInRushSegundos = byte.Parse(txtTiempoProteccionInRush.Text);
                                    break;
                                case "txtTiempoRetardoValidacionTension":
                                    fci.ParamFCI.TiempoRetardoValidacionTensionSegundos = short.Parse(txtTiempoRetardoValidacionTension.Text);
                                    break;
                                case "txtCorrienteAbsolutaDisparo":
                                    fci.ParamFCI.CorrienteAbsolutaDisparo = short.Parse(txtCorrienteAbsolutaDisparo.Text);
                                    break;
                                case "txtNumeroReintentosComunicaciones":
                                    fci.ParamFCI.NumeroReintentosComunicacion = byte.Parse(txtNumeroReintentosComunicaciones.Text);
                                    break;
                                case "txtSegundosProximaComunicacion":
                                    fci.ParamFCI.SegundosParaProximaComunicacion = int.Parse(txtSegundosProximaComunicacion.Text);
                                    break;
                                case "txtCapacidadBateria":
                                    fci.ParamFCI.CapacidadBateriaInstalada = short.Parse(txtCapacidadBateria.Text);
                                    break;
                            }

                        }
                        bDatos.SaveChanges();    //Se guardan los cambios en el context Manager 
                        lblEstadoActualizacion.Visible = true;
                        lblEstadoActualizacion.Text = (string)this.GetLocalResourceObject("TextlblEstadoActFCIPendiente");
                        ViewState["controlesChanged"] = null;  // empieza desde cero los controles cambiados.    
                        ViewState["ActualizadoOffline"] = true; //Ya se hizo la actualización OffLine
                        imgEstadoFCI.Visible = true;
                        tmrActualizacionEstadoFCI.Enabled = true; 
                           
                    }
                    else
                    {
                        lblEstadoActualizacion.Visible = true;
                        lblEstadoActualizacion.Text = (string)this.GetLocalResourceObject("TextlblEstadoActFCINoCambios");
                    }
                }
            }

          
        }


        protected void VerifyChangePrm(object objeto1, object objeto2, ref bool huboCambio)
        {
            var valor1 = objeto1;
            var valor2 = objeto2;

            if (valor1.ToString() != valor2.ToString())
            {
                huboCambio = true;
            }
        }


        /// <summary>
        /// Metodo que se ejecuta cuando el valor de un control cambió 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Control_TextChanged(object sender, EventArgs e)
        {
            Control cntrl = (Control)sender; //Control es la base class de todos los aps net server controls 
            string strViewStCntrlChgd = (string)ViewState["controlesChanged"];
            if ((ViewState["controlesChanged"] == null) || (strViewStCntrlChgd.IndexOf(cntrl.ID) < 0)) //No se van a agregar controles duplicados , 
            //no debe existir cntrl.ID en el viewState  , se utiliza orelse (||) de C#
            {                                                                                            //para que no vaya a existir problemas de null reference.
                ViewState["controlesChanged"] = ViewState["controlesChanged"] + "*" + cntrl.ID;  //Aca se almacenan los Ids de los controles que cambiaron , separados por *
            }



        }


        //Dario: Este manajador de evento no es necesario, pues ya no hay dependencia entre Tipo Circuito y Fase.

        //protected void listBoxTipoCircuito_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    switch (listBoxTipoCircuito.SelectedValue)
        //    {
        //        case "1":
        //            DDListFases.Enabled = false;
        //            break;
        //        case "2":
        //            DDListFases.Enabled = true;
        //            DDListFases.Items.Clear();
        //            DDListFases.Items.Add(new ListItem("A", "A"));
        //            DDListFases.Items.Add(new ListItem("B", "B"));
        //            break;
        //        case "3":
        //            DDListFases.Enabled = true;
        //            DDListFases.Items.Clear();
        //            DDListFases.Items.Add(new ListItem("R", "R"));
        //            DDListFases.Items.Add(new ListItem("S", "S"));
        //            DDListFases.Items.Add(new ListItem("T", "T"));
        //            break;
        //    }
        //}

        //Activar el Calculo de la autonomia de la bateria según datos presentes del usuario
        
        protected void btnCalcAutonoBat_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string autonomiaDestello = CalcularAutonomiaBateria();
                lblAutonomiaBattInst.Text = autonomiaDestello  + " horas.";
                lblAutonomiaBattInstDias.Text = (double.Parse(autonomiaDestello) / 24).ToString("F2") + " días."; //Fixed point con dos digitos decimales
                lblAutonomiaBattInstAnios.Text = ((double.Parse(autonomiaDestello) / 24) /365).ToString("F2") + " años.";
            }
        }

        protected void butUpdateOnline_Click(object sender, EventArgs e)
        {
            this.Validate("edicionFCI");
            if (this.IsValid)
            {
                ViewState["ActualizadoOffline"] = false;  //antes de actualizar Online , se hace todo el proceso de Actualizar OffLine
                butUpdate_Click(sender, e);
                if ((bool)ViewState["ActualizadoOffline"])
                {
                    RealizarComunicacionOnlineYMSMQ(ComandosUsuario.ActParamFCI);
                }
            }


        }

        protected void tmrActualizacionEstadoFCI_Tick(object sender, EventArgs e)
        {

            using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
            {
                FCI fci = bDatos.FCIs.SingleOrDefault(f => f.Serial == lblSerial.Text);
                if (fci != null)
                {
                    if (fci.PendienteRecibirParametros)
                    {
                        lblEstadoFCI.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteRecibir");
                    }
                    else
                    {
                        if (fci.PendienteConfirmarActualizacionParametros)
                        {
                            lblEstadoFCI.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteConfirmar");
                        }
                        else if (fci.PendienteEnviarParametros)
                        {
                            lblEstadoFCI.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteEnviar");
                        }
                        else
                        {
                            lblEstadoFCI.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIDatosOK");
                            imgEstadoFCI.Visible = false;
                            tmrActualizacionEstadoFCI.Enabled = false; //si los datos estan actualizados se desactiva el timer .
                            lblEstadoActualizacion.Visible = false;
                            lblEstadoActualizacionOnline.Visible = false;
                            ActivarBotonesOnline();
                            LlenarComboFechasHistoricasParametros(fci.Id);

                        }
                    }
                }


            }

        }

        protected void butLeerParamOnline_Click(object sender, EventArgs e)
        {
            RealizarComunicacionOnlineYMSMQ(ComandosUsuario.ReadParamFCI);
        }

        protected void butLeerEstadisticas_Click(object sender, EventArgs e)
        {
            lblEstadisticasActuales.Visible = false;
            RealizarComunicacionOnlineYMSMQ(ComandosUsuario.ReadStatisticsFCI);
        }

        protected void btnResetFCI_Click(object sender, EventArgs e)
        {
            lblResetFCI.Visible = false;
            RealizarComunicacionOnlineYMSMQ(ComandosUsuario.ResetFCI);
        }

        protected void btnComandoTestFCI_Click(object sender, EventArgs e)
        {
            lblTestFCI.Visible = false;
            RealizarComunicacionOnlineYMSMQ(ComandosUsuario.TestFCI);
        }

        protected void btnCalcularAutNormal_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string autonomiaFuncionamiento = CalcularAutonomiaBateriaFuncionamiento();
                lblAutonomiaFuncionamiento.Text = autonomiaFuncionamiento + " horas.";
                lblAutonomiaFuncionamientoDias.Text = (double.Parse(autonomiaFuncionamiento) / 24).ToString("F2") + " días.";
                lblAutonomiaFuncionamientoAnios.Text = ((double.Parse(autonomiaFuncionamiento) / 24) / 365).ToString("F2") + " años.";
            }
        }

        protected void DDLFechasActualizacionesPrms_SelectedIndexChanged(object sender, EventArgs e)
        {
            ConfigurarHyperLinkHistoricoParametros();
        }

        protected void TimerShowEventosReposicion_Tick(object sender, EventArgs e)
        {
            GVEventosReposicion.DataBind();
        }

        #endregion


        #region Metodos de Validadores


        //En los Prms de tiempos, este valor debe ser un multiplo de 8
        public void CheckTiempoDuracionDestello(Object source, ServerValidateEventArgs args)
        {
            int valPrm;

            if (int.TryParse(args.Value, out valPrm))
            {
                if ((valPrm % 8) == 0)
                {
                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                }
            }
            else
            {
                args.IsValid = false;
            }
        }

        #endregion




        //********************************  ACTIVACIÓN CON EL SCADA ************************************************

        #region Metodos Relacionados con Scada


        protected void btnSetScada_Click(object sender, EventArgs e)
        {
            bool scadaOK = false;
            string txtResultadoProceso;
            string serialFwt = lblSerialFWT.Text;
            byte sectorIdentificador;
            int idFci;

            if (byte.TryParse(lblIdentificador.Text, out sectorIdentificador) && int.TryParse(lblId.Text, out idFci))
            {
                if (RealizarOperacionCompletaCambioFuncionScada(serialFwt, sectorIdentificador, TipoOperacionInWinScada.CARGA_PUNTOS, out txtResultadoProceso))
                {
                    if (!AccesoDatosEF.UpdateEnScadaFCI(idFci, true))
                    {
                        txtResultadoProceso = txtResultadoProceso + " " + (string)this.GetLocalResourceObject("TextRealizarOpScadaErrBD");
                    }
                    else
                    {
                        scadaOK = true;
                    }
                }
                lblTxtMsgScada.Text = txtResultadoProceso;
            }
            SettingScadaBotones(int.Parse(lblASDUFWT.Text), scadaOK);
        }
        
        protected void btnQuitScada_Click(object sender, EventArgs e)
        {
            bool inScada = true;
            string txtResultadoProceso;
            string serialFwt = lblSerialFWT.Text;
            byte sectorIdentificador;
            int idFci;

            if (byte.TryParse(lblIdentificador.Text, out sectorIdentificador) && int.TryParse(lblId.Text, out idFci))
            {
                if (RealizarOperacionCompletaCambioFuncionScada(serialFwt, sectorIdentificador, TipoOperacionInWinScada.DESCARGA_PUNTOS, out txtResultadoProceso))
                {
                    if (!AccesoDatosEF.UpdateEnScadaFCI(idFci, false))
                    {
                        txtResultadoProceso = txtResultadoProceso + " " + (string)this.GetLocalResourceObject("TextRealizarOpScadaErrBD");
                    }
                    else
                    {
                        inScada = false;
                    }
                }
                lblTxtMsgScada.Text = txtResultadoProceso;
            }
            SettingScadaBotones(int.Parse(lblASDUFWT.Text), inScada);
        }

        protected bool RealizarOperacionCompletaCambioFuncionScada(string serialEquipo, byte subSector, TipoOperacionInWinScada tipoCmd, out string txtSalida)
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
                                if (EjecutarOperacionCambioFuncionScada(conectorMsg, serialEquipo, subSector , tipoCmd, out txtFromWinScada, byte.Parse(lblCanal104FWT.Text)))
                                {
                                    txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaOk");
                                    exito = true;
                                }
                                else
                                {
                                    txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaWinScadaNoK") + txtFromWinScada;
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

        protected bool EjecutarOperacionCambioFuncionScada(ConectorMQ conector, string serialEquipo, byte subSector, TipoOperacionInWinScada tipoCmd, out string msgFromWScada, byte canalIEC)
        {
            bool exito = true;
            msgFromWScada = "";

            MessageToWinScada msgComando = new MessageToWinScada(serialEquipo, subSector, tipoCmd, TiposEquipo.FWT, canalIEC);

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


        #endregion

        

        

        

        

        

    }
}