using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaGestionRedes.PagesUpdates
{
    public partial class FirmwareStateReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRefrescarFiltros_Click(object sender, EventArgs e)
        {
            GVCurrentVersion.DataSourceID = "SqlDSCurrVer";
            GVFCIsPendientes.DataSourceID = "SqlDSPorActualizar";
            GVFCIsNoActivadosYet.DataSourceID = "SqlDSNoActivosAun";
            GVFwtConVersion.DataSourceID = "SqlDSVersionCargada";
            GVFwtNoCargan.DataSourceID = "SqlDSFWTsNoCargan";

            SetDataSource();

            GVCurrentVersion.DataBind();
            GVFCIsPendientes.DataBind();
            GVFCIsNoActivadosYet.DataBind();
            GVFwtConVersion.DataBind();
            GVFwtNoCargan.DataBind();
        }

        protected void SetDataSource()
        {
            SqlDSCurrVer.SelectParameters["versionFw"].DefaultValue = DDListVersionesFw.SelectedValue;
            SqlDSPorActualizar.SelectParameters["versionFw"].DefaultValue = DDListVersionesFw.SelectedValue;
            SqlDSNoActivosAun.SelectParameters["versionFw"].DefaultValue = DDListVersionesFw.SelectedValue;
            SqlDSVersionCargada.SelectParameters["versionFw"].DefaultValue = DDListVersionesFw.SelectedValue;

            if (txtInfoFwt.Text.Trim().Equals(""))
            {
                SqlDSCurrVer.SelectParameters["infoFwt"].DefaultValue = null;
                SqlDSPorActualizar.SelectParameters["infoFwt"].DefaultValue = null;
                SqlDSNoActivosAun.SelectParameters["infoFwt"].DefaultValue = null;
                SqlDSVersionCargada.SelectParameters["infoFwt"].DefaultValue = null;
                SqlDSFWTsNoCargan.SelectParameters["infoFwt"].DefaultValue = null;
            }
            else
            {
                SqlDSCurrVer.SelectParameters["infoFwt"].DefaultValue = txtInfoFwt.Text.Trim();
                SqlDSPorActualizar.SelectParameters["infoFwt"].DefaultValue = txtInfoFwt.Text.Trim();
                SqlDSNoActivosAun.SelectParameters["infoFwt"].DefaultValue = txtInfoFwt.Text.Trim();
                SqlDSVersionCargada.SelectParameters["infoFwt"].DefaultValue = txtInfoFwt.Text.Trim();
                SqlDSFWTsNoCargan.SelectParameters["infoFwt"].DefaultValue = txtInfoFwt.Text.Trim();
            }
        }

        protected void GVCurrentVersion_DataBound(object sender, EventArgs e)
        {
            int count = GVCurrentVersion.Rows.Count;
        }
    }
}