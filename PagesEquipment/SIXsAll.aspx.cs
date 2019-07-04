using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace SistemaGestionRedes.PagesEquipment
{
    public partial class SIXsAll : System.Web.UI.Page
    {
        bool hayRojas = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            lblMsgRedRows.Visible = false;
        }

        protected void gvAllSixs_DataBound(object sender, EventArgs e)
        {
            if (gvAllSixs.Rows.Count == 0)
            {
                lblMsgNoEquipos.Visible = true;
            }

            if (hayRojas)
            {
                lblMsgRedRows.Visible = true;
            }
        }

        protected void gvAllSixs_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (DataBinder.Eval(e.Row.DataItem, "TieneFallaPer") != DBNull.Value)
                {
                    e.Row.BackColor = Color.Red;
                    hayRojas = true;
                }
            }
        }
    }
}