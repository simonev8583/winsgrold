using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes
{
    public partial class NewTemplateFCI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                WizardNuevoTemplateParamFCI.ActiveStepIndex = 0;
            }
        }


        #region Metodos Eventos Controles

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
                lblNombreValorFalla.Text = "DeltaI (di/dt) :";
                txtValorFalla.Text = "2"; //Valor por defecto Delta
                lblUnids.Visible = true;
                lblUnids.Text = "2-100 Veces";
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
                lblNombreValorFalla.Text = "Escalón (Incremento) :";
                txtValorFalla.Text = "10";
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
                lblNombreValorFalla.Text = "Corriente :";
                txtValorFalla.Text = "10";
                lblUnids.Visible = true;
                lblUnids.Text = "(10-1000)A";
                txtValorFalla.Focus();

            }
            else if (rdButModoPorAutoRango.Checked)
            {
                ReqValPropor.Enabled = false;
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

        //Fue necesario este control para este evento en el caso de la configuración
        //de los Tiempos (varios prms del FCI), pues para este caso particular, que se 
        //cuenta con ValidationSummary, al existir error de algún control de validación,
        //la página estaba dejando hacer PostBack cuando se hacia click en alguna opción
        //del SideBar. La diferencia radical consiste en que se debe trabajar con la propiedad
        //ValidationGroup de todos los validadores.
        protected void WizardNuevoTemplateParamFCI_SideBarButtonClick(object sender, WizardNavigationEventArgs e)
        {
            //WizardStepConfiguraciones
            if (WizardNuevoTemplateParamFCI.WizardSteps[e.CurrentStepIndex].ID.Equals("WizardStepModoDisparo")
                || WizardNuevoTemplateParamFCI.WizardSteps[e.CurrentStepIndex].ID.Equals("WizardStepTiempos")
                || WizardNuevoTemplateParamFCI.WizardSteps[e.CurrentStepIndex].ID.Equals("WizardStepConfiguraciones"))
            {
                Page.Validate();
                e.Cancel = !Page.IsValid;
            }
        }


        protected void butCalcularAutonomia_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblAutonomia.Text = " = " + CalcularAutonomiaBateria() + " Horas";
            }
        }


        #endregion


        #region Botones Wizard

        protected void WizardNuevoTemplateParamFCI_FinishButtonClick(object sender, WizardNavigationEventArgs e)
        {
            byte modoDisparo = 0;

            switch (lblModoDisparoBD.Text.ToUpper())
            {
                case "PROPORCIONAL":
                    modoDisparo = 0;
                    break;
                case "POR INCREMENTO":
                    modoDisparo = 1;

                    break;
                case "POR VALOR FIJO":
                    modoDisparo = 2;
                    break;
                case "POR AUTORANGO":
                    modoDisparo = 3;
                    break;
            }

            //Aqui se va a ingresar los que está en visualizado en los controles sin BD (es el mismo valor de los que tienen el sufijo BD)
            CrearNuevaPlantillaParamFCI(txtNombre.Text, modoDisparo, short.Parse(txtValorFalla.Text), chkBoxModoRepPorTiempo.Checked, chkBoxModoRepPorTension.Checked,
                int.Parse(txtTiempoIndicacionFallatemp.Text), byte.Parse(txtTiempoFlashIndicacion.Text), byte.Parse(txtTiempoEntreFlashIndicacion.Text),
                byte.Parse(txtTiempoProteccionInRush.Text), short.Parse(txtCorrienteAbsolutaDisparo.Text), byte.Parse(txtNumeroReintentosComunicaciones.Text),
                int.Parse(txtSegundosProximaComunicacion.Text), short.Parse(txtTiempoRetardoValidacionTension.Text), chkBoxModoRepPorMagneto.Checked,
                chkBoxModoRepPorCorriente.Checked, chkBoxHabReloj.Checked, chkBoxHabFallaTransitoria.Checked, short.Parse(txtTiempoValFalla.Text),
                short.Parse(txtToleranciaTensionReposicion.Text), int.Parse(txtTiempoReposicion.Text), short.Parse(txtCapacidadBateria.Text));

        }

        protected void WizardNuevoTemplateParamFCI_NextButtonClick(object sender, WizardNavigationEventArgs e)
        {
            Page.Validate();
            if (!Page.IsValid)
            {
                e.Cancel = !Page.IsValid;
            }
            else
            {
                llenarValores();
            }

        }

        protected void WizardNuevoTemplateParamFCI_PreviousButtonClick(object sender, WizardNavigationEventArgs e)
        {
            Page.Validate();
            e.Cancel = !Page.IsValid;
        }

        #endregion


        #region Metodos Auxiliares

        private void CrearNuevaPlantillaParamFCI(string nombre, Byte modoDisparo, Int16 valorFalla, Boolean reposicionPorTiempo, Boolean reposicionPorTension,
            Int32 tiempoIndicacionFallaTemporalSegundos, Byte tiempoFlashIndicacion8ms, Byte tiermpoEntreFlashIndicacionSegundos, Byte tiempoProteccionInRushSegundos,
            Int16 corrienteAbsolutaDisparo, Byte numeroReintentosComunicacion, Int32 segundosParaProximaComunicacion, Int16 tiempoRetardoValidacionTensionSegundos,
            Boolean reposicionPorMagneto, Boolean reposicionPorCorriente, Boolean habilitarReloj, Boolean habilitarFallaTransitoria, Int16 tiempoValidacionFallaSegundos,
            Int16 toleranciaTensionReposicion, Int32 tiempoReposicionSegundos, Int16 capacidadBateriaInstalada)
        {
            try
            {
                using (SistemaGestionRemotoContainer ObjCont = new SistemaGestionRemotoContainer()) //SistemaGestionRemotoContainer es un object context del EF 4.0
                {
                    ParametrosFCI paramFCI = ParametrosFCI.CreateParametrosFCI(modoDisparo, valorFalla, reposicionPorTiempo, reposicionPorTension,
                        tiempoIndicacionFallaTemporalSegundos, tiempoFlashIndicacion8ms, tiermpoEntreFlashIndicacionSegundos, tiempoProteccionInRushSegundos,
                        corrienteAbsolutaDisparo, numeroReintentosComunicacion, segundosParaProximaComunicacion, tiempoRetardoValidacionTensionSegundos,
                        reposicionPorMagneto, reposicionPorCorriente, habilitarReloj, habilitarFallaTransitoria, tiempoValidacionFallaSegundos, toleranciaTensionReposicion,
                        tiempoReposicionSegundos, capacidadBateriaInstalada,false, true); //cambio bateria = false . Ete parametro se envia solamente él mismo que se reciba del FCI
                    TemplateParametrosFCI tmplParamFCI = TemplateParametrosFCI.CreateTemplateParametrosFCI(1, nombre, paramFCI);  //Se utilizan los factory Methods del EF 
                    ObjCont.TemplatesParametrosFCI.AddObject(tmplParamFCI);
                    ObjCont.SaveChanges();
                    lblPlantillaParamFCIIngresada.Text = "Plantilla de parametros FCI ingresada";
                }
            }
            catch (Exception e)
            {

                lblPlantillaParamFCIIngresada.Text = "No se puedo ingresar la plantilla de parametros FCI . Error = " + e.Message;
            }

        }



        /// <summary>
        /// Llena los controles para ingresar la plantilla a base de datos con los valores escogidos/escritos por el usuario.
        /// </summary>
        private void llenarValores()
        {
            lblNombreBD.Text = txtNombre.Text;
            if (rdButModoProporcional.Checked)
            {
                lblModoDisparoBD.Text = "Proporcional";
                lblNombreValorFallaBD.Text = "Delta (Di/Dt)";
            }
            if (rdButModoPorIncremento.Checked)
            {
                lblModoDisparoBD.Text = "Por Incremento";
                lblNombreValorFallaBD.Text = "Valor Escalón ";
            }

            if (rdButModoPorValorFijo.Checked)
            {
                lblModoDisparoBD.Text = "Por Valor Fijo";
                lblNombreValorFallaBD.Text = "Valor Corriente";
            }

            if (rdButModoPorAutoRango.Checked)
            {
                lblModoDisparoBD.Text = "Por AutoRango";
                lblNombreValorFallaBD.Text = "N/A";
            }
            lblValorFallaBD.Text = txtValorFalla.Text;
            chkBoxRepTiempoBD.Checked = chkBoxModoRepPorTiempo.Checked;
            chkBoxRepTensionBD.Checked = chkBoxModoRepPorTension.Checked;
            chkBoxRepMagnetoBD.Checked = chkBoxModoRepPorMagneto.Checked;
            chkBoxRepCorrienteBD.Checked = chkBoxModoRepPorCorriente.Checked;
            chkBoxHabRelojBD.Checked = chkBoxHabReloj.Checked;
            chkBoxHabFallaTransBD.Checked = chkBoxHabFallaTransitoria.Checked;
            lblTimeValFallaBD.Text = txtTiempoValFalla.Text;
            lblToleranciaTensBD.Text = txtToleranciaTensionReposicion.Text;
            lblTimeReposBD.Text = txtTiempoReposicion.Text;
            lblTimeIndicFallatempBD.Text = txtTiempoIndicacionFallatemp.Text;
            lblTimeIndicFlashBD.Text = txtTiempoFlashIndicacion.Text;
            lblTimeEntreIndicFlashBD.Text = txtTiempoEntreFlashIndicacion.Text;
            lblTimeProtecInRushBD.Text = txtTiempoProteccionInRush.Text;
            lblTimeRetardoValidTensionBD.Text = txtTiempoRetardoValidacionTension.Text;
            lblCorrienteAbsDisparoBD.Text = txtCorrienteAbsolutaDisparo.Text;
            lblNumReintComBD.Text = txtNumeroReintentosComunicaciones.Text;
            lblSegProxComBD.Text = txtSegundosProximaComunicacion.Text;
            lblCapBatInstBD.Text = txtCapacidadBateria.Text;
            lblAutonomiaBattInstBD.Text = CalcularAutonomiaBateriaFromBD();

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

        protected string CalcularAutonomiaBateriaFromBD()
        {
            double capBateria = (double)(double.Parse(lblCapBatInstBD.Text) / 1000d);
            double tpoDestello = (double)(double.Parse(lblTimeIndicFlashBD.Text) / 1000d);
            double tpoEntreFlash = double.Parse(lblTimeEntreIndicFlashBD.Text);

            double autonomia = (tpoEntreFlash * capBateria) / (0.14d * tpoDestello);

            int autoAproximada = (int)autonomia;

            return autoAproximada.ToString();
        }

        #endregion


        #region Metodos de Validadores

        public void CheckNombrePlantillaFCI(Object source, ServerValidateEventArgs args)
        {
            if (AccesoDatosEF.ExisteTemplateFCI(args.Value))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

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
        


    }
}