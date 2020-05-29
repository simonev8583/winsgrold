using System;
using System.Globalization;
using System.Collections.Generic;
using System.Linq;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using AjaxControlToolkit;
using System.IO;
using SGR.DataAccessLayer;
using SGR.BussinessLayer;

namespace SistemaGestionRedes
{
    public partial class CircuitFault : System.Web.UI.Page
    {
        private const short _ID_REPORTE = 80;

        private const byte _INDEX_COLUMNA_CAUSA_APERTURA = 17;
        private const byte _INDEX_COLUMNA_BAJAR_MANUAL = 19;

        private bool _verSix;

        static double  duracionIndicacionAlarma;
        static string _codLang;

        private void MostrarErrorBaseDatos()
        {
            ViewState["errorBaseDatos"] = true;
            LblMsgNoData.Text = (string)this.GetLocalResourceObject("TextErrorBaseDatos");
            LblMsgNoData.ForeColor = Color.Red;
            LblMsgNoData.Visible = true;
            CollapsiblePanelExtenderActual.Collapsed = false;
        }

        private void QuitarErrorBaseDatos()
        {
            ViewState["errorBaseDatos"] = false;
            LblMsgNoData.ForeColor = Color.Black;
            LblMsgNoData.Visible = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                duracionIndicacionAlarma = ConfigApp.PeriodoSonidoAlarma;
                _codLang = AccesoDatosEF.ConfirmarLenguaje(CultureInfo.CurrentUICulture.TwoLetterISOLanguageName);
                SqDSListaFallas.SelectParameters["IdLang"].DefaultValue = _codLang;
                SqDSFallasAll.SelectParameters["IdLang"].DefaultValue = _codLang;
                SqDSxFalla.SelectParameters["IdLang"].DefaultValue = _codLang;
                SqlDataSourceHistorico.SelectParameters["IdLang"].DefaultValue = _codLang;
                _verSix = ConfigApp.VerSix;
                TryOcultarColumnasOnlySix();
            }
        }

        protected void TryOcultarColumnasOnlySix()
        {
            if (!_verSix)
            {
                GVFallasCtos.Columns[_INDEX_COLUMNA_CAUSA_APERTURA].Visible = false;
                GVFallasCtos.Columns[_INDEX_COLUMNA_BAJAR_MANUAL].Visible = false;
                GridViewHistorico.Columns[_INDEX_COLUMNA_CAUSA_APERTURA].Visible = false;
            }
        }


        protected void GVFallasCtos_DataBound(object sender, EventArgs e)
        {
            if (GVFallasCtos.Rows.Count == 0)
            {
                LblMsgNoData.Visible = true;
            }
            else
            {
                LblMsgNoData.Visible = false ;
            }
            
        }

