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
    public partial class FWTFault : System.Web.UI.Page
    {
        static string _codLang;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                _codLang = AccesoDatosEF.ConfirmarLenguaje(CultureInfo.CurrentUICulture.TwoLetterISOLanguageName);
                SqDSDatosAll.SelectParameters["IdLang"].DefaultValue = _codLang;
            }
        }

        protected void GVFallasEquFWTs_DataBound(object sender, EventArgs e)
        {
            if (GVFallasEquFWTs.Rows.Count == 0)
            {
                LblMsgNoData.Visible = true;
            }
        }
    }
}