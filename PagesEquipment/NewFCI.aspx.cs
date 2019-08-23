using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes
{
    public partial class NewFCI : System.Web.UI.Page
    {
        /// <summary>
        /// Carga todos los concentradores en el dropdownlist ddlConcentradores
        /// </summary>
        private void LoadConcentradores()
        {
            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {
                ddlConcentradores.DataSource = from conc in db.FWTs
                                               orderby conc.Id
                                               select new { Id = conc.Id  , Ser = conc.Serial };
                ddlConcentradores.DataTextField = "Ser";
                ddlConcentradores.DataValueField = "Id";
                ddlConcentradores.DataBind();

            }
            if (ddlConcentradores.SelectedItem != null)
            {
                LlenarValoresConcentrador(int.Parse(ddlConcentradores.SelectedItem.Value));
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
                var consulta = from conc in bDatos.FWTs
                               where conc.Id == idConc
                               select conc;
                foreach (var registro in consulta) //Se recorre como una colección .
                {
                    lblCiudad.Text = registro.ParamFWT.DireccionNomenclatura.Ciudad;
                    lblCalle.Text = registro.ParamFWT.DireccionNomenclatura.CalleCarrera;
                    lblNumero.Text = registro.ParamFWT.DireccionNomenclatura.Numero.ToString();
                }

            }
        }

        private void LoadPlantillasParametrosFCIDropDownList()
        {

            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {


                ddlPlantillasFCI.DataSource = from u in db.TemplatesParametrosFCIs
                                              orderby u.Id
                                              select new { Name = u.Nombre, Id = u.Id };

                ddlPlantillasFCI.DataTextField = "Name";
                ddlPlantillasFCI.DataValueField = "Id";
                ddlPlantillasFCI.DataBind();



            }

        }

        private void llenarValoresPropios()
        {
            lblSerialBD.Text = txtSerial.Text;
            lblIdConcBD.Text = ddlConcentradores.SelectedValue;
            lblSerialConcMostrar.Text = ddlConcentradores.SelectedItem.Text;
            lblTipoCircuitoBD.Text = listBoxTipoCircuito.SelectedValue;
            switch (listBoxTipoCircuito.SelectedValue)
            {   
                case "1":
                    lblTipoCircuitoMostrar.Text = "Monofásico";
                    lblFaseBD.Text = "";
                    break;
                case "2":
                    lblTipoCircuitoMostrar.Text = "Bifásico";
                    lblFaseBD.Text = DDListFases.SelectedValue;
                    break;
                case "3":
                    lblTipoCircuitoMostrar.Text = "Trifásico";
                    lblFaseBD.Text = DDListFases.SelectedValue;
                    break;
            }
        }

        private void llenarValoresDePlantilla(int idPlantilla)
        {

            llenarValoresPropios();
            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {

                var registros = from reg in db.TemplatesParametrosFCIs
                                where reg.Id == idPlantilla
                                select reg;   //LINQ to SQL query para retornar todo el registro de esta plantilla


                foreach (var reg in registros) //Esta consulta se recorre como si fuera una colección .
                {
                    switch (reg.Parametros.ModoDisparo)
                    {
                        case 0:
                            lblModoDisparoBD.Text = "Proporcional";
                            lblNombreValorFallaBD.Text = "Delta (Di/Dt)";
                            break;
                        case 1:
                            lblModoDisparoBD.Text = "Por Incremento";
                            lblNombreValorFallaBD.Text = "Valor Escalón ";
                            break;
                        case 2:
                            lblModoDisparoBD.Text = "Por Valor Fijo";
                            lblNombreValorFallaBD.Text = "Valor Corriente";
                            break;
                        case 3:
                            lblModoDisparoBD.Text = "Por AutoRango";
                            lblNombreValorFallaBD.Text = "N/A";
                            break;
                    }
                    lblValorFallaBD.Text = reg.Parametros.ValorFalla.ToString();
                    chkBoxRepTiempoBD.Checked = reg.Parametros.ReposicionPorTiempo;
                    chkBoxRepTensionBD.Checked = reg.Parametros.ReposicionPorTension;
                    chkBoxRepMagnetoBD.Checked = reg.Parametros.ReposicionPorMagneto;
                    chkBoxRepCorrienteBD.Checked = reg.Parametros.ReposicionPorCorriente;
                    chkBoxHabRelojBD.Checked = reg.Parametros.HabilitarReloj;
                    chkBoxHabFallaTransBD.Checked = reg.Parametros.HabilitarFallaTransitoria;
                    lblTimeValFallaBD.Text = reg.Parametros.TiempoValidacionFallaSegundos.ToString();
                    lblToleranciaTensBD.Text = reg.Parametros.ToleranciaTensionReposicion.ToString();
                    lblTimeReposBD.Text = reg.Parametros.TiempoReposicionSegundos.ToString();
                    lblTimeIndicFallatempBD.Text = reg.Parametros.TiempoIndicacionFallaTemporalSegundos.ToString();
                    lblTimeIndicFlashBD.Text = reg.Parametros.TiempoFlashIndicacion8ms.ToString();
                    lblTimeEntreIndicFlashBD.Text = reg.Parametros.TiermpoEntreFlashIndicacionSegundos.ToString();
                    lblTimeProtecInRushBD.Text = reg.Parametros.TiempoIndicacionFallaTemporalSegundos.ToString();
                    lblTimeRetardoValidTensionBD.Text = reg.Parametros.TiempoRetardoValidacionTensionSegundos.ToString();
                    lblCorrienteAbsDisparoBD.Text = reg.Parametros.CorrienteAbsolutaDisparo.ToString();
                    lblNumReintComBD.Text = reg.Parametros.NumeroReintentosComunicacion.ToString();
                    lblSegProxComBD.Text = reg.Parametros.SegundosParaProximaComunicacion.ToString();
                    lblCapBatInstBD.Text = reg.Parametros.CapacidadBateriaInstalada.ToString();
                    lblAutonomiaBattInstBD.Text = CalcularAutonomiaBateriaFromBD() + " Horas";

                }



            }


        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadConcentradores();
                LoadPlantillasParametrosFCIDropDownList();
                WizardNuevoFCI.ActiveStepIndex = 0; //Siempre empieza en el primer Step
            }
        }

                

        private void CreateNewFCI(int idConcentrador, Byte modoDisparo, Int16 valorFalla, Boolean reposicionPorTiempo, Boolean reposicionPorTension,
                                  Int32 tiempoIndicacionFallaTemporalSegundos, Byte tiempoFlashIndicacion8ms, Byte tiermpoEntreFlashIndicacionSegundos,
                                  Byte tiempoProteccionInRushSegundos, Int16 corrienteAbsolutaDisparo, Byte numeroReintentosComunicacion,
                                  Int32 segundosParaProximaComunicacion, Int16 tiempoRetardoValidacionTensionSegundos, Boolean reposicionPorMagneto,
                                  Boolean reposicionPorCorriente, Boolean habilitarReloj, Boolean habilitarFallaTransitoria, Int16 tiempoValidacionFallaSegundos,
                                  Int16 toleranciaTensionReposicion, Int32 tiempoReposicionSegundos, Int16 capacidadBateriaInstalada, byte tipoCircuito, string valorFase, string serial)
        {
            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {
                ParametrosFCI paramFCI = ParametrosFCI.CreateParametrosFCI(modoDisparo, valorFalla, reposicionPorTiempo, reposicionPorTension,
                                  tiempoIndicacionFallaTemporalSegundos, tiempoFlashIndicacion8ms, tiermpoEntreFlashIndicacionSegundos,
                                  tiempoProteccionInRushSegundos, corrienteAbsolutaDisparo, numeroReintentosComunicacion,
                                  segundosParaProximaComunicacion, tiempoRetardoValidacionTensionSegundos, reposicionPorMagneto,
                                  reposicionPorCorriente, habilitarReloj, habilitarFallaTransitoria, tiempoValidacionFallaSegundos,
                                  toleranciaTensionReposicion, tiempoReposicionSegundos, capacidadBateriaInstalada, false, true); //Se crea con cambiobateria = false
                
                FCI fci = new FCI();
                fci.UltimaFechaInicializacion = DateTime.Now;
                fci.FechaRegistroGestion = DateTime.Now;  //queda sin fecha instalacion 
                fci.ParamFCI = paramFCI;
                fci.Serial = serial;
                fci.TipoCircuito = tipoCircuito;
                fci.Fase = valorFase;
                fci.PendienteRecibirParametros = true;
                fci.PendienteEnviarParametros = false;
                fci.PendienteConfirmarActualizacionParametros = false;
                //fci =    FCI.CreateFCI( DateTime.Now ,null , DateTime.Now , paramFCI,false,false,serial ,tipoCircuito ,valorFase,true, false); //Queda pendiente por recibir parametros de comunicaciones
                fci.FWTId = idConcentrador;
              
                db.FCIs.AddObject(fci);
                db.SaveChanges();
                lblFCIIngresado.Text = "El FCI ha sido registrado en el sistema exitosamente.";
            }

        }


        private void PermanecerEnStepSerial()
        {

            txtSerial.Focus();
            lblNoingresoSerial.Visible = true;
            WizardNuevoFCI.ActiveStepIndex = WizardNuevoFCI.WizardSteps.IndexOf(WizardStepEscogerParametros);
            WizardNuevoFCI.ActiveStepIndex = WizardNuevoFCI.WizardSteps.IndexOf(WizardStepSerial);//Se envia a cualquier step y despues se devuelve al mismo para que se quede en este estep
        }

        




        private void llenarValoresDefault()
        {
            llenarValoresPropios();

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
            lblAutonomiaBattInstBD.Text = CalcularAutonomiaBateria() + " Horas";

        }

        


        #region Metodos de Validadores

        public void CheckSerial(Object source, ServerValidateEventArgs args)
        {
            if (AccesoDatosEF.ExisteSerialenFCIs(args.Value))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        public void CheckPlantillaParametros(Object source, ServerValidateEventArgs args)
        {
            if (rdlParametrosPlantilla.Checked)
            {
                if (args.Value.Equals("0"))
                {
                    args.IsValid = false;
                }
                else
                {
                    args.IsValid = true;
                }
            }
            else
            {
                args.IsValid = true;
            }
        }

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


        #region Botones del Wizard

        protected void WizardNuevoFCI_NextButtonClick(object sender, WizardNavigationEventArgs e)
        {
            switch (WizardNuevoFCI.WizardSteps[WizardNuevoFCI.ActiveStepIndex].ID)
            {

                //case "WizardStepSerial":
                //    if ((txtSerial.Text == "") || (txtSerial.Text.Length != 8)) //Tiene que existir serial de 8 caracteres
                //    {
                //        PermanecerEnStepSerial();

                //    }
                //    else
                //    {
                //        if (AccesoDatosEF.ExisteSerialenFCIs(txtSerial.Text))
                //        {
                //            lblNoingresoSerial.Text = "Este Serial ya Existe !";
                //            PermanecerEnStepSerial();
                //        }
                //        else
                //        {
                //            lblNoingresoSerial.Visible = false;
                //        }

                //    }


                //    break;



                case "WizardStepEscogerParametros":
                    if (rdlParametrosPlantilla.Checked)
                    {
                        if (!String.IsNullOrEmpty(ddlPlantillasFCI.Text))
                        {
                            //Se chequeó por plantilla , se muestran los datos de la plantilla .
                            //Se va al final del Wizard para insertar el FCI con los datos de la plantilla seleccionada.
                            //lblDatosIng.Text = "Estos son los datos de la plantilla " + ddlPlantillasFCI.SelectedItem.Text + " para crear el concentrador:";
                            llenarValoresDePlantilla(int.Parse(ddlPlantillasFCI.Text));
                            WizardNuevoFCI.ActiveStepIndex = WizardNuevoFCI.WizardSteps.IndexOf(WizardStepDatosIngresados);

                        }
                        else
                        {   //Atención :Se debe escoger una plantilla si nono se puede avanzar . Verificar que no sea vacia Y debe quedarse en el mismo
                            //WizardStep , con una validación .. y un mensaje (No utilizar required field validator.
                            lblNoPlantilla.Visible = true;
                            ddlPlantillasFCI.Focus();
                            WizardNuevoFCI.ActiveStepIndex = WizardNuevoFCI.WizardSteps.IndexOf(WizardStepConfiguraciones);

                            WizardNuevoFCI.ActiveStepIndex = WizardNuevoFCI.WizardSteps.IndexOf(WizardStepEscogerParametros);
                        }

                    }

                    break;

                case "WizardStepConfiguraciones": //Si se ingresaron los datos del step parametros adicionales se muestran los datos ingresados completos
                    Page.Validate();
                    if (Page.IsValid)
                    {
                        //lblDatosIng.Text = "Estos son los datos ingresados para crear el FCI:";
                        llenarValoresDefault();
                    }
                    else
                    {
                        e.Cancel = !Page.IsValid;
                    }
                    break;

                default:
                    Page.Validate();
                    e.Cancel = !Page.IsValid;
                    break;



            }
        }

        protected void WizardNuevoFCI_PreviousButtonClick(object sender, WizardNavigationEventArgs e)
        {
            //Casos Especiales de Validación:
            //En selección de plantilla de datos de Prms o manualmente, si hay error se permite ir atrás.
            if (WizardNuevoFCI.WizardSteps[e.CurrentStepIndex].ID.Equals("WizardStepEscogerParametros"))
            {
                e.Cancel = false;
            }
            else
            {
                Page.Validate();
                e.Cancel = !Page.IsValid;
            }
        }

        protected void WizardNuevoFCI_FinishButtonClick(object sender, WizardNavigationEventArgs e)
        {
            byte modoDisparo = 0;
            string valFase;

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

            if (lblFaseBD.Text == "")
            {
                valFase = "";
            }
            else
            {
                valFase = lblFaseBD.Text;
            }

            CreateNewFCI(int.Parse(lblIdConcBD.Text), modoDisparo, short.Parse(lblValorFallaBD.Text), chkBoxRepTiempoBD.Checked,
                         chkBoxRepTensionBD.Checked, int.Parse(lblTimeIndicFallatempBD.Text), byte.Parse(lblTimeIndicFlashBD.Text),
                         byte.Parse(lblTimeEntreIndicFlashBD.Text), byte.Parse(lblTimeProtecInRushBD.Text), short.Parse(lblCorrienteAbsDisparoBD.Text),
                         byte.Parse(lblNumReintComBD.Text), int.Parse(lblSegProxComBD.Text), short.Parse(lblTimeRetardoValidTensionBD.Text),
                         chkBoxRepMagnetoBD.Checked, chkBoxRepCorrienteBD.Checked, chkBoxHabRelojBD.Checked, chkBoxHabFallaTransBD.Checked,
                         short.Parse(lblTimeValFallaBD.Text), short.Parse(lblToleranciaTensBD.Text), int.Parse(lblTimeReposBD.Text),
                         short.Parse(lblCapBatInstBD.Text), byte.Parse(lblTipoCircuitoBD.Text), valFase, lblSerialBD.Text);

        }

        #endregion


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
                lblNombreValorFalla.Text = "DeltaI (di/dt):";
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
                lblNombreValorFalla.Text = "Escalón(Incremento):";
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

        //Definir Ingreso de Parametros: Manual o por Plantilla
        protected void rdlParametrosManual_CheckedChanged(object sender, EventArgs e)
        {
            if (rdlParametrosPlantilla.Checked)
            {
                ddlPlantillasFCI.Enabled = true;
            }
            else
            {
                lblNoPlantilla.Visible = false;
                ddlPlantillasFCI.Enabled = false;
            }
        }

        //Definir Ingreso de Parametros: Manual o por Plantilla
        protected void rdlParametrosPlantilla_CheckedChanged(object sender, EventArgs e)
        {
            if (rdlParametrosPlantilla.Checked)
            {
                ddlPlantillasFCI.Enabled = true;
            }
            else
            {
                lblNoPlantilla.Visible = false;
                ddlPlantillasFCI.Enabled = false;
            }
        }

        //Relacionar el Concentrador FWT. Definir el Tipo de Circuito
        protected void listBoxTipoCircuito_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (listBoxTipoCircuito.SelectedValue)
            {
                case "1":
                    DDListFases.Enabled = false;
                    break;
                case "2":
                    DDListFases.Enabled = true;
                    DDListFases.Items.Clear();
                    DDListFases.Items.Add(new ListItem("A", "A"));
                    DDListFases.Items.Add(new ListItem("B", "B"));
                    break;
                case "3":
                    DDListFases.Enabled = true;
                    DDListFases.Items.Clear();
                    DDListFases.Items.Add(new ListItem("R", "R"));
                    DDListFases.Items.Add(new ListItem("S", "S"));
                    DDListFases.Items.Add(new ListItem("T", "T"));
                    break;
            }
        }

        //Relacionar el Concentrador FWT. Seleccionar el FWT
        protected void ddlConcentradores_SelectedIndexChanged(object sender, EventArgs e)
        {
            LlenarValoresConcentrador(int.Parse(ddlConcentradores.SelectedItem.Value));
        }

        //Fue necesario este control para este evento en el caso de la configuración
        //de los Tiempos (varios prms del FCI), pues para este caso particular, que se 
        //cuenta con ValidationSummary, al existir error de algún control de validación,
        //la página estaba dejando hacer PostBack cuando se hacia click en alguna opción
        //del SideBar. La diferencia radical consiste en que se debe trabajar con la propiedad
        //ValidationGroup de todos los validadores.
        protected void WizardNuevoFCI_SideBarButtonClick(object sender, WizardNavigationEventArgs e)
        {
            //WizardStepModoDisparo
            if (WizardNuevoFCI.WizardSteps[e.CurrentStepIndex].ID.Equals("WizardStepTiempos")
                || WizardNuevoFCI.WizardSteps[e.CurrentStepIndex].ID.Equals("WizardStepConfiguraciones")
                || WizardNuevoFCI.WizardSteps[e.CurrentStepIndex].ID.Equals("WizardStepModoDisparo"))
            {
                Page.Validate();
                e.Cancel = !Page.IsValid;
            }
        }

        //Para calcular la autonomia de la batería según valores definidos en los Prms de la sección Configuración.
        protected void butCalcularAutonomia_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblAutonomia.Text = " = " + CalcularAutonomiaBateria() + " Horas";
            }

        }

        protected string CalcularAutonomiaBateria()
        {
            double capBateria = (double)(double.Parse(txtCapacidadBateria.Text) / 1000d);
            double tpoDestello = (double)(double.Parse(txtTiempoFlashIndicacion.Text) / 1000d);
            double tpoEntreFlash = double.Parse(txtTiempoEntreFlashIndicacion.Text);

            double autonomia = (tpoEntreFlash * capBateria)/(0.14d * tpoDestello);

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

        

        

        

    }//end of class
}