using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace SistemaGestionRedes
{
    public partial class seccionAB : System.Web.UI.Page
    {



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                menuPrimerNivel.Items.RemoveAt(1);
            }

            //if (!Page.IsPostBack)
            //{
            //    string menuOpcion = Request.QueryString["menuOpcion"];
            //    //switch (menuOpcion)
            //    //{
            //    //    case "conf":
            //    //        menuPrimerNivel.DynamicSelectedStyle.BackColor = Color.Yellow;
            //    //        menuPrimerNivel.StaticSelectedStyle.BackColor = Color.Yellow;
            //    //        menuPrimerNivel.Items[1].Selected = true;


            //    //        break;
            //    //}
            //}
          // menuPrimerNivel.Items[0].Selected = true;
        }

        protected void menuPrimerNivel_MenuItemClick(object sender, MenuEventArgs e)
        {
            
        }


    }
}