using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;
using SGR.BussinessLayer;
using System.Messaging;

namespace SistemaGestionRedes
{
    public partial class EditARIX : System.Web.UI.Page
    {
        private MessageQueue mqWebToSGR;
        private MessageQueue mqSGRToWeb;
        public int numeroDisparos = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string strId = Request.QueryString["Id"];
                lblId.Text = strId;
                LlenarValoresARIX(int.Parse(strId));
                //_fwtIsConnected = AccesoDatosEF.ExisteConexionFWT(lblTxtSerialFWT.Text);
                ActivarBotones();
                //LlenarComboFechasHistoricasParametros(int.Parse(strId));
                ControlarAutorizacionControles();
            }
        }

        #region paramsArix

        private void LlenarValoresARIX(int Id)
        {
            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {
                var arix = db.ARIXs.FirstOrDefault(x => x.Id == Id);
                if (arix.FWTId != null)
                {
                    serialARIX.Text = arix.Serial;
                    serialFWT.Text = db.FWTs.FirstOrDefault(x => x.Id == arix.FWTId).Serial;
                    numeroDisparos = arix.ARIX_Disparos.Count;
                    var paramArix = arix.ParamARIX;
                    var disparo1Arix = arix.ARIX_Disparos.ToList()[0];
                    var disparo2Arix = arix.ARIX_Disparos.ToList()[1];
                    var disparo3Arix = arix.ARIX_Disparos.ToList()[2];
                    var disparo4Arix = arix.ARIX_Disparos.ToList()[3];
                    var disparo5Arix = arix.ARIX_Disparos.ToList()[4];
                    var disparo6Arix = arix.ARIX_Disparos.Count == 6 ? arix.ARIX_Disparos.ToList()[5] : null;

                    ///DATOS ARIX FALTA IMPLEMENTAR

                    ///OPERACIÓN GENERAL

                    ObtenerValorSelect(paramArix.modoOperacion.ToString(), listBoxModoOperacion);
                    txtOpGeneral_porcentajeHisteresis.Text = paramArix.porcentajeHisteresisDisparo.ToString();
                    txtOpGeneral_ciclosVerifResetDismCorrFalla.Text =
                        paramArix.ciclosVerifResetDismCorrFalla.ToString();
                    ObtenerValorSelect(paramArix.fciaOperacion ? "1" : "0", listBoxFrecOperacion);
                    chkBoxOpGeneral_habilitarInrush.Checked = paramArix.habilitarFuncionalidadInrush;
                    ObtenerValorSelect(paramArix.modoOperacionAlFinalVidaUtil.ToString(),
                        listBoxmodOperacionFinVidaUtil);
                    ObtenerValorSelect(paramArix.tipoFuncionalidadInrush ? "1" : "0", listBoxmodoInrush);
                    txtOpGeneral_corrInrush.Text = paramArix.corrInrush.ToString();
                    txtOpGeneral_porcentaje2doArmonicoInrush.Text = paramArix.porcentaje2DoArmonicoInrush.ToString();
                    txtOpGeneral_tiempoDeValidacionInrush.Text = paramArix.tiempoDeValidacionInrush.ToString();
                    txtOpGeneral_tiempoSostenimientoInrush.Text = paramArix.tiempoSostenimientoInrush.ToString();

                    ///OPERACIÓN RECONECTADOR
                    const int MIL = 1000;
                    txtOpReconectador_numRecierres.Text = paramArix.numRecierres.ToString();
                    txtOpReconectador_corrMaxAbsolutas.Text = paramArix.corrMaxAbsoluta.ToString();
                    txtOpReconectador_tiempoDefDisparoCorrMaxAbs.Text = paramArix.tiempoDefDisparoCorrMaxAbs.ToString();
                    txtOpReconectador_resetTimeAfterLockout.Text = (paramArix.resetTimeAfterLockout/MIL).ToString();
                    txtOpReconectador_resetTimeLockout.Text = (paramArix.resetTimeLockout/MIL).ToString();
                    txtOpReconectador_corrMaxCapacidadRIX.Text = paramArix.corrMaxCapacidadRIX.ToString();

                    /// DISPAROS
                    /// DISPARO1
                    ObtenerValorSelect(disparo1Arix.TipoOperacion.ToString(), listBoxDisparo1_tipoOperacion);
                    ObtenerValorSelect(disparo1Arix.TipoReset.ToString(), listBoxDisparo1_tipoReset);
                    checkDisparo1_habilitaModificadores.Checked = (bool)disparo1Arix.HabilitaModificadores;
                    txtDisparo1_corrArranque.Text = disparo1Arix.CorrArranque.ToString();
                    txtDisparo1_modCorrMaxActuacion.Text = disparo1Arix.ModCorrMaxActuacion.ToString();
                    txtDisparo1_modTd.Text = disparo1Arix.ModTd.ToString();
                    txtDisparo1_tiempoDisparoDefinido.Text = disparo1Arix.TiempoDisparoDefinido.ToString();
                    txtDisparo1_tiempoResetCiclo.Text = disparo1Arix.TiempoResetCiclo.ToString();
                    txtDisparo1_tiempoApertura.Text = disparo1Arix.TiempoApertura.ToString();
                    txtDisparo1_modTiempoMaxRespuesta.Text = disparo1Arix.ModTiempoMaxRespuesta.ToString();
                    txtDisparo1_modTiempoMinRespuesta.Text = disparo1Arix.ModTiempoMinRespuesta.ToString();
                    txtDisparo1_modTiempoDefIMaxAct.Text = disparo1Arix.ModTiempoDefIMaxAct.ToString();
                    txtDisparo1_modRetardoAdicional.Text = disparo1Arix.ModRetardoAdicional.ToString();

                    /// DISPARO2

                    ObtenerValorSelect(disparo2Arix.TipoOperacion.ToString(), listBoxDisparo2_tipoOperacion);
                    ObtenerValorSelect(disparo2Arix.TipoReset.ToString(), listBoxDisparo2_tipoReset);
                    checkDisparo2_habilitaModificadores.Checked = (bool)disparo2Arix.HabilitaModificadores;
                    txtDisparo2_corrArranque.Text = disparo2Arix.CorrArranque.ToString();
                    txtDisparo2_modCorrMaxActuacion.Text = disparo2Arix.ModCorrMaxActuacion.ToString();
                    txtDisparo2_modTd.Text = disparo2Arix.ModTd.ToString();
                    txtDisparo2_tiempoDisparoDefinido.Text = disparo2Arix.TiempoDisparoDefinido.ToString();
                    txtDisparo2_tiempoResetCiclo.Text = disparo2Arix.TiempoResetCiclo.ToString();
                    txtDisparo2_tiempoApertura.Text = disparo2Arix.TiempoApertura.ToString();
                    txtDisparo2_modTiempoMaxRespuesta.Text = disparo2Arix.ModTiempoMaxRespuesta.ToString();
                    txtDisparo2_modTiempoMinRespuesta.Text = disparo2Arix.ModTiempoMinRespuesta.ToString();
                    txtDisparo2_modTiempoDefIMaxAct.Text = disparo2Arix.ModTiempoDefIMaxAct.ToString();
                    txtDisparo2_modRetardoAdicional.Text = disparo2Arix.ModRetardoAdicional.ToString();

                    /// DISPARO3

                    ObtenerValorSelect(disparo3Arix.TipoOperacion.ToString(), listBoxDisparo3_tipoOperacion);
                    ObtenerValorSelect(disparo3Arix.TipoReset.ToString(), listBoxDisparo3_tipoReset);
                    checkDisparo3_habilitaModificadores.Checked = (bool)disparo3Arix.HabilitaModificadores;
                    txtDisparo3_corrArranque.Text = disparo3Arix.CorrArranque.ToString();
                    txtDisparo3_modCorrMaxActuacion.Text = disparo3Arix.ModCorrMaxActuacion.ToString();
                    txtDisparo3_modTd.Text = disparo3Arix.ModTd.ToString();
                    txtDisparo3_tiempoDisparoDefinido.Text = disparo3Arix.TiempoDisparoDefinido.ToString();
                    txtDisparo3_tiempoResetCiclo.Text = disparo3Arix.TiempoResetCiclo.ToString();
                    txtDisparo3_tiempoApertura.Text = disparo3Arix.TiempoApertura.ToString();
                    txtDisparo3_modTiempoMaxRespuesta.Text = disparo3Arix.ModTiempoMaxRespuesta.ToString();
                    txtDisparo3_modTiempoMinRespuesta.Text = disparo3Arix.ModTiempoMinRespuesta.ToString();
                    txtDisparo3_modTiempoDefIMaxAct.Text = disparo3Arix.ModTiempoDefIMaxAct.ToString();
                    txtDisparo3_modRetardoAdicional.Text = disparo3Arix.ModRetardoAdicional.ToString();

                    /// DISPARO4

                    ObtenerValorSelect(disparo4Arix.TipoOperacion.ToString(), listBoxDisparo4_tipoOperacion);
                    ObtenerValorSelect(disparo4Arix.TipoReset.ToString(), listBoxDisparo4_tipoReset);
                    checkDisparo4_habilitaModificadores.Checked = (bool)disparo4Arix.HabilitaModificadores;
                    txtDisparo4_corrArranque.Text = disparo4Arix.CorrArranque.ToString();
                    txtDisparo4_modCorrMaxActuacion.Text = disparo4Arix.ModCorrMaxActuacion.ToString();
                    txtDisparo4_modTd.Text = disparo4Arix.ModTd.ToString();
                    txtDisparo4_tiempoDisparoDefinido.Text = disparo4Arix.TiempoDisparoDefinido.ToString();
                    txtDisparo4_tiempoResetCiclo.Text = disparo4Arix.TiempoResetCiclo.ToString();
                    txtDisparo4_tiempoApertura.Text = disparo4Arix.TiempoApertura.ToString();
                    txtDisparo4_modTiempoMaxRespuesta.Text = disparo4Arix.ModTiempoMaxRespuesta.ToString();
                    txtDisparo4_modTiempoMinRespuesta.Text = disparo4Arix.ModTiempoMinRespuesta.ToString();
                    txtDisparo4_modTiempoDefIMaxAct.Text = disparo4Arix.ModTiempoDefIMaxAct.ToString();
                    txtDisparo4_modRetardoAdicional.Text = disparo4Arix.ModRetardoAdicional.ToString();

                    /// DISPARO5

                    ObtenerValorSelect(disparo5Arix.TipoOperacion.ToString(), listBoxDisparo5_tipoOperacion);
                    ObtenerValorSelect(disparo5Arix.TipoReset.ToString(), listBoxDisparo5_tipoReset);
                    checkDisparo5_habilitaModificadores.Checked = (bool)disparo5Arix.HabilitaModificadores;
                    txtDisparo5_corrArranque.Text = disparo5Arix.CorrArranque.ToString();
                    txtDisparo5_modCorrMaxActuacion.Text = disparo5Arix.ModCorrMaxActuacion.ToString();
                    txtDisparo5_modTd.Text = disparo5Arix.ModTd.ToString();
                    txtDisparo5_tiempoDisparoDefinido.Text = disparo5Arix.TiempoDisparoDefinido.ToString();
                    txtDisparo5_tiempoResetCiclo.Text = disparo5Arix.TiempoResetCiclo.ToString();
                    txtDisparo5_tiempoApertura.Text = disparo5Arix.TiempoApertura.ToString();
                    txtDisparo5_modTiempoMaxRespuesta.Text = disparo5Arix.ModTiempoMaxRespuesta.ToString();
                    txtDisparo5_modTiempoMinRespuesta.Text = disparo5Arix.ModTiempoMinRespuesta.ToString();
                    txtDisparo5_modTiempoDefIMaxAct.Text = disparo5Arix.ModTiempoDefIMaxAct.ToString();
                    txtDisparo5_modRetardoAdicional.Text = disparo5Arix.ModRetardoAdicional.ToString();

                    /// DISPARO6
                    
                    if(disparo6Arix != null)
                    {
                        ObtenerValorSelect(disparo6Arix.TipoOperacion.ToString(), listBoxDisparo6_tipoOperacion);
                        ObtenerValorSelect(disparo6Arix.TipoReset.ToString(), listBoxDisparo6_tipoReset);
                        checkDisparo6_habilitaModificadores.Checked = (bool)disparo6Arix.HabilitaModificadores;
                        txtDisparo6_corrArranque.Text = disparo6Arix.CorrArranque.ToString();
                        txtDisparo6_modCorrMaxActuacion.Text = disparo6Arix.ModCorrMaxActuacion.ToString();
                        txtDisparo6_modTd.Text = disparo6Arix.ModTd.ToString();
                        txtDisparo6_tiempoDisparoDefinido.Text = disparo6Arix.TiempoDisparoDefinido.ToString();
                        txtDisparo6_tiempoResetCiclo.Text = disparo6Arix.TiempoResetCiclo.ToString();
                        txtDisparo6_tiempoApertura.Text = disparo6Arix.TiempoApertura.ToString();
                        txtDisparo6_modTiempoMaxRespuesta.Text = disparo6Arix.ModTiempoMaxRespuesta.ToString();
                        txtDisparo6_modTiempoMinRespuesta.Text = disparo6Arix.ModTiempoMinRespuesta.ToString();
                        txtDisparo6_modTiempoDefIMaxAct.Text = disparo6Arix.ModTiempoDefIMaxAct.ToString();
                        txtDisparo6_modRetardoAdicional.Text = disparo6Arix.ModRetardoAdicional.ToString();
                    }

                    ///HARDWARE

                    txtHardware_adcCargaLOWCapacitorDisparo.Text = paramArix.adcCargaLOWCapacitorDisparo.ToString();
                    txtHardware_adcCargaOKCapacitorDisparo.Text = paramArix.adcCargaOKCapacitorDisparo.ToString();
                    txtHardware_adcCargaLOWFuenteBaja.Text = paramArix.adcCargaLOWFuenteBaja.ToString();
                    txtHardware_adcCargaOKFuenteBaja.Text = paramArix.adcCargaOKFuenteBaja.ToString();
                    txtHardware_numOperacionesBotellaCercanoAlMax.Text =
                        paramArix.numOperacionesBotellaCercanoAlMax.ToString();
                    txtHardware_numOperacionesBotellaLlegaAlMax.Text =
                        paramArix.numOperacionesBotellaLlegaAlMax.ToString();
                    txtHardware_porcentDesgasteBotellaCercanoAlMax.Text =
                        paramArix.porcentDesgasteBotellaCercanoAlMax.ToString();
                    txtHardware_porcentDesgasteBotellaLlegaAlMax.Text =
                        paramArix.porcentDesgasteBotellaLlegaAlMax.ToString();
                    txtHardware_adcCorrMinParaAutoalimentacion50Hz.Text =
                        paramArix.adcCorrMinParaAutoalimentacion50Hz.ToString();
                    txtHardware_adcCorrMinParaAutoalimentacion60Hz.Text =
                        paramArix.adcCorrMinParaAutoalimentacion60Hz.ToString();

                    /// COMUNICACIONES

                    txtComunicacion_canalComunicacionRF.Text = paramArix.canalComunicacionRF.ToString();
                    txtComunicacion_codigoDeGrupo.Text = paramArix.codigoDelGrupo.ToString();
                    txtComunicacion_canalRfEnMHz.Text = paramArix.canalRfEnMHz.ToString();

                }
            }
        }

        private void ObtenerValorSelect(string valor, ListBox label)
        {
            foreach (ListItem item in label.Items)
            {
                if (item.Value == valor)
                {
                    item.Selected = true;
                    break;
                }
            }
        }

        protected void butActualizarParams_Click(object sender, EventArgs e)
        {
            this.ActualizarParametrosArix(false);
        }

        private void ActualizarParametrosArix(bool isOnline = false)
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('error','mensaje de error');", true);
            // validar campos antes de actualizar... 
            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {
                /// EL id esta en cero ... OJO o esta estatico....
                int id = int.Parse(lblId.Text);
                var arix = db.ARIXs.FirstOrDefault(x => x.Id == id);
                if (arix.FWTId != null)
                {
                    bool hayCambiosOpGeneral = HayModificacionOperacionGeneral(arix);
                    bool hayCambiosOpReconectador = HayModificacionOperacionReconectador(arix);
                    bool hayCambiosHardware = HayModificacionHardware(arix);
                    bool hayCambiosComunicaciones = HayModificacionComunicaciones(arix);
                    bool hayCambiosDisparo1 = HayModificacionDisparo1(arix);
                    bool hayCambiosDisparo2 = HayModificacionDisparo2(arix);
                    bool hayCambiosDisparo3 = HayModificacionDisparo3(arix);
                    bool hayCambiosDisparo4 = HayModificacionDisparo4(arix);
                    bool hayCambiosDisparo5 = HayModificacionDisparo5(arix);
                    bool hayCambiosDisparo6 = HayModificacionDisparo6(arix);

                    bool datosEnRangoOpGeneral = validarRangoOperacionGeneral();
                    if (!datosEnRangoOpGeneral)
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('warning','Revisar campos', 'Parámetros de OPERACIÓN GENERAL');", true);
                    //Response.Write("<script>alert('Revisar los rangos en parámetros de operación general')</script>");

                    bool datosEnRangoOpReconectador = validarRangoOperacionReconectador();
                    if (!datosEnRangoOpReconectador)
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('warning','Revisar campos', 'Parámetros de OPERACIÓN RECONECTADOR');", true);
                    //Response.Write("<script>alert('Revisar los rangos en parámetros de operación reconectador')</script>");

                    bool datosEnRangoDisparo1 = validarRangoDisparo(1);
                    if (!datosEnRangoDisparo1)
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('warning','Revisar campos', 'Parámetros de DISPARO 1');", true);
                    //Response.Write("<script>alert('Revisar los rangos en parámetros de disparo 1')</script>");

                    bool datosEnRangoDisparo2 = validarRangoDisparo(2);
                    if (!datosEnRangoDisparo2)
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('warning','Revisar campos', 'Parámetros de DISPARO 2');", true);
                    //Response.Write("<script>alert('Revisar los rangos en parámetros de disparo 2')</script>");

                    bool datosEnRangoDisparo3 = validarRangoDisparo(3);
                    if (!datosEnRangoDisparo3)
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('warning','Revisar campos', 'Parámetros de DISPARO 3');", true);
                    //Response.Write("<script>alert('Revisar los rangos en parámetros de disparo 3')</script>");

                    bool datosEnRangoDisparo4 = validarRangoDisparo(4);
                    if (!datosEnRangoDisparo4)
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('warning','Revisar campos', 'Parámetros de DISPARO 4');", true);
                    //Response.Write("<script>alert('Revisar los rangos en parámetros de disparo 4')</script>");

                    bool datosEnRangoDisparo5 = validarRangoDisparo(5);
                    if (!datosEnRangoDisparo5)
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('warning','Revisar campos', 'Parámetros de DISPARO 5');", true);
                    //Response.Write("<script>alert('Revisar los rangos en parámetros de disparo 5')</script>");

                    bool datosEnRangoDisparo6 = true;
                    if (hayCambiosDisparo6)
                    {
                        datosEnRangoDisparo6 = validarRangoDisparo(6);
                        if (!datosEnRangoDisparo6)
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('warning','Revisar campos', 'Parámetros de DISPARO 6');", true);
                    }                    

                    bool datosEnRangoHardware = validarRangoHardware();
                    if (!datosEnRangoHardware)
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('warning','Revisar campos', 'Parámetros de HARDWARE');", true);
                    //Response.Write("<script>alert('Revisar los rangos en parámetros del hardware')</script>");

                    bool datosEnRangoComunicacion = validarRangoComunicacion();
                    if (!datosEnRangoComunicacion)
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('warning','Revisar campos', 'Parámetros de COMUNICACIÓN');", true);
                    //Response.Write("<script>alert('Revisar los rangos en parámetros de comunicación')</script>");

                    if (hayCambiosOpGeneral || hayCambiosOpReconectador || hayCambiosHardware ||
                        hayCambiosComunicaciones || hayCambiosDisparo1 || hayCambiosDisparo2 ||
                        hayCambiosDisparo3 || hayCambiosDisparo4 || hayCambiosDisparo5 || hayCambiosDisparo6
                        )
                    {
                        if (datosEnRangoDisparo5 && datosEnRangoDisparo4 && datosEnRangoDisparo3 && datosEnRangoDisparo2 && datosEnRangoDisparo1
                        && datosEnRangoComunicacion && datosEnRangoHardware && datosEnRangoOpReconectador && datosEnRangoOpGeneral)
                        {
                            if (hayCambiosOpGeneral)
                            {
                                arix = ModificarOperacionGeneral(arix);
                            }
                            if (hayCambiosOpReconectador)
                            {
                                const int MIL = 1000;
                                arix = ModificarOperacionReconectador(arix);
                                //arix.ParamARIX.resetTimeAfterLockout = int.Parse(txtOpReconectador_resetTimeAfterLockout.Text) * MIL;
                                //arix.ParamARIX.resetTimeLockout = (short)(arix.ParamARIX.resetTimeLockout * 1000);
                            }
                            if (hayCambiosHardware)
                            {
                                arix = ModificarHardware(arix);
                            }
                            if (hayCambiosComunicaciones)
                            {
                                arix = ModificarComunicaciones(arix);
                            }
                            if (hayCambiosDisparo1)
                            {
                                arix = ModificarDisparo1(arix);
                            }
                            if (hayCambiosDisparo2)
                            {
                                arix = ModificarDisparo2(arix);
                            }
                            if (hayCambiosDisparo3)
                            {
                                arix = ModificarDisparo3(arix);
                            }
                            if (hayCambiosDisparo4)
                            {
                                arix = ModificarDisparo4(arix);
                            }
                            if (hayCambiosDisparo5)
                            {
                                arix = ModificarDisparo5(arix);
                            }
                            if (hayCambiosDisparo6)
                            {
                                arix = ModificarDisparo6(arix);
                            }
                            if (isOnline)
                            {
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('success','Los parámetros en el ARIX han sido actualizados', 'Guardando cambios');", true);
                            }
                            else
                            {
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('success','Los parámetros en el ARIX se actualizarán en el próximo reporte periódico', 'Guardando cambios');", true);
                            }                            
                            //Response.Write("<script>alert('Hay cambios por subir')</script>");
                            arix.PendienteEnviarParametros = true;
                            arix.PendienteConfirmarActualizacionParametros = false;
                        }
                        db.SaveChanges();
                        ViewState["ActualizadoOffline"] = true;
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showContent('error','No se realizaron cambios en los parámetros', 'No hubieron cambios');", true);
                        //Response.Write("<script>alert('Sin cambios')</script>");
                    }
                }
            }
        }

        private bool validarRangoOperacionGeneral()
        {
            bool respuesta = true;

            int porHisteresis = int.Parse(txtOpGeneral_porcentajeHisteresis.Text);
            const int minPorHisteresis = 10;
            const int maxPorHisteresis = 90;

            if (porHisteresis < minPorHisteresis || porHisteresis > maxPorHisteresis) respuesta = false;

            int ciclosVerif = int.Parse(txtOpGeneral_ciclosVerifResetDismCorrFalla.Text);
            const int minpCiclosVerif = 1;
            const int maxCiclosVerif = 10;

            if (ciclosVerif < minpCiclosVerif || ciclosVerif > maxCiclosVerif) respuesta = false;

            int corrInrush = int.Parse(txtOpGeneral_corrInrush.Text);
            const int minCorrInrush = 10;
            const int maxCorrInrush = 6500;

            if (corrInrush < minCorrInrush || corrInrush > maxCorrInrush) respuesta = false;

            int porcentaje2doArmonicoInrush = int.Parse(txtOpGeneral_porcentaje2doArmonicoInrush.Text);
            const int minPorcentaje2doArmonicoInrush = 10;
            const int maxPorcentaje2doArmonicoInrush = 20;

            if (porcentaje2doArmonicoInrush < minPorcentaje2doArmonicoInrush || porcentaje2doArmonicoInrush > maxPorcentaje2doArmonicoInrush) respuesta = false;

            int tiempoDeValidacionInrush = int.Parse(txtOpGeneral_tiempoDeValidacionInrush.Text);
            const int minTiempoDeValidacionInrush = 10;
            const int maxTtiempoDeValidacionInrush = 60000;

            if (tiempoDeValidacionInrush < minTiempoDeValidacionInrush || tiempoDeValidacionInrush > maxTtiempoDeValidacionInrush) respuesta = false;

            int tiempoSostenimientoInrush = int.Parse(txtOpGeneral_tiempoSostenimientoInrush.Text);
            const int minTiempoSostenimientoInrush = 10;
            const int maxTiempoSostenimientoInrush = 60000;

            if (tiempoSostenimientoInrush < minTiempoSostenimientoInrush || tiempoSostenimientoInrush > maxTiempoSostenimientoInrush) respuesta = false;

            return respuesta;
        }

        private bool validarRangoOperacionReconectador()
        {
            bool respuesta = true;

            int numRecierres = int.Parse(txtOpReconectador_numRecierres.Text);
            const int minNumRecierres = 1;
            const int maxNumRecierres = 4;

            if (numRecierres < minNumRecierres || numRecierres > maxNumRecierres) respuesta = false;

            int corrMaxAbsolutas = int.Parse(txtOpReconectador_corrMaxAbsolutas.Text);
            const int minCorrMaxAbsolutas = 10;
            const int maxCorrMaxAbsolutas = 6500;

            if (corrMaxAbsolutas < minCorrMaxAbsolutas || corrMaxAbsolutas > maxCorrMaxAbsolutas) respuesta = false;

            int tiempoDefDisparoCorrMaxAbs = int.Parse(txtOpReconectador_tiempoDefDisparoCorrMaxAbs.Text);
            const int minTiempoDefDisparoCorrMaxAbs = 20;
            const int maxTiempoDefDisparoCorrMaxAbs = 10000;

            if (tiempoDefDisparoCorrMaxAbs < minTiempoDefDisparoCorrMaxAbs || tiempoDefDisparoCorrMaxAbs > maxTiempoDefDisparoCorrMaxAbs) respuesta = false;

            //int resetTimeAfterLockout = int.Parse(txtOpReconectador_resetTimeAfterLockout.Text);
            //const int minResetTimeAfterLockout = 1;
            //const int maxResetTimeAfterLockout = 120;

            //if (resetTimeAfterLockout < minResetTimeAfterLockout || resetTimeAfterLockout > maxResetTimeAfterLockout) respuesta = false;

            return respuesta;
        }

        private bool validarRangoHardware()
        {
            bool respuesta = true;

            double cargaLOWCapacitorDisparo = double.Parse(txtHardware_adcCargaLOWCapacitorDisparo.Text);
            const double minCargaLOWCapacitorDisparo = 40;
            const double maxCargaLOWCapacitorDisparo = 69;
            if (cargaLOWCapacitorDisparo < minCargaLOWCapacitorDisparo || cargaLOWCapacitorDisparo > maxCargaLOWCapacitorDisparo) respuesta = false;

            double cargaOKCapacitorDisparo = double.Parse(txtHardware_adcCargaOKCapacitorDisparo.Text);
            const double minCargaOKCapacitorDisparo = 70;
            const double maxCargaOKCapacitorDisparo = 80;
            if (cargaOKCapacitorDisparo < minCargaOKCapacitorDisparo || cargaOKCapacitorDisparo > maxCargaOKCapacitorDisparo) respuesta = false;

            double cargaLOWFuenteBaja = double.Parse(txtHardware_adcCargaLOWFuenteBaja.Text);
            const double minCargaLOWFuenteBaja = 1.8;
            const double maxCargaLOWFuenteBaja = 2.5;
            if (cargaLOWFuenteBaja < minCargaLOWFuenteBaja || cargaLOWFuenteBaja > maxCargaLOWFuenteBaja) respuesta = false;

            double cargaOKFuenteBaja = double.Parse(txtHardware_adcCargaOKFuenteBaja.Text);
            const double minCargaOKFuenteBaja = 4.5;
            const double maxCargaOKFuenteBaja = 5.1;
            if (cargaOKFuenteBaja < minCargaOKFuenteBaja || cargaOKFuenteBaja > maxCargaOKFuenteBaja) respuesta = false;

            int operacionesBotellaCercanoAlMax = int.Parse(txtHardware_numOperacionesBotellaCercanoAlMax.Text);
            const int minOperacionesBotellaCercanoAlMax = 1000;
            const int maxOperacionesBotellaCercanoAlMax = 8000;
            if (operacionesBotellaCercanoAlMax < minOperacionesBotellaCercanoAlMax || operacionesBotellaCercanoAlMax > maxOperacionesBotellaCercanoAlMax) respuesta = false;

            int operacionesBotellaLlegaAlMax = int.Parse(txtHardware_numOperacionesBotellaLlegaAlMax.Text);
            const int minOperacionesBotellaLlegaAlMax = 8001;
            const int maxOperacionesBotellaLlegaAlMax = 10000;
            if (operacionesBotellaLlegaAlMax < minOperacionesBotellaLlegaAlMax || operacionesBotellaLlegaAlMax > maxOperacionesBotellaLlegaAlMax) respuesta = false;

            int porcentDesgasteBotellaCercanoAlMax = int.Parse(txtHardware_porcentDesgasteBotellaCercanoAlMax.Text);
            const int minPorcentDesgasteBotellaCercanoAlMax = 50;
            const int maxPorcentDesgasteBotellaCercanoAlMax = 80;
            if (porcentDesgasteBotellaCercanoAlMax < minPorcentDesgasteBotellaCercanoAlMax || porcentDesgasteBotellaCercanoAlMax > maxPorcentDesgasteBotellaCercanoAlMax) respuesta = false;

            int porcentDesgasteBotellaLlegaAlMax = int.Parse(txtHardware_porcentDesgasteBotellaLlegaAlMax.Text);
            const int minPorcentDesgasteBotellaLlegaAlMax = 81;
            const int maxPorcentDesgasteBotellaLlegaAlMax = 100;
            if (porcentDesgasteBotellaLlegaAlMax < minPorcentDesgasteBotellaLlegaAlMax || porcentDesgasteBotellaLlegaAlMax > maxPorcentDesgasteBotellaLlegaAlMax) respuesta = false;

            int corrMinParaAutoalimentacion50Hz = int.Parse(txtHardware_adcCorrMinParaAutoalimentacion50Hz.Text);
            const int minCorrMinParaAutoalimentacion50Hz = 3;
            const int maxCorrMinParaAutoalimentacion50Hz = 100;
            if (corrMinParaAutoalimentacion50Hz < minCorrMinParaAutoalimentacion50Hz || corrMinParaAutoalimentacion50Hz > maxCorrMinParaAutoalimentacion50Hz) respuesta = false;

            int corrMinParaAutoalimentacion60Hz = int.Parse(txtHardware_adcCorrMinParaAutoalimentacion60Hz.Text);
            const int minCorrMinParaAutoalimentacion60Hz = 3;
            const int maxCorrMinParaAutoalimentacion60Hz = 100;
            if (corrMinParaAutoalimentacion60Hz < minCorrMinParaAutoalimentacion60Hz || corrMinParaAutoalimentacion60Hz > maxCorrMinParaAutoalimentacion60Hz) respuesta = false;

            return respuesta;
        }

        private bool validarRangoComunicacion()
        {
            bool respuesta = true;

            int canal = int.Parse(txtComunicacion_canalComunicacionRF.Text);
            const int minCanal = 0;
            const int maxCanal = 9;
            if (canal < minCanal || canal > maxCanal) respuesta = false;

            int grupo = int.Parse(txtComunicacion_codigoDeGrupo.Text);
            const int minGrupo = 0;
            const int maxGrupo = 9;
            if (grupo < minGrupo || grupo > maxGrupo) respuesta = false;

            return respuesta;
        }

        private bool validarRangoDisparo(int numeroDisparo)
        {
            bool respuesta = true;


            /*RANGOS*/

            const int minIArranque = 3;
            const int maxIArranque = 6500;
            const int minIMaxActu = 10;
            const int maxIMaxActu = 6500;
            const double minDial = 0.01;
            const double maxDial = 9;
            const int minTDispDef = 20;
            const int maxTDispDef = 10000;
            const int minTReset = 1;
            const int maxTReset = 300;
            const int minTMuerto = 500;
            const int maxTMuerto = 30000;
            const int minTMaxResp = 10;
            const int maxTMaxResp = 60000;
            const int minTMinResp = 20;
            const int maxTMinResp = 10000;
            const int minTDefIMax = 20;
            const int maxTDefIMax = 10000;
            const int minRetAdic = 0;
            const int maxRetAdic = 10000;

            /*DEFINICIONES*/
            int iArranque = 0, iMaxAct = 0, tiempoDisparoDefinido = 0, tiempoResetCiclo = 0,
                tiempoApertura = 0, modTiempoMaxRespuesta = 0, modTiempoMinRespuesta = 0,
                modTiempoDefIMaxAct = 0, modRetardoAdicional = 0;
            double modTd = 0;

            switch (numeroDisparo)
            {
                case (1):
                    iArranque = int.Parse(txtDisparo1_corrArranque.Text);
                    iMaxAct = int.Parse(txtDisparo1_modCorrMaxActuacion.Text);
                    modTd = double.Parse(txtDisparo1_modTd.Text);
                    tiempoDisparoDefinido = int.Parse(txtDisparo1_tiempoDisparoDefinido.Text);
                    tiempoResetCiclo = int.Parse(txtDisparo1_tiempoResetCiclo.Text);
                    tiempoApertura = int.Parse(txtDisparo1_tiempoApertura.Text);
                    modTiempoMaxRespuesta = int.Parse(txtDisparo1_modTiempoMaxRespuesta.Text);
                    modTiempoMinRespuesta = int.Parse(txtDisparo1_modTiempoMinRespuesta.Text);
                    modTiempoDefIMaxAct = int.Parse(txtDisparo1_modTiempoDefIMaxAct.Text);
                    modRetardoAdicional = int.Parse(txtDisparo1_modRetardoAdicional.Text);
                    break;
                case (2):
                    iArranque = int.Parse(txtDisparo2_corrArranque.Text);
                    iMaxAct = int.Parse(txtDisparo2_modCorrMaxActuacion.Text);
                    modTd = double.Parse(txtDisparo2_modTd.Text);
                    tiempoDisparoDefinido = int.Parse(txtDisparo2_tiempoDisparoDefinido.Text);
                    tiempoResetCiclo = int.Parse(txtDisparo2_tiempoResetCiclo.Text);
                    tiempoApertura = int.Parse(txtDisparo2_tiempoApertura.Text);
                    modTiempoMaxRespuesta = int.Parse(txtDisparo2_modTiempoMaxRespuesta.Text);
                    modTiempoMinRespuesta = int.Parse(txtDisparo2_modTiempoMinRespuesta.Text);
                    modTiempoDefIMaxAct = int.Parse(txtDisparo2_modTiempoDefIMaxAct.Text);
                    modRetardoAdicional = int.Parse(txtDisparo2_modRetardoAdicional.Text);
                    break;
                case (3):
                    iArranque = int.Parse(txtDisparo3_corrArranque.Text);
                    iMaxAct = int.Parse(txtDisparo3_modCorrMaxActuacion.Text);
                    modTd = double.Parse(txtDisparo3_modTd.Text);
                    tiempoDisparoDefinido = int.Parse(txtDisparo3_tiempoDisparoDefinido.Text);
                    tiempoResetCiclo = int.Parse(txtDisparo3_tiempoResetCiclo.Text);
                    tiempoApertura = int.Parse(txtDisparo3_tiempoApertura.Text);
                    modTiempoMaxRespuesta = int.Parse(txtDisparo3_modTiempoMaxRespuesta.Text);
                    modTiempoMinRespuesta = int.Parse(txtDisparo3_modTiempoMinRespuesta.Text);
                    modTiempoDefIMaxAct = int.Parse(txtDisparo3_modTiempoDefIMaxAct.Text);
                    modRetardoAdicional = int.Parse(txtDisparo3_modRetardoAdicional.Text);
                    break;
                case (4):
                    iArranque = int.Parse(txtDisparo4_corrArranque.Text);
                    iMaxAct = int.Parse(txtDisparo4_modCorrMaxActuacion.Text);
                    modTd = double.Parse(txtDisparo4_modTd.Text);
                    tiempoDisparoDefinido = int.Parse(txtDisparo4_tiempoDisparoDefinido.Text);
                    tiempoResetCiclo = int.Parse(txtDisparo4_tiempoResetCiclo.Text);
                    tiempoApertura = int.Parse(txtDisparo4_tiempoApertura.Text);
                    modTiempoMaxRespuesta = int.Parse(txtDisparo4_modTiempoMaxRespuesta.Text);
                    modTiempoMinRespuesta = int.Parse(txtDisparo4_modTiempoMinRespuesta.Text);
                    modTiempoDefIMaxAct = int.Parse(txtDisparo4_modTiempoDefIMaxAct.Text);
                    modRetardoAdicional = int.Parse(txtDisparo4_modRetardoAdicional.Text);
                    break;
                case (5):
                    iArranque = int.Parse(txtDisparo5_corrArranque.Text);
                    iMaxAct = int.Parse(txtDisparo5_modCorrMaxActuacion.Text);
                    modTd = double.Parse(txtDisparo5_modTd.Text);
                    tiempoDisparoDefinido = int.Parse(txtDisparo5_tiempoDisparoDefinido.Text);
                    tiempoResetCiclo = int.Parse(txtDisparo5_tiempoResetCiclo.Text);
                    tiempoApertura = int.Parse(txtDisparo5_tiempoApertura.Text);
                    modTiempoMaxRespuesta = int.Parse(txtDisparo5_modTiempoMaxRespuesta.Text);
                    modTiempoMinRespuesta = int.Parse(txtDisparo5_modTiempoMinRespuesta.Text);
                    modTiempoDefIMaxAct = int.Parse(txtDisparo5_modTiempoDefIMaxAct.Text);
                    modRetardoAdicional = int.Parse(txtDisparo5_modRetardoAdicional.Text);
                    break;
                case (6):
                    iArranque = int.Parse(txtDisparo6_corrArranque.Text);
                    iMaxAct = int.Parse(txtDisparo6_modCorrMaxActuacion.Text);
                    modTd = double.Parse(txtDisparo6_modTd.Text);
                    tiempoDisparoDefinido = int.Parse(txtDisparo6_tiempoDisparoDefinido.Text);
                    tiempoResetCiclo = int.Parse(txtDisparo6_tiempoResetCiclo.Text);
                    tiempoApertura = int.Parse(txtDisparo6_tiempoApertura.Text);
                    modTiempoMaxRespuesta = int.Parse(txtDisparo6_modTiempoMaxRespuesta.Text);
                    modTiempoMinRespuesta = int.Parse(txtDisparo6_modTiempoMinRespuesta.Text);
                    modTiempoDefIMaxAct = int.Parse(txtDisparo6_modTiempoDefIMaxAct.Text);
                    modRetardoAdicional = int.Parse(txtDisparo6_modRetardoAdicional.Text);
                    break;
            }

            if (iArranque < minIArranque || iArranque > maxIArranque) respuesta = false;
            if (iMaxAct < minIMaxActu || iMaxAct > maxIMaxActu) respuesta = false;
            if (modTd < minDial || modTd > maxDial) respuesta = false;
            if (tiempoDisparoDefinido < minTDispDef || tiempoDisparoDefinido > maxTDispDef) respuesta = false;
            if (tiempoResetCiclo < minTReset || tiempoResetCiclo > maxTReset) respuesta = false;
            if (tiempoApertura < minTMuerto || tiempoApertura > maxTMuerto) respuesta = false;
            if (modTiempoMaxRespuesta < minTMaxResp || modTiempoMaxRespuesta > maxTMaxResp) respuesta = false;
            if (modTiempoMinRespuesta < minTMinResp || modTiempoMinRespuesta > maxTMinResp) respuesta = false;
            if (modTiempoDefIMaxAct < minTDefIMax || modTiempoDefIMaxAct > maxTDefIMax) respuesta = false;
            if (modRetardoAdicional < minRetAdic || modRetardoAdicional > maxRetAdic) respuesta = false;

            return respuesta;
        }

        private bool HayModificacionOperacionGeneral(ARIX arix)
        {
            bool respuesta = false;
            int contador = 0;

            var paramArix = arix.ParamARIX;

            if (listBoxModoOperacion.GetSelectedIndices()[0] != paramArix.modoOperacion) contador++;
            if (txtOpGeneral_porcentajeHisteresis.Text != paramArix.porcentajeHisteresisDisparo.ToString()) contador++;
            if (txtOpGeneral_ciclosVerifResetDismCorrFalla.Text != paramArix.ciclosVerifResetDismCorrFalla.ToString()) contador++;
            int frecOperacion = paramArix.fciaOperacion ? 1 : 0;
            if (listBoxFrecOperacion.GetSelectedIndices()[0] != frecOperacion) contador++;
            if (chkBoxOpGeneral_habilitarInrush.Checked != paramArix.habilitarFuncionalidadInrush) contador++;
            if (listBoxmodOperacionFinVidaUtil.GetSelectedIndices()[0] != paramArix.modoOperacionAlFinalVidaUtil) contador++;
            if (listBoxmodoInrush.GetSelectedIndices()[0] != (paramArix.tipoFuncionalidadInrush ? 1 : 0)) contador++;
            if (txtOpGeneral_corrInrush.Text != paramArix.corrInrush.ToString()) contador++;
            if (txtOpGeneral_porcentaje2doArmonicoInrush.Text != paramArix.porcentaje2DoArmonicoInrush.ToString()) contador++;
            if (txtOpGeneral_tiempoDeValidacionInrush.Text != paramArix.tiempoDeValidacionInrush.ToString()) contador++;
            if (txtOpGeneral_tiempoSostenimientoInrush.Text != paramArix.tiempoSostenimientoInrush.ToString()) contador++;

            //txtOpGeneral_ciclosVerifResetDismCorrFalla.Text = paramArix.ciclosVerifResetDismCorrFalla.ToString();

            if (contador > 0)
            {
                respuesta = true;

            }
            return respuesta;
        }

        private bool HayModificacionOperacionReconectador(ARIX arix)
        {
            bool respuesta = false;
            int contador = 0;
            const int MIL = 1000;

            var paramArix = arix.ParamARIX;

            if (txtOpReconectador_numRecierres.Text != paramArix.numRecierres.ToString()) contador++;
            if (txtOpReconectador_corrMaxAbsolutas.Text != paramArix.corrMaxAbsoluta.ToString()) contador++;
            if (txtOpReconectador_tiempoDefDisparoCorrMaxAbs.Text != paramArix.tiempoDefDisparoCorrMaxAbs.ToString()) contador++;
            //if (txtOpReconectador_resetTimeAfterLockout.Text != (paramArix.resetTimeAfterLockout / MIL).ToString()) contador++;
            //if (txtOpReconectador_resetTimeLockout.Text != paramArix.resetTimeLockout.ToString()) contador++;
            //if (txtOpReconectador_corrMaxCapacidadRIX.Text != paramArix.corrMaxCapacidadRIX.ToString()) contador++;

            txtOpReconectador_resetTimeLockout.Text = (paramArix.resetTimeLockout / MIL).ToString();
            txtOpReconectador_corrMaxCapacidadRIX.Text = paramArix.corrMaxCapacidadRIX.ToString();

            if (contador > 0)
            {
                respuesta = true;

            }
            return respuesta;
        }

        private bool HayModificacionHardware(ARIX arix)
        {
            bool respuesta = false;
            int contador = 0;

            var paramArix = arix.ParamARIX;

            if (txtHardware_adcCargaLOWCapacitorDisparo.Text != paramArix.adcCargaLOWCapacitorDisparo.ToString()) contador++;
            if (txtHardware_adcCargaOKCapacitorDisparo.Text != paramArix.adcCargaOKCapacitorDisparo.ToString()) contador++;
            if (txtHardware_adcCargaLOWFuenteBaja.Text != paramArix.adcCargaLOWFuenteBaja.ToString()) contador++;
            if (txtHardware_adcCargaOKFuenteBaja.Text != paramArix.adcCargaOKFuenteBaja.ToString()) contador++;
            if (txtHardware_numOperacionesBotellaCercanoAlMax.Text !=
                paramArix.numOperacionesBotellaCercanoAlMax.ToString()) contador++;
            if (txtHardware_numOperacionesBotellaLlegaAlMax.Text !=
                paramArix.numOperacionesBotellaLlegaAlMax.ToString()) contador++;
            if (txtHardware_porcentDesgasteBotellaCercanoAlMax.Text !=
                paramArix.porcentDesgasteBotellaCercanoAlMax.ToString()) contador++;
            if (txtHardware_porcentDesgasteBotellaLlegaAlMax.Text !=
                paramArix.porcentDesgasteBotellaLlegaAlMax.ToString()) contador++;
            if (txtHardware_adcCorrMinParaAutoalimentacion50Hz.Text !=
                paramArix.adcCorrMinParaAutoalimentacion50Hz.ToString()) contador++;
            if (txtHardware_adcCorrMinParaAutoalimentacion60Hz.Text !=
                paramArix.adcCorrMinParaAutoalimentacion60Hz.ToString()) contador++;

            if (contador > 0)
            {
                respuesta = true;

            }
            return respuesta;
        }

        private bool HayModificacionComunicaciones(ARIX arix)
        {
            bool respuesta = false;
            int contador = 0;

            var paramArix = arix.ParamARIX;

            if (txtComunicacion_canalComunicacionRF.Text != paramArix.canalComunicacionRF.ToString()) contador++;
            if (txtComunicacion_codigoDeGrupo.Text != paramArix.codigoDelGrupo.ToString()) contador++;
            //if (txtComunicacion_canalRfEnMHz.Text != paramArix.canalRfEnMHz.ToString()) contador++;

            if (contador > 0)
            {
                respuesta = true;

            }
            return respuesta;
        }

        private bool HayModificacionDisparo1(ARIX arix)
        {
            bool respuesta = false;
            int contador = 0;

            var disparo1Arix = arix.ARIX_Disparos.ToList()[0];

            if (listBoxDisparo1_tipoOperacion.GetSelectedIndices()[0] != disparo1Arix.TipoOperacion) contador++;
            if (listBoxDisparo1_tipoReset.GetSelectedIndices()[0] != disparo1Arix.TipoReset) contador++;
            if (checkDisparo1_habilitaModificadores.Checked != disparo1Arix.HabilitaModificadores) contador++;
            if (txtDisparo1_corrArranque.Text != disparo1Arix.CorrArranque.ToString()) contador++;
            if (txtDisparo1_modCorrMaxActuacion.Text != disparo1Arix.ModCorrMaxActuacion.ToString()) contador++;
            var modTd = txtDisparo1_modTd.Text.Replace(".", ",");
            if (modTd != disparo1Arix.ModTd.ToString()) contador++;
            if (txtDisparo1_tiempoDisparoDefinido.Text != disparo1Arix.TiempoDisparoDefinido.ToString()) contador++;
            if (txtDisparo1_tiempoResetCiclo.Text != disparo1Arix.TiempoResetCiclo.ToString()) contador++;
            if (txtDisparo1_tiempoApertura.Text != disparo1Arix.TiempoApertura.ToString()) contador++;
            if (txtDisparo1_modTiempoMaxRespuesta.Text != disparo1Arix.ModTiempoMaxRespuesta.ToString()) contador++;
            if (txtDisparo1_modTiempoMinRespuesta.Text != disparo1Arix.ModTiempoMinRespuesta.ToString()) contador++;
            if (txtDisparo1_modTiempoDefIMaxAct.Text != disparo1Arix.ModTiempoDefIMaxAct.ToString()) contador++;
            if (txtDisparo1_modRetardoAdicional.Text != disparo1Arix.ModRetardoAdicional.ToString()) contador++;

            if (contador > 0)
            {
                respuesta = true;

            }
            return respuesta;
        }

        private bool HayModificacionDisparo2(ARIX arix)
        {
            bool respuesta = false;
            int contador = 0;

            var disparo2Arix = arix.ARIX_Disparos.ToList()[1];

            if (listBoxDisparo2_tipoOperacion.GetSelectedIndices()[0] != disparo2Arix.TipoOperacion) contador++;
            if (listBoxDisparo2_tipoReset.GetSelectedIndices()[0] != disparo2Arix.TipoReset) contador++;
            if (checkDisparo2_habilitaModificadores.Checked != disparo2Arix.HabilitaModificadores) contador++;
            if (txtDisparo2_corrArranque.Text != disparo2Arix.CorrArranque.ToString()) contador++;
            if (txtDisparo2_modCorrMaxActuacion.Text != disparo2Arix.ModCorrMaxActuacion.ToString()) contador++;
            var modTd = txtDisparo2_modTd.Text.Replace(".", ",");
            if (modTd != disparo2Arix.ModTd.ToString()) contador++;
            if (txtDisparo2_tiempoDisparoDefinido.Text != disparo2Arix.TiempoDisparoDefinido.ToString()) contador++;
            if (txtDisparo2_tiempoResetCiclo.Text != disparo2Arix.TiempoResetCiclo.ToString()) contador++;
            if (txtDisparo2_tiempoApertura.Text != disparo2Arix.TiempoApertura.ToString()) contador++;
            if (txtDisparo2_modTiempoMaxRespuesta.Text != disparo2Arix.ModTiempoMaxRespuesta.ToString()) contador++;
            if (txtDisparo2_modTiempoMinRespuesta.Text != disparo2Arix.ModTiempoMinRespuesta.ToString()) contador++;
            if (txtDisparo2_modTiempoDefIMaxAct.Text != disparo2Arix.ModTiempoDefIMaxAct.ToString()) contador++;
            if (txtDisparo2_modRetardoAdicional.Text != disparo2Arix.ModRetardoAdicional.ToString()) contador++;

            if (contador > 0)
            {
                respuesta = true;

            }
            return respuesta;
        }

        private bool HayModificacionDisparo3(ARIX arix)
        {
            bool respuesta = false;
            int contador = 0;

            var disparo3Arix = arix.ARIX_Disparos.ToList()[2];

            if (listBoxDisparo3_tipoOperacion.GetSelectedIndices()[0] != disparo3Arix.TipoOperacion) contador++;
            if (listBoxDisparo3_tipoReset.GetSelectedIndices()[0] != disparo3Arix.TipoReset) contador++;
            if (checkDisparo3_habilitaModificadores.Checked != disparo3Arix.HabilitaModificadores) contador++;
            if (txtDisparo3_corrArranque.Text != disparo3Arix.CorrArranque.ToString()) contador++;
            if (txtDisparo3_modCorrMaxActuacion.Text != disparo3Arix.ModCorrMaxActuacion.ToString()) contador++;
            var modTd = txtDisparo3_modTd.Text.Replace(".", ",");
            if (modTd != disparo3Arix.ModTd.ToString()) contador++;
            if (txtDisparo3_tiempoDisparoDefinido.Text != disparo3Arix.TiempoDisparoDefinido.ToString()) contador++;
            if (txtDisparo3_tiempoResetCiclo.Text != disparo3Arix.TiempoResetCiclo.ToString()) contador++;
            if (txtDisparo3_tiempoApertura.Text != disparo3Arix.TiempoApertura.ToString()) contador++;
            if (txtDisparo3_modTiempoMaxRespuesta.Text != disparo3Arix.ModTiempoMaxRespuesta.ToString()) contador++;
            if (txtDisparo3_modTiempoMinRespuesta.Text != disparo3Arix.ModTiempoMinRespuesta.ToString()) contador++;
            if (txtDisparo3_modTiempoDefIMaxAct.Text != disparo3Arix.ModTiempoDefIMaxAct.ToString()) contador++;
            if (txtDisparo3_modRetardoAdicional.Text != disparo3Arix.ModRetardoAdicional.ToString()) contador++;

            if (contador > 0)
            {
                respuesta = true;

            }
            return respuesta;
        }

        private bool HayModificacionDisparo4(ARIX arix)
        {
            bool respuesta = false;
            int contador = 0;

            var disparo4Arix = arix.ARIX_Disparos.ToList()[3];

            if (listBoxDisparo4_tipoOperacion.GetSelectedIndices()[0] != disparo4Arix.TipoOperacion) contador++;
            if (listBoxDisparo4_tipoReset.GetSelectedIndices()[0] != disparo4Arix.TipoReset) contador++;
            if (checkDisparo4_habilitaModificadores.Checked != disparo4Arix.HabilitaModificadores) contador++;
            if (txtDisparo4_corrArranque.Text != disparo4Arix.CorrArranque.ToString()) contador++;
            if (txtDisparo4_modCorrMaxActuacion.Text != disparo4Arix.ModCorrMaxActuacion.ToString()) contador++;
            var modTd = txtDisparo4_modTd.Text.Replace(".", ",");
            if (modTd != disparo4Arix.ModTd.ToString()) contador++;
            if (txtDisparo4_tiempoDisparoDefinido.Text != disparo4Arix.TiempoDisparoDefinido.ToString()) contador++;
            if (txtDisparo4_tiempoResetCiclo.Text != disparo4Arix.TiempoResetCiclo.ToString()) contador++;
            if (txtDisparo4_tiempoApertura.Text != disparo4Arix.TiempoApertura.ToString()) contador++;
            if (txtDisparo4_modTiempoMaxRespuesta.Text != disparo4Arix.ModTiempoMaxRespuesta.ToString()) contador++;
            if (txtDisparo4_modTiempoMinRespuesta.Text != disparo4Arix.ModTiempoMinRespuesta.ToString()) contador++;
            if (txtDisparo4_modTiempoDefIMaxAct.Text != disparo4Arix.ModTiempoDefIMaxAct.ToString()) contador++;
            if (txtDisparo4_modRetardoAdicional.Text != disparo4Arix.ModRetardoAdicional.ToString()) contador++;

            if (contador > 0)
            {
                respuesta = true;

            }
            return respuesta;
        }

        private bool HayModificacionDisparo5(ARIX arix)
        {
            bool respuesta = false;
            int contador = 0;

            var disparo5Arix = arix.ARIX_Disparos.ToList()[4];

            if (listBoxDisparo5_tipoOperacion.GetSelectedIndices()[0] != disparo5Arix.TipoOperacion) contador++;
            if (listBoxDisparo5_tipoReset.GetSelectedIndices()[0] != disparo5Arix.TipoReset) contador++;
            if (checkDisparo5_habilitaModificadores.Checked != disparo5Arix.HabilitaModificadores) contador++;
            if (txtDisparo5_corrArranque.Text != disparo5Arix.CorrArranque.ToString()) contador++;
            if (txtDisparo5_modCorrMaxActuacion.Text != disparo5Arix.ModCorrMaxActuacion.ToString()) contador++;
            var modTd = txtDisparo5_modTd.Text.Replace(".", ",");
            if (modTd != disparo5Arix.ModTd.ToString()) contador++;
            if (txtDisparo5_tiempoDisparoDefinido.Text != disparo5Arix.TiempoDisparoDefinido.ToString()) contador++;
            if (txtDisparo5_tiempoResetCiclo.Text != disparo5Arix.TiempoResetCiclo.ToString()) contador++;
            if (txtDisparo5_tiempoApertura.Text != disparo5Arix.TiempoApertura.ToString()) contador++;
            if (txtDisparo5_modTiempoMaxRespuesta.Text != disparo5Arix.ModTiempoMaxRespuesta.ToString()) contador++;
            if (txtDisparo5_modTiempoMinRespuesta.Text != disparo5Arix.ModTiempoMinRespuesta.ToString()) contador++;
            if (txtDisparo5_modTiempoDefIMaxAct.Text != disparo5Arix.ModTiempoDefIMaxAct.ToString()) contador++;
            if (txtDisparo5_modRetardoAdicional.Text != disparo5Arix.ModRetardoAdicional.ToString()) contador++;

            if (contador > 0)
            {
                respuesta = true;

            }
            return respuesta;
        }

        private bool HayModificacionDisparo6(ARIX arix)
        {
            bool respuesta = false;
            int contador = 0;

            var disparo6Arix = arix.ARIX_Disparos.Count == 6? arix.ARIX_Disparos.ToList()[5]: null;
            if(disparo6Arix != null)
            {
                if (listBoxDisparo6_tipoOperacion.GetSelectedIndices()[0] != disparo6Arix.TipoOperacion) contador++;
                if (listBoxDisparo6_tipoReset.GetSelectedIndices()[0] != disparo6Arix.TipoReset) contador++;
                if (checkDisparo6_habilitaModificadores.Checked != disparo6Arix.HabilitaModificadores) contador++;
                if (txtDisparo6_corrArranque.Text != disparo6Arix.CorrArranque.ToString()) contador++;
                if (txtDisparo6_modCorrMaxActuacion.Text != disparo6Arix.ModCorrMaxActuacion.ToString()) contador++;
                var modTd = txtDisparo6_modTd.Text.Replace(".", ",");
                if (modTd != disparo6Arix.ModTd.ToString()) contador++;
                if (txtDisparo6_tiempoDisparoDefinido.Text != disparo6Arix.TiempoDisparoDefinido.ToString()) contador++;
                if (txtDisparo6_tiempoResetCiclo.Text != disparo6Arix.TiempoResetCiclo.ToString()) contador++;
                if (txtDisparo6_tiempoApertura.Text != disparo6Arix.TiempoApertura.ToString()) contador++;
                if (txtDisparo6_modTiempoMaxRespuesta.Text != disparo6Arix.ModTiempoMaxRespuesta.ToString()) contador++;
                if (txtDisparo6_modTiempoMinRespuesta.Text != disparo6Arix.ModTiempoMinRespuesta.ToString()) contador++;
                if (txtDisparo6_modTiempoDefIMaxAct.Text != disparo6Arix.ModTiempoDefIMaxAct.ToString()) contador++;
                if (txtDisparo6_modRetardoAdicional.Text != disparo6Arix.ModRetardoAdicional.ToString()) contador++;
            }
            
            if (contador > 0)
            {
                respuesta = true;

            }
            return respuesta;
        }

        private void ActivarBotones()
        {
            butActualizarParams.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            //Para que el boton se desactive cuando se le haga click y además permita continuar con el postback 
            butActualizarParams.Attributes.Add("onclick",
                "javascript:" + butActualizarParams.ClientID + ".disabled=true;" +
                ClientScript.GetPostBackEventReference(butActualizarParams, ""));
        }

        private ARIX ModificarOperacionGeneral(ARIX arix)
        {
            var paramArix = arix.ParamARIX;

            if (listBoxModoOperacion.GetSelectedIndices()[0] != paramArix.modoOperacion) paramArix.modoOperacion = listBoxModoOperacion.GetSelectedIndices()[0];
            if (txtOpGeneral_porcentajeHisteresis.Text != paramArix.porcentajeHisteresisDisparo.ToString()) paramArix.porcentajeHisteresisDisparo = Byte.Parse(txtOpGeneral_porcentajeHisteresis.Text);
            if (txtOpGeneral_ciclosVerifResetDismCorrFalla.Text != paramArix.ciclosVerifResetDismCorrFalla.ToString()) paramArix.ciclosVerifResetDismCorrFalla = Byte.Parse(txtOpGeneral_ciclosVerifResetDismCorrFalla.Text);
            int frecOperacion = paramArix.fciaOperacion ? 1 : 0;
            if (listBoxFrecOperacion.GetSelectedIndices()[0] != frecOperacion) paramArix.fciaOperacion = (listBoxFrecOperacion.GetSelectedIndices()[0] == 1);
            if (chkBoxOpGeneral_habilitarInrush.Checked != paramArix.habilitarFuncionalidadInrush) paramArix.habilitarFuncionalidadInrush = chkBoxOpGeneral_habilitarInrush.Checked;
            if (listBoxmodOperacionFinVidaUtil.GetSelectedIndices()[0] != paramArix.modoOperacionAlFinalVidaUtil) paramArix.modoOperacionAlFinalVidaUtil = listBoxmodOperacionFinVidaUtil.GetSelectedIndices()[0];
            if (listBoxmodoInrush.GetSelectedIndices()[0] != (paramArix.tipoFuncionalidadInrush ? 1 : 0)) paramArix.tipoFuncionalidadInrush = (listBoxmodoInrush.GetSelectedIndices()[0] == 1);
            if (txtOpGeneral_corrInrush.Text != paramArix.corrInrush.ToString()) paramArix.corrInrush = short.Parse(txtOpGeneral_corrInrush.Text);
            if (txtOpGeneral_porcentaje2doArmonicoInrush.Text != paramArix.porcentaje2DoArmonicoInrush.ToString()) paramArix.porcentaje2DoArmonicoInrush = short.Parse(txtOpGeneral_porcentaje2doArmonicoInrush.Text);
            if (txtOpGeneral_tiempoDeValidacionInrush.Text != paramArix.tiempoDeValidacionInrush.ToString()) paramArix.tiempoDeValidacionInrush = int.Parse(txtOpGeneral_tiempoDeValidacionInrush.Text);
            if (txtOpGeneral_tiempoSostenimientoInrush.Text != paramArix.tiempoSostenimientoInrush.ToString()) paramArix.tiempoSostenimientoInrush = int.Parse(txtOpGeneral_tiempoSostenimientoInrush.Text);

            arix.ParamARIX = paramArix;

            return arix;
        }

        private ARIX ModificarOperacionReconectador(ARIX arix)
        {
            var paramArix = arix.ParamARIX;

            if (txtOpReconectador_numRecierres.Text != paramArix.numRecierres.ToString()) paramArix.numRecierres = int.Parse(txtOpReconectador_numRecierres.Text);
            if (txtOpReconectador_corrMaxAbsolutas.Text != paramArix.corrMaxAbsoluta.ToString()) paramArix.corrMaxAbsoluta = short.Parse(txtOpReconectador_corrMaxAbsolutas.Text);
            if (txtOpReconectador_tiempoDefDisparoCorrMaxAbs.Text != paramArix.tiempoDefDisparoCorrMaxAbs.ToString()) paramArix.tiempoDefDisparoCorrMaxAbs = short.Parse(txtOpReconectador_tiempoDefDisparoCorrMaxAbs.Text);
            //if (txtOpReconectador_resetTimeAfterLockout.Text != paramArix.resetTimeAfterLockout.ToString()) paramArix.resetTimeAfterLockout = short.Parse(txtOpReconectador_resetTimeAfterLockout.Text);
            //if (txtOpReconectador_resetTimeLockout.Text != paramArix.resetTimeLockout.ToString()) paramArix.resetTimeLockout = short.Parse(txtOpReconectador_resetTimeLockout.Text);
            //if (txtOpReconectador_corrMaxCapacidadRIX.Text != paramArix.corrMaxCapacidadRIX.ToString()) paramArix.corrMaxCapacidadRIX = short.Parse(txtOpReconectador_corrMaxCapacidadRIX.Text);

            arix.ParamARIX = paramArix;

            return arix;
        }

        private ARIX ModificarHardware(ARIX arix)
        {
            var paramArix = arix.ParamARIX;

            if (txtHardware_adcCargaLOWCapacitorDisparo.Text != paramArix.adcCargaLOWCapacitorDisparo.ToString()) paramArix.adcCargaLOWCapacitorDisparo = short.Parse(txtHardware_adcCargaLOWCapacitorDisparo.Text);
            if (txtHardware_adcCargaOKCapacitorDisparo.Text != paramArix.adcCargaOKCapacitorDisparo.ToString()) paramArix.adcCargaOKCapacitorDisparo = short.Parse(txtHardware_adcCargaOKCapacitorDisparo.Text);
            if (txtHardware_adcCargaLOWFuenteBaja.Text != paramArix.adcCargaLOWFuenteBaja.ToString())
            {
                var cargaLOWFuenteBaja = decimal.Parse(txtHardware_adcCargaLOWFuenteBaja.Text);
                paramArix.adcCargaLOWFuenteBaja = cargaLOWFuenteBaja;
            }
            if (txtHardware_adcCargaOKFuenteBaja.Text != paramArix.adcCargaOKFuenteBaja.ToString())
            {
                var cargaOkFuenteBaja = decimal.Parse(txtHardware_adcCargaOKFuenteBaja.Text);
                paramArix.adcCargaOKFuenteBaja = cargaOkFuenteBaja;
            }
            if (txtHardware_numOperacionesBotellaCercanoAlMax.Text !=
                paramArix.numOperacionesBotellaCercanoAlMax.ToString()) paramArix.numOperacionesBotellaCercanoAlMax = short.Parse(txtHardware_numOperacionesBotellaCercanoAlMax.Text);
            if (txtHardware_numOperacionesBotellaLlegaAlMax.Text !=
                paramArix.numOperacionesBotellaLlegaAlMax.ToString()) paramArix.numOperacionesBotellaLlegaAlMax = short.Parse(txtHardware_numOperacionesBotellaLlegaAlMax.Text);
            if (txtHardware_porcentDesgasteBotellaCercanoAlMax.Text !=
                paramArix.porcentDesgasteBotellaCercanoAlMax.ToString()) paramArix.porcentDesgasteBotellaCercanoAlMax = short.Parse(txtHardware_porcentDesgasteBotellaCercanoAlMax.Text);
            if (txtHardware_porcentDesgasteBotellaLlegaAlMax.Text !=
                paramArix.porcentDesgasteBotellaLlegaAlMax.ToString()) paramArix.porcentDesgasteBotellaLlegaAlMax = short.Parse(txtHardware_porcentDesgasteBotellaLlegaAlMax.Text);
            if (txtHardware_adcCorrMinParaAutoalimentacion50Hz.Text !=
                paramArix.adcCorrMinParaAutoalimentacion50Hz.ToString()) paramArix.adcCorrMinParaAutoalimentacion50Hz = short.Parse(txtHardware_adcCorrMinParaAutoalimentacion50Hz.Text);
            if (txtHardware_adcCorrMinParaAutoalimentacion60Hz.Text !=
                paramArix.adcCorrMinParaAutoalimentacion60Hz.ToString()) paramArix.adcCorrMinParaAutoalimentacion60Hz = short.Parse(txtHardware_adcCorrMinParaAutoalimentacion60Hz.Text);

            arix.ParamARIX = paramArix;

            return arix;
        }

        private ARIX ModificarComunicaciones(ARIX arix)
        {
            var paramArix = arix.ParamARIX;

            if (txtComunicacion_canalComunicacionRF.Text != paramArix.canalComunicacionRF.ToString()) paramArix.canalComunicacionRF = short.Parse(txtComunicacion_canalComunicacionRF.Text);
            if (txtComunicacion_codigoDeGrupo.Text != paramArix.codigoDelGrupo.ToString()) paramArix.codigoDelGrupo = short.Parse(txtComunicacion_codigoDeGrupo.Text);
            if (txtComunicacion_canalRfEnMHz.Text != paramArix.canalRfEnMHz.ToString()) paramArix.canalRfEnMHz = short.Parse(txtComunicacion_canalRfEnMHz.Text);

            arix.ParamARIX = paramArix;

            return arix;
        }

        private ARIX ModificarDisparo1(ARIX arix)
        {
            var disparo1Arix = arix.ARIX_Disparos.ToList()[0];
            if (listBoxDisparo1_tipoOperacion.GetSelectedIndices()[0] != disparo1Arix.TipoOperacion) disparo1Arix.TipoOperacion = listBoxDisparo1_tipoOperacion.GetSelectedIndices()[0];
            if (listBoxDisparo1_tipoReset.GetSelectedIndices()[0] != disparo1Arix.TipoReset) disparo1Arix.TipoReset = (byte)listBoxDisparo1_tipoReset.GetSelectedIndices()[0];
            if (checkDisparo1_habilitaModificadores.Checked != disparo1Arix.HabilitaModificadores) disparo1Arix.HabilitaModificadores = checkDisparo1_habilitaModificadores.Checked;
            if (txtDisparo1_corrArranque.Text != disparo1Arix.CorrArranque.ToString()) disparo1Arix.CorrArranque = int.Parse(txtDisparo1_corrArranque.Text);
            if (txtDisparo1_modCorrMaxActuacion.Text != disparo1Arix.ModCorrMaxActuacion.ToString()) disparo1Arix.ModCorrMaxActuacion = int.Parse(txtDisparo1_modCorrMaxActuacion.Text);
            var modTd = txtDisparo1_modTd.Text.Replace(".", ",");
            if (modTd != disparo1Arix.ModTd.ToString()) disparo1Arix.ModTd = decimal.Parse(modTd);
            if (txtDisparo1_tiempoDisparoDefinido.Text != disparo1Arix.TiempoDisparoDefinido.ToString()) disparo1Arix.TiempoDisparoDefinido = int.Parse(txtDisparo1_tiempoDisparoDefinido.Text);
            if (txtDisparo1_tiempoResetCiclo.Text != disparo1Arix.TiempoResetCiclo.ToString()) disparo1Arix.TiempoResetCiclo = int.Parse(txtDisparo1_tiempoResetCiclo.Text);
            if (txtDisparo1_tiempoApertura.Text != disparo1Arix.TiempoApertura.ToString()) disparo1Arix.TiempoApertura = int.Parse(txtDisparo1_tiempoApertura.Text);
            if (txtDisparo1_modTiempoMaxRespuesta.Text != disparo1Arix.ModTiempoMaxRespuesta.ToString()) disparo1Arix.ModTiempoMaxRespuesta = int.Parse(txtDisparo1_modTiempoMaxRespuesta.Text);
            if (txtDisparo1_modTiempoMinRespuesta.Text != disparo1Arix.ModTiempoMinRespuesta.ToString()) disparo1Arix.ModTiempoMinRespuesta = int.Parse(txtDisparo1_modTiempoMinRespuesta.Text);
            if (txtDisparo1_modTiempoDefIMaxAct.Text != disparo1Arix.ModTiempoDefIMaxAct.ToString()) disparo1Arix.ModTiempoDefIMaxAct = int.Parse(txtDisparo1_modTiempoDefIMaxAct.Text);
            if (txtDisparo1_modRetardoAdicional.Text != disparo1Arix.ModRetardoAdicional.ToString()) disparo1Arix.ModRetardoAdicional = int.Parse(txtDisparo1_modRetardoAdicional.Text);

            arix.ARIX_Disparos.ToList()[0] = disparo1Arix;

            return arix;
        }

        private ARIX ModificarDisparo2(ARIX arix)
        {
            var disparo2Arix = arix.ARIX_Disparos.ToList()[1];
            if (listBoxDisparo2_tipoOperacion.GetSelectedIndices()[0] != disparo2Arix.TipoOperacion) disparo2Arix.TipoOperacion = listBoxDisparo2_tipoOperacion.GetSelectedIndices()[0];
            if (listBoxDisparo2_tipoReset.GetSelectedIndices()[0] != disparo2Arix.TipoReset) disparo2Arix.TipoReset = (byte)listBoxDisparo2_tipoReset.GetSelectedIndices()[0];
            if (checkDisparo2_habilitaModificadores.Checked != disparo2Arix.HabilitaModificadores) disparo2Arix.HabilitaModificadores = checkDisparo2_habilitaModificadores.Checked;
            if (txtDisparo2_corrArranque.Text != disparo2Arix.CorrArranque.ToString()) disparo2Arix.CorrArranque = int.Parse(txtDisparo2_corrArranque.Text);
            if (txtDisparo2_modCorrMaxActuacion.Text != disparo2Arix.ModCorrMaxActuacion.ToString()) disparo2Arix.ModCorrMaxActuacion = int.Parse(txtDisparo2_modCorrMaxActuacion.Text);
            var modTd = txtDisparo2_modTd.Text.Replace(".", ",");
            if (modTd != disparo2Arix.ModTd.ToString()) disparo2Arix.ModTd = decimal.Parse(modTd);
            if (txtDisparo2_tiempoDisparoDefinido.Text != disparo2Arix.TiempoDisparoDefinido.ToString()) disparo2Arix.TiempoDisparoDefinido = int.Parse(txtDisparo2_tiempoDisparoDefinido.Text);
            if (txtDisparo2_tiempoResetCiclo.Text != disparo2Arix.TiempoResetCiclo.ToString()) disparo2Arix.TiempoResetCiclo = int.Parse(txtDisparo2_tiempoResetCiclo.Text);
            if (txtDisparo2_tiempoApertura.Text != disparo2Arix.TiempoApertura.ToString()) disparo2Arix.TiempoApertura = int.Parse(txtDisparo2_tiempoApertura.Text);
            if (txtDisparo2_modTiempoMaxRespuesta.Text != disparo2Arix.ModTiempoMaxRespuesta.ToString()) disparo2Arix.ModTiempoMaxRespuesta = int.Parse(txtDisparo2_modTiempoMaxRespuesta.Text);
            if (txtDisparo2_modTiempoMinRespuesta.Text != disparo2Arix.ModTiempoMinRespuesta.ToString()) disparo2Arix.ModTiempoMinRespuesta = int.Parse(txtDisparo2_modTiempoMinRespuesta.Text);
            if (txtDisparo2_modTiempoDefIMaxAct.Text != disparo2Arix.ModTiempoDefIMaxAct.ToString()) disparo2Arix.ModTiempoDefIMaxAct = int.Parse(txtDisparo2_modTiempoDefIMaxAct.Text);
            if (txtDisparo2_modRetardoAdicional.Text != disparo2Arix.ModRetardoAdicional.ToString()) disparo2Arix.ModRetardoAdicional = int.Parse(txtDisparo2_modRetardoAdicional.Text);

            arix.ARIX_Disparos.ToList()[1] = disparo2Arix;

            return arix;
        }

        private ARIX ModificarDisparo3(ARIX arix)
        {
            var disparo3Arix = arix.ARIX_Disparos.ToList()[2];
            if (listBoxDisparo3_tipoOperacion.GetSelectedIndices()[0] != disparo3Arix.TipoOperacion) disparo3Arix.TipoOperacion = listBoxDisparo3_tipoOperacion.GetSelectedIndices()[0];
            if (listBoxDisparo3_tipoReset.GetSelectedIndices()[0] != disparo3Arix.TipoReset) disparo3Arix.TipoReset = (byte)listBoxDisparo3_tipoReset.GetSelectedIndices()[0];
            if (checkDisparo3_habilitaModificadores.Checked != disparo3Arix.HabilitaModificadores) disparo3Arix.HabilitaModificadores = checkDisparo3_habilitaModificadores.Checked;
            if (txtDisparo3_corrArranque.Text != disparo3Arix.CorrArranque.ToString()) disparo3Arix.CorrArranque = int.Parse(txtDisparo3_corrArranque.Text);
            if (txtDisparo3_modCorrMaxActuacion.Text != disparo3Arix.ModCorrMaxActuacion.ToString()) disparo3Arix.ModCorrMaxActuacion = int.Parse(txtDisparo3_modCorrMaxActuacion.Text);
            var modTd = txtDisparo3_modTd.Text.Replace(".", ",");
            if (modTd != disparo3Arix.ModTd.ToString()) disparo3Arix.ModTd = decimal.Parse(modTd);
            if (txtDisparo3_tiempoDisparoDefinido.Text != disparo3Arix.TiempoDisparoDefinido.ToString()) disparo3Arix.TiempoDisparoDefinido = int.Parse(txtDisparo3_tiempoDisparoDefinido.Text);
            if (txtDisparo3_tiempoResetCiclo.Text != disparo3Arix.TiempoResetCiclo.ToString()) disparo3Arix.TiempoResetCiclo = int.Parse(txtDisparo3_tiempoResetCiclo.Text);
            if (txtDisparo3_tiempoApertura.Text != disparo3Arix.TiempoApertura.ToString()) disparo3Arix.TiempoApertura = int.Parse(txtDisparo3_tiempoApertura.Text);
            if (txtDisparo3_modTiempoMaxRespuesta.Text != disparo3Arix.ModTiempoMaxRespuesta.ToString()) disparo3Arix.ModTiempoMaxRespuesta = int.Parse(txtDisparo3_modTiempoMaxRespuesta.Text);
            if (txtDisparo3_modTiempoMinRespuesta.Text != disparo3Arix.ModTiempoMinRespuesta.ToString()) disparo3Arix.ModTiempoMinRespuesta = int.Parse(txtDisparo3_modTiempoMinRespuesta.Text);
            if (txtDisparo3_modTiempoDefIMaxAct.Text != disparo3Arix.ModTiempoDefIMaxAct.ToString()) disparo3Arix.ModTiempoDefIMaxAct = int.Parse(txtDisparo3_modTiempoDefIMaxAct.Text);
            if (txtDisparo3_modRetardoAdicional.Text != disparo3Arix.ModRetardoAdicional.ToString()) disparo3Arix.ModRetardoAdicional = int.Parse(txtDisparo3_modRetardoAdicional.Text);

            arix.ARIX_Disparos.ToList()[2] = disparo3Arix;

            return arix;
        }

        private ARIX ModificarDisparo4(ARIX arix)
        {
            var disparo4Arix = arix.ARIX_Disparos.ToList()[3];
            if (listBoxDisparo4_tipoOperacion.GetSelectedIndices()[0] != disparo4Arix.TipoOperacion) disparo4Arix.TipoOperacion = listBoxDisparo4_tipoOperacion.GetSelectedIndices()[0];
            if (listBoxDisparo4_tipoReset.GetSelectedIndices()[0] != disparo4Arix.TipoReset) disparo4Arix.TipoReset = (byte)listBoxDisparo4_tipoReset.GetSelectedIndices()[0];
            if (checkDisparo4_habilitaModificadores.Checked != disparo4Arix.HabilitaModificadores) disparo4Arix.HabilitaModificadores = checkDisparo4_habilitaModificadores.Checked;
            if (txtDisparo4_corrArranque.Text != disparo4Arix.CorrArranque.ToString()) disparo4Arix.CorrArranque = int.Parse(txtDisparo4_corrArranque.Text);
            if (txtDisparo4_modCorrMaxActuacion.Text != disparo4Arix.ModCorrMaxActuacion.ToString()) disparo4Arix.ModCorrMaxActuacion = int.Parse(txtDisparo4_modCorrMaxActuacion.Text);
            var modTd = txtDisparo4_modTd.Text.Replace(".", ",");
            if (modTd != disparo4Arix.ModTd.ToString()) disparo4Arix.ModTd = decimal.Parse(modTd);
            if (txtDisparo4_tiempoDisparoDefinido.Text != disparo4Arix.TiempoDisparoDefinido.ToString()) disparo4Arix.TiempoDisparoDefinido = int.Parse(txtDisparo4_tiempoDisparoDefinido.Text);
            if (txtDisparo4_tiempoResetCiclo.Text != disparo4Arix.TiempoResetCiclo.ToString()) disparo4Arix.TiempoResetCiclo = int.Parse(txtDisparo4_tiempoResetCiclo.Text);
            if (txtDisparo4_tiempoApertura.Text != disparo4Arix.TiempoApertura.ToString()) disparo4Arix.TiempoApertura = int.Parse(txtDisparo4_tiempoApertura.Text);
            if (txtDisparo4_modTiempoMaxRespuesta.Text != disparo4Arix.ModTiempoMaxRespuesta.ToString()) disparo4Arix.ModTiempoMaxRespuesta = int.Parse(txtDisparo4_modTiempoMaxRespuesta.Text);
            if (txtDisparo4_modTiempoMinRespuesta.Text != disparo4Arix.ModTiempoMinRespuesta.ToString()) disparo4Arix.ModTiempoMinRespuesta = int.Parse(txtDisparo4_modTiempoMinRespuesta.Text);
            if (txtDisparo4_modTiempoDefIMaxAct.Text != disparo4Arix.ModTiempoDefIMaxAct.ToString()) disparo4Arix.ModTiempoDefIMaxAct = int.Parse(txtDisparo4_modTiempoDefIMaxAct.Text);
            if (txtDisparo4_modRetardoAdicional.Text != disparo4Arix.ModRetardoAdicional.ToString()) disparo4Arix.ModRetardoAdicional = int.Parse(txtDisparo4_modRetardoAdicional.Text);

            arix.ARIX_Disparos.ToList()[3] = disparo4Arix;

            return arix;
        }

        private ARIX ModificarDisparo5(ARIX arix)
        {
            var disparo5Arix = arix.ARIX_Disparos.ToList()[4];
            if (listBoxDisparo5_tipoOperacion.GetSelectedIndices()[0] != disparo5Arix.TipoOperacion) disparo5Arix.TipoOperacion = listBoxDisparo5_tipoOperacion.GetSelectedIndices()[0];
            if (listBoxDisparo5_tipoReset.GetSelectedIndices()[0] != disparo5Arix.TipoReset) disparo5Arix.TipoReset = (byte)listBoxDisparo5_tipoReset.GetSelectedIndices()[0];
            if (checkDisparo5_habilitaModificadores.Checked != disparo5Arix.HabilitaModificadores) disparo5Arix.HabilitaModificadores = checkDisparo5_habilitaModificadores.Checked;
            if (txtDisparo5_corrArranque.Text != disparo5Arix.CorrArranque.ToString()) disparo5Arix.CorrArranque = int.Parse(txtDisparo5_corrArranque.Text);
            if (txtDisparo5_modCorrMaxActuacion.Text != disparo5Arix.ModCorrMaxActuacion.ToString()) disparo5Arix.ModCorrMaxActuacion = int.Parse(txtDisparo5_modCorrMaxActuacion.Text);
            var modTd = txtDisparo5_modTd.Text.Replace(".", ",");
            if (modTd != disparo5Arix.ModTd.ToString()) disparo5Arix.ModTd = decimal.Parse(modTd);
            if (txtDisparo5_tiempoDisparoDefinido.Text != disparo5Arix.TiempoDisparoDefinido.ToString()) disparo5Arix.TiempoDisparoDefinido = int.Parse(txtDisparo5_tiempoDisparoDefinido.Text);
            if (txtDisparo5_tiempoResetCiclo.Text != disparo5Arix.TiempoResetCiclo.ToString()) disparo5Arix.TiempoResetCiclo = int.Parse(txtDisparo5_tiempoResetCiclo.Text);
            if (txtDisparo5_tiempoApertura.Text != disparo5Arix.TiempoApertura.ToString()) disparo5Arix.TiempoApertura = int.Parse(txtDisparo5_tiempoApertura.Text);
            if (txtDisparo5_modTiempoMaxRespuesta.Text != disparo5Arix.ModTiempoMaxRespuesta.ToString()) disparo5Arix.ModTiempoMaxRespuesta = int.Parse(txtDisparo5_modTiempoMaxRespuesta.Text);
            if (txtDisparo5_modTiempoMinRespuesta.Text != disparo5Arix.ModTiempoMinRespuesta.ToString()) disparo5Arix.ModTiempoMinRespuesta = int.Parse(txtDisparo5_modTiempoMinRespuesta.Text);
            if (txtDisparo5_modTiempoDefIMaxAct.Text != disparo5Arix.ModTiempoDefIMaxAct.ToString()) disparo5Arix.ModTiempoDefIMaxAct = int.Parse(txtDisparo5_modTiempoDefIMaxAct.Text);
            if (txtDisparo5_modRetardoAdicional.Text != disparo5Arix.ModRetardoAdicional.ToString()) disparo5Arix.ModRetardoAdicional = int.Parse(txtDisparo5_modRetardoAdicional.Text);

            arix.ARIX_Disparos.ToList()[4] = disparo5Arix;

            return arix;
        }

        private ARIX ModificarDisparo6(ARIX arix)
        {
            var disparo6Arix = arix.ARIX_Disparos.Count == 6? arix.ARIX_Disparos.ToList()[5]: null;
            if (disparo6Arix != null)
            {
                if (listBoxDisparo6_tipoOperacion.GetSelectedIndices()[0] != disparo6Arix.TipoOperacion) disparo6Arix.TipoOperacion = listBoxDisparo6_tipoOperacion.GetSelectedIndices()[0];
                if (listBoxDisparo6_tipoReset.GetSelectedIndices()[0] != disparo6Arix.TipoReset) disparo6Arix.TipoReset = (byte)listBoxDisparo6_tipoReset.GetSelectedIndices()[0];
                if (checkDisparo6_habilitaModificadores.Checked != disparo6Arix.HabilitaModificadores) disparo6Arix.HabilitaModificadores = checkDisparo6_habilitaModificadores.Checked;
                if (txtDisparo6_corrArranque.Text != disparo6Arix.CorrArranque.ToString()) disparo6Arix.CorrArranque = int.Parse(txtDisparo6_corrArranque.Text);
                if (txtDisparo6_modCorrMaxActuacion.Text != disparo6Arix.ModCorrMaxActuacion.ToString()) disparo6Arix.ModCorrMaxActuacion = int.Parse(txtDisparo6_modCorrMaxActuacion.Text);
                var modTd = txtDisparo6_modTd.Text.Replace(".", ",");
                if (modTd != disparo6Arix.ModTd.ToString()) disparo6Arix.ModTd = decimal.Parse(modTd);
                if (txtDisparo6_tiempoDisparoDefinido.Text != disparo6Arix.TiempoDisparoDefinido.ToString()) disparo6Arix.TiempoDisparoDefinido = int.Parse(txtDisparo6_tiempoDisparoDefinido.Text);
                if (txtDisparo6_tiempoResetCiclo.Text != disparo6Arix.TiempoResetCiclo.ToString()) disparo6Arix.TiempoResetCiclo = int.Parse(txtDisparo6_tiempoResetCiclo.Text);
                if (txtDisparo6_tiempoApertura.Text != disparo6Arix.TiempoApertura.ToString()) disparo6Arix.TiempoApertura = int.Parse(txtDisparo6_tiempoApertura.Text);
                if (txtDisparo6_modTiempoMaxRespuesta.Text != disparo6Arix.ModTiempoMaxRespuesta.ToString()) disparo6Arix.ModTiempoMaxRespuesta = int.Parse(txtDisparo6_modTiempoMaxRespuesta.Text);
                if (txtDisparo6_modTiempoMinRespuesta.Text != disparo6Arix.ModTiempoMinRespuesta.ToString()) disparo6Arix.ModTiempoMinRespuesta = int.Parse(txtDisparo6_modTiempoMinRespuesta.Text);
                if (txtDisparo6_modTiempoDefIMaxAct.Text != disparo6Arix.ModTiempoDefIMaxAct.ToString()) disparo6Arix.ModTiempoDefIMaxAct = int.Parse(txtDisparo6_modTiempoDefIMaxAct.Text);
                if (txtDisparo6_modRetardoAdicional.Text != disparo6Arix.ModRetardoAdicional.ToString()) disparo6Arix.ModRetardoAdicional = int.Parse(txtDisparo6_modRetardoAdicional.Text);
            }            
            if(disparo6Arix != null)
            {
                arix.ARIX_Disparos.ToList()[5] = disparo6Arix;
            }            

            return arix;
        }

        #endregion

        #region ONLINE
        protected void butUpdate_Click(object sender, EventArgs e)
        {
            using (SistemaGestionRemotoContainer bDatos = new SistemaGestionRemotoContainer())
            {
                int idArix = Convert.ToInt32(lblId.Text);
                ARIX arix = bDatos.ARIXs.SingleOrDefault(a => a.Id == idArix);
                if (arix != null)
                {
                    butActualizarParams_Click(sender, e);
                }
            }
        }

        protected void butUpdateOnline_Click(object sender, EventArgs e)
        {
            this.Validate("editARIX");
            if (this.IsValid)
            {
                ViewState["ActualizadoOffline"] = false;  //antes de actualizar Online , se hace todo el proceso de Actualizar OffLine
                this.ActualizarParametrosArix(true);
                if ((bool)ViewState["ActualizadoOffline"])
                {
                    //RealizarComunicacionOnlineYMSMQ(ComandosUsuario.UpdateParamsARIX);
                    RealizarComunicacionOnlineYMSMQ(ComandosUsuario.UpdateParamsARIX);
                }
            }


        }

        private void RealizarComunicacionOnlineYMSMQ(ComandosUsuario comandoUser)
        {
            InicializarMessageQueues();
            var respuesta = "";
            MensajeComandoMQOnline msgComando = new MensajeComandoMQOnline();

            msgComando.SerialFWT = serialFWT.Text;
            msgComando.IdFCI = byte.Parse(lblId.Text);
            msgComando.SerialFCI = serialARIX.Text;
            msgComando.Comando = comandoUser;
            mqWebToSGR.Send(msgComando);

            //Formato de mensaje de recepcion MensajeRespuestasMQOnline
            ((XmlMessageFormatter)mqSGRToWeb.Formatter).TargetTypes = new Type[1];
            ((XmlMessageFormatter)mqSGRToWeb.Formatter).TargetTypes[0] = (new MensajeRespuestasMQOnline()).GetType();

            try
            {
                System.Messaging.Message msg = mqSGRToWeb.Receive(new TimeSpan(0, 0, 45)); //Espera Máximo 45 segs sincronicamente para recibir respuesta
                MensajeRespuestasMQOnline msgRespuesta = (MensajeRespuestasMQOnline)msg.Body;

                if (msgRespuesta.Respuesta == RespuestasSvrCom.NotConnected)
                {
                    respuesta = DescripcionEnumeraciones.GetRespuestasSvrComSpa(RespuestasSvrCom.NotConnected);
                }
                else if (msgRespuesta.Respuesta == RespuestasSvrCom.MsgQueueExceptionComunicaciones)
                {

                    //lblEstadoActualizacionOnline.Text = "MessageQueueException en servidor comunicaciones  : " + (string)msgRespuesta.Datos;
                    respuesta = DescripcionEnumeraciones.GetRespuestasSvrComSpa(RespuestasSvrCom.MsgQueueExceptionComunicaciones);
                }
                else
                {
                    if (msgRespuesta.SerialFWT == serialFWT.Text)
                    {
                        switch (comandoUser)
                        {
                            case ComandosUsuario.UpdateParamsARIX:
                                if (msgRespuesta.Respuesta == RespuestasSvrCom.OK)
                                {
                                    respuesta = "Correcto, si funciona, buena crack!!!!!";
                                }
                                else
                                {
                                    //lblEstadoActualizacionOnline.Text = "Se recibió otra respuesta para este serial :  " + msgRespuesta.Respuesta.ToString();
                                    respuesta = DescripcionEnumeraciones.GetRespuestasSvrComSpa(msgRespuesta.Respuesta);
                                }
                                break;
                        }
                    }
                }
            }
            catch (Exception e)
            {

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


        protected void ControlarAutorizacionControles()
        {
            //ATENCIÓN: Cada vez que se adicione un control en esta lista, se debe buscar o controlar en el resto del
            //código que no se haga una habilitación directa en otro sitio sin pasar por la función de control
            //de autorización UtilitariosWebGUI.HasAuthorization().
            butUpdate.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
            //butUpdateOnline.Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
        }
        #endregion
    }
}