using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.Profile;
using System.Web.UI.DataVisualization.Charting;
using SGR.DataAccessLayer;
using SGR.BussinessLayer;

namespace SistemaGestionRedes.PagesReportes
{
    public partial class InfoHardwareArix : System.Web.UI.Page
    {
        private const short _ID_REPORTE = 50;

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
                chartCorriente.Visible = false;
                _usuarioLogged = Membership.GetUser().UserName;
            }

            PopCalFi.Culture = CultureInfo.CurrentUICulture.ToString();
            PopCalFf.Culture = CultureInfo.CurrentUICulture.ToString();
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
        }

        protected void btnNewAceptar_Click(object sender, EventArgs e)
        {
            fechaInicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
            fechaFinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

            _EjecutarBusquedaCompletaComun();

            TryMostrarMensajeNoData();

            chartCorriente.Visible = false;
        }

        private void _EjecutarBusquedaCompletaComun()
        {
            bool organizarFcis;

            UtilitariosWebGUI.ConfigurarDataSourceReporteComun(sqlDSResultadosConSix, DDListCntrs, fechaInicial, fechaFinal, _usuarioLogged, LstBoxSixs, out organizarFcis);

            //Aquí, cualquier filtro adicional o especial debería tener algún valor o ser asignado a NULL.


            gvResultados.DataSourceID = "sqlDSResultadosConSix";
            SqlDataSource dataSourceObj = sqlDSResultadosFechaUltimo;
            GridView1.DataSourceID = "sqlDSResultadosFechaUltimo";
            if (organizarFcis)
            {
                UtilitariosWebGUI.DeleteTablaGUI_IDS_Equipos_Reportes(SqlDSQuerySIXs, _usuarioLogged);
                int[] vectIDs = UtilitariosWebGUI.GetSelectedValuesFromListBox(LstBoxSixs.GetSelectedIndices(), LstBoxSixs);
                UtilitariosWebGUI.InsertarIDsFCIsParaFiltros(SqlDSQuerySIXs, vectIDs, _usuarioLogged);
            }

            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(gvResultados, _ID_REPORTE, _usuarioLogged); //Before: Membership.GetUser().UserName
            
            dataSourceObj.SelectParameters["Finicial"].DefaultValue = fechaInicial;
            dataSourceObj.SelectParameters["Ffinal"].DefaultValue = fechaFinal;
            dataSourceObj.SelectParameters["SixId"].DefaultValue = (LstBoxSixs.GetSelectedIndices().Length > 0) ? LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Value : 0.ToString(); ;
            gvResultados.DataBind();
            gvResultados.PageIndex = 0;
            GridView1.DataBind();
            GridView1.PageIndex = 0;
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


        #region Manejo de Graficas

        protected void btnGraficarVoltPanel_Click(object sender, EventArgs e)
        {
            if (LstBoxSixs.GetSelectedIndices().Length == 1) //Esta opción de gráfica solo permite un equipo FCI.
            {
                chartCorriente.Series.Clear();
                chartCorriente.Visible = true;
                string finicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
                string ffinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

                SqlDataSource dataSourceObj = SqlDataGrafVoltPanel;
                chartCorriente.DataSourceID = "SqlDataGrafVoltPanel";

                dataSourceObj.SelectParameters["Finicial"].DefaultValue = finicial;
                dataSourceObj.SelectParameters["Ffinal"].DefaultValue = ffinal;
                dataSourceObj.SelectParameters["SixId"].DefaultValue = LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Value;
                chartCorriente.Series.Add("SIX_Corrientes");
                chartCorriente.Series["SIX_Corrientes"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
                chartCorriente.Series["SIX_Corrientes"].XValueMember = "Fecha";
                chartCorriente.Series["SIX_Corrientes"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
                chartCorriente.Series["SIX_Corrientes"].YValueMembers = "VoltPanel";
                chartCorriente.Series["SIX_Corrientes"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
                chartCorriente.Series["SIX_Corrientes"].Legend = "EquipoIndividual";
                chartCorriente.Series["SIX_Corrientes"].LegendText = "SIX " + LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Text;
                chartCorriente.DataBind();
            }
            else
            {
                chartCorriente.Visible = false;
                lblMsgGeneracionGrafica.Visible = true;
            }
        }

        protected void btnGraficar_Click(object sender, EventArgs e)
        {
            if (LstBoxSixs.GetSelectedIndices().Length == 1) //Esta opción de gráfica solo permite un equipo FCI.
            {
                chartCorriente.Series.Clear();
                chartCorriente.Visible = true;
                string finicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
                string ffinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

                SqlDataSource dataSourceObj = SqlDataGrafOneSixCte;
                chartCorriente.DataSourceID = "SqlDataGrafOneSixCte";

                dataSourceObj.SelectParameters["Finicial"].DefaultValue = finicial;
                dataSourceObj.SelectParameters["Ffinal"].DefaultValue = ffinal;
                dataSourceObj.SelectParameters["SixId"].DefaultValue = LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Value;
                chartCorriente.Series.Add("SIX_Corrientes");
                chartCorriente.Series["SIX_Corrientes"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
                chartCorriente.Series["SIX_Corrientes"].XValueMember = "Fecha";
                chartCorriente.Series["SIX_Corrientes"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
                chartCorriente.Series["SIX_Corrientes"].YValueMembers = "ValorCorriente";
                chartCorriente.Series["SIX_Corrientes"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
                chartCorriente.Series["SIX_Corrientes"].Legend = "EquipoIndividual";
                chartCorriente.Series["SIX_Corrientes"].LegendText = "SIX " + LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Text;
                chartCorriente.DataBind();
            }
            else
            {
                chartCorriente.Visible = false;
                lblMsgGeneracionGrafica.Visible = true;
            }
        }

        protected void btnGraficarCap_Click(object sender, EventArgs e)
        {
            if (LstBoxSixs.GetSelectedIndices().Length == 1) //Esta opción de gráfica solo permite un equipo FCI.
            {
                chartCorriente.Series.Clear();
                chartCorriente.Visible = true;
                string finicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
                string ffinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

                SqlDataSource dataSourceObj = SqlDataCapacitor;
                chartCorriente.DataSourceID = "SqlDataCapacitor";

                dataSourceObj.SelectParameters["Finicial"].DefaultValue = finicial;
                dataSourceObj.SelectParameters["Ffinal"].DefaultValue = ffinal;
                dataSourceObj.SelectParameters["SixId"].DefaultValue = LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Value;
                chartCorriente.Series.Add("SIX_Corrientes");
                chartCorriente.Series["SIX_Corrientes"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
                chartCorriente.Series["SIX_Corrientes"].XValueMember = "Fecha";
                chartCorriente.Series["SIX_Corrientes"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
                chartCorriente.Series["SIX_Corrientes"].YValueMembers = "ValorCorriente";
                chartCorriente.Series["SIX_Corrientes"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
                chartCorriente.Series["SIX_Corrientes"].Legend = "EquipoIndividual";
                chartCorriente.Series["SIX_Corrientes"].LegendText = "SIX " + LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Text;
                chartCorriente.DataBind();
            }
            else
            {
                chartCorriente.Visible = false;
                lblMsgGeneracionGrafica.Visible = true;
            }
        }

        protected void btnGraficarFrec_Click(object sender, EventArgs e)
        {
            if (LstBoxSixs.GetSelectedIndices().Length == 1) //Esta opción de gráfica solo permite un equipo FCI.
            {
                chartCorriente.Series.Clear();
                chartCorriente.Visible = true;
                string finicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
                string ffinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

                SqlDataSource dataSourceObj = SqlDataFrecuencia;
                chartCorriente.DataSourceID = "SqlDataFrecuencia";

                dataSourceObj.SelectParameters["Finicial"].DefaultValue = finicial;
                dataSourceObj.SelectParameters["Ffinal"].DefaultValue = ffinal;
                dataSourceObj.SelectParameters["SixId"].DefaultValue = LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Value;
                chartCorriente.Series.Add("SIX_Corrientes");
                chartCorriente.Series["SIX_Corrientes"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
                chartCorriente.Series["SIX_Corrientes"].XValueMember = "Fecha";
                chartCorriente.Series["SIX_Corrientes"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
                chartCorriente.Series["SIX_Corrientes"].YValueMembers = "ValorCorriente";
                chartCorriente.Series["SIX_Corrientes"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
                chartCorriente.Series["SIX_Corrientes"].Legend = "EquipoIndividual";
                chartCorriente.Series["SIX_Corrientes"].LegendText = "SIX " + LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Text;
                chartCorriente.DataBind();
            }
            else
            {
                chartCorriente.Visible = false;
                lblMsgGeneracionGrafica.Visible = true;
            }
        }

        protected void btnGraficarTemp_Click(object sender, EventArgs e)
        {
            if (LstBoxSixs.GetSelectedIndices().Length == 1) //Esta opción de gráfica solo permite un equipo FCI.
            {
                chartCorriente.Series.Clear();
                chartCorriente.Visible = true;
                string finicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
                string ffinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

                SqlDataSource dataSourceObj = SqlDataTemperatura;
                chartCorriente.DataSourceID = "SqlDataTemperatura";

                dataSourceObj.SelectParameters["Finicial"].DefaultValue = finicial;
                dataSourceObj.SelectParameters["Ffinal"].DefaultValue = ffinal;
                dataSourceObj.SelectParameters["SixId"].DefaultValue = LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Value;
                chartCorriente.Series.Add("SIX_Corrientes");
                chartCorriente.Series["SIX_Corrientes"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
                chartCorriente.Series["SIX_Corrientes"].XValueMember = "Fecha";
                chartCorriente.Series["SIX_Corrientes"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
                chartCorriente.Series["SIX_Corrientes"].YValueMembers = "ValorCorriente";
                chartCorriente.Series["SIX_Corrientes"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
                chartCorriente.Series["SIX_Corrientes"].Legend = "EquipoIndividual";
                chartCorriente.Series["SIX_Corrientes"].LegendText = "SIX " + LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Text;
                chartCorriente.DataBind();
            }
            else
            {
                chartCorriente.Visible = false;
                lblMsgGeneracionGrafica.Visible = true;
            }
        }


        protected void btnManualPoints_Click(object sender, EventArgs e)
        {
            int qtySixsSeleccionados = LstBoxSixs.GetSelectedIndices().Length;

            if ((qtySixsSeleccionados == 2) || (qtySixsSeleccionados == 3)) //Esta opción de gráfica permite 2 o 3 equipos FCIs.
            {
                string[] seriales;
                //string finicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
                //string ffinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";
                string finicial = txtFechaInicial.Text + " 00:00:00";
                string ffinal = txtFechaFinal.Text + " 23:59:59";

                //chartCorriente.DataSourceID = "SqlDataThreeFcis";
                ObtenerSerialesProcesar(LstBoxSixs, qtySixsSeleccionados, out seriales);
                chartCorriente.Series.Clear();
                try
                {
                    ProcesarSerieInformacion(chartCorriente, "SIX1_Corrientes", seriales[0], int.Parse(LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[0]].Value), finicial, ffinal);
                    ProcesarSerieInformacion(chartCorriente, "SIX2_Corrientes", seriales[1], int.Parse(LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[1]].Value), finicial, ffinal);

                    if (qtySixsSeleccionados == 3)
                    {
                        ProcesarSerieInformacion(chartCorriente, "SIX3_Corrientes", seriales[2], int.Parse(LstBoxSixs.Items[LstBoxSixs.GetSelectedIndices()[2]].Value), finicial, ffinal);
                    }

                    chartCorriente.Visible = true; //En este punto se sabe que el proceso fue OK.
                }
                catch
                {
                    lblMsgErrCriticoGenGrafico.Visible = true;
                }
            }
            else
            {
                chartCorriente.Visible = false;
                lblMsgGraficaComparativa.Visible = true;
            }
        }


        protected void ObtenerSerialesProcesar(ListBox lbControl, int qtyEquipos, out string[] serialesCods)
        {
            serialesCods = new string[3];

            //En este punto qtyEquipos es igual a 2 o a 3.

            if (qtyEquipos == 2)
            {
                serialesCods[0] = lbControl.Items[lbControl.GetSelectedIndices()[0]].Text;
                serialesCods[1] = lbControl.Items[lbControl.GetSelectedIndices()[1]].Text;
                serialesCods[2] = "";
            }
            else
            {
                serialesCods[0] = lbControl.Items[lbControl.GetSelectedIndices()[0]].Text;
                serialesCods[1] = lbControl.Items[lbControl.GetSelectedIndices()[1]].Text;
                serialesCods[2] = lbControl.Items[lbControl.GetSelectedIndices()[2]].Text;
            }
        }


        protected void ProcesarSerieInformacion(Chart chartObj, string nmSerie, string serialSIX, int sixId, string finicial, string ffinal)
        {
            chartObj.Series.Add(nmSerie);
            chartObj.Series[nmSerie].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
            chartObj.Series[nmSerie].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
            chartObj.Series[nmSerie].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
            chartObj.Series[nmSerie].Legend = "EquipoIndividual";
            chartObj.Series[nmSerie].LegendText = "SIX " + serialSIX;

            List<GenericaDecimalDateTime> puntosBD = AccesoDatosEFGUI.GetPuntosLogCorrienteSIX(sixId, finicial, ffinal);
            if (puntosBD.Count > 0)
            {
                foreach (GenericaDecimalDateTime pto in puntosBD)
                {
                    object[] valY = new object[] { pto.InformacionDecimal };
                    chartCorriente.Series[nmSerie].Points.AddXY(pto.InformacionDateTime, valY);
                }
            }

        }


        #endregion

    }
}