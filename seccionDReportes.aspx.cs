using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaGestionRedes
{
    public partial class seccionDReportes : System.Web.UI.Page
    {
        private bool _verSix;

        protected void Page_Load(object sender, EventArgs e)
        {
            _verSix = ConfigApp.VerSix;

            if (!_verSix)
            {
                menuSegundoNivel.Items[0].Text = (string)this.GetLocalResourceObject("TextHistorialAlarmasFCI");
                menuSegundoNivel.Items.RemoveAt(2); //Estadisticas SIX
                menuSegundoNivel.Items.RemoveAt(3); //OJO: Log Corriente SIX. Es por diseño el 4, pero a medida que se eliminan,
                                                    // los que son de índice superior, decrementan.
            }
            else
            {
                menuSegundoNivel.Items[0].Text = (string)this.GetLocalResourceObject("TextHistorialAlarmasBoth");
            }
            this.validateUsername();

        }

        private void validateUsername()
        {
            var username = Membership.GetUser().UserName;
            if(!username.Equals("celsa"))
            {
                menuSegundoNivel.Items.RemoveAt(8);
            }
            
        }
    }
}