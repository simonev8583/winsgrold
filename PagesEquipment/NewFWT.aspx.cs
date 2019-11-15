using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes
{
    public partial class NewFWT : System.Web.UI.Page
    {

        private void PermanecerEnStepSerial()
        {

            txtSerial.Focus();
            lblNoingresoSerial.Visible = true;
            WizardNuevoFWT.ActiveStepIndex = WizardNuevoFWT.WizardSteps.IndexOf(WizardStepEscogerParametros);
            WizardNuevoFWT.ActiveStepIndex = WizardNuevoFWT.WizardSteps.IndexOf(WizardStepSerial);//Se envia a cualquier step y despues se devuelve al mismo para que se quede en este estep
        }


        #region Metodos Botones Wizard

        protected void NextButtonClick(object sender, WizardNavigationEventArgs e)
        {

            switch (WizardNuevoFWT.WizardSteps[WizardNuevoFWT.ActiveStepIndex].ID)
            {
                case "WizardStepEscogerParametros":
                    if (rdlParametrosPlantilla.Checked)
                    {
                        if (!String.IsNullOrEmpty(ddlPlantillasFWT.Text))
                        {
                            //Se chequeó por plantilla , se muestran los datos de la plantilla .
                            lblDatosIng.Text = "Estos son los datos de la plantilla " + ddlPlantillasFWT.SelectedItem.Text + " para crear el concentrador:";
                            llenarValoresDePlantilla(int.Parse(ddlPlantillasFWT.Text));
                            WizardNuevoFWT.ActiveStepIndex = WizardNuevoFWT.WizardSteps.IndexOf(WizardStepDatosIngresados);

                        }
                        else
                        {   //Atención :Se debe escoger una plantilla si nono se puede avanzar . Verificar que no sea vacia Y debe quedarse en el mismo
                            //WizardStep , con una validación .. y un mensaje (No utilizar required field validator.)
                            lblNoPlantilla.Visible = true;
                            ddlPlantillasFWT.Focus();
                            WizardNuevoFWT.ActiveStepIndex = WizardNuevoFWT.WizardSteps.IndexOf(WizardStepParametrosAdicionales);
                            WizardNuevoFWT.ActiveStepIndex = WizardNuevoFWT.WizardSteps.IndexOf(WizardStepEscogerParametros); //Se retorna al mismo step
                        }

                    }

                    break;

                case "WizardStepParametrosAdicionales": //Si se ingresaron los datos del step parametros adicionales se muestran los datos ingresados completos
                    lblDatosIng.Text = "Estos son los datos ingresados para crear el concentrador:";
                    llenarValoresDefault();
                    break;
            }

        }

        protected void WizardNuevoFWT_PreviousButtonClick(object sender, WizardNavigationEventArgs e)
        {
            //Casos Especiales de Validación:
            //En selección de plantilla de datos de Prms o manualmente, si hay error se permite ir atrás.
            if (WizardNuevoFWT.WizardSteps[e.CurrentStepIndex].ID.Equals("WizardStepEscogerParametros"))
            {
                e.Cancel = false;
            }
            else
            {
                Page.Validate();
                e.Cancel = !Page.IsValid;
            }
        }

        protected void WizardNuevoFWT_FinishButtonClick(object sender, WizardNavigationEventArgs e)
        {
                CrearNuevoFWT(int.Parse(txtPeriodoReporteSeg.Text),
                              lblAPNBD.Text, lblUserBD.Text,
                              lblPwdBD.Text,
                              lblDirIpGesBD.Text,
                              short.Parse(lblPtoGesBD.Text), lblDirIpSCADABD.Text, short.Parse(lblPtoSCADABD.Text), lblCiudadBD.Text, lblCalleBD.Text,
                              lblNumeroBD.Text, lblSubEsBD.Text, lblCircuitoBD.Text, lblTramoBD.Text, lblLatitudBD.Text,
                              lblLongitudBD.Text, byte.Parse(lblCanalRFBD.Text), byte.Parse(lblVecesNoBD.Text), byte.Parse(lblNumeroMaximoFCIBD.Text),
                              lblSerialBD.Text);
        }

        #endregion




        private void llenarValoresPropios()
        {   //Estos datos son unicos para este FWT 
            lblSerialBD.Text = txtSerial.Text;
            lblPeriodoRepBD.Text = txtPeriodoReporteSeg.Text;
        }


        private void llenarValoresDefault()
        {
            llenarValoresPropios();
            lblAPNBD.Text = txtAPN.Text;
            lblUserBD.Text = txtUsuario.Text;
            lblPwdBD.Text = txtPassword.Text;
            lblDirIpGesBD.Text = txtIpGestion.Text;
            lblPtoGesBD.Text = txtPuertoGestion.Text;
            lblDirIpSCADABD.Text = txtIpSCADA.Text;
            lblPtoSCADABD.Text = txtPuertoSCADA.Text;
            lblCiudadBD.Text = txtCiudad.Text ;
            lblCalleBD.Text = txtCalle.Text;
            lblNumeroBD.Text = txtNumero.Text;
            lblSubEsBD.Text = txtSubEstacion.Text;
            lblCircuitoBD.Text = txtCircuito.Text;
            lblTramoBD.Text = txtTramo.Text;
            lblLatitudBD.Text = txtLatitud.Text;
            lblLongitudBD.Text = txtLongitud.Text;
            lblCanalRFBD.Text = txtCanalRF.Text;
            lblVecesNoBD.Text = txtVecesNoReportar.Text;
            lblNumeroMaximoFCIBD.Text = txtNumeroMaximoFCI.Text; //20 campos
        }

        /// <summary>
        /// Llena los valores de la plantilla desde BD en los campos del wizard step Datos ingresados .
        /// </summary>
        /// <param name="idPlantilla">id de la plantilla</param>
        private void llenarValoresDePlantilla(int idPlantilla)
        {
            llenarValoresPropios();

            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {

                var registros = from reg in db.TemplatesParametrosFWTs
                                where reg.Id == idPlantilla
                                select reg;   //LINQ to SQL query para retornar todo el registro de esta plantilla


                foreach (var reg in registros) //Esta consulta se recorre como si fuera una colección .
                {
                    lblAPNBD.Text = reg.Parametros.APN;
                    lblUserBD.Text = reg.Parametros.Usuario;
                    lblPwdBD.Text = reg.Parametros.Password;
                    lblDirIpGesBD.Text = reg.Parametros.DireccionIPGestion;
                    lblPtoGesBD.Text = reg.Parametros.PuertoGESTION.ToString();
                    lblDirIpSCADABD.Text = reg.Parametros.DireccionIPSCADA;
                    lblPtoSCADABD.Text = reg.Parametros.PuertoSCADA.ToString();
                    lblCiudadBD.Text = reg.Parametros.DireccionNomenclatura.Ciudad;
                    lblCalleBD.Text = reg.Parametros.DireccionNomenclatura.CalleCarrera;
                    lblNumeroBD.Text = reg.Parametros.DireccionNomenclatura.Numero.ToString();
                    lblSubEsBD.Text = reg.Parametros.DireccionElectrica.SubEstacion;
                    lblCircuitoBD.Text = reg.Parametros.DireccionElectrica.Circuito;
                    lblTramoBD.Text = reg.Parametros.DireccionElectrica.Tramo;
                    lblLatitudBD.Text = reg.Parametros.DireccionGPS.Latitud.ToString();
                    lblLongitudBD.Text = reg.Parametros.DireccionGPS.Longitud.ToString();
                    lblCanalRFBD.Text = reg.Parametros.CanalRF.ToString();
                    lblVecesNoBD.Text = reg.Parametros.VecesSinReportarse.ToString();
                    lblNumeroMaximoFCIBD.Text = reg.Parametros.NumeroMaximoFCIs.ToString(); //20 campos
                }



            }


        }


        /// <summary>
        /// Crea un nuevo FWT en base de datos .
        /// </summary>
        private void CrearNuevoFWT(int periodoReporte, string apn, string usr, string pwd, string ipGes, short ptoGes,
                                    string ipSCA, short ptoSCA, string ciudad, string calle, string numero, string subestacion,
                                    string circuito, string tramo, string latitud, string longitud, byte canalRF,
                                    byte vecesNoReportar, byte numeroMaximoFCIs , string serial )
        {
            byte apnUsado = 0;
            try
            {
                using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
                {
                    UbicacionDireccion ubicaDir = UbicacionDireccion.CreateUbicacionDireccion(calle,numero,ciudad);
                    UbicacionElectrica ubicaElec = UbicacionElectrica.CreateUbicacionElectrica(subestacion,circuito,tramo,"");
                    UbicacionGPS ubicaGPS = UbicacionGPS.CreateUbicacionGPS(longitud,latitud);

                    if ((apn.Length <= 29) && (usr.Length <= 15) && (pwd.Length <= 15))
                    {
                        apnUsado = 0;
                    }
                    else
                    {
                        apnUsado = 1;
                    }

                    ParametrosFWT paramFWT = ParametrosFWT.CreateParametrosFWT(
                        apn,
                        0,
                        canalRF,
                        7,
                        ubicaElec,
                        ubicaGPS,
                        ipGes,
                        ipSCA,
                        ubicaDir,
                        6,
                        4,
                        numeroMaximoFCIs,
                        0,
                        pwd,
                        periodoReporte,
                        120,
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        true,
                        ptoGes,
                        ptoSCA,
                        30,
                        120,
                        6,
                        apnUsado,
                        false,
                        usr,
                        vecesNoReportar,
                        192,
                        87m,
                        11m,
                        "",
                        190m
                    );

                    FWT fwt = FWT.CreateFWT(1, DateTime.Now, serial, true, false, paramFWT, 0, false);//sin falla empieza el equipo.//Queda pendiente por recibir parametros y No queda pendiente por enviar actualización 
                            
                    db.FWTs.AddObject(fwt);
                    db.SaveChanges();
                    lblConcentradorIngresado.Text = "El Concentrador ha sido registrado en el sistema exitosamente.";
                }
            }
            catch (Exception e)
            {

                lblConcentradorIngresado.Text = "No se pudo registrar el concentrador en el sistema !" + Environment.NewLine + "Error: " + e.Message;
            }


        }

        /// <summary>
        /// Se cargan las plantillas de la tabla TemplatesParametros FWT en un dropdownlist 
        /// </summary>
        private void LoadPlantillasParametrosFWTDropDownList()
        {

            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {


                ddlPlantillasFWT.DataSource = from u in db.TemplatesParametrosFWTs
                                              orderby u.Id
                                              select new { Name = u.Nombre, Id = u.Id };

                ddlPlantillasFWT.DataTextField = "Name";
                ddlPlantillasFWT.DataValueField = "Id";
                ddlPlantillasFWT.DataBind();


                //ddlPlantillasFWT.Items.Insert(0, new ListItem("", ""));  

            }



        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPlantillasParametrosFWTDropDownList();
                WizardNuevoFWT.ActiveStepIndex = 0; //Siempre empieza en el primer Step
                txtSerial.Focus();
            }

        }

    

        protected void rdlParametrosManual_CheckedChanged(object sender, EventArgs e)
        {
            if (rdlParametrosPlantilla.Checked)
            {
                ddlPlantillasFWT.Enabled = true;
            }
            else
            {
                lblNoPlantilla.Visible = false;
                ddlPlantillasFWT.Enabled = false;
            }
        }

        protected void rdlParametrosPlantilla_CheckedChanged(object sender, EventArgs e)
        {
            if (rdlParametrosPlantilla.Checked)
            {
                ddlPlantillasFWT.Enabled = true;
            }
            else
            {
                lblNoPlantilla.Visible = false;
                ddlPlantillasFWT.Enabled = false;
            }
        }


        #region Metodos de CustomValidators

        public void CheckSerial(Object source, ServerValidateEventArgs args)
        {
            if (AccesoDatosEF.ExisteSerialenFWTs(args.Value))
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

        #endregion
          
    }//end of class
}