using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes
{
    public partial class TemplatesFWT : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (! Page.IsPostBack)
            {
                
                LoadPlantillasParametrosFWTDropDownList();
                CargarDatosPlantilla();
                tbContainerPlantillasConcentrador.ActiveTabIndex = 0; //Muestra tab general
            }
        }

        #region Metodos Eventos Controles

        protected void ddlPlantillasFWT_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblEstadoActualizacion.Visible = false;
            CargarDatosPlantilla();
        }

        protected void butActualizar_Click(object sender, EventArgs e)
        {
            if (HayErrorEnTab())
            {
                return;
            }

            lblEstadoActualizacion.Visible = true;
            if (ddlPlantillasFWT.SelectedValue != "")
            {
                int tmplID = int.Parse(ddlPlantillasFWT.SelectedValue);
                using (SistemaGestionRemotoContainer bData = new SistemaGestionRemotoContainer())
                {
                    TemplatesParametrosFWT tmplParamFwt = bData.TemplatesParametrosFWTs.SingleOrDefault(t => t.Id == tmplID);
                    if (tmplParamFwt != null)
                    {


                        //Se actualizan todos los campos 
                        tmplParamFwt.Nombre = txtNombre.Text;
                        tmplParamFwt.Parametros.CanalRF = byte.Parse(txtCanalRF.Text);
                        //tmplParamFwt.Parametros.VecesSinReportarse = byte.Parse(txtVecesNoReportar.Text);
                        tmplParamFwt.Parametros.NumeroMaximoFCIs = byte.Parse(txtNumeroMaximoFCI.Text);
                        tmplParamFwt.Parametros.APN = txtAPN.Text;
                        tmplParamFwt.Parametros.Usuario = txtUsuario.Text;
                        tmplParamFwt.Parametros.Password = txtPassword.Text;
                        tmplParamFwt.Parametros.DireccionIPGestion = txtIpGestion.Text;
                        tmplParamFwt.Parametros.PuertoGESTION = short.Parse(txtPuertoGestion.Text);
                        tmplParamFwt.Parametros.DireccionIPSCADA = txtIpSCADA.Text;
                        tmplParamFwt.Parametros.PuertoSCADA = short.Parse(txtPuertoSCADA.Text);
                        tmplParamFwt.Parametros.DireccionNomenclatura.Ciudad = txtCiudad.Text;
                        tmplParamFwt.Parametros.DireccionNomenclatura.CalleCarrera = txtCalle.Text;
                        tmplParamFwt.Parametros.DireccionNomenclatura.Numero = txtNumero.Text;
                        tmplParamFwt.Parametros.DireccionElectrica.SubEstacion = txtSubEstacion.Text;
                        tmplParamFwt.Parametros.DireccionElectrica.Circuito = txtCircuito.Text;
                        tmplParamFwt.Parametros.DireccionElectrica.Tramo = txtTramo.Text;
                        tmplParamFwt.Parametros.DireccionGPS.Latitud = txtLatitud.Text;
                        tmplParamFwt.Parametros.DireccionGPS.Longitud = txtLongitud.Text;
                        bData.SaveChanges();
                        lblEstadoActualizacion.Text = "Plantilla de parametros de concentrador actualizada. ";
                        LoadPlantillasParametrosFWTDropDownList(); //Puedo haber cambiado el nombre 
                        foreach (ListItem item in ddlPlantillasFWT.Items)
                        {
                            if (int.Parse(item.Value) == tmplID)
                            {
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
            else
            {
                lblEstadoActualizacion.Text = "No hay seleccionado una plantilla de parametros de concentrador para actualizar. ";
            }
        }

        protected void butDelete_Click(object sender, EventArgs e)
        {
            lblEstadoActualizacion.Visible = true;
            if (ddlPlantillasFWT.SelectedValue != "")
            {
                int tmplID = int.Parse(ddlPlantillasFWT.SelectedValue);
                using (SistemaGestionRemotoContainer bData = new SistemaGestionRemotoContainer())
                {
                    TemplatesParametrosFWT tmplParamFwt = bData.TemplatesParametrosFWTs.SingleOrDefault(t => t.Id == tmplID);
                    if (tmplParamFwt != null)
                    {


                        bData.ObjectStateManager.ChangeObjectState(tmplParamFwt, System.Data.EntityState.Deleted);
                        bData.SaveChanges();
                        lblEstadoActualizacion.Text = "Plantilla de parametros de concentrador borrada. ";
                        LoadPlantillasParametrosFWTDropDownList(); //se carga de nuevo el ddlist
                        CargarDatosPlantilla();
                    }

                }
            }
            else
            {
                lblEstadoActualizacion.Text = "No hay seleccionado una plantilla de parametros de concentrador para borrar. ";
            }

        }

        #endregion


        #region Metodos Auxiliares

        private void LoadPlantillasParametrosFWTDropDownList()
        {
            lblEstadoActualizacion.Visible = false;
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

        private void BorrarDatos()
        {
            txtNombre.Text = "";
            txtCanalRF.Text = "1";
            txtVecesNoReportar.Text = "";
            txtNumeroMaximoFCI.Text = "";
            txtAPN.Text = "";
            txtUsuario.Text = "";
            txtPassword.Text = "";
            txtIpGestion.Text = "";
            txtPuertoGestion.Text = "";
            txtIpSCADA.Text = "";
            txtPuertoSCADA.Text = "";
            txtCiudad.Text = "";
            txtCalle.Text = "";
            txtNumero.Text = "";
            txtSubEstacion.Text = "";
            txtCircuito.Text = "";
            txtTramo.Text = "";
            txtLatitud.Text = "";
            txtLongitud.Text = "";
        }

        private void CargarDatosPlantilla()
        {
            if (ddlPlantillasFWT.SelectedValue != "")
            {
                using (SistemaGestionRemotoContainer bData = new SistemaGestionRemotoContainer())
                {
                    int idTmplFWT = int.Parse(ddlPlantillasFWT.SelectedValue);
                    TemplatesParametrosFWT tmplParamFwt = bData.TemplatesParametrosFWTs.SingleOrDefault(t => t.Id == idTmplFWT);
                    if (tmplParamFwt != null)
                    {


                        txtNombre.Text = tmplParamFwt.Nombre;
                        txtCanalRF.Text = tmplParamFwt.Parametros.CanalRF.ToString();
                        txtVecesNoReportar.Text = tmplParamFwt.Parametros.VecesSinReportarse.ToString();
                        txtNumeroMaximoFCI.Text = tmplParamFwt.Parametros.NumeroMaximoFCIs.ToString();
                        txtAPN.Text = tmplParamFwt.Parametros.APN;
                        txtUsuario.Text = tmplParamFwt.Parametros.Usuario;
                        txtPassword.Text = tmplParamFwt.Parametros.Password;
                        txtIpGestion.Text = tmplParamFwt.Parametros.DireccionIPGestion;
                        txtPuertoGestion.Text = tmplParamFwt.Parametros.PuertoGESTION.ToString();
                        txtIpSCADA.Text = tmplParamFwt.Parametros.DireccionIPSCADA;
                        txtPuertoSCADA.Text = tmplParamFwt.Parametros.PuertoSCADA.ToString();
                        txtCiudad.Text = tmplParamFwt.Parametros.DireccionNomenclatura.Ciudad;
                        txtCalle.Text = tmplParamFwt.Parametros.DireccionNomenclatura.CalleCarrera;
                        txtNumero.Text = tmplParamFwt.Parametros.DireccionNomenclatura.Numero.ToString();
                        txtSubEstacion.Text = tmplParamFwt.Parametros.DireccionElectrica.SubEstacion;
                        txtCircuito.Text = tmplParamFwt.Parametros.DireccionElectrica.Circuito;
                        txtTramo.Text = tmplParamFwt.Parametros.DireccionElectrica.Tramo;
                        txtLatitud.Text = tmplParamFwt.Parametros.DireccionGPS.Latitud.ToString();
                        txtLongitud.Text = tmplParamFwt.Parametros.DireccionGPS.Longitud.ToString();
                    }
                }
            }
            else
            {   //No se seleccionó plantilla . todo queda vacio
                BorrarDatos();

            }
        }
        
        private bool HayErrorEnTab()
        {
            bool rta = false;

            Page.Validate("general");
            if (!Page.IsValid)
            {
                tbContainerPlantillasConcentrador.ActiveTab = tbContainerPlantillasConcentrador.Tabs[0];
                rta = true;
                return rta;
            }

            Page.Validate("grupoGPRS");
            if (!Page.IsValid)
            {
                tbContainerPlantillasConcentrador.ActiveTab = tbContainerPlantillasConcentrador.Tabs[1];
                rta = true;
                return rta;
            }

            Page.Validate("datosRed");
            if (!Page.IsValid)
            {
                tbContainerPlantillasConcentrador.ActiveTab = tbContainerPlantillasConcentrador.Tabs[2];
                rta = true;
                return rta;
            }

            Page.Validate("datosNomenclatura");
            if (!Page.IsValid)
            {
                tbContainerPlantillasConcentrador.ActiveTab = tbContainerPlantillasConcentrador.Tabs[3];
                rta = true;
                return rta;
            }

            Page.Validate("datosDirElectrica");
            if (!Page.IsValid)
            {
                tbContainerPlantillasConcentrador.ActiveTab = tbContainerPlantillasConcentrador.Tabs[4];
                rta = true;
                return rta;
            }

            return rta;

        }

        #endregion



        #region Metodos Validadores

        public void CheckNombreTemplate(Object source, ServerValidateEventArgs args)
        {
            if (AccesoDatosEF.ExisteTemplateFWT_Update(args.Value, int.Parse(ddlPlantillasFWT.SelectedValue)))
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