using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes.PagesEquipment
{
    public partial class DetallePrmsFWT : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strIdInterno = Request.QueryString["IdInterno"];
            string strFechaTicks = Request.QueryString["Fecha"];
            LlenarValores(int.Parse(strIdInterno), new DateTime(Int64.Parse(strFechaTicks)));
        }

        protected void LlenarValores(int idInterno, DateTime fechaRegistro)
        {
            using (SistemaGestionRemotoContainer context = new SistemaGestionRemotoContainer())
            {
                var Prms = (from record in context.HistoriaParamsFWT
                            where record.IdFWT == idInterno && record.FechaConfirmacion == fechaRegistro
                            select record).SingleOrDefault();

                if (Prms != null)
                {
                    txtCanalRF.Text = Prms.ParamFWT_CanalRF.ToString();
                    txtNumeroMaximoFCI.Text = Prms.ParamFWT_NumeroMaximoFCIs.ToString();
                    txtPrmReporteCteSix.Text = Prms.ParamFWT_SegReporteCorrientesSIX.ToString();
                    txtIpGestion.Text = Prms.ParamFWT_DireccionIPGESTION;
                    txtPuertoGestion.Text = Prms.ParamFWT_PuertoGESTION.ToString();
                    txtAPN.Text = Prms.ParamFWT_APN;
                    txtUsuario.Text = Prms.ParamFWT_Usuario;
                    txtPassword.Text = Prms.ParamFWT_Password;
                    prmDDLBandaGsm.SelectedValue = Prms.ParamFWT_BandaDeOperacionGSM.ToString();
                    txtTiempoEsperaPaqueteDeSGR.Text = Prms.ParamFWT_TiempoEsperaPaqueteDeSGR.ToString();
                    txtMaxNumeroReintentosPack.Text = Prms.ParamFWT_MaxNumeroReintentosPack.ToString();
                    txtSecondsBeforeRetryConnection.Text = Prms.ParamFWT_SecondsBeforeRetryConnection.ToString();
                    txtMaxNumeroReintentosConexionToSGR.Text = Prms.ParamFWT_MaxNumeroReintentosConexionToSGR.ToString();
                    txtPeriodoReporteSeg.Text = Prms.ParamFWT_PeriodoReporteSeg.ToString();
                    txtPrmVoltajeMinNivelCargador.Text = Prms.PrmVoltajeMinNivelCargador.ToString();
                    txtPrmVoltajeMinNivelPanel.Text = Prms.PrmVoltajeMinNivelPanel.ToString();
                    txtPrmvoltajeMinBateria.Text = Prms.PrmVoltajeMinBateria.ToString();
                    txtPrmVoltajeLowBatt.Text = Prms.PrmVoltajeLowBatt.ToString();
                    txtPrmCorrienteBateria.Text = Prms.ParamFWT_CorrienteBateria.ToString();
                    txtPrmPeriodoRevisionFuentes.Text = Prms.ParamFWT_PeriodoRevisionFtesEnSeg.ToString();
                    prmChkProcesoCargaBateria.Checked = Prms.ParamFWT_ProcesoCargaBatHabilitado;
                    txtIpSCADA.Text = Prms.ParamFWT_DireccionIPSCADA;
                    txtPuertoSCADA.Text = Prms.ParamFWT_PuertoSCADA.ToString();
                }
            }
        }
    }
}