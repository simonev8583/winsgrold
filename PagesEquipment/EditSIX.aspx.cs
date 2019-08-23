using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Messaging;
using SGR.DataAccessLayer;
using SGR.BussinessLayer;
using SCADA104.Definiciones;
using Celsa.ConexionMensajeria;

namespace SistemaGestionRedes.PagesEquipment
{
    public partial class EditSIX : System.Web.UI.Page
    {
        private const byte SEGS_WAIT_RESPUESTA_COSOFT = 40;
        private SistemaGestionRemotoContainer _context = new SistemaGestionRemotoContainer();
        private static string _idEquipo;
        private FCI _objEquipo;

        private static string _serialConcentrador;
        private static int _canalIECConcentrador;

        private MessageQueue mqWebToSGR;
        private MessageQueue mqSGRToWeb;

        private bool _fwtIsConnected = false;

        //Para control del cambio del Código de Grupo según el Modo del SIX (Mono - Tri).
        private static byte _valCodGrupo_Monofasico;
        private static byte _valCodGrupo_Trifasico;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                _idEquipo = Request.QueryString["Id"];
                _objEquipo = GetEquipoEntitySix(_idEquipo);
                DefinirPagina(_objEquipo);
                _fwtIsConnected = AccesoDatosEF.ExisteConexionFWT(_serialConcentrador);
                ActivarBotonesOnline();
                ControlarAutorizacionControles();
            }
            else
            {
                MsgLblResultadoCmdStdsOnLine.Visible = false;
                MsgLblResultadoCmdCteOnLine.Visible = false;
                MsgLblResultadoCmdLeerPrmsOnLine.Visible = false;
                MsgLblResultadoCmdWritePrmsOnLine.Visible = false;
            }
        }



        #region Metodos Llenado Pagina

        private FCI GetEquipoEntitySix(string idEquipo)
        {
            FCI objSix = null;
            int idSix;

            if (int.TryParse(idEquipo, out idSix))
            {
                //_context = new SistemaGestionRemotoContainer();
                objSix = (from equipos in _context.FCIs
                          where equipos.Id == idSix
                          select equipos).SingleOrDefault();
            }

            return objSix;
        }

        private void DefinirPagina(FCI equipoSix)
        {
            DefinirSeccionGeneral(equipoSix);
            DefinirSeccionGestionElectrica(equipoSix);
            DefinirSeccionParametros(equipoSix);
            DefinirSeccionStdCorrientes(equipoSix);
            DefinirSeccionStdUso(equipoSix);
        }

        private void DefinirSeccionGeneral(FCI equipoSix)
        {
            //ESTADO
            if (equipoSix.PendienteRecibirParametros)
            {
                genLblEstado.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteRecibir"); //"PENDIENTE RECIBIR PARAMETROS.";
                genLblEstado.ForeColor = Color.Red;
                imgEstadoSix.Visible = true;
                tmrActualizacionEstadoSix.Enabled = true;
            }
            else
            {
                if (equipoSix.PendienteConfirmarActualizacionParametros)
                {
                    genLblEstado.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteConfirmar"); //"PENDIENTE CONFIRMAR ACTUALIZACIÓN PARAMETROS.";
                    genLblEstado.ForeColor = Color.Red;
                    imgEstadoSix.Visible = true;
                    tmrActualizacionEstadoSix.Enabled = true;
                }
                else if (equipoSix.PendienteEnviarParametros)
                {
                    genLblEstado.Text = (string)this.GetLocalResourceObject("TextlblEstadoActFCIPendiente"); //"PENDIENTE ENVIAR PARAMETROS.";
                    genLblEstado.ForeColor = Color.Red;
                    imgEstadoSix.Visible = true;
                    tmrActualizacionEstadoSix.Enabled = true;
                }
                else
                {
                    genLblEstado.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIDatosOK"); //"DATOS ACTUALIZADOS.";
                    genLblEstado.ForeColor = Color.Black;
                }
            }

            //FECHA REGISTRO GESTION
            if (equipoSix.FechaRegistroGestion != null)
            {
                genLblFechaRegistro.Text = equipoSix.FechaRegistroGestion.ToString();
            }

            //FECHA INSTALACION
            if (equipoSix.FechaInstalacion != null)
            {
                genLblFechaInstalacion.Text = equipoSix.FechaInstalacion.ToString();
            }

            //FALLA EN CIRCUITO
            string posibleFechaFallaPerm;
            if (_TieneFallaPermanente(equipoSix, out posibleFechaFallaPerm))
            {
                genLblFallaCircuito.Text = (string)this.GetLocalResourceObject("TextAvisoFallaPermanente") + " " + posibleFechaFallaPerm;
            }
            else
            {
                genLblFallaCircuito.Text = "OK";
            }

            //VERSION PROGRAMA SIX
            if (equipoSix.VersionProgramaSix != null)
            {
                genLblVersionPrograma.Text = equipoSix.VersionProgramaSix;
            }
            else
            {
                genLblVersionPrograma.Text = "";
            }

            //SERIAL EQUIPO SIX
            if (equipoSix.Serial != null)
            {
                genLblSerialSix.Text = equipoSix.Serial;
            }
            else
            {
                genLblSerialSix.Text = "";
            }
        }

        private void DefinirSeccionGestionElectrica(FCI equipoSix)
        {
            //Selección del concentrador padre del equipo
            if (equipoSix.FWT != null)
            {
                gesDDLConcentradores.SelectedValue = equipoSix.FWTId.ToString();
                _serialConcentrador = equipoSix.FWT.Serial;
                //_canalIECConcentrador = equipoSix.FWT.Canal104.Value;
                _canalIECConcentrador = (int)equipoSix.FWT.Canal104;
            }
            //else
            //{
            //    gesDDLConcentradores.Items.Insert(0, new ListItem("", ""));
            //    gesDDLConcentradores.SelectedValue = "";
            //}

            //Definir el identificador.
            if (equipoSix.Identificador != null)
            {
                gesLblIdentificador.Text = equipoSix.Identificador.ToString();
            }
            else
            {
                gesLblIdentificador.Text = "";
            }

            //Definir tipo de circuito
            gesLblOriginalCirto.Text = equipoSix.TipoCircuito.ToString();
            gesDDLTiposCircuito.SelectedValue = equipoSix.TipoCircuito.ToString();
            //Definir valor de la fase
            //gesLblOriginalFase.Text = equipoSix.Fase;
            //_ConfigurarFaseCircuito(gesDDLFases, equipoSix.TipoCircuito.ToString(), equipoSix.Fase);

            //Definir configuración de SCADA
            gesChkValEnScada.Checked = equipoSix.EnScada;
            gesChkScada.Checked = equipoSix.EnScada;
            gesBtnConfirScada.Enabled = _DefinirEstadoBotonScada(gesChkValEnScada.Checked, gesChkScada.Checked);

        }

        private void DefinirSeccionParametros(FCI equipoSix)
        {
            //Grupo Corriente de actuacion
            rbLstModoActuacion.SelectedValue = equipoSix.ParamSIX.modoDeteccionFalla.ToString();
            rbLstFrecuencia.SelectedValue = equipoSix.ParamSIX.frecuencia.ToString();
            prmTxtCorrienteIncremental.Text = equipoSix.ParamSIX.corrienteIncremental.ToString();
            _ResetCampoTiempoIncremental(equipoSix.ParamSIX.corrienteIncremental);
            prmTxtTiempoIncremental.Text = equipoSix.ParamSIX.tiempoIncremental.ToString();
            prmTxtCteNominal.Text = equipoSix.ParamSIX.corrienteNominal.ToString();
            _ResetCorrienteActuacion();

            //if (equipoSix.ParamSIX.modoDeteccionFalla == 0x00)
            //{
            //    //Incremental
            //    prmTxtCteNominal.Enabled = false;
            //    prmTxtCorrienteIncremental.Enabled = true;
            //    prmTxtTiempoIncremental.Enabled = true;
            //}
            //else
            //{
            //    //Umbral
            //    prmTxtCteNominal.Enabled = true;
            //    prmTxtCorrienteIncremental.Enabled = false;
            //    prmTxtTiempoIncremental.Enabled = false;
            //}

            //Grupo Conteos
            prmTxtConteos.Text = equipoSix.ParamSIX.conteos.ToString();
            prmTxtResetContador.Text = equipoSix.ParamSIX.resetContador.ToString();

            //Grupo Corriente Apertura
            rbLstUmbralCteApertura.SelectedValue = equipoSix.ParamSIX.valorUmbralCLM.ToString();
            //if (equipoSix.ParamSIX.valorUmbralCLM == 0x00) //200mA
            //{
            //    rbLstUmbralCteApertura.Items[0].Selected = true; //200mA
            //    rbLstUmbralCteApertura.Items[1].Selected = false; //300mA
            //}
            //else
            //{
            //    //300mA
            //    rbLstUmbralCteApertura.Items[0].Selected = false; //200mA
            //    rbLstUmbralCteApertura.Items[1].Selected = true; //300mA
            //}
            prmTxtTiempoDeteccion.Text = equipoSix.ParamSIX.tiempoDetectarCLM.ToString();
            prmTxtTiempoValidacion.Text = equipoSix.ParamSIX.tiempoValidarCLM.ToString();


            //Grupo Comunicaciones
            rbLstFase.SelectedValue = equipoSix.ParamSIX.fase.ToString();
            //switch (equipoSix.ParamSIX.fase)
            //{
            //    case 0x01:
            //        rbLstFase.Items[0].Selected = true; //A - R
            //        break;

            //    case 0x02:
            //        rbLstFase.Items[1].Selected = true; //B - S
            //        break;

            //    case 0x03:
            //        rbLstFase.Items[2].Selected = true; //C - T
            //        break;
            //}

            rbLstModoSix.SelectedValue = equipoSix.ParamSIX.modoOperacionSix.ToString();

            if (equipoSix.ParamSIX.modoOperacionSix == 0x00)
            {
                //Monofasico
                _valCodGrupo_Monofasico = equipoSix.ParamSIX.codigoTerna;
                _valCodGrupo_Trifasico = 0x00;
            }
            else
            {
                //Trifasico
                _valCodGrupo_Trifasico = equipoSix.ParamSIX.codigoTerna;
                _valCodGrupo_Monofasico = 0x00;
            }

            prmDDLCanalComm.SelectedValue = equipoSix.ParamSIX.canalComunicacion.ToString();
            prmDDLCodigoTerna.SelectedValue = equipoSix.ParamSIX.codigoTerna.ToString();
            _ResetModoTrifasico();


            //Grupo Varios
            prmTxtTiempoValidacionInrush.Text = equipoSix.ParamSIX.resetInrush.ToString();
            prmChkActivarLED.Checked = equipoSix.ParamSIX.ActivarLed;
            //prmChkActivarSGR.Checked = (equipoSix.ParamSIX.activarSGR == 0x01) ? true : false;
            prmRBLstSGR.SelectedValue = equipoSix.ParamSIX.activarSGR.ToString();


            //prmTxtCteNominal.Text = equipoSix.ParamSIX.corrienteNominal.ToString();
            //prmTxtConteos.Text = equipoSix.ParamSIX.conteos.ToString();
            //prmTxtResetContador.Text = equipoSix.ParamSIX.resetContador.ToString();
            //prmDDLCodigoTerna.SelectedValue = equipoSix.ParamSIX.codigoTerna.ToString();
            //prmChkActivarLED.Checked = equipoSix.ParamSIX.ActivarLed;
            //prmDDLCanalComm.SelectedValue = equipoSix.ParamSIX.canalComunicacion.ToString();
            //prmDDLModoOperacion.SelectedValue = equipoSix.ParamSIX.modoOperacionSix.ToString();
            //prmDDLCausasApertura.SelectedValue = equipoSix.ParamSIX.causaApertura.ToString();
        }

        private void DefinirSeccionStdCorrientes(FCI equipoSix)
        {
            var registros = (from corrientes in equipoSix.LogCorrienteSIXs
                             orderby corrientes.Fecha descending
                             select new { corrientes.Fecha, corrientes.ValorIL }).Take(5);

            stdGVCorrientes.DataSource = registros;
            stdGVCorrientes.DataBind();

        }

        private void DefinirSeccionStdUso(FCI equipoSix)
        {
            var registros = (from datos in _context.vw_app_estadisticasSIX
                             where datos.SIXId == equipoSix.Id
                             orderby datos.Fecha descending
                             select new
                             {
                                 datos.Fecha,
                                 datos.ContOperaciones,
                                 datos.ContTransitorios,
                                 datos.TiempoEnActuacion,
                                 datos.TiempoEnMaxima
                             }
                                 ).Take(5);

            stdGVOtrosDatos.DataSource = registros;
            stdGVOtrosDatos.DataBind();
        }

        private void DefinirEstadoActualizacionSix(FCI equipoSix)
        {
            //ESTADO
            if (equipoSix.PendienteRecibirParametros)
            {
                genLblEstado.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteRecibir"); //"PENDIENTE RECIBIR PARAMETROS.";
                genLblEstado.ForeColor = Color.Red;
                imgEstadoSix.Visible = true;
                tmrActualizacionEstadoSix.Enabled = true;
            }
            else
            {
                if (equipoSix.PendienteConfirmarActualizacionParametros)
                {
                    genLblEstado.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteConfirmar");  //"PENDIENTE CONFIRMAR ACTUALIZACIÓN PARAMETROS.";
                    genLblEstado.ForeColor = Color.Red;
                    imgEstadoSix.Visible = true;
                    tmrActualizacionEstadoSix.Enabled = true;
                }
                else if (equipoSix.PendienteEnviarParametros)
                {
                    genLblEstado.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIPendienteEnviar");  //"PENDIENTE ENVIAR PARAMETROS.";
                    genLblEstado.ForeColor = Color.Red;
                    imgEstadoSix.Visible = true;
                    tmrActualizacionEstadoSix.Enabled = true;
                }
                else
                {
                    genLblEstado.Text = (string)this.GetLocalResourceObject("TextlblEstadoFCIDatosOK");  //"DATOS ACTUALIZADOS.";
                    genLblEstado.ForeColor = Color.Black;
                    imgEstadoSix.Visible = false;
                    tmrActualizacionEstadoSix.Enabled = false;
                    //OJO: Algo con Activacion de Botones OnLine????, Analizar luego.
                }
            }
        }

        #endregion



        #region Metodos Modificar Informacion

        private void ModificarEquipoSix(ref FCI equipoSix)
        {
            bool cambioPrms;
            bool cambioGestionElectrica;

            ModificarDatosGestionElectrica(ref equipoSix, out cambioGestionElectrica);
            ModificarParametrosSIX(ref equipoSix, out cambioPrms, byte.Parse(rbLstModoActuacion.SelectedValue), byte.Parse(rbLstModoSix.SelectedValue));
            ModificarBanderaPendienteEnvioPrms(ref equipoSix, cambioPrms);

            if (cambioPrms || cambioGestionElectrica)
            {
                _context.SaveChanges();
                if (cambioPrms)
                {
                    tmrActualizacionEstadoSix.Enabled = true;
                    imgEstadoSix.Visible = true;
                }
            }
        }

        private void ModificarDatosGestionElectrica(ref FCI equipoSix, out bool huboCambios)
        {
            huboCambios = false;
            int idConcentrador;
            byte tipoCircuito;
            string fase;

            idConcentrador = int.Parse(gesDDLConcentradores.SelectedValue);
            tipoCircuito = byte.Parse(gesDDLTiposCircuito.SelectedValue);
            fase = gesDDLFases.SelectedValue;

            if (equipoSix.FWTId != idConcentrador)
            {
                huboCambios = true;
                equipoSix.FWTId = idConcentrador;
            }

            if (equipoSix.TipoCircuito != tipoCircuito)
            {
                huboCambios = true;
                equipoSix.TipoCircuito = tipoCircuito;
            }

            if (equipoSix.Fase != fase)
            {
                huboCambios = true;
                equipoSix.Fase = fase;
            }
        }

        //private void ModificarParametros(ref FCI equipoSix, out bool huboCambios)
        //{
        //    huboCambios = false;
        //    byte corrienteNominal;
        //    byte conteos;
        //    short resetContador;
        //    byte codigoTerna;
        //    bool activarLed;
        //    byte canalComunicacion;
        //    byte modoOperacion;
        //    //byte causaApertura; Este parámetro es de solo lectura, por tanto no se modifica por el usuario.

        //    corrienteNominal = byte.Parse(prmTxtCteNominal.Text);
        //    conteos = byte.Parse(prmTxtConteos.Text);
        //    resetContador = short.Parse(prmTxtResetContador.Text);
        //    codigoTerna = byte.Parse(prmDDLCodigoTerna.SelectedValue);
        //    activarLed = prmChkActivarLED.Checked;
        //    canalComunicacion = byte.Parse(prmDDLCanalComm.SelectedValue);
        //    modoOperacion = byte.Parse(prmDDLModoOperacion.SelectedValue);

        //    if (equipoSix.ParamSIX.corrienteNominal != corrienteNominal)
        //    {
        //        huboCambios = true;
        //        equipoSix.ParamSIX.corrienteNominal = corrienteNominal;
        //    }

        //    if (equipoSix.ParamSIX.conteos != conteos)
        //    {
        //        huboCambios = true;
        //        equipoSix.ParamSIX.conteos = conteos;
        //    }

        //    if (equipoSix.ParamSIX.resetContador != resetContador)
        //    {
        //        huboCambios = true;
        //        equipoSix.ParamSIX.resetContador = resetContador;
        //    }

        //    if (equipoSix.ParamSIX.codigoTerna != codigoTerna)
        //    {
        //        huboCambios = true;
        //        equipoSix.ParamSIX.codigoTerna = codigoTerna;
        //    }

        //    if (equipoSix.ParamSIX.ActivarLed != activarLed)
        //    {
        //        huboCambios = true;
        //        equipoSix.ParamSIX.ActivarLed = activarLed;
        //    }

        //    if (equipoSix.ParamSIX.canalComunicacion != canalComunicacion)
        //    {
        //        huboCambios = true;
        //        equipoSix.ParamSIX.canalComunicacion = canalComunicacion;
        //    }

        //    if (equipoSix.ParamSIX.modoOperacionSix != modoOperacion)
        //    {
        //        huboCambios = true;
        //        equipoSix.ParamSIX.modoOperacionSix = modoOperacion;
        //    }

        //}

        private void ModificarParametrosSIX(ref FCI equipoSix, out bool huboCambios, byte modoActuacionGUI, byte operacionTrifasica)
        {
            huboCambios = false;
            byte Frecuencia;                     //Frecuencia de operación de la línea: 50Hz o 60Hz.
            ushort CorrienteUmbralActuacion;     //Corriente umbral de actuación del equipo, entre 4 y 320 A
            byte CorrienteIncremental;           //Corriente incremental para el modo di/dt, entre 4 y 200 A
            ushort TiempoIncremental;            //Tiempo para medir el incremento de corriente, entre 40 y 500 ms
            byte Conteos;                        //Conteos de ausencia de corriente para abrir el circuito de 1 a 4
            ushort ResetContador;                //Tiempo máximo entre conteos, si no hay conteo se borra la falla de 1 - 99 segundos (en centesimas de segundo)
            ushort ResetInrush;                  //Tiempo para terminar el bloqueo por corriente inrush de 1 - 99 segundos
            ushort TiempoDetectarCLM;            //Tiempo para detectar la ausencia de corriente, entre 0 y 5000 ms. Corriente Linea Muerta
            byte TiempoValidarCLM;               //Tiempo de validacion de la ausencia de corriente, entre 50 y 100 ms. Corriente Linea Muerta
            byte CanalComunicacion;              //Canal de comunicaciòn por RF, entre 0 y 9
            byte CodigoGrupo;                    //Código para vinculación por RF, entre 1 y 10
            //byte CausaApertura;                  //Para definir la cuasa de la operación, 0:Ninguna; 1:Corriente; 2:RF; 3:Comando. Siempre en 0 cuando se actualicen prms.
            //Un byte tipo banderas:
            byte ModoDeteccionFalla;             //b0. 1:Umbral;      0:Incremental
            byte OperacionTrifasica;             //b1. 1:Trifásica;   0:Monofásica
            byte ValorUmbralCLM;                 //b2. 1:300mA;       0:200mA;
            //byte ActivarLED;                     //b3. 1:Activar LED; 0:Desactivar LED;
            byte ActivarSGR;                     //b4. 1:Activar SGR; 0:Desactivar SGR;
            byte Fase;                           //b5-b6. 3:FaseC; 2:FaseB; 1:FaseA;

            Frecuencia = byte.Parse(rbLstFrecuencia.SelectedValue);
            CorrienteUmbralActuacion = ushort.Parse(prmTxtCteNominal.Text);
            CorrienteIncremental = byte.Parse(prmTxtCorrienteIncremental.Text);
            TiempoIncremental = ushort.Parse(prmTxtTiempoIncremental.Text);
            Conteos = byte.Parse(prmTxtConteos.Text);
            ResetContador = ushort.Parse(prmTxtResetContador.Text);
            ResetInrush = ushort.Parse(prmTxtTiempoValidacionInrush.Text);
            TiempoDetectarCLM = ushort.Parse(prmTxtTiempoDeteccion.Text);
            TiempoValidarCLM = byte.Parse(prmTxtTiempoValidacion.Text);
            CanalComunicacion = byte.Parse(prmDDLCanalComm.SelectedValue);
            CodigoGrupo = byte.Parse(prmDDLCodigoTerna.SelectedValue);
            ModoDeteccionFalla = byte.Parse(rbLstModoActuacion.SelectedValue); //ojo
            OperacionTrifasica = byte.Parse(rbLstModoSix.SelectedValue);
            ValorUmbralCLM = byte.Parse(rbLstUmbralCteApertura.SelectedValue);
            //ActivarLED = (byte)((prmChkActivarLED.Checked) ? 0x01 : 0x00);
            //ActivarSGR = (byte)((prmChkActivarSGR.Checked) ? 0x01 : 0x00);
            ActivarSGR = byte.Parse(prmRBLstSGR.SelectedValue);
            Fase = byte.Parse(rbLstFase.SelectedValue);

            if (modoActuacionGUI == 0x00) //Incremental
            {
                if (equipoSix.ParamSIX.corrienteIncremental != CorrienteIncremental)
                {
                    huboCambios = true;
                    equipoSix.ParamSIX.corrienteIncremental = CorrienteIncremental;
                }

                if (equipoSix.ParamSIX.tiempoIncremental != TiempoIncremental)
                {
                    huboCambios = true;
                    equipoSix.ParamSIX.tiempoIncremental = TiempoIncremental;
                }
            }
            else
            {
                if (equipoSix.ParamSIX.corrienteNominal != CorrienteUmbralActuacion)
                {
                    huboCambios = true;
                    equipoSix.ParamSIX.corrienteNominal = (byte)CorrienteUmbralActuacion;
                }
            }

            if (equipoSix.ParamSIX.frecuencia != Frecuencia)
            {
                huboCambios = true;
                equipoSix.ParamSIX.frecuencia = Frecuencia;
            }

            if (equipoSix.ParamSIX.conteos != Conteos)
            {
                huboCambios = true;
                equipoSix.ParamSIX.conteos = Conteos;
            }

            if (equipoSix.ParamSIX.resetContador != ResetContador)
            {
                huboCambios = true;
                equipoSix.ParamSIX.resetContador = (short)ResetContador;
            }

            if (equipoSix.ParamSIX.resetInrush != ResetInrush)
            {
                huboCambios = true;
                equipoSix.ParamSIX.resetInrush = ResetInrush;
            }

            if (equipoSix.ParamSIX.tiempoDetectarCLM != TiempoDetectarCLM)
            {
                huboCambios = true;
                equipoSix.ParamSIX.tiempoDetectarCLM = TiempoDetectarCLM;
            }

            if (equipoSix.ParamSIX.tiempoValidarCLM != TiempoValidarCLM)
            {
                huboCambios = true;
                equipoSix.ParamSIX.tiempoValidarCLM = TiempoValidarCLM;
            }

            if (equipoSix.ParamSIX.canalComunicacion != CanalComunicacion)
            {
                huboCambios = true;
                equipoSix.ParamSIX.canalComunicacion = CanalComunicacion;
            }


            if (operacionTrifasica == 0x01) //Trifásica
            {
                if (equipoSix.ParamSIX.codigoTerna != CodigoGrupo)
                {
                    huboCambios = true;
                    equipoSix.ParamSIX.codigoTerna = CodigoGrupo;
                }
            }

            if (equipoSix.ParamSIX.modoDeteccionFalla != ModoDeteccionFalla)
            {
                huboCambios = true;
                equipoSix.ParamSIX.modoDeteccionFalla = ModoDeteccionFalla;
            }

            if (equipoSix.ParamSIX.modoOperacionSix != OperacionTrifasica)
            {
                huboCambios = true;
                equipoSix.ParamSIX.modoOperacionSix = OperacionTrifasica;
            }

            if (equipoSix.ParamSIX.valorUmbralCLM != ValorUmbralCLM)
            {
                huboCambios = true;
                equipoSix.ParamSIX.valorUmbralCLM = ValorUmbralCLM;
            }

            if (equipoSix.ParamSIX.ActivarLed != prmChkActivarLED.Checked)
            {
                huboCambios = true;
                equipoSix.ParamSIX.ActivarLed = prmChkActivarLED.Checked;
            }

            if (equipoSix.ParamSIX.activarSGR != ActivarSGR)
            {
                huboCambios = true;
                equipoSix.ParamSIX.activarSGR = ActivarSGR;
            }

            if (equipoSix.ParamSIX.fase != Fase)
            {
                huboCambios = true;
                equipoSix.ParamSIX.fase = Fase;
            }

        }

        private void ModificarBanderaPendienteEnvioPrms(ref FCI equipoSix, bool huboCambios)
        {
            if (huboCambios)
            {
                equipoSix.PendienteEnviarParametros = huboCambios;
            }
        }


        #endregion


        #region Metodos Utilitarios de Pagina

        private bool _TieneFallaPermanente(FCI equipoSix, out string fechaFalla)
        {
            bool respuesta = false;
            fechaFalla = "";

            var fallaP = (from fallas in equipoSix.AlarmasFCI
                          where fallas.Id == 178 && fallas.ClearAlarma == null
                          orderby fallas.Fecha descending
                          select fallas).FirstOrDefault();
            if (fallaP != null)
            {
                respuesta = true;
                fechaFalla = fallaP.Fecha.ToString();
            }

            return respuesta;
        }

        private void _ConfigurarFaseCircuito(DropDownList ddlFases, string tipoCircuito, string valorFase = null)
        {
            ddlFases.Items.Clear();
            switch (tipoCircuito)
            {
                case "1":
                    ddlFases.Enabled = false;
                    break;
                case "2":
                    ddlFases.Enabled = true;
                    ddlFases.Items.Add(new ListItem("A", "A"));
                    ddlFases.Items.Add(new ListItem("B", "B"));
                    break;
                case "3":
                    ddlFases.Enabled = true;
                    ddlFases.Items.Add(new ListItem("R", "R"));
                    ddlFases.Items.Add(new ListItem("S", "S"));
                    ddlFases.Items.Add(new ListItem("T", "T"));
                    break;
            }

            if (valorFase != null)
            {
                ddlFases.SelectedValue = valorFase;
            }

        }

        private bool _DefinirEstadoBotonScada(bool valOriginal, bool tryNewVal)
        {
            //Se realiza una operacion XOR entre:
            //El valor original de la opcion EnScada del equipo y
            //La opción en GUI que define lo que quiere el usuario, si habilitar o no.
            //Para esta página, simplemente no se permite dar click al boton si el usuario no ha modificado o ha dado una
            //opción diferente a dicha definición de permitir/no Scada para este equipo.

            return valOriginal ^ tryNewVal; //Operacion XOR (Or-Exclusiva).
        }

        private void ActivarBotonesOnline()
        {
            if ((_serialConcentrador != null) && (!_serialConcentrador.Equals("")))
            {
                if (_fwtIsConnected)
                {
                    btnActualizarInfo.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                    //Para que el boton se desactive cuando se le haga click y además permita continuar con el postback 
                    btnActualizarInfo.Attributes.Add("onclick", "javascript:" + btnActualizarInfo.ClientID + ".disabled=true;" + ClientScript.GetPostBackEventReference(btnActualizarInfo, ""));
                    btnLeerPrmsOnLine.Attributes.Add("onclick", "javascript:" + btnLeerPrmsOnLine.ClientID + ".disabled=true;" + ClientScript.GetPostBackEventReference(btnLeerPrmsOnLine, ""));
                    btnCteActualOnLine.Attributes.Add("onclick", "javascript:" + btnCteActualOnLine.ClientID + ".disabled=true;" + ClientScript.GetPostBackEventReference(btnCteActualOnLine, ""));
                    stdFuncionalesOnLine.Attributes.Add("onclick", "javascript:" + stdFuncionalesOnLine.ClientID + ".disabled=true;" + ClientScript.GetPostBackEventReference(stdFuncionalesOnLine, ""));

                    btnCteActualOnLine.Enabled = true;
                    stdFuncionalesOnLine.Enabled = true;
                    if (genLblEstado.Text.ToUpper() != (string)this.GetLocalResourceObject("TextlblEstadoActFCIPendiente"))
                    {
                        btnLeerPrmsOnLine.Enabled = true;
                    }
                    else
                    {
                        btnLeerPrmsOnLine.Enabled = false;
                    }
                }
            }
        }

        protected void ControlarAutorizacionControles()
        {
            //ATENCIÓN: Cada vez que se adicione un control en esta lista, se debe buscar o controlar en el resto del
            //código que no se haga una habilitación directa en otro sitio sin pasar por la función de control
            //de autorización UtilitariosWebGUI.HasAuthorization().
            if (_serialConcentrador != null)
            {
                btnActualizarInfo.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                gesChkScada.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            }
            else
            {
                gesChkScada.Enabled = false;
            }
        }

        private void _ResetCampoTiempoIncremental(ushort newValCteIncremental)
        {
            if (newValCteIncremental <= 10)
            {
                lblHelpTiempoIncremental.Text = "(40-100)ms";
                valRVTiempoIncremental.MaximumValue = "100";                
            }
            else if (newValCteIncremental > 10 && newValCteIncremental <= 20)
            {
                lblHelpTiempoIncremental.Text = "(40-200)ms";
                valRVTiempoIncremental.MaximumValue = "200";
            }
            else if (newValCteIncremental > 20 && newValCteIncremental <= 30)
            {
                lblHelpTiempoIncremental.Text = "(40-300)ms";
                valRVTiempoIncremental.MaximumValue = "300";
            }
            else if (newValCteIncremental > 30 && newValCteIncremental <= 40)
            {
                lblHelpTiempoIncremental.Text = "(40-400)ms";
                valRVTiempoIncremental.MaximumValue = "400";
            }
            else if (newValCteIncremental > 40)
            {
                lblHelpTiempoIncremental.Text = "(40-500)ms";
                valRVTiempoIncremental.MaximumValue = "500";
            }

            valRVTiempoIncremental.ErrorMessage = this.GetLocalResourceObject("TextErrorTiempoIncremental") + " " + lblHelpTiempoIncremental.Text;
        }

        private void _ResetCorrienteActuacion()
        {
            switch (rbLstModoActuacion.SelectedValue)
            {
                case "0": //Incremental
                    prmTxtCteNominal.Enabled = false;
                    prmTxtCorrienteIncremental.Enabled = true;
                    prmTxtTiempoIncremental.Enabled = true;
                    
                    valRFCorrienteIncremental.Enabled = true;
                    valRVCorrienteIncremental.Enabled = true;
                    valRExCorrienteIncremental.Enabled = true;
                    valRFTiempoIncremental.Enabled = true;
                    valRVTiempoIncremental.Enabled = true;
                    valCVTiempoIncremental.Enabled = true;

                    valRFcteNominal.Enabled = false;
                    valRVcteNominal.Enabled = false;
                    break;

                case "1": //Umbral
                    prmTxtCteNominal.Enabled = true;
                    prmTxtCorrienteIncremental.Enabled = false;
                    prmTxtTiempoIncremental.Enabled = false;

                    valRFCorrienteIncremental.Enabled = false;
                    valRVCorrienteIncremental.Enabled = false;
                    valRExCorrienteIncremental.Enabled = false;
                    valRFTiempoIncremental.Enabled = false;
                    valRVTiempoIncremental.Enabled = false;
                    valCVTiempoIncremental.Enabled = false;

                    valRFcteNominal.Enabled = true;
                    valRVcteNominal.Enabled = true;
                    break;
            }

        }

        private void _ResetModoTrifasico()
        {
            switch (rbLstModoSix.SelectedValue)
            {
                case "0": //Monofásico
                    prmDDLCodigoTerna.Enabled = false;
                    break;

                case "1": //Trifásico
                    prmDDLCodigoTerna.Enabled = true;
                    break;
            }
        }
               

        #endregion
      


        #region Metodos Eventos de Controles


        protected void gesDDLTiposCircuito_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (gesLblOriginalCirto.Text == gesDDLTiposCircuito.SelectedValue)
            {
                if (gesLblOriginalCirto.Text != "1") //Valor 1 es Monofásico. No maneja Fases.
                {
                    _ConfigurarFaseCircuito(gesDDLFases, gesDDLTiposCircuito.SelectedValue, gesLblOriginalFase.Text);
                }
                else
                {
                    _ConfigurarFaseCircuito(gesDDLFases, gesDDLTiposCircuito.SelectedValue);
                }
            }
            else
            {
                _ConfigurarFaseCircuito(gesDDLFases, gesDDLTiposCircuito.SelectedValue);
            }
        }

        protected void stdButRefresh_Click(object sender, EventArgs e)
        {
            _idEquipo = Request.QueryString["Id"];
            _objEquipo = GetEquipoEntitySix(_idEquipo);
            DefinirSeccionStdCorrientes(_objEquipo);
        }

        protected void stdFuncionalesRefresh_Click(object sender, EventArgs e)
        {
            _idEquipo = Request.QueryString["Id"];
            _objEquipo = GetEquipoEntitySix(_idEquipo);
            DefinirSeccionStdUso(_objEquipo);
        }

        protected void gesChkScada_CheckedChanged(object sender, EventArgs e)
        {
            gesBtnConfirScada.Enabled = _DefinirEstadoBotonScada(gesChkValEnScada.Checked, gesChkScada.Checked);
        }

        protected void btnActualizarInfo_Click(object sender, EventArgs e)
        {
            this.Validate("parametros");
            if (this.IsValid)
            {
                _idEquipo = Request.QueryString["Id"];
                _objEquipo = GetEquipoEntitySix(_idEquipo);
                ModificarEquipoSix(ref _objEquipo);

                //Probemos aqui...
                RealizarComunicacionOnlineYMSMQ(ComandosUsuario.ActParamFCI, MsgLblResultadoCmdWritePrmsOnLine);

                DefinirPagina(_objEquipo);
            }
        }

        protected void tmrActualizacionEstadoSix_Tick(object sender, EventArgs e)
        {
            _idEquipo = Request.QueryString["Id"];
            _objEquipo = GetEquipoEntitySix(_idEquipo);
            DefinirEstadoActualizacionSix(_objEquipo);
        }

        protected void stdFuncionalesOnLine_Click(object sender, EventArgs e)
        {
            RealizarComunicacionOnlineYMSMQ(ComandosUsuario.ReadStatisticsFCI, MsgLblResultadoCmdStdsOnLine);
        }

        protected void btnCteActualOnLine_Click(object sender, EventArgs e)
        {
            RealizarComunicacionOnlineYMSMQ(ComandosUsuario.ReadCurrentNowSix, MsgLblResultadoCmdCteOnLine);
        }

        protected void btnLeerPrmsOnLine_Click(object sender, EventArgs e)
        {
            RealizarComunicacionOnlineYMSMQ(ComandosUsuario.ReadParamFCI, MsgLblResultadoCmdLeerPrmsOnLine);
        }

        protected void prmTxtCorrienteIncremental_TextChanged(object sender, EventArgs e)
        {
            this.Validate("parametros");
            if (this.IsValid)
            {
                ushort nuevaCteIncremental = ushort.Parse(prmTxtCorrienteIncremental.Text);
                _ResetCampoTiempoIncremental(nuevaCteIncremental);
            }
        }

        protected void rbLstModoActuacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            _ResetCorrienteActuacion();
        }

        protected void rbLstModoSix_SelectedIndexChanged(object sender, EventArgs e)
        {
            _ResetModoTrifasico();
        }

        protected void valCVTiempoIncremental_ServerValidate(object source, ServerValidateEventArgs args)
        {
            ushort _tiempoIncrementalGUI;

            if (ushort.TryParse(prmTxtTiempoIncremental.Text, out _tiempoIncrementalGUI))
            {
                if ((_tiempoIncrementalGUI % 20) == 0)
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


        protected void valCambioCodigoGrupo_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (rbLstModoSix.SelectedValue.Equals("0")) //Esta selecionado monofásico
            {
                if (_valCodGrupo_Monofasico != 0x00)
                {
                    if (_valCodGrupo_Monofasico != byte.Parse(prmDDLCodigoTerna.SelectedValue))
                    {
                        args.IsValid = false; //El SIX continuará en modo monofásico, pero están intentando modificar el
                                              //Código de Grupo.
                    }
                    else
                    {
                        args.IsValid = true; //El SIX continua en monofásico y dejaron el valor del Código de Grupo igual.
                    }
                }
                else
                {
                    args.IsValid = true; //Fue modificado de Trifásico a Monofásico
                }
            }
            else
            {
                args.IsValid = true; //Han seleccionado el modo de SIX en trifásico. Se permite modificar el valor del Código de Grupo.
            }
        }

        #endregion



        #region Manejo Comandos OnLine Cosoft


        /// <summary>
        /// Realiza toda la comunicacion Online segun el caso , incluyendo el intercambio de MSMQ
        /// </summary>
        /// <param name="comandoUser"></param>
        private void RealizarComunicacionOnlineYMSMQ(ComandosUsuario comandoUser, Label lblMsg)
        {
            lblMsg.Text = "";
            InicializarMessageQueues();

            //Se crea un comando de usuario para enviar .
            MensajeComandoMQOnline msgComando = new MensajeComandoMQOnline();
            msgComando.SerialFWT = gesDDLConcentradores.SelectedItem.Text;
            msgComando.IdFCI = byte.Parse(gesLblIdentificador.Text);
            msgComando.SerialFCI = genLblSerialSix.Text;
            msgComando.Comando = comandoUser;
            mqWebToSGR.Send(msgComando);

            //Formato de mensaje de recepcion MensajeRespuestasMQOnline
            ((XmlMessageFormatter)mqSGRToWeb.Formatter).TargetTypes = new Type[1];
            //((XmlMessageFormatter)mqSGRToWeb.Formatter).TargetTypes[0] = (new MensajeRespuestasMQOnline()).GetType();
            ((XmlMessageFormatter)mqSGRToWeb.Formatter).TargetTypes[0] = typeof(MensajeRespuestasMQOnline); // Va a recibir MensajeRespuestasMQOnline

            try
            {
                System.Messaging.Message msg = mqSGRToWeb.Receive(new TimeSpan(0, 0, SEGS_WAIT_RESPUESTA_COSOFT)); //Espera Máximo N segs sincronicamente para recibir respuesta
                MensajeRespuestasMQOnline msgRespuesta = (MensajeRespuestasMQOnline)msg.Body;

                if (msgRespuesta.Respuesta == RespuestasSvrCom.NotConnected)
                {
                    lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLineFWTNoConectado"); //"FWT No Conectado";
                }
                else if (msgRespuesta.Respuesta == RespuestasSvrCom.MsgQueueExceptionComunicaciones)
                {
                    lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLineMQException") + " " + (string)msgRespuesta.Datos;
                }

                else
                {
                    if (msgRespuesta.SerialFWT == gesDDLConcentradores.SelectedItem.Text)
                    {
                        switch (comandoUser)
                        {
                            case ComandosUsuario.ActParamFCI:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.OK)
                                {
                                    lblMsg.Text = (string)this.GetLocalResourceObject("TextEscrituraPrmsOnLineOK");
                                    tmrActualizacionEstadoSix.Enabled = true;
                                }
                                else
                                {
                                    lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLineOtraRta") + " " + msgRespuesta.Respuesta.ToString();
                                }
                                break;

                            //case ComandosUsuario.ReadParamFCI:
                            //    if (msgRespuesta.Respuesta == RespuestasSvrCom.DATOS)
                            //    {
                            //        LlenarValoresFCI(int.Parse(lblId.Text)); //Se llenan los valores desde base de datos pues ya Cosoft los actualizó 
                            //        lblEstadoActualizacionOnline.Text = "Se recibieron los parametros del FCI.";
                            //        lblEstadoActualizacion.Visible = false; //No se muestra 
                            //    }
                            //    else
                            //    {

                            //        lblEstadoActualizacionOnline.Text = "Se recibió otra respuesta para este serial :  " + msgRespuesta.Respuesta.ToString();
                            //    }
                            //    break;

                            case ComandosUsuario.ReadParamFCI: //Se usa el mismo tipo de comando para SIX
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.DATOS)
                                {
                                    _idEquipo = Request.QueryString["Id"];
                                    _objEquipo = GetEquipoEntitySix(_idEquipo);
                                    DefinirSeccionParametros(_objEquipo);
                                    lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLinePrmsLeidos"); //"Parámeteros Leídos";
                                }
                                else
                                {
                                    lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLineOtraRta") + " " + msgRespuesta.Respuesta.ToString();
                                }
                                break;

                            case ComandosUsuario.ReadStatisticsFCI:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.DATOS)
                                {
                                    _idEquipo = Request.QueryString["Id"];
                                    _objEquipo = GetEquipoEntitySix(_idEquipo);
                                    DefinirSeccionStdUso(_objEquipo);
                                    lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLineStdsActualizadas"); //"Estadisticas Actualizadas";
                                }
                                else
                                {
                                    lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLineOtraRta") + " " + msgRespuesta.Respuesta.ToString();
                                }
                                break;

                            case ComandosUsuario.ReadCurrentNowSix:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.DATOS)
                                {
                                    _idEquipo = Request.QueryString["Id"];
                                    _objEquipo = GetEquipoEntitySix(_idEquipo);
                                    DefinirSeccionStdCorrientes(_objEquipo);
                                    short valorLeido = (short)msgRespuesta.Datos;
                                    //lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLineCteActualLeida") + valorLeido.ToString() + " A";
                                    lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLineCteActualLeida") + UtilitariosWebGUI.MostrarValorCorrienteSIXAjustado((object)valorLeido) + " A";
                                }
                                else
                                {
                                    lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLineOtraRta") + " " + msgRespuesta.Respuesta.ToString();
                                }
                                break;

                            case ComandosUsuario.DeleteFCIFromFWT:
                                break;
                            case ComandosUsuario.ReadCurrentStatisticsFCI:
                                break;
                        }

                    }
                    else
                    {
                        lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLineOtroSerialFWT") + " " + msgRespuesta.SerialFWT;
                    }
                }



            }
            catch (MessageQueueException mqExc)
            {

                lblMsg.Text = (string)this.GetLocalResourceObject("TextCmdOnLineMQExceptionRecibir") + " " + mqExc.Message;
            }

            lblMsg.Visible = true;
        }


        private void InicializarMessageQueues()
        {
            string queueName = ConfigApp.QueueToCosoft;  //Queue de Envío

            if (MessageQueue.Exists(queueName))
            {
                mqWebToSGR = new MessageQueue(queueName);
            }
            else
            {
                mqWebToSGR = MessageQueue.Create(queueName);
            }

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


        #endregion




        #region Metodos Relacionados con WinScada

        protected void gesBtnConfirScada_Click(object sender, EventArgs e)
        {
            if (gesChkScada.Checked)
            {
                OperacionBotonEquipoWinScada(TipoOperacionInWinScada.CARGA_PUNTOS, true);
            }
            else
            {
                OperacionBotonEquipoWinScada(TipoOperacionInWinScada.DESCARGA_PUNTOS, false);
            }
        }


        protected void OperacionBotonEquipoWinScada(TipoOperacionInWinScada operacionToWinScada, bool inScadaFinalmente)
        //inScadaFinalmente: Vendra en True si: La operacion que se desea es activación en el Scada.
        //inScadaFinalmente: vendra en False si: La operación que se desea es descativacion en el Scada.
        {
            string txtResultadoProceso;
            string serialFwt = _serialConcentrador;
            byte sectorIdentificador;
            int idSix;

            if (byte.TryParse(gesLblIdentificador.Text, out sectorIdentificador) && int.TryParse(_idEquipo, out idSix))
            {
                if (RealizarOperacionCompletaCambioFuncionScada(serialFwt, sectorIdentificador, operacionToWinScada, out txtResultadoProceso))
                {
                    if (!AccesoDatosEF.UpdateEnScadaFCI(idSix, inScadaFinalmente))
                    {
                        txtResultadoProceso = txtResultadoProceso + " " + (string)this.GetLocalResourceObject("TextRealizarOpScadaErrBD"); //"Error al actualizar indicador Scada en B.D del dispositivo.";
                        gesChkScada.Checked = inScadaFinalmente;
                        gesChkValEnScada.Checked = !inScadaFinalmente;
                    }
                    else
                    {
                        gesChkScada.Checked = inScadaFinalmente;
                        gesChkValEnScada.Checked = inScadaFinalmente;
                    }
                }
                else
                {
                    gesChkScada.Checked = !inScadaFinalmente;
                    gesChkValEnScada.Checked = !inScadaFinalmente;
                }
                gesLblTextoMensajeScada.Text = txtResultadoProceso;
            }
            _DefinirEstadoBotonScada(gesChkValEnScada.Checked, gesChkScada.Checked);
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
                                if (EjecutarOperacionCambioFuncionScada(conectorMsg, serialEquipo, subSector, tipoCmd, out txtFromWinScada, (byte)_canalIECConcentrador))
                                {
                                    txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaOk"); //"Operación Exitosa.";
                                    exito = true;
                                }
                                else
                                {
                                    txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaWinScadaNoK") + " : " + txtFromWinScada;
                                }
                            }
                            catch (EnvioMensajeException)
                            {
                                txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaErrMQSrvOp"); //"Error interno del servicio Messaging al enviar solicitud de operación al WinScada.";
                            }
                            catch (InicioRecepcionException)
                            {
                                txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaWinScadaNotAvailable"); //"El servicio WinScada no está disponible al enviar solicitud de operación.";
                            }
                        }
                        else
                        {
                            txtSalida = txtRespuesta;
                        }
                    }
                    catch (EnvioMensajeException)
                    {
                        txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaErrMQVerifyWinScada"); //"Error interno del servicio Messaging al verificar servicio WinScada.";
                    }
                    catch (InicioRecepcionException)
                    {
                        txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaWinScadaNotAvail"); //"El servicio WinScada no está disponible.";
                    }
                }
                else
                {
                    txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaErrColas"); //"Error al recuperar los nombres de las colas de comunicacion.";
                }
            }
            catch (FormatoPathColaException)
            {
                txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaErrNombresColas"); //"Error en el formato de los nombres de las colas de comunicacion.";
            }
            catch (CreacionColaException)
            {
                txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaCreandoColas"); //"Error al crear colas de comunicacion.";
            }
            catch (MessageQueueException)
            {
                txtSalida = (string)this.GetLocalResourceObject("TextRealizarOpScadaErrorInternoMQSrv"); //"Error interno en el servicio Messaging Queue.";
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

        protected void gesDDLConcentradores_DataBound(object sender, EventArgs e)
        {
            if (_serialConcentrador == null)
            {
                gesDDLConcentradores.Items.Insert(0, new ListItem("", ""));
                gesDDLConcentradores.SelectedValue = "";
            }
        }

        





    } //end of page
}