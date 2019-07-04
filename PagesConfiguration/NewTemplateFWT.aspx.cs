using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes
{
    public partial class NewTemplateFWT : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack )
            {
                 WizardNuevoTemplateParamFWT.ActiveStepIndex = 0; //Cuando se carga empieza siempre en el step que pide el nombre
            }
           
        }


        #region Metodos de Eventos Controles

        protected void WizardNuevoTemplateParamFWT_PreviousButtonClick(object sender, WizardNavigationEventArgs e)
        {
            Page.Validate();
            e.Cancel = !Page.IsValid;
        }

        protected void NextButtonClick(object sender, WizardNavigationEventArgs e)
        {
            switch (WizardNuevoTemplateParamFWT.WizardSteps[WizardNuevoTemplateParamFWT.ActiveStepIndex].ID)

            {
                default:
                    break;
            }
            llenarValores();
        }

        protected void WizardNuevoTemplateParamFWT_FinishButtonClick(object sender, WizardNavigationEventArgs e)
        {
            //Nota :Aqui se debe enviar como parametro el dato que tiene el prefijo BD
            CrearNuevaPlantillaParamFWT(lblNombreBD.Text, byte.Parse(lblCanalRFBD.Text), byte.Parse(lblVecesNoBD.Text), lblDirIpSCADABD.Text, short.Parse(lblPtoSCADABD.Text),
                lblDirIpGesBD.Text, short.Parse(lblPtoGesBD.Text), lblAPNBD.Text, lblUserBD.Text, lblPwdBD.Text, lblCalleBD.Text, lblNumeroBD.Text,
                lblCiudadBD.Text, lblSubEsBD.Text, lblCircuitoBD.Text, lblTramoBD.Text, lblLongitudBD.Text, lblLatitudBD.Text,
                byte.Parse(lblNumeroMaximoFCIBD.Text));

        }
        

        #endregion


        #region Metodos Auxiliares

        /// <summary>
        /// Llena los controles de ingreso a base de datos (labels) con los valores que se han recogido a partir de los diferentes WizardSteps
        /// </summary>
        private void llenarValores()
        {
            lblNombreBD.Text = txtNombre.Text;
            lblAPNBD.Text = txtAPN.Text;
            lblUserBD.Text = txtUsuario.Text;
            lblPwdBD.Text = txtPassword.Text;
            lblDirIpGesBD.Text = txtIpGestion.Text;
            lblPtoGesBD.Text = txtPuertoGestion.Text;
            lblDirIpSCADABD.Text = txtIpSCADA.Text;
            lblPtoSCADABD.Text = txtPuertoSCADA.Text;
            lblCiudadBD.Text = txtCiudad.Text;
            lblCalleBD.Text = txtCalle.Text;
            lblNumeroBD.Text = txtNumero.Text;
            lblSubEsBD.Text = txtSubEstacion.Text;
            lblCircuitoBD.Text = txtCircuito.Text;
            lblTramoBD.Text = txtTramo.Text;
            lblLatitudBD.Text = txtLatitud.Text;
            lblLongitudBD.Text = txtLongitud.Text;
            lblCanalRFBD.Text = txtCanalRF.Text;
            lblVecesNoBD.Text = txtVecesNoReportar.Text;
            lblNumeroMaximoFCIBD.Text = txtNumeroMaximoFCI.Text; //19 campos
        }

        /// <summary>
        /// Ingresa un objeto TemplateParametrosFWT a base de datos utilizando EF 4.0
        /// </summary>
        /// <param name="nombre"></param>
        /// <param name="canalRF"></param>
        /// <param name="vecesSinReportarse"></param>
        /// <param name="direccionIPSCADA"></param>
        /// <param name="puertoSCADA"></param>
        /// <param name="direccionIPGESTION"></param>
        /// <param name="puertoGESTION"></param>
        /// <param name="aPN"></param>
        /// <param name="usuario"></param>
        /// <param name="password"></param>
        /// <param name="calleCarrera"></param>
        /// <param name="numero"></param>
        /// <param name="ciudad"></param>
        /// <param name="subEstacion"></param>
        /// <param name="circuito"></param>
        /// <param name="tramo"></param>
        /// <param name="longitud"></param>
        /// <param name="latitud"></param>
        /// <param name="numeroMaximoFCIs"></param>
        private void CrearNuevaPlantillaParamFWT(string nombre, Byte canalRF, Byte vecesSinReportarse, String direccionIPSCADA, Int16 puertoSCADA, String direccionIPGESTION,
            Int16 puertoGESTION, String aPN, String usuario, String password, String calleCarrera, string numero, String ciudad,
            String subEstacion, String circuito, String tramo, String longitud, String latitud,
            Byte numeroMaximoFCIs)
        {
            byte apnUsado = 0;
            try
            {
                using (SistemaGestionRemotoContainer baseDatos = new SistemaGestionRemotoContainer())
                {
                    UbicacionDireccion direccionNomenclatura = UbicacionDireccion.CreateUbicacionDireccion(calleCarrera, numero, ciudad);
                    UbicacionElectrica direccionElectrica = UbicacionElectrica.CreateUbicacionElectrica(subEstacion, circuito, tramo, "");
                    UbicacionGPS direccionGPS = UbicacionGPS.CreateUbicacionGPS(longitud, latitud);

                    if ((aPN.Length <= 29) && (usuario.Length <= 15) && (password.Length <= 15))
                    {
                        apnUsado = 0;
                    }
                    else
                    {
                        apnUsado = 1;
                    }

                    ParametrosFWT paramFWT = ParametrosFWT.CreateParametrosFWT(canalRF, vecesSinReportarse, direccionIPSCADA, puertoSCADA, direccionIPGESTION, puertoGESTION,
                                                aPN, usuario, password, direccionNomenclatura, direccionElectrica, direccionGPS, numeroMaximoFCIs
                                                , "", "", "", "", "", "", 30, 4, 6, 3, 18000, 87m, 11m, 190m, 192m, 7, "", apnUsado, 120, 0, 120, true, 0, false);
                    TemplateParametrosFWT tmplParamFWT = TemplateParametrosFWT.CreateTemplateParametrosFWT(1, nombre, paramFWT);
                    baseDatos.TemplatesParametrosFWT.AddObject(tmplParamFWT); //Se adiciona a la colección de estas entidades
                    baseDatos.SaveChanges();
                    lblPlantillaIngresada.Text = "La plantilla de concentrador ha sido registrado en el sistema exitosamente.";

                }
            }
            catch (Exception e)
            {

                lblPlantillaIngresada.Text = "Error al crear plantilla . Error = " + e.Message;
            }
        }


        #endregion

               


        #region Metodos de Validadores

        public void CheckNombreTemplate(Object source, ServerValidateEventArgs args)
        {
            if (AccesoDatosEF.ExisteTemplateFWT(args.Value))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }


        #endregion

        

    }
}