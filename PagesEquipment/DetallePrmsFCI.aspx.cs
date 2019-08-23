using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes.PagesEquipment
{
    public partial class DetallePrmsFCI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string strIdInterno = Request.QueryString["IdInterno"];
                string strFechaTicks = Request.QueryString["Fecha"];
                LlenarValores(int.Parse(strIdInterno), new DateTime(Int64.Parse(strFechaTicks)));
            }
        }


        protected void LlenarValores(int idInterno, DateTime fechaRegistro)
        {
            using (SistemaGestionRemotoContainer context = new SistemaGestionRemotoContainer())
            {
                var Prms = (from record in context.HistorialParamsFiSxes
                            where record.IdFiSx == idInterno && record.FechaConfirmacion == fechaRegistro
                            select record).SingleOrDefault();

                if (Prms != null)
                {

                    switch (Prms.ParamsFCI.ModoDisparo)
                    {
                        case 0:
                            rdButModoProporcional.Checked = true;
                            lblNombreValorFalla.Text = (string)this.GetLocalResourceObject("TextlblNombreValorFallaDeltaI"); //"DeltaI (di/dt) :";
                            lblUnids.Text = (string)this.GetLocalResourceObject("TextlblUnidsVeces"); //"2-100 Veces";
                            break;
                        case 1:
                            rdButModoPorIncremento.Checked = true;
                            lblNombreValorFalla.Text = (string)this.GetLocalResourceObject("TextlblNombreValorFallaEscalon"); //"Escalón :";
                            lblUnids.Text = "(10-1000)A";
                            break;
                        case 2:
                            rdButModoPorValorFijo.Checked = true;
                            lblNombreValorFalla.Text = (string)this.GetLocalResourceObject("TextlblNombreValorFallaCorriente"); //"Corriente :";
                            lblUnids.Text = "(10-1000)A";
                            break;
                        case 3:
                            rdButModoPorAutoRango.Checked = true;
                            lblNombreValorFalla.Text = "N/A";
                            lblUnids.Text = "";
                            break;
                    }

                    txtValorFalla.Text = Prms.ParamsFCI.ValorFalla.ToString();
                    chkBoxRepTiempo.Checked = Prms.ParamsFCI.ReposicionPorTiempo;
                    chkBoxRepTension.Checked = Prms.ParamsFCI.ReposicionPorTension;
                    chkBoxRepMagneto.Checked = Prms.ParamsFCI.ReposicionPorMagneto;
                    chkBoxRepCorriente.Checked = Prms.ParamsFCI.ReposicionPorCorriente;
                    chkBoxHabReloj.Checked = Prms.ParamsFCI.HabilitarReloj;
                    chkBoxHabFallaTrans.Checked = Prms.ParamsFCI.HabilitarFallaTransitoria;
                    txtTiempoValFalla.Text = Prms.ParamsFCI.TiempoValidacionFallaSegundos.ToString();
                    txtToleranciaTensionReposicion.Text = Prms.ParamsFCI.ToleranciaTensionReposicion.ToString();
                    txtTiempoReposicion.Text = Prms.ParamsFCI.TiempoReposicionSegundos.ToString();
                    txtTiempoIndicacionFallatemp.Text = Prms.ParamsFCI.TiempoIndicacionFallaTemporalSegundos.ToString();
                    txtTiempoFlashIndicacion.Text = (Prms.ParamsFCI.TiempoFlashIndicacion8ms * 8).ToString(); //Se multiplica por 8 para mostrar (viene en multiplos)
                    txtTiempoEntreFlashIndicacion.Text = Prms.ParamsFCI.TiermpoEntreFlashIndicacionSegundos.ToString();
                    txtTiempoProteccionInRush.Text = Prms.ParamsFCI.TiempoProteccionInRushSegundos.ToString();
                    txtTiempoRetardoValidacionTension.Text = Prms.ParamsFCI.TiempoRetardoValidacionTensionSegundos.ToString();
                    txtCorrienteAbsolutaDisparo.Text = Prms.ParamsFCI.CorrienteAbsolutaDisparo.ToString();
                    txtNumeroReintentosComunicaciones.Text = Prms.ParamsFCI.NumeroReintentosComunicacion.ToString();
                    txtSegundosProximaComunicacion.Text = Prms.ParamsFCI.SegundosParaProximaComunicacion.ToString();
                    txtCapacidadBateria.Text = Prms.ParamsFCI.CapacidadBateriaInstalada.ToString();

                }

            }
        }




    }//end of class
}