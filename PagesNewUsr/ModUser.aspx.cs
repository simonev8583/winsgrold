using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Profile;
using System.Web.Security;
using SGR.DataAccessLayer;


namespace SistemaGestionRedes.PagesNewUsr
{
    public partial class ModUser : System.Web.UI.Page
    {
        static string _codLang;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                _codLang = AccesoDatosEF.ConfirmarLenguaje(CultureInfo.CurrentUICulture.TwoLetterISOLanguageName);
                SqlDSRoles.SelectParameters["IdLang"].DefaultValue = _codLang;

                if (_codLang.Equals("en"))
                {
                    btnBorrar.OnClientClick = "return confirmar_borrar_en();";
                }
                else
                {
                    btnBorrar.OnClientClick = "return confirmar_borrar();";
                }
            }

            if (User.Identity.Name.Equals("celsa"))
            {
                //Si el usuario es "celsa", puede hacer cambios a la configuración de todos los demás usuarios,
                //incluso otros administradores.
                SqlDSAllUsers.SelectCommand = "select aspnet_Users.userName from aspnet_Users where aspnet_Users.LoweredUserName <> 'celsa' order by aspnet_Users.userName asc";
            }
            else
            {
                //Si es otro usuario administrador, solo puede hacer cambios a la configuración de otros
                //usuarios que no son administradores. No visualiza a los otros administradores.
                SqlDSAllUsers.SelectCommand = "select aspnet_Users.userName from aspnet_Users, aspnet_UsersInRoles, aspnet_Roles where aspnet_Users.UserId = aspnet_UsersInRoles.UserId and aspnet_UsersInRoles.RoleId = aspnet_Roles.RoleId and aspnet_Roles.LoweredRoleName <> 'administrador' order by UserName asc";
            }
        }

        protected void DDListUsers_SelectedIndexChanged(object sender, EventArgs e)
        {
            ReconfigurarSegunUsuario();
            lblMsgBorrarUsuario.Visible = false;
            lblMsgCambiarUsr.Visible = false;
        }

        protected void ReconfigurarSegunUsuario()
        {
            string userRol = "";
            string usuario = DDListUsers.SelectedValue;
            lblUserSelected.Text = usuario;

            ProfileBase pb = ProfileBase.Create(usuario);

            string[] rolesUsr = Roles.GetRolesForUser(usuario); //Por la aplicación, debe ser uno solo.
            if (rolesUsr.Length > 0)
            {
                userRol = rolesUsr[0];
            }

            EstadoUsr stdUsr = (EstadoUsr)pb.GetPropertyValue("EstadoUsuario");

            if ((int)stdUsr > 0)
            {
                //lblEstadoActualUsr.Text = stdUsr.ToString(); GetDescripcionEstadoUsr
                lblEstadoActualUsr.Text = GetDescripcionEstadoUsr(stdUsr);
            }
            else
            {
                lblEstadoActualUsr.Text = (string)this.GetLocalResourceObject("lblEstadoActualUsrDesbloqueado"); //"Desbloqueado";
            }
            
            btnBloquear.Text = GetTextoBotonEstado(stdUsr);
            DDListTiposUsuario.SelectedValue = userRol;
            lblRolOriginal.Text = userRol;
            btnCambiar.Enabled = false;


        }

        private string GetDescripcionEstadoUsr(EstadoUsr stdUsr)
        {
            string desc = "";

            switch (stdUsr)
            {
                case EstadoUsr.Desbloqueado:
                    if (_codLang.Equals("en"))
                    {
                        desc = "Enabled";
                    }
                    else
                    {
                        desc = "Desbloqueado";
                    }
                    break;

                case EstadoUsr.Bloqueado:
                    if (_codLang.Equals("en"))
                    {
                        desc = "Disabled";
                    }
                    else
                    {
                        desc = "Bloqueado";
                    }
                    break;
            }

            return desc;
        }

        protected string GetTextoBotonEstado(EstadoUsr stdUsuario)
        {
            string txtFinal = "";

            switch (stdUsuario)
            {
                case EstadoUsr.Bloqueado:
                    txtFinal = (string)this.GetLocalResourceObject("TextBotonBloquear_Desbloquear"); //"Desbloquear";
                    break;

                case EstadoUsr.Desbloqueado:
                    txtFinal = (string)this.GetLocalResourceObject("TextBotonBloquear_Bloquear"); //"Bloquear";
                    break;

                default:
                    txtFinal = (string)this.GetLocalResourceObject("TextBotonBloquear_Bloquear"); //"Bloquear";
                    break;
            }

            return txtFinal;

        }

        protected void btnCambiar_Click(object sender, EventArgs e)
        {
            string usuario = lblUserSelected.Text;

            if (!Roles.IsUserInRole(usuario, DDListTiposUsuario.SelectedValue))
            {
                //Elimar el usuario del rol actual.
                Roles.RemoveUserFromRole(usuario, lblRolOriginal.Text);
                //Incluir el usuario en el nuevo rol.
                Roles.AddUserToRole(usuario, DDListTiposUsuario.SelectedValue);
                lblMsgCambiarUsr.Text = (string)this.GetLocalResourceObject("lblMsgCambiarUsrCambioOk") + DDListTiposUsuario.Items[DDListTiposUsuario.SelectedIndex].Text;
                btnCambiar.Enabled = false;
            }
            else
            {
                lblMsgCambiarUsr.Text = (string)this.GetLocalResourceObject("lblMsgCambiarUsrYaEs"); //"Usuario ya es de ese Tipo";
            }

            lblMsgCambiarUsr.Visible = true;

        }

        protected void btnBloquear_Click(object sender, EventArgs e)
        {
            string usuario = lblUserSelected.Text;

            ProfileBase pb = ProfileBase.Create(usuario);

            if (btnBloquear.Text.Equals((string)this.GetLocalResourceObject("TextBotonBloquear_Desbloquear")))
            {
                pb.SetPropertyValue("EstadoUsuario", (SistemaGestionRedes.EstadoUsr)EstadoUsr.Desbloqueado);
            }
            else
            {
                pb.SetPropertyValue("EstadoUsuario", (SistemaGestionRedes.EstadoUsr)EstadoUsr.Bloqueado);
            }

            pb.Save();

            ReconfigurarSegunUsuario();
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {
            string usuario = lblUserSelected.Text;

            //Eliminar la configuración previa a nivel de columnas de reportes...
            AccesoDatosEFGUI.RemoverAllColumnasDeUsuario(usuario);

            //Eliminar el usuario del sistema Membership: Profile, Roles, etc..
            if (Membership.DeleteUser(usuario, true))
            {
                lblMsgBorrarUsuario.Text = (string)this.GetLocalResourceObject("lblMsgBorrarUsuarioEliminado"); //"Usuario Eliminado del Sistema";
            }
            else
            {
                lblMsgBorrarUsuario.Text = (string)this.GetLocalResourceObject("lblMsgBorrarUsuarioNoEliminado"); //"No fue posible eliminar el usuario";
            }

            DDListUsers.DataBind();
            lblMsgBorrarUsuario.Visible = true;

        }

        //Se ejecuta luego de llenar el List de los usuarios. La idea es refrescar el resto de información.
        protected void DDListUsers_DataBound(object sender, EventArgs e)
        {
            if (DDListUsers.Items.Count > 0)
            {
                ReconfigurarSegunUsuario();
            }
            else
            {
                btnBorrar.Enabled = false;
                btnBloquear.Enabled = false;
                btnCambiar.Enabled = false;
            }
        }

        protected void DDListTiposUsuario_SelectedIndexChanged(object sender, EventArgs e)
        {
            string usuario = lblUserSelected.Text;

            if (Roles.IsUserInRole(usuario, DDListTiposUsuario.SelectedValue))
            {
                btnCambiar.Enabled = false;
            }
            else
            {
                btnCambiar.Enabled = true;
            }
        }

        


    }
}