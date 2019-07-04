using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes
{
    public partial class FCIFault : System.Web.UI.Page
    {
        static string _codLang;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                _codLang = AccesoDatosEF.ConfirmarLenguaje(CultureInfo.CurrentUICulture.TwoLetterISOLanguageName);
                SqDSDatosAll.SelectParameters["IdLang"].DefaultValue = _codLang;
                SqDSDatosFCIdeFWT.SelectParameters["IdLang"].DefaultValue = _codLang;
            }
        }

        protected void GVFallasEquFCIs_DataBound(object sender, EventArgs e)
        {
            if (GVFallasEquFCIs.Rows.Count == 0)
            {
                LblMsgNoData.Visible = true;
            }
        }

        protected void DDListFWTs_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDListFWTs.SelectedValue.Equals("0"))
            {
                GVFallasEquFCIs.DataSourceID = "SqDSDatosAll";
            }
            else
            {
                GVFallasEquFCIs.DataSourceID = "SqDSDatosFCIdeFWT";
            }
            GVFallasEquFCIs.DataBind();
        }

                        
    }
}