using System;
using System.Collections.Generic;
using System.Linq;
using System.Globalization;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;
using System.Web.Security;

namespace SistemaGestionRedes
{
    public partial class HistorialFWT : System.Web.UI.Page
    {
        private const short _ID_REPORTE = 60;

        static DateTime txtFi;
        static DateTime txtFf;
        static int valFiltroFalla;
        static string _codLang;
        private static DateTimeFormatInfo _dateFullFormat = new DateTimeFormatInfo();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                _codLang = AccesoDatosEF.ConfirmarLenguaje(CultureInfo.CurrentUICulture.TwoLetterISOLanguageName);
                DateTime ya = DateTime.Now;
                txtFi = ya;
                txtFf = ya;
                string anoYa = ya.Year.ToString();
                string mesYa = ya.Month.ToString();
                string hoyYa = ya.Day.ToString();

                _dateFullFormat.FullDateTimePattern = "yyyyMMdd HH:mm:ss";
                _dateFullFormat.ShortDatePattern = "yyyyMMdd";
                _dateFullFormat.ShortTimePattern = "HH:mm:ss";
                _dateFullFormat.DateSeparator = "";

                txtFechaInicial.Text = anoYa + "-" + mesYa + "-" + hoyYa;
                txtFechaFinal.Text = anoYa + "-" + mesYa + "-" + hoyYa;

                SqDSFallas.SelectParameters["IdLang"].DefaultValue = _codLang;
                SqlDSResultados.SelectParameters["IdLang"].DefaultValue = _codLang;
            }

            PopCalFi.Culture = CultureInfo.CurrentUICulture.ToString();
            PopCalFf.Culture = CultureInfo.CurrentUICulture.ToString();

        }

        public static IQueryable<AlarmasFWT> FiltrarPorFecha(IQueryable<AlarmasFWT> query)
        {
            return from falla in query
                   where falla.Fecha >= txtFi && falla.Fecha <= txtFf
                   select falla;

        }

        public static IQueryable<AlarmasFWT> FiltrarPorFalla(IQueryable<AlarmasFWT> query)
        {
            if (valFiltroFalla == 0)
            {
                return from falla in query
                       select falla;
            }
            else
            {
                return from falla in query
                       where falla.Id == valFiltroFalla
                       select falla;
            }

        }

        //public static IQueryable<MtAlarmas_Lenguaje> FiltrarPorLenguaje(IQueryable<MtAlarmas_Lenguaje> query)
        //{
        //    return from nmAlrs in query
        //           where nmAlrs.MtLenguaje.Cod == _codLang
        //           select nmAlrs;
        //}

        //public static IQueryable<MtAlarmas_Lenguaje> FiltrarPorLenguaje(IQueryable<AlarmaFWT> query, IQueryable<MtAlarmas_Lenguaje> mtAlarmLeng)
        //{
        //    return from falla in mtAlarmLeng
        //           where falla.MtLenguaje.Cod == _codLang
        //           select falla;

        //}

        protected void Button1_Click(object sender, EventArgs e)
        {
            //Organizar las fechas
            string dateInicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
            string dateFinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";
            //txtFi = Convert.ToDateTime(dateInicial, _dateFullFormat);
            //txtFf = Convert.ToDateTime(dateFinal, _dateFullFormat);
            valFiltroFalla = int.Parse(DDListFallas.SelectedValue);

            SqlDSResultados.SelectParameters["Finicial"].DefaultValue = dateInicial;
            SqlDSResultados.SelectParameters["Ffinal"].DefaultValue = dateFinal;

            if (valFiltroFalla == 0)
            {
                SqlDSResultados.SelectParameters["IdFalla"].DefaultValue = null;
            }
            else
            {
                SqlDSResultados.SelectParameters["IdFalla"].DefaultValue = valFiltroFalla.ToString();
            }

            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVFWTData, _ID_REPORTE, Membership.GetUser().UserName);

            //Hacer el Bind final
            GVFWTData.DataBind();
            TryMostrarMensajeNoData();
        }

        protected void EnDSFallasHistFWT_Selecting(object sender, EntityDataSourceSelectingEventArgs e)
        {
            string targetId = qExFalla.TargetControlID;
        }

        protected void TryMostrarMensajeNoData()
        {
            if (GVFWTData.Rows.Count > 0)
            {
                lblMsgNoResultados.Visible = false;
            }
            else
            {
                lblMsgNoResultados.Visible = true;
            }
        }

    }
}