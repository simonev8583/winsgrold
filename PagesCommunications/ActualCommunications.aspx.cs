using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaGestionRedes
{
    public partial class ActualCommunications : System.Web.UI.Page
    {
        private static bool isActive = false;
        protected void Page_Load(object sender, EventArgs e)
        {            
        }

        protected void tmrComAct_Tick(object sender, EventArgs e)
        {
            try
            {
                    GridViewComAct.DataBind(); //Se actualiza lo que está consultando 
            }
            catch (Exception ex)
            {
                LblComAct.Text = "Error de Red ó Base de datos : " + ex.Message  ;
                LblComAct.Visible = true;
            } 
        }

        protected void GridViewComAct_DataBound(object sender, EventArgs e)
        {
            if (GridViewComAct.Rows.Count == 0)
            {
                LblComAct.Visible = true;
            }
            else
            {
                LblComAct.Visible = false;
            }
        }
    }
}