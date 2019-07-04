using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Profile;


namespace SistemaGestionRedes
{
    public class ProfileCelsa
    {

        public bool CodificarEquipos
        {
            get
            {
                return (bool)HttpContext.Current.Profile.GetPropertyValue("VerCodificacionEquipos");
            }
            set
            {
                HttpContext.Current.Profile.SetPropertyValue("VerCodificacionEquipos", value);
            }
        }


        public EstadoUsr StateUsuario
        {
            get
            {
                return (EstadoUsr)HttpContext.Current.Profile.GetPropertyValue("EstadoUsuario");
            }
            set
            {
                HttpContext.Current.Profile.SetPropertyValue("EstadoUsuario", value);
            }
        }


    }//end of class
}