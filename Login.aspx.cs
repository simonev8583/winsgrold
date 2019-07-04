using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Profile;

namespace SistemaGestionRedes
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //It was learn from Scott Mitchell:
                //.Net por defecto, cuando usuarios autenticados, pero no autorizados a un recurso, SIEMPRE
                //redirecciona al usuario a la página de Login.aspx (esta), sacándolo de la aplicación.
                //Para que eso no ocurra, se hace este control, de tal manera, que al estar seguros que
                //el usuario está autenticado, simplemente se re-envia a una página que le indique que
                //no puede visitar dicho recurso por motivos de falta de autorización.
                //.Net en la variable llamada ReturnUrl asigna la ruta del recurso o de la página que el
                //usuario no está autorizado a visitar. Si dicha variable tiene contenido, entonces se hace
                //lo aquí explicado.
                if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                {
                    // This is an unauthorized, authenticated request...
                    Response.Redirect("~/NoAuthorPage.aspx");
                }
            }
            LoginSGR.Focus();
        }

        protected void LoginSGR_LoggingIn(object sender, LoginCancelEventArgs e)
        {
            if (UserIsBlocked(LoginSGR.UserName))
            {
                LoginSGR.InstructionText = (string)this.GetLocalResourceObject("TextUsuarioNoHabilitado"); //"Usuario no habilitado";
                e.Cancel = true;
            }
            else
            {
                LoginSGR.InstructionText = string.Empty;
            }
        }


        protected void LoginSGR_LoggedIn(object sender, EventArgs e)
        {
            //Esta fue la solución para el problema donde al visitar la raíz del sitio web, sale la variable
            //returnUrl con cierta basura y a pesar de dar las credenciales correctas, volvia la invitación del 
            //login.
            //Con este código, si el usuario está bien antenticado, entonces la aplicación continua a la página
            //principal.
            Response.Redirect("~/HomeFrames.htm");
        }

        protected bool UserIsBlocked(string userName)
        {
            bool rta = false;

            ProfileBase pb = ProfileBase.Create(userName);
            EstadoUsr stdUsr = (EstadoUsr)pb.GetPropertyValue("EstadoUsuario");

            if (stdUsr == EstadoUsr.Bloqueado)
            {
                rta = true;
            }

            return rta;
        }

        


    }
}