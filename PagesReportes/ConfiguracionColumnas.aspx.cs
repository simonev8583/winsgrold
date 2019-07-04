using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes.PagesReportes
{
    public partial class ConfiguracionColumnas : System.Web.UI.Page
    {
        private bool _verSix;
        private string _idReporte;
        private string _userName;

        static string _codLang;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                _idReporte = Request.QueryString["IdReporte"];
                _userName = Membership.GetUser().UserName;
                _verSix = ConfigApp.VerSix;
                _codLang = AccesoDatosEF.ConfirmarLenguaje(CultureInfo.CurrentUICulture.TwoLetterISOLanguageName);
                lblNombreReporte.Text = AccesoDatosEFGUI.GetNombreReporte(int.Parse(_idReporte), _codLang);
                MostrarTodasColumnasReporte(int.Parse(_idReporte));
                ResaltarColumnasConfiguradas(int.Parse(_idReporte), _userName);
            }

        }


        //********** Proceso de Visualizacion *****************************

        protected void MostrarTodasColumnasReporte(int idReporte)
        {
            List<GenericaIntString> listaColumnas = AccesoDatosEFGUI.GetAllDescripcionesColumnasReporte(idReporte, _codLang);
            if (listaColumnas.Count > 0)
            {
                ChkBoxColumnas.Items.Clear();
                foreach (GenericaIntString item in listaColumnas)
                {
                    ChkBoxColumnas.Items.Add(new ListItem(AnalizarDescripcionConSix(item.InformacionString), item.InformacionInt.ToString()));
                }
            }
        }

        protected string AnalizarDescripcionConSix(string descOriginal)
        {
            if (!_verSix)
            {
                return descOriginal;
            }
            else
            {
                return descOriginal.Replace("FCI", "FCI/SIX");
            }
        }


        protected void ResaltarColumnasConfiguradas(int idReporte, string nombreUsuario)
        {
            if (ChkBoxColumnas.Items.Count > 0)
            {
                List<int> listIdCols = AccesoDatosEFGUI.GetIDColumnasConfiguradasDelReporte(nombreUsuario, idReporte);
                if (listIdCols.Count > 0)
                {
                    foreach (ListItem item in ChkBoxColumnas.Items)
                    {
                        if (listIdCols.Contains(int.Parse(item.Value)))
                        {
                            item.Selected = true;
                        }
                    }
                }
            }
        }
        


        //*********** Proceso de almacenamiento de la configuración **************


        protected void ProcesarAlmacenamiento(int idReporte, string nombreUsuario)
        {
            List<int> listaOriginal = AccesoDatosEFGUI.GetIDColumnasConfiguradasDelReporte(nombreUsuario, idReporte);
            AlmacenarNuevasColumnas(idReporte, nombreUsuario, listaOriginal);
            RemoverColumnas(idReporte, nombreUsuario, listaOriginal);
        }


        protected void AlmacenarNuevasColumnas(int idReporte, string nombreUsuario, List<int> listaOriginalCols)
        {
            if (ChkBoxColumnas.Items.Count > 0)
            {
                foreach (ListItem item in ChkBoxColumnas.Items)
                {
                    if (item.Selected)
                    {
                        int idCol = int.Parse(item.Value);
                        if (!listaOriginalCols.Contains(idCol))
                        {
                            AccesoDatosEFGUI.InsertarColumnaParaUsuario(nombreUsuario, idReporte, idCol);
                        }
                    }
                }
            }
        }


        protected void RemoverColumnas(int idReporte, string nombreUsuario, List<int> listaOriginalCols)
        {
            if (listaOriginalCols.Count > 0)
            {
                foreach (ListItem item in ChkBoxColumnas.Items)
                {
                    if (!item.Selected)
                    {
                        int idCol = int.Parse(item.Value);
                        if (listaOriginalCols.Contains(idCol))
                        {
                            AccesoDatosEFGUI.RemoverColumnaDeUsuario(nombreUsuario, idReporte, idCol);
                        }
                    }
                }
            }
        }




        #region Metodos Eventos Controles


        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            _idReporte = Request.QueryString["IdReporte"];
            _userName = Membership.GetUser().UserName;
            ProcesarAlmacenamiento(int.Parse(_idReporte), _userName);
            //Ver que se puede hacer como mensaje informativo al usuario....
            chkCerrarAceptar.Checked = true;
            
        }



        #endregion

    }
}