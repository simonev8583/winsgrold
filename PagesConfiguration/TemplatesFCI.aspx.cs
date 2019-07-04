using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes
{
    public partial class TemplatesFCI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                LoadPlantillasParametrosFCIDropDownList();
                CargarDatosPlantilla();
                tbContainerPlantillasFCI.ActiveTabIndex = 0; //Muestra tab general
            }
        }


        #region Metodos Auxiliares

        private void LoadPlantillasParametrosFCIDropDownList()
        {
            lblEstadoActualizacion.Visible = false;
            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {


                ddlPlantillasFCI.DataSource = from u in db.TemplatesParametrosFCI
                                              orderby u.Id
                                              select new { Name = u.Nombre, Id = u.Id };

                ddlPlantillasFCI.DataTextField = "Name";
                ddlPlantillasFCI.DataValueField = "Id";
                ddlPlantillasFCI.DataBind();



            }



        }

        private void BorrarDatos()
        {
            txtNombre.Text = "";
            txtCorrienteAbsolutaDisparo.Text = "";
            txtNumeroReintentosComunicaciones.Text = "";
            txtSegundosProximaComunicacion.Text = "";
            txtCapacidadBateria.Text = "";
            rdButModoProporcional.Checked = true;
            txtValorFalla.Text = "";
            chkBoxModoRepPorTiempo.Checked = false;
            chkBoxModoRepPorTension.Checked = false;
            chkBoxModoRepPorMagneto.Checked = false;
            chkBoxModoRepPorCorriente.Checked = false;
            chkBoxHabReloj.Checked = false;
            chkBoxHabFallaTransitoria.Checked = false;
            txtTiempoValFalla.Text = "";
            txtToleranciaTensionReposicion.Text = "";
            txtTiempoReposicion.Text = "";
            txtTiempoIndicacionFallatemp.Text = "";
            txtTiempoFlashIndicacion.Text = "";
            txtTiempoEntreFlashIndicacion.Text = "";
            txtTiempoProteccionInRush.Text = "";
            txtTiempoRetardoValidacionTension.Text = "";

        }

        private void CargarDatosPlantilla()
        {
            if (ddlPlantillasFCI.SelectedValue != "")
            {
                using (SistemaGestionRemotoContainer bData = new SistemaGestionRemotoContainer())
                {
                    int idTmplFCI = int.Parse(ddlPlantillasFCI.SelectedValue);
                    TemplateParametrosFCI tmplParamFCI = bData.TemplatesParametrosFCI.SingleOrDefault(t => t.Id == idTmplFCI);
                    if (tmplParamFCI != null)
                    {
                   
                            txtNombre.Text = tmplParamFCI.Nombre;
                            txtCorrienteAbsolutaDisparo.Text = tmplParamFCI.Parametros.CorrienteAbsolutaDisparo.ToString();
                            txtNumeroReintentosComunicaciones.Text = tmplParamFCI.Parametros.NumeroReintentosComunicacion.ToString();
                            txtSegundosProximaComunicacion.Text = tmplParamFCI.Parametros.SegundosParaProximaComunicacion.ToString();
                            txtCapacidadBateria.Text = tmplParamFCI.Parametros.CapacidadBateriaInstalada.ToString();
                            switch (tmplParamFCI.Parametros.ModoDisparo)
                            {
                                case 0:
                                    rdButModoProporcional.Checked = true;
                                    break;
                                case 1:
                                    rdButModoPorIncremento.Checked = true;
                                    break;
                                case 2:
                                    rdButModoPorValorFijo.Checked = true;
                                    break;
                                case 3:
                                    rdButModoPorAutoRango.Checked = true;
                                    break;
                            }

                            txtValorFalla.Text = tmplParamFCI.Parametros.ValorFalla.ToString();

                            chkBoxModoRepPorTiempo.Checked = tmplParamFCI.Parametros.ReposicionPorTiempo;
                            chkBoxModoRepPorTension.Checked = tmplParamFCI.Parametros.ReposicionPorTension;
                            chkBoxModoRepPorMagneto.Checked = tmplParamFCI.Parametros.ReposicionPorMagneto;
                            chkBoxModoRepPorCorriente.Checked = tmplParamFCI.Parametros.ReposicionPorCorriente;
                            chkBoxHabReloj.Checked = tmplParamFCI.Parametros.HabilitarFallaTransitoria;
                            chkBoxHabFallaTransitoria.Checked = tmplParamFCI.Parametros.HabilitarReloj;
                            txtTiempoValFalla.Text = tmplParamFCI.Parametros.TiempoValidacionFallaSegundos.ToString();
                            txtToleranciaTensionReposicion.Text = tmplParamFCI.Parametros.ToleranciaTensionReposicion.ToString();
                            txtTiempoReposicion.Text = tmplParamFCI.Parametros.TiempoReposicionSegundos.ToString();
                            txtTiempoIndicacionFallatemp.Text = tmplParamFCI.Parametros.TiempoIndicacionFallaTemporalSegundos.ToString();
                            txtTiempoFlashIndicacion.Text = tmplParamFCI.Parametros.TiempoFlashIndicacion8ms.ToString();
                            txtTiempoEntreFlashIndicacion.Text = tmplParamFCI.Parametros.TiermpoEntreFlashIndicacionSegundos.ToString();
                            txtTiempoProteccionInRush.Text = tmplParamFCI.Parametros.TiempoProteccionInRushSegundos.ToString();
                            txtTiempoRetardoValidacionTension.Text = tmplParamFCI.Parametros.TiempoRetardoValidacionTensionSegundos.ToString();
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
                tbContainerPlantillasFCI.ActiveTab = tbContainerPlantillasFCI.Tabs[0];
                rta = true;
                return rta;
            }

            Page.Validate("ModoDisparo");
            if (!Page.IsValid)
            {
                tbContainerPlantillasFCI.ActiveTab = tbContainerPlantillasFCI.Tabs[1];
                rta = true;
                return rta;
            }

            Page.Validate("Tiempos");
            if (!Page.IsValid)
            {
                tbContainerPlantillasFCI.ActiveTab = tbContainerPlantillasFCI.Tabs[4];
                rta = true;
                return rta;
            }


            return rta;

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
                txtValorFalla.Visible = false;
                lblUnids.Text = "";
                lblUnids.Visible = false;
                txtValorFalla.Visible = false;
            }
        }

        protected void butActualizar_Click(object sender, EventArgs e)
        {

            if (HayErrorEnTab())
            {
                return;
            }

            lblEstadoActualizacion.Visible = true;
            if (ddlPlantillasFCI.SelectedValue != "")
            {
                int tmplID = int.Parse(ddlPlantillasFCI.SelectedValue);
                using (SistemaGestionRemotoContainer bData = new SistemaGestionRemotoContainer())
                {
                    TemplateParametrosFCI tmplParamFci = bData.TemplatesParametrosFCI.SingleOrDefault(t => t.Id == tmplID);
                    //Se actualizan todos los campos 
                    if (tmplParamFci != null)
                    {
                 
                    tmplParamFci.Nombre = txtNombre.Text;
                    tmplParamFci.Parametros.CorrienteAbsolutaDisparo = short.Parse(txtCorrienteAbsolutaDisparo.Text);
                    tmplParamFci.Parametros.NumeroReintentosComunicacion = byte.Parse(txtNumeroReintentosComunicaciones.Text);
                    tmplParamFci.Parametros.SegundosParaProximaComunicacion = int.Parse(txtSegundosProximaComunicacion.Text);
                    tmplParamFci.Parametros.CapacidadBateriaInstalada = short.Parse(txtCapacidadBateria.Text);
                    if (rdButModoProporcional.Checked)
                    {
                        tmplParamFci.Parametros.ModoDisparo = 0;
                    }
                    else if (rdButModoPorIncremento.Checked)
                    {
                        tmplParamFci.Parametros.ModoDisparo = 1;
                    }
                    else if (rdButModoPorValorFijo.Checked)
                    {
                        tmplParamFci.Parametros.ModoDisparo = 2;
                    }
                    else
                    {
                        tmplParamFci.Parametros.ModoDisparo = 3;
                    }

                    tmplParamFci.Parametros.ValorFalla = short.Parse(txtValorFalla.Text);
                    tmplParamFci.Parametros.ReposicionPorTiempo = chkBoxModoRepPorTiempo.Checked;
                    tmplParamFci.Parametros.ReposicionPorTension = chkBoxModoRepPorTension.Checked;
                    tmplParamFci.Parametros.ReposicionPorMagneto = chkBoxModoRepPorMagneto.Checked;
                    tmplParamFci.Parametros.ReposicionPorCorriente = chkBoxModoRepPorCorriente.Checked;
                    tmplParamFci.Parametros.HabilitarReloj = chkBoxHabReloj.Checked;
                    tmplParamFci.Parametros.HabilitarFallaTransitoria = chkBoxHabFallaTransitoria.Checked;
                    tmplParamFci.Parametros.TiempoValidacionFallaSegundos = short.Parse(txtTiempoValFalla.Text);
                    tmplParamFci.Parametros.ToleranciaTensionReposicion = short.Parse(txtToleranciaTensionReposicion.Text);
                    tmplParamFci.Parametros.TiempoReposicionSegundos = int.Parse(txtTiempoReposicion.Text);
                    tmplParamFci.Parametros.TiempoIndicacionFallaTemporalSegundos = int.Parse(txtTiempoIndicacionFallatemp.Text);
                    tmplParamFci.Parametros.TiempoFlashIndicacion8ms = byte.Parse(txtTiempoFlashIndicacion.Text);
                    tmplParamFci.Parametros.TiermpoEntreFlashIndicacionSegundos = byte.Parse(txtTiempoEntreFlashIndicacion.Text);
                    tmplParamFci.Parametros.TiempoProteccionInRushSegundos = byte.Parse(txtTiempoProteccionInRush.Text);
                    tmplParamFci.Parametros.TiempoRetardoValidacionTensionSegundos = short.Parse(txtTiempoRetardoValidacionTension.Text);


                    bData.SaveChanges();
                    lblEstadoActualizacion.Text = "Plantilla de parametros de FCI actualizada. ";
                    LoadPlantillasParametrosFCIDropDownList(); //Pudo haber cambiado el valor del nombre 
                    //Se vuelve a seleccionar este objeto en el dropdownlist
                    foreach (ListItem item in ddlPlantillasFCI.Items)
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
                lblEstadoActualizacion.Text = "No hay seleccionado una plantilla de parametros de FCI para actualizar. ";
            }
        }

        protected void butDelete_Click(object sender, EventArgs e)
        {
            lblEstadoActualizacion.Visible = true;
            if (ddlPlantillasFCI.SelectedValue != "")
            {
                int tmplID = int.Parse(ddlPlantillasFCI.SelectedValue);
                using (SistemaGestionRemotoContainer bData = new SistemaGestionRemotoContainer())
                {
                    TemplateParametrosFCI tmplParamFCI = bData.TemplatesParametrosFCI.SingleOrDefault(t => t.Id == tmplID);
                    if (tmplParamFCI != null)
                    {


                        bData.ObjectStateManager.ChangeObjectState(tmplParamFCI, System.Data.EntityState.Deleted);
                        bData.SaveChanges();
                        lblEstadoActualizacion.Text = "Plantilla de parametros de FCI borrada. ";
                        LoadPlantillasParametrosFCIDropDownList(); //se carga de nuevo el ddlist
                        CargarDatosPlantilla();
                    }
                }
            }
            else
            {
                lblEstadoActualizacion.Text = "No hay seleccionado una plantilla de parametros de FCI para borrar. ";
            }

        }

        protected void ddlPlantillasFCI_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblEstadoActualizacion.Visible = false;
            CargarDatosPlantilla();
        }

        #endregion


        #region Metodos de Validadores

        public void CheckNombrePlantillaFCI(Object source, ServerValidateEventArgs args)
        {
            if (AccesoDatosEF.ExisteTemplateFCI_Update(args.Value, int.Parse(ddlPlantillasFCI.SelectedValue)))
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