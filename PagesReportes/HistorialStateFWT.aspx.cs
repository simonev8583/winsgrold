using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes.PagesReportes
{
    public partial class HistorialStateFWT : System.Web.UI.Page
    {
        private const short _ID_REPORTE = 70;

        string fechaInicial;
        string fechaFinal;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DateTime ya = DateTime.Now;
                string anoYa = ya.Year.ToString();
                string mesYa = ya.Month.ToString();
                string hoyYa = ya.Day.ToString();
                txtFechaInicial.Text = anoYa + "-" + mesYa + "-" + hoyYa;
                txtFechaFinal.Text = anoYa + "-" + mesYa + "-" + hoyYa;
                LoadConcentradores();
            }

            PopCalFi.Culture = CultureInfo.CurrentUICulture.ToString();
            PopCalFf.Culture = CultureInfo.CurrentUICulture.ToString();
        }

        private void LoadConcentradores()
        {
            
            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {
                txtSerialFWT.DataSource = from conc in db.FWTs
                                               orderby conc.Id
                                               select new { Id = conc.Id, Ser = conc.Serial };
                txtSerialFWT.DataTextField = "Ser";
                txtSerialFWT.DataValueField = "Ser";
                txtSerialFWT.DataBind();

            }
            txtSerialFWT.Items.Add(new ListItem("", "")); //Item vacio para no escoger concentrador 
            txtSerialFWT.SelectedIndex = txtSerialFWT.Items.Count - 1;  //para que quede escogido el ultimo item vacio
           
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            fechaInicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
            fechaFinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

            if (txtSerialFWT.Text.Trim().Equals(""))
            {
                SqlDSInfoCompleta.SelectParameters.Clear();
                SqlDSInfoCompleta.SelectParameters.Add("Finicial", fechaInicial);
                SqlDSInfoCompleta.SelectParameters.Add("Ffinal", fechaFinal);
                GVReporte.DataSourceID = "SqlDSInfoCompleta";
            }
            else
            {
                SqDSInfoLikeSerial.SelectParameters.Clear();
                SqDSInfoLikeSerial.SelectParameters.Add("Finicial", fechaInicial);
                SqDSInfoLikeSerial.SelectParameters.Add("Ffinal", fechaFinal);
                SqDSInfoLikeSerial.SelectParameters.Add("Serial", txtSerialFWT.Text.Trim());
                GVReporte.DataSourceID = "SqDSInfoLikeSerial";
            }

            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVReporte, _ID_REPORTE, Membership.GetUser().UserName);

            GVReporte.DataBind();
        }

        protected void GVReporte_DataBound(object sender, EventArgs e)
        {
            if (GVReporte.Rows.Count == 0)
            {
                LblMsgNoData.Visible = true;
            }
            else
            {
                LblMsgNoData.Visible = false;
            }
        }

        protected void tmrRefreshReporte_Tick(object sender, EventArgs e)
        {
            btnBuscar_Click(sender, e);
        }

        /// <summary>
        /// Activa el timer para refrescar el grid view segun si ckBoxRefreshReporte esté ó NO chequeado
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ckBoxRefreshReporte_CheckedChanged(object sender, EventArgs e)
        {
            if (ckBoxRefreshReporte.Checked)
            {
                btnBuscar_Click(sender, e);
                tmrRefreshReporte.Interval = int.Parse(ddListIntervalRefresh.SelectedValue) * 1000;
                tmrRefreshReporte.Enabled = true;
            }
            else
            {
                tmrRefreshReporte.Enabled = false;
            }
        }

        protected void tmrTimeActual_Tick(object sender, EventArgs e)
        {
            lblTimeActual.Text = DateTime.Now.ToLongTimeString();
        }

        protected void lblTimeActual_Load(object sender, EventArgs e)
        {
            lblTimeActual.Text = DateTime.Now.ToLongTimeString(); //Tiempo inicial antes del primer tick
        }

        protected void ddListIntervalRefresh_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Cuando se cambie un intervalo tambien se debe actualizar el timer 
            ckBoxRefreshReporte_CheckedChanged(sender, e);
        }


    }
}