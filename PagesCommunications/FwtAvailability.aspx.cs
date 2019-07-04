using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using SGR.DataAccessLayer;
using SGR.UtilityLibrary;

namespace SistemaGestionRedes.PagesCommunications
{
    public partial class FwtAvailability : System.Web.UI.Page
    {

        string fechaInicial;
        string fechaFinal;
        private static string _usuarioLogged;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DateTime ya = DateTime.Now;
                string anoYa = ya.Year.ToString();
                string mesYa = Utilitarios.Conc2Ceros(ya.Month.ToString());
                string hoyYa = Utilitarios.Conc2Ceros(ya.Day.ToString());
                txtFechaInicial.Text = anoYa + "-" + mesYa + "-" + hoyYa;
                txtFechaFinal.Text = anoYa + "-" + mesYa + "-" + hoyYa;
                //SetDataSource();
                _usuarioLogged = Membership.GetUser().UserName;
            }
            PopCalFi.Culture = CultureInfo.CurrentUICulture.ToString();
            PopCalFf.Culture = CultureInfo.CurrentUICulture.ToString();
        }


        protected void SetDataSource()
        {
            fechaInicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
            fechaFinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

            SqlDSReporte.SelectParameters["fechaIni"].DefaultValue = fechaInicial;
            SqlDSReporte.SelectParameters["fechaFin"].DefaultValue = fechaFinal;

            if (txtInfoFwt.Text.Trim().Equals(""))
            {
                SqlDSReporte.SelectParameters["infoFWT"].DefaultValue = null;
            }
            else
            {
                SqlDSReporte.SelectParameters["infoFWT"].DefaultValue = txtInfoFwt.Text.Trim();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            GVResultados.DataSourceID = "SqlDSReporte";
            ChartFwtAvailability.DataSourceID = "SqlDSReporte";
            SetDataSource();
            GVResultados.DataBind();
        }

        protected void GVResultados_DataBinding(object sender, EventArgs e)
        {
            //fechaInicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
            //fechaFinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

            //SqlDSReporte.SelectParameters["fechaIni"].DefaultValue = fechaInicial;
            //SqlDSReporte.SelectParameters["fechaFin"].DefaultValue = fechaFinal;

            //SetDataSource();

            //if (txtInfoFwt.Text.Trim().Equals(""))
            //{
            //    SqlDSReporte.SelectParameters["infoFWT"].DefaultValue = null;
            //}
            //else
            //{
            //    SqlDSReporte.SelectParameters["infoFWT"].DefaultValue = txtInfoFwt.Text.Trim();
            //}

        }

        protected void GVResultados_DataBound(object sender, EventArgs e)
        {
            ChartFwtAvailability.DataSourceID = "SqlDSReporte";
            ChartFwtAvailability.DataBind();
        }



    }
}