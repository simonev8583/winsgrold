using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.Profile;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes.PagesNewUsr
{
    public partial class NewUser : System.Web.UI.Page
    {
        static string _codLang;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                _codLang = AccesoDatosEF.ConfirmarLenguaje(CultureInfo.CurrentUICulture.TwoLetterISOLanguageName);
                SqlDSRoles.SelectParameters["IdLang"].DefaultValue = _codLang;
            }
        }

        /*
         * La idea del esquema de autorización para la creacion de usuarios es:
         * El usuario celsa (de fábrica) es el único autorizado para crear usuarios. Esta configuración se hace
         * de fábrica en la definición de la seguridad de ASP .NET por el menú Proyecto --> Configuración de ASP .NET.
         * Un usuario nuevo es inmediatamente vinculado al rol llamado "autenticados", pues en la configuración de
         * seguridad por fábrica establece que dichos usuarios no están autorizados a entrar a la página de creación
         * de nuevo usuario.
         * */

        protected void CrearUsuarioWz_CreatedUser(object sender, EventArgs e)
        {
            //MembershipUser user = Membership.GetUser(CrearUsuarioWz.UserName);
            
            ProfileBase pb = ProfileBase.Create(CrearUsuarioWz.UserName);
            string valRol = ((DropDownList)CrearUsuarioWz.CreateUserStep.ContentTemplateContainer.FindControl("DDListTipoUsuario")).SelectedValue;

            Roles.AddUserToRole(CrearUsuarioWz.UserName, valRol);

            //pb.SetPropertyValue("TipoUsuario", (SistemaGestionRedes.TipoUsuario)valTipousr);
            pb.SetPropertyValue("EstadoUsuario", (SistemaGestionRedes.EstadoUsr)EstadoUsr.Desbloqueado);

            pb.Save();

        }

        protected void DDListTipoUsuario_DataBound(object sender, EventArgs e)
        {
            DropDownList listTiposUsrs = (DropDownList)CrearUsuarioWz.CreateUserStep.ContentTemplateContainer.FindControl("DDListTipoUsuario");
            if (listTiposUsrs.Items.Count == 0)
            {
                CrearUsuarioWz.Enabled = false;
            }
        }
       
    }
}