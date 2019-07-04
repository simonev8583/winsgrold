using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;


namespace SistemaGestionRedes.PagesReportes
{
    public partial class StatisticsSix : System.Web.UI.Page
    {

        private const short _ID_REPORTE = 30;

        string fechaInicial;
        string fechaFinal;
        private static string _usuarioLogged;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DateTime ya = DateTime.Now;
                string anoYa = ya.Year.ToString();
                string mesYa = ya.Month.ToString();
                string hoyYa = ya.Day.ToString();
                txtFechaInicial.Text = anoYa + "-" + mesYa + "-" + hoyYa;
                txtFechaFinal.Text = anoYa + "-" + mesYa + "-" + hoyYa;
                _usuarioLogged = Membership.GetUser().UserName;
            }

            PopCalFi.Culture = CultureInfo.CurrentUICulture.ToString();
            PopCalFf.Culture = CultureInfo.CurrentUICulture.ToString();
        }


        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            //fechaInicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
            //fechaFinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

            //if (ddListSixs.SelectedValue.Equals("0")) //Todos los SIX.
            //{
            //    sqlDSResultadosFecha.SelectParameters["fechai"].DefaultValue = fechaInicial;
            //    sqlDSResultadosFecha.SelectParameters["fechaf"].DefaultValue = fechaFinal;
            //    gvResultados.DataSourceID = sqlDSResultadosFecha.ID;
            //}
            //else
            //{
            //    sqlDSResultadosConSix.SelectParameters["fechai"].DefaultValue = fechaInicial;
            //    sqlDSResultadosConSix.SelectParameters["fechaf"].DefaultValue = fechaFinal;
            //    sqlDSResultadosConSix.SelectParameters["sixid"].DefaultValue = ddListSixs.SelectedValue;
            //    gvResultados.DataSourceID = sqlDSResultadosConSix.ID;
            //}

            //UtilitariosWebGUI.DefinirColumnasVisualizadasCel(gvResultados, _ID_REPORTE, Membership.GetUser().UserName);

            //gvResultados.DataBind();
            //TryMostrarMensajeNoData();
        }


        protected void btnNewAceptar_Click(object sender, EventArgs e)
        {
            fechaInicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
            fechaFinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

            _EjecutarBusquedaCompletaComun();

            TryMostrarMensajeNoData();
        }

        private void _EjecutarBusquedaCompletaComun()
        {
            bool organizarFcis;

            UtilitariosWebGUI.ConfigurarDataSourceReporteComun(sqlDSResultadosConSix, DDListCntrs, fechaInicial, fechaFinal, _usuarioLogged, LstBoxSixs, out organizarFcis);

            //Aquí, cualquier filtro adicional o especial debería tener algún valor o ser asignado a NULL.


            gvResultados.DataSourceID = "sqlDSResultadosConSix";

            if (organizarFcis)
            {
                UtilitariosWebGUI.DeleteTablaGUI_IDS_Equipos_Reportes(SqlDSQuerySIXs, _usuarioLogged);
                int[] vectIDs = UtilitariosWebGUI.GetSelectedValuesFromListBox(LstBoxSixs.GetSelectedIndices(), LstBoxSixs);
                UtilitariosWebGUI.InsertarIDsFCIsParaFiltros(SqlDSQuerySIXs, vectIDs, _usuarioLogged);
            }

            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(gvResultados, _ID_REPORTE, _usuarioLogged); //Before: Membership.GetUser().UserName

            gvResultados.DataBind();
            gvResultados.PageIndex = 0;
        }
              

        protected void TryMostrarMensajeNoData()
        {
            if (gvResultados.Rows.Count > 0)
            {
                lblMsgNoResultados.Visible = false;
            }
            else
            {
                lblMsgNoResultados.Visible = true;
            }
        }



        #region Metodos manejo de filtros equipos


        protected void DDListCntrs_DataBound(object sender, EventArgs e)
        {
            DDListCntrs.Items.Add(new ListItem("", "")); //Item vacio para no escoger FCI 
            DDListCntrs.SelectedIndex = DDListCntrs.Items.Count - 1;  //para que quede escogido el ultimo item vacio
        }

        protected void DDListCntrs_SelectedIndexChanged(object sender, EventArgs e)
        {
            LstBoxSixs.Items.Clear();

            if (DDListCntrs.SelectedValue == "")
            {
                SqlDSSixs.SelectParameters["idfwt"].DefaultValue = null;
            }
            else
            {
                SqlDSSixs.SelectParameters["idfwt"].DefaultValue = DDListCntrs.SelectedValue;
            }

            LstBoxSixs.DataBind();

        }


        #endregion

        

    }
}