        protected void DDListFallas_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDListFallas.SelectedValue.Equals("0"))
            {
                GVFallasCtos.DataSourceID = "SqDSFallasAll";
            }
            else
            {
                GVFallasCtos.DataSourceID = "SqDSxFalla";
            }
            GVFallasCtos.DataBind();
        }

        protected void tmrCircuitFault_Tick(object sender, EventArgs e)
        {
            try
            {  //chequear si es necesario HACER un l o c k 
                AnalizarClearManualAlarmas();
                UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVFallasCtos, _ID_REPORTE, User.Identity.Name);
                GVFallasCtos.DataBind();
                //28 junio
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "valRedRows", "checkFilasRojas();", true);
            }
            catch
            {
                
            } 
        }

        protected void tmrHistorico_Tick(object sender, EventArgs e)
        {
            try
            {
                UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GridViewHistorico, _ID_REPORTE, Membership.GetUser().UserName);
                GridViewHistorico.DataBind();
            }
            catch
            {

            } 
        }

        protected void GridViewHistorico_DataBound(object sender, EventArgs e)
        {
            if (GridViewHistorico.Rows.Count == 0)
            {
                lblNoDataHistorico.Visible = true;
            }
            else
            {
                lblNoDataHistorico.Visible = false;
            }
        }

        protected void tmrTimeActual_Tick(object sender, EventArgs e)
        {
            //lblTimeActual.Text = DateTime.Now.ToLongTimeString();
            lblTimeActual.Text = string.Format("{0:HH:mm:ss}", Convert.ToDateTime(DateTime.Now.ToLongTimeString()).AddHours(0));
        }

        protected void lblTimeActual_Load(object sender, EventArgs e)
        {
            //lblTimeActual.Text = DateTime.Now.ToLongTimeString(); //Tiempo inicial antes del primer tick
            lblTimeActual.Text = string.Format("{0:HH:mm:ss}", Convert.ToDateTime(DateTime.Now.ToLongTimeString()).AddHours(0));
        }

        protected void GVFallasCtos_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string valorTxt = "";

                //Control de alarmas recientes
                DateTime fecha = Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "Fecha"));
                TimeSpan dateDiff = DateTime.Now.Subtract(fecha);
                if (dateDiff.TotalMinutes < duracionIndicacionAlarma)
                {
                    e.Row.BackColor = Color.Red;
                    //28 juinio
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "markRojas", "chkRedRows=true;", true);
                }

                //Control de tipo de equipo para permitir Clear Manual de Alarmas
                //Por ahora solo es posible hacer clear/bajar manual de fallas de equipos tipo SIX.
                //Se deshabilita el CheckBox para los otros equipos.
                byte textTipoE = (byte)DataBinder.Eval(e.Row.DataItem, "TipoEquipo");
                TipoEquipoRed tipoEquipo = (TipoEquipoRed)textTipoE;
                if (tipoEquipo != TipoEquipoRed.SIXDG)
                {
                    ((CheckBox)e.Row.FindControl("chkClear")).Enabled = false;
                }
                else //El equipo es SIX, pero hay que controlar que el usuario pueda modificar los datos de fallas.
                {
                    ((CheckBox)e.Row.FindControl("chkClear")).Enabled = UtilitariosWebGUI.HasAuthorization(OperacionGenerica.Update, User);
                }

                //Definir el LINK al equipo segun sea su tipo: FCI o SIX.
                HyperLink linkObj = (HyperLink)e.Row.FindControl("lnkEquipo");
                string textSerial = (string)DataBinder.Eval(e.Row.DataItem, "Serial");
                linkObj.Text = textSerial;

                //Crear el objeto control relacionado con el Valor.
                Label lblVal = (Label)e.Row.FindControl("lblValor");
                if (DataBinder.Eval(e.Row.DataItem, "Valor") != DBNull.Value)
                {
                    valorTxt = DataBinder.Eval(e.Row.DataItem, "Valor").ToString();
                }

                //int valorTxt = (int)DataBinder.Eval(e.Row.DataItem, "Valor");

                Label lblCausa = (Label)e.Row.FindControl("lblCausaOpen"); 
                //int valorCausa = 0;
                //if (tipoEquipo == TipoEquipoRed.SIXDG)
                //{
                //    //Crear el objeto control relacionado con la causa de apertura.
                //    //lblCausa = (Label)e.Row.FindControl("lblCausaOpen");
                    
                //}

                int textId;
                if (tipoEquipo == TipoEquipoRed.SIXDG)
                {
                    byte valorCausa = (byte)(int)(DataBinder.Eval(e.Row.DataItem, "CausaApertura"));
                    textId = (int)DataBinder.Eval(e.Row.DataItem, "FCI");
                    linkObj.NavigateUrl = "EditSIX.aspx?Id=" + textId.ToString();
                    e.Row.Cells[0].ToolTip = TipoEquipoRed.SIXDG.ToString();
                    lblVal.Text = "N/A";
                    lblCausa.Text = UtilitariosWebGUI.GetNombreCausaAperturaSixLenguaje(_codLang, valorCausa);
                }
                else
                {
                    textId = (int)DataBinder.Eval(e.Row.DataItem, "FCI");
                    linkObj.NavigateUrl = "EditFCI.aspx?Id=" + textId.ToString();
                    e.Row.Cells[0].ToolTip = TipoEquipoRed.FCI.ToString();
                    lblVal.Text = valorTxt;
                    lblCausa.Text = "N/A";
                }

            }
        }

        protected void GridViewHistorico_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string valorTxt = "";

                //Definir el LINK al equipo segun sea su tipo: FCI o SIX.
                HyperLink linkObj = (HyperLink)e.Row.FindControl("lnkEquipoHist"); //lnkEquipoHist
                string textSerial = (string)DataBinder.Eval(e.Row.DataItem, "Serial");
                linkObj.Text = textSerial;

                //Crear el objeto control relacionado con el Valor.
                Label lblVal = (Label)e.Row.FindControl("lblValor");
                if (DataBinder.Eval(e.Row.DataItem, "Valor") != DBNull.Value)
                {
                    valorTxt = DataBinder.Eval(e.Row.DataItem, "Valor").ToString();
                }
                //int valorTxt = (int)DataBinder.Eval(e.Row.DataItem, "Valor");

                //Capturar el tipo de equipo que servirá para definir visualización de columnas
                byte textTipoE = (byte)DataBinder.Eval(e.Row.DataItem, "TipoEquipo");
                TipoEquipoRed tipoEquipo = (TipoEquipoRed)textTipoE;

                //Crear el objeto control relacionado con la causa de activación.
                Label lblCausa = (Label)e.Row.FindControl("lblCausaOpen");

                int textId;
                if (tipoEquipo == TipoEquipoRed.SIXDG)
                {
                    byte valorCausa = (byte)(int)(DataBinder.Eval(e.Row.DataItem, "CausaApertura"));
                    textId = (int)DataBinder.Eval(e.Row.DataItem, "FCI");
                    linkObj.NavigateUrl = "EditSIX.aspx?Id=" + textId.ToString();
                    e.Row.Cells[0].ToolTip = TipoEquipoRed.SIXDG.ToString();
                    lblVal.Text = "N/A";
                    lblCausa.Text = UtilitariosWebGUI.GetNombreCausaAperturaSixLenguaje(_codLang, valorCausa);
                }
                else
                {
                    textId = (int)DataBinder.Eval(e.Row.DataItem, "FCI");
                    linkObj.NavigateUrl = "EditFCI.aspx?Id=" + textId.ToString();
                    e.Row.Cells[0].ToolTip = TipoEquipoRed.FCI.ToString();
                    //lblVal.Text = valorTxt.ToString();
                    lblVal.Text = valorTxt;
                    lblCausa.Text = "N/A";
                }
            }
        }


        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {
            //ToolkitScriptManager1.RegisterClientScriptBlock(this, this.GetType(), "hola", "hello();", true);
            //ToolkitScriptManager.RegisterClientScriptBlock(this, this.GetType(), "hola", "hello();", true);
        }

        protected void GVFallasCtos_DataBinding(object sender, EventArgs e)
        {
            //chkRedRows.Value = "false";
            //28 junio
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "demarkRojas", "chkRedRows=false;", true);
            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVFallasCtos, _ID_REPORTE, Membership.GetUser().UserName);
        }

        //protected void UpdatePanel1_Load(object sender, EventArgs e)
        //{
        //    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "hello", "<script type='text/javascript'> hello(); </script>");
        //}

        //*********************** MANEJO DE CLEAR-MANUAL DE FALLAS *****************************

        #region Manejo Clear Fallas Six

        protected void AnalizarClearManualAlarmas()
        {
            foreach (GridViewRow record in GVFallasCtos.Rows)
            {
                if (((CheckBox)record.FindControl("chkClear")).Checked)
                {
                    int idAlarma = (int)GVFallasCtos.DataKeys[record.RowIndex].Values["IdAlarma"];
                    int idFci = (int)GVFallasCtos.DataKeys[record.RowIndex].Values["FCI"];
                    DateTime fechaAlar = (DateTime)GVFallasCtos.DataKeys[record.RowIndex].Values["Fecha"];
                    DateTime yaClear = DateTime.Now;
                    HacerUpdateFilaBD(idAlarma, idFci, fechaAlar, yaClear);
                }
            }
        }


        protected void HacerUpdateFilaBD(int idAlarma, int idFCI, DateTime fechaAlarma, DateTime fechaClear)
        {
            using (var contexto = new SistemaGestionRemotoContainer())
            {
                var alarma = from afci in contexto.AlarmasFCIs
                             where (afci.Id == idAlarma && afci.FCIId == idFCI && afci.Fecha == fechaAlarma)
                             select afci;
                AlarmasFCI registro = alarma.SingleOrDefault();
                if (registro != null)
                {
                    registro.ClearAlarma = fechaClear;
                    registro.DuracionTime = (int)fechaClear.Subtract(fechaAlarma).TotalSeconds; //Hay que calcularlo
                    contexto.SaveChanges();
                }
            }
        }


        #endregion


    }
}