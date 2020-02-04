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
    public partial class CurrentStatistics : System.Web.UI.Page
    {
        private const short _ID_REPORTE = 40;

        private bool _verCodificacionEquipos = false;

        //private ProfileCelsa profileObj = new ProfileCelsa();

        string fechaInicial;
        string fechaFinal;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                _verCodificacionEquipos = (bool)Context.Profile.GetPropertyValue("VerCodificacionEquipos");
                //_verCodificacionEquipos = profileObj.CodificarEquipos;
                DateTime ya = DateTime.Now;
                string anoYa = ya.Year.ToString();
                string mesYa = ya.Month.ToString();
                string hoyYa = ya.Day.ToString();

                txtFechaInicial.Text = anoYa + "-" + mesYa + "-" + hoyYa;
                txtFechaFinal.Text = anoYa + "-" + mesYa + "-" + hoyYa;
                //LoadFCIs(); Obsoleto, aunque su control visual se dejó como invisible.
                chartCorriente.Visible = false;
                DefinirTextoEnControlesFiltros();
            }
            else
            {
                //Esto se tiene que hacer o de lo contrario si el GridView ya tiene resultados, estos se dañan entre
                //clicks a sus páginas u order de las columnas.
                ReconfigurarSQLDataSourcePpal();
            }

            PopCalFi.Culture = CultureInfo.CurrentUICulture.ToString();
            PopCalFf.Culture = CultureInfo.CurrentUICulture.ToString();

            lblMsgGeneracionGrafica.Visible = false;
            lblMsgGraficaComparativa.Visible = false;
            lblMsgErrCriticoGenGrafico.Visible = false;
        }

        private void DefinirTextoEnControlesFiltros()
        {
            if (_verCodificacionEquipos)
            {
                DDListCntrs.DataTextField = "Serial";
                LstBoxFcis.DataTextField = "Serial";
            }
        }

        private void LoadFCIs()
        {

            using (SistemaGestionRemotoContainer db = new SistemaGestionRemotoContainer())
            {
                txtSerialFCI.DataSource = from fci in db.FCIs
                                          where fci.TipoEquipo == 1
                                          orderby fci.Serial
                                          select new { Id = fci.Id, Ser = fci.Serial };
                txtSerialFCI.DataTextField = "Ser";
                txtSerialFCI.DataValueField = "Ser";
                txtSerialFCI.DataBind();

            }
            txtSerialFCI.Items.Add(new ListItem("", "")); //Item vacio para no escoger FCI 
            txtSerialFCI.SelectedIndex = txtSerialFCI.Items.Count - 1;  //para que quede escogido el ultimo item vacio

        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            fechaInicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
            fechaFinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

            if (txtSerialFCI.Text.Trim().Equals(""))
            {
                SqDSInfoCompleta.SelectParameters.Clear();
                SqDSInfoCompleta.SelectParameters.Add("Finicial", fechaInicial);
                SqDSInfoCompleta.SelectParameters.Add("Ffinal", fechaFinal);
                GVReporte.DataSourceID = "SqDSInfoCompleta";
            }
            else
            {
                SqDSInfoLikeSerial.SelectParameters.Clear();
                SqDSInfoLikeSerial.SelectParameters.Add("Finicial", fechaInicial);
                SqDSInfoLikeSerial.SelectParameters.Add("Ffinal", fechaFinal);
                SqDSInfoLikeSerial.SelectParameters.Add("Serial", txtSerialFCI.Text.Trim());
                GVReporte.DataSourceID = "SqDSInfoLikeSerial";
            }

            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVReporte, _ID_REPORTE, Membership.GetUser().UserName);

            chartCorriente.Visible = false;
            GVReporte.DataBind();
        }

        protected void btnNewBuscar_Click(object sender, EventArgs e)
        {
            fechaInicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
            fechaFinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

            SqlDSNewInfoCompleta.SelectParameters["Finicial"].DefaultValue = fechaInicial;
            SqlDSNewInfoCompleta.SelectParameters["Ffinal"].DefaultValue = fechaFinal;
            SqlDSNewInfoCompleta.FilterExpression = "";
            GVReporte.DataSourceID = "SqlDSNewInfoCompleta";

            if (DDListCntrs.SelectedValue == "")
            {
                if (LstBoxFcis.GetSelectedIndices().Length > 0) //Hay varios seleccionados
                {
                    string valsSeleccionados = UtilitariosWebGUI.GetSelectedItemsComaSeparated(LstBoxFcis.GetSelectedIndices(), LstBoxFcis);
                    SqlDSNewInfoCompleta.FilterExpression = "IdFCI IN (" + valsSeleccionados + ")";
                }
            }
            else
            {
                if (LstBoxFcis.GetSelectedIndices().Length == 0) //Todos los FCIs del FWT
                {
                    SqlDSNewInfoCompleta.FilterExpression = "IdFWT = " + DDListCntrs.SelectedValue;
                }
                else
                {
                    //Hay algunos seleccionados...
                    string valsSeleccionados = UtilitariosWebGUI.GetSelectedItemsComaSeparated(LstBoxFcis.GetSelectedIndices(), LstBoxFcis);
                    SqlDSNewInfoCompleta.FilterExpression = "IdFCI IN (" + valsSeleccionados + ")";
                }
            }

            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVReporte, _ID_REPORTE, Membership.GetUser().UserName);
            chartCorriente.Visible = false;
            GVReporte.DataBind();
            GVReporte.PageIndex = 0;
        }

        protected void ReconfigurarSQLDataSourcePpal()
        {
            if (DDListCntrs.SelectedValue == "")
            {
                if (LstBoxFcis.GetSelectedIndices().Length > 0) //Hay varios seleccionados
                {
                    string valsSeleccionados = UtilitariosWebGUI.GetSelectedItemsComaSeparated(LstBoxFcis.GetSelectedIndices(), LstBoxFcis);
                    SqlDSNewInfoCompleta.FilterExpression = "IdFCI IN (" + valsSeleccionados + ")";
                }
            }
            else
            {
                if (LstBoxFcis.GetSelectedIndices().Length == 0) //Todos los FCIs del FWT
                {
                    SqlDSNewInfoCompleta.FilterExpression = "IdFWT = " + DDListCntrs.SelectedValue;
                }
                else
                {
                    //Hay algunos seleccionados...
                    string valsSeleccionados = UtilitariosWebGUI.GetSelectedItemsComaSeparated(LstBoxFcis.GetSelectedIndices(), LstBoxFcis);
                    SqlDSNewInfoCompleta.FilterExpression = "IdFCI IN (" + valsSeleccionados + ")";
                }
            }
        }

        protected void GVReporte_DataBound(object sender, EventArgs e)
        {
            if (GVReporte.Rows.Count == 0)
            {
                LblMsgNoData.Visible = true;
            }
            else
            {
                LblMsgNoData.Visible = false;
            }
        }

        protected void GVReporte_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                byte tipoE = (byte)DataBinder.Eval(e.Row.DataItem, "TipoEquipo");
                TipoEquipoRed tipoERed = (TipoEquipoRed)tipoE;
                if (tipoERed == TipoEquipoRed.FCI)
                {
                    e.Row.Cells[0].ToolTip = TipoEquipoRed.FCI.ToString();
                }
                else
                {
                    e.Row.Cells[0].ToolTip = TipoEquipoRed.SIXDG.ToString();
                }
            }
        }

        protected void btnGraficar_Click(object sender, EventArgs e)
        {
            if (LstBoxFcis.GetSelectedIndices().Length == 1) //Esta opción de gráfica solo permite un equipo FCI.
            {
                chartCorriente.Series.Clear();
                chartCorriente.Visible = true;
                string finicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
                string ffinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

                //SqlDataSource dataSourceObj = SqlDataGrafOneFci;
                SqlDataSource dataSourceObj = SqlDataGrafOneFciCteProm;
                //chartCorriente.DataSourceID = "SqlDataGrafOneFci"; 
                chartCorriente.DataSourceID = "SqlDataGrafOneFciCteProm";

                dataSourceObj.SelectParameters["Finicial"].DefaultValue = finicial;
                dataSourceObj.SelectParameters["Ffinal"].DefaultValue = ffinal;
                dataSourceObj.SelectParameters["FciId"].DefaultValue = LstBoxFcis.Items[LstBoxFcis.GetSelectedIndices()[0]].Value;
                chartCorriente.Series.Add("FCI_Corrientes");
                chartCorriente.Series["FCI_Corrientes"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
                chartCorriente.Series["FCI_Corrientes"].XValueMember = "Fecha";
                chartCorriente.Series["FCI_Corrientes"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
                chartCorriente.Series["FCI_Corrientes"].YValueMembers = "ValorCorriente";
                chartCorriente.Series["FCI_Corrientes"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
                chartCorriente.Series["FCI_Corrientes"].Legend = "EquipoIndividual";
                chartCorriente.Series["FCI_Corrientes"].LegendText = "FCI " + LstBoxFcis.Items[LstBoxFcis.GetSelectedIndices()[0]].Text;
                chartCorriente.DataBind();
            }
            else
            {
                chartCorriente.Visible = false;
                lblMsgGeneracionGrafica.Visible = true;
            }

            //chartCorriente.DataSourceID = "SqDSInfoLikeSerial";
            //chartCorriente.Series.Add("FCI_Corrientes");
            //chartCorriente.Series["FCI_Corrientes"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
            //chartCorriente.Series["FCI_Corrientes"].XValueMember = "Fecha";
            //chartCorriente.Series["FCI_Corrientes"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
            //chartCorriente.Series["FCI_Corrientes"].YValueMembers = "ValorCorriente";
            //chartCorriente.Series["FCI_Corrientes"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
            //chartCorriente.ChartAreas["ChartArea1"].AxisX.LabelAutoFitStyle = System.Web.UI.DataVisualization.Charting.LabelAutoFitStyles.DecreaseFont;
            //var lblStyle = new System.Web.UI.DataVisualization.Charting.LabelStyle();
            //lblStyle.Format = "yyyy-MM-dd HH:MM:ss";
            //chartCorriente.ChartAreas["ChartArea1"].AxisX.LabelStyle = lblStyle;
            //chartCorriente.DataBind();
        }


        //Con esta estrategia, que fue las mas dispendiosa y con algunos desarrollos en BD de SPs, la gráfica
        //tiene una rayas o lineas muy extrañas (basura en la gráfica), aunque la tendencia general de la línea sea lógica.
        //El boton de este event handler queda como visible = false.
        protected void btnPruebaThree_Click(object sender, EventArgs e)
        {
            int qtyFcisSeleccionados = LstBoxFcis.GetSelectedIndices().Length;

            if ((qtyFcisSeleccionados == 2) || (qtyFcisSeleccionados == 3)) //Esta opción de gráfica permite 2 o 3 equipos FCIs.
            {
                string[] seriales;
                chartCorriente.Visible = true;
                string finicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
                string ffinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

                if (PrepararInformacionChartingComparativa(finicial, ffinal, LstBoxFcis, qtyFcisSeleccionados, out seriales))
                {

                    chartCorriente.DataSourceID = "SqlDataThreeFcis";

                    chartCorriente.Series.Clear(); 

                    chartCorriente.Series.Add("FCI1_Corrientes");
                    chartCorriente.Series["FCI1_Corrientes"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
                    chartCorriente.Series["FCI1_Corrientes"].XValueMember = "FechaFCI1";
                    chartCorriente.Series["FCI1_Corrientes"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
                    chartCorriente.Series["FCI1_Corrientes"].YValueMembers = "ValorIL1";
                    chartCorriente.Series["FCI1_Corrientes"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
                    chartCorriente.Series["FCI1_Corrientes"].Legend = "EquipoIndividual";
                    chartCorriente.Series["FCI1_Corrientes"].LegendText = "FCI " + seriales[0];
                    

                    chartCorriente.Series.Add("FCI2_Corrientes");
                    chartCorriente.Series["FCI2_Corrientes"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
                    chartCorriente.Series["FCI2_Corrientes"].XValueMember = "FechaFCI2";
                    chartCorriente.Series["FCI2_Corrientes"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
                    chartCorriente.Series["FCI2_Corrientes"].YValueMembers = "ValorIL2";
                    chartCorriente.Series["FCI2_Corrientes"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
                    chartCorriente.Series["FCI2_Corrientes"].Legend = "EquipoIndividual";
                    chartCorriente.Series["FCI2_Corrientes"].LegendText = "FCI " + seriales[1];
                    

                    if (qtyFcisSeleccionados == 3)
                    {
                        chartCorriente.Series.Add("FCI3_Corrientes");
                        chartCorriente.Series["FCI3_Corrientes"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
                        chartCorriente.Series["FCI3_Corrientes"].XValueMember = "FechaFCI3";
                        chartCorriente.Series["FCI3_Corrientes"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
                        chartCorriente.Series["FCI3_Corrientes"].YValueMembers = "ValorIL3";
                        chartCorriente.Series["FCI3_Corrientes"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
                        chartCorriente.Series["FCI3_Corrientes"].Legend = "EquipoIndividual";
                        chartCorriente.Series["FCI3_Corrientes"].LegendText = "FCI " + seriales[2];
                    }

                    chartCorriente.DataBind();
                }
                else
                {
                    chartCorriente.Visible = false;
                    lblMsgErrCriticoGenGrafico.Visible = true;
                }
            }
            else
            {
                chartCorriente.Visible = false;
                lblMsgGraficaComparativa.Visible = true;
            }
        }

        protected void btnManualPoints_Click(object sender, EventArgs e)
        {
            int qtyFcisSeleccionados = LstBoxFcis.GetSelectedIndices().Length;

            if ((qtyFcisSeleccionados == 2) || (qtyFcisSeleccionados == 3)) //Esta opción de gráfica permite 2 o 3 equipos FCIs.
            {
                string[] seriales;
                //string finicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
                //string ffinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";
                string finicial = txtFechaInicial.Text+ " 00:00:00";
                string ffinal = txtFechaFinal.Text + " 23:59:59";

                //chartCorriente.DataSourceID = "SqlDataThreeFcis";
                ObtenerSerialesProcesar(LstBoxFcis, qtyFcisSeleccionados, out seriales);
                chartCorriente.Series.Clear();
                try
                {
                    ProcesarSerieInformacion(chartCorriente, "FCI1_Corrientes", seriales[0], int.Parse(LstBoxFcis.Items[LstBoxFcis.GetSelectedIndices()[0]].Value), finicial, ffinal);
                    ProcesarSerieInformacion(chartCorriente, "FCI2_Corrientes", seriales[1], int.Parse(LstBoxFcis.Items[LstBoxFcis.GetSelectedIndices()[1]].Value), finicial, ffinal);

                    if (qtyFcisSeleccionados == 3)
                    {
                        ProcesarSerieInformacion(chartCorriente, "FCI3_Corrientes", seriales[2], int.Parse(LstBoxFcis.Items[LstBoxFcis.GetSelectedIndices()[2]].Value), finicial, ffinal);
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

        protected void DDListCntrs_DataBound(object sender, EventArgs e)
        {
            DDListCntrs.Items.Add(new ListItem("", "")); //Item vacio para no escoger FCI 
            DDListCntrs.SelectedIndex = DDListCntrs.Items.Count - 1;  //para que quede escogido el ultimo item vacio
        }

        protected void DDListCntrs_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDListCntrs.SelectedValue == "")
            {
                SqlDSFcis.FilterExpression = "";
                SqlDSFcis.FilterParameters.Clear();
            }
            else
            {
                SqlDSFcis.FilterExpression = "FWTId = " + DDListCntrs.SelectedValue;
            }

            LstBoxFcis.DataBind();
        }

        protected bool PrepararInformacionChartingComparativa(string fini, string ffin, ListBox lbControl, int qtyEquipos,
            out string[] serialesCods)
        {
            serialesCods = new string[3];
            int valIdFci1 = 0;
            int valIdFci2 = 0;
            int valIdFci3 = 0;

            //En este punto qtyEquipos es igual a 2 o a 3.

            if (qtyEquipos == 2)
            {
                valIdFci1 = int.Parse(lbControl.Items[lbControl.GetSelectedIndices()[0]].Value);
                serialesCods[0] = lbControl.Items[lbControl.GetSelectedIndices()[0]].Text;
                valIdFci2 = int.Parse(lbControl.Items[lbControl.GetSelectedIndices()[1]].Value);
                serialesCods[1] = lbControl.Items[lbControl.GetSelectedIndices()[1]].Text;
                valIdFci3 = 0;
                serialesCods[2] = "";
            }
            else
            {
                valIdFci1 = int.Parse(lbControl.Items[lbControl.GetSelectedIndices()[0]].Value);
                serialesCods[0] = lbControl.Items[lbControl.GetSelectedIndices()[0]].Text;
                valIdFci2 = int.Parse(lbControl.Items[lbControl.GetSelectedIndices()[1]].Value);
                serialesCods[1] = lbControl.Items[lbControl.GetSelectedIndices()[1]].Text;
                valIdFci3 = int.Parse(lbControl.Items[lbControl.GetSelectedIndices()[2]].Value); ;
                serialesCods[2] = lbControl.Items[lbControl.GetSelectedIndices()[2]].Text;
            }

            return AccesoDatosEFGUI.ProcesarLogCorrienteFCIChart(valIdFci1, valIdFci2, valIdFci3, fini, ffin);

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

        protected void ProcesarSerieInformacion(Chart chartObj, string nmSerie, string serialFCI, int fciId, string finicial, string ffinal)
        {
            chartObj.Series.Add(nmSerie);
            chartObj.Series[nmSerie].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
            chartObj.Series[nmSerie].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.DateTime;
            chartObj.Series[nmSerie].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
            chartObj.Series[nmSerie].Legend = "EquipoIndividual";
            chartObj.Series[nmSerie].LegendText = "FCI " + serialFCI;

            //List<GenericaIntDateTime> puntosBD = AccesoDatosEFGUI.GetPuntosLogCorriente(fciId, finicial, ffinal);
            List<GenericaIntDateTime> puntosBD = AccesoDatosEFGUI.GetPuntosLogCorrientePromedio(fciId, finicial, ffinal);
            if (puntosBD.Count > 0)
            {
                foreach (GenericaIntDateTime pto in puntosBD)
                {
                    object[] valY = new object[] { pto.InformacionInt };
                    chartCorriente.Series[nmSerie].Points.AddXY(pto.InformacionDateTime, valY);
                }
            }

        }
        

    }
}