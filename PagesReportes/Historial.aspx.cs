using System;
using System.Collections.Generic;
using System.Linq;
using System.Globalization;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.Expressions;
using System.Web.Security;
using SGR.DataAccessLayer;
using SGR.BussinessLayer;

/*
 * Nota Importante:
 * Para el caso de las consultas que permiten generar la gráfica, estas capturan los resultados incluyendo
 * las alarmas de FCIs que ya no se encuentran relacionados con un FWT (huerfanos), por tanto, en algunas
 * ejecuciones es posible ver cantidades mayores en las barras que en los resultados tabulares.
 * 
 * Para las consultas que dan soporte a los resultados tabulares, estas no recuperan las alarmas de FCIs
 * huerfanos, pues se hace una relación directa entre las tablas AlarmasFCI y FWTs en la vista vw_app_alarmasFCI.
 * 
 * Para las consultas SQL de los DataSource de esta página que obtienen los datos para la gráfica, es necesario adicionar
 * la siguiente condición a la cláusula WHERE: [and FCIs.FWTId is not null], con el fin de omitir los resultados de
 * alarmas históricas de FCIs huerfanos de FWT. Bajo este caso, los resultados tabulares y de las gráficas sí deben 
 * coincidir.
 * */

namespace SistemaGestionRedes
{
    public partial class Historial : System.Web.UI.Page
    {
        private const short _ID_REPORTE = 10;
        private bool _verCodificacionEquipos = false;
        private bool _verSix;
        private static DateTimeFormatInfo _dateFullFormat = new DateTimeFormatInfo();
        static string _codLang;
        static DateTime txtFi;
        static DateTime txtFf;
        static int valFiltroFalla;
        static byte valFiltroEquipo;
        static int _valFiltroFwt;
        static int[] _valFcisSeleccionados = new int[]{};
        static string _selectCommandSQLDSGrafFallas;
        //private ProfileCelsa profileObj = new ProfileCelsa();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                _verCodificacionEquipos = (bool)Context.Profile.GetPropertyValue("VerCodificacionEquipos");
                _codLang = AccesoDatosEF.ConfirmarLenguaje(CultureInfo.CurrentUICulture.TwoLetterISOLanguageName);
                //_verCodificacionEquipos = profileObj.CodificarEquipos;
                _verSix = ConfigApp.VerSix;
                DateTime ya = DateTime.Now;
                txtFi = ya;
                txtFf = ya;
                string anoYa = ya.Year.ToString();
                string mesYa = ya.Month.ToString();
                string hoyYa = ya.Day.ToString();

                txtFechaInicial.Text = anoYa + "-" + mesYa + "-" + hoyYa;
                txtFechaFinal.Text = anoYa + "-" + mesYa + "-" + hoyYa;

                _dateFullFormat.FullDateTimePattern = "yyyyMMdd HH:mm:ss";
                _dateFullFormat.ShortDatePattern = "yyyyMMdd";
                _dateFullFormat.ShortTimePattern = "HH:mm:ss";
                _dateFullFormat.DateSeparator = "";

                DefinirEntitySetForEnDSFallasHistFCI();

                SqDSFallas.SelectParameters["IdLang"].DefaultValue = _codLang;

                
                chartReporte.Visible = false;
                ConfigurarParaginaParaSix();
            }
            else
            {
                //Se requiere por: El SQL dataSource que permite graficar la cantidad de fallas por el sistema/FWT/FCI
                //tiene un SelectCommand con algunos filtros fijos o constantes por defecto los cuales según las
                //necesidades son reemplazados por los valores adecuados cada vez que se quiere obtener dicha gráfica
                //(boton btnGraficarFallas). Cuando hay postBack por otros controles o links en el gridView por ejemplo
                //es necesario asignar al DataSource el último SelectCommand que permitió realizar la última gráfica o sino
                //este postBack no dibujaria nada, ya que trataria de ejecutar el SelectCommand del tiempo de diseño.
                //Si el postBack es realizado por el botón que activa la gráfica, en este algoritmo no se modifica el 
                //SelectCommand y se trabajará con el original para realizar los reemplazos que permitirán obtener la nueva gráfica.
                DefinirSelectCommandSqlDSGraficaFallas();
            }

            PopCalFi.Culture = CultureInfo.CurrentUICulture.ToString();
            PopCalFf.Culture = CultureInfo.CurrentUICulture.ToString();

            lblTextErrQtyFallasFwt.Visible = false;
            lblMegErrTodasFallas.Visible = false;
            lblMsgErrNoVariosFcis.Visible = false;
        }

        private void DefinirEntitySetForEnDSFallasHistFCI()
        {
            if (_codLang.Equals("en"))
            {
                GVFCIData.DataSourceID = "EnDSFallasHistFCI_en";
            }
            else
            {
                GVFCIData.DataSourceID = "EnDSFallasHistFCI";
            }
        }

        private void DefinirTextoEnControlesFiltros()
        {
            if (_verCodificacionEquipos)
            {
                DDListCntrs.DataTextField = "Codigo";
                LstBoxFcis.DataTextField = "Codigo";
            }
        }

        protected void ConfigurarParaginaParaSix()
        {
            if (_verSix)
            {
                DDListEquipos.Items.Add(new ListItem("FCI", "1"));
                DDListEquipos.Items.Add(new ListItem("SIX", "2"));
                DDListEquipos.Items[0].Selected = true;
                LblTituloReporte.Text = (string)this.GetLocalResourceObject("TextTittleReporteAlterno"); //"Reporte: Historia Fallas FCI/SIX";
                lblDescTipoEquipo.Text = "FCI/SIX:";
                GVFCIData.Columns[20].Visible = true; //Causa Apertura
            }
            else
            {
                DDListEquipos.Items.Add(new ListItem("FCI", "1"));
                DDListEquipos.Items[0].Selected = true;
                LblTituloReporte.Text = (string)this.GetLocalResourceObject("TextTittleReporte"); //"Reporte: Historia Fallas FCI";
                lblDescTipoEquipo.Text = "FCI:";
                GVFCIData.Columns[20].Visible = false; //Causa Apertura
                SqDSFallas.SelectCommand = SqDSFallas.SelectCommand + " " + " and MtAlarmas.Nombre not like '%SIX%' ";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //Organizar las fechas
            string dateInicial = txtFechaInicial.Text + " 00:00:00";
            string dateFinal = txtFechaFinal.Text + " 23:59:59";
            txtFi = Convert.ToDateTime(dateInicial, _dateFullFormat);
            txtFf = Convert.ToDateTime(dateFinal, _dateFullFormat);
            valFiltroFalla = int.Parse(DDListFallas.SelectedValue);
            valFiltroEquipo = byte.Parse(DDListEquipos.SelectedValue);
            if (DDListCntrs.SelectedValue == "")
            {
                _valFiltroFwt = 0;
            }
            else
            {
                _valFiltroFwt = int.Parse(DDListCntrs.SelectedValue);
            }
            _valFcisSeleccionados = UtilitariosWebGUI.GetSelectedValuesFromListBox(LstBoxFcis.GetSelectedIndices(), LstBoxFcis);

            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVFCIData, _ID_REPORTE, Membership.GetUser().UserName);

            chartReporte.Visible = false;
            //Hacer el Bind final
            GVFCIData.DataBind();
            TryMostrarMensajeNoData();
            GVFCIData.PageIndex = 0;
        }

        protected void EnDSFallasHistFCI_Selecting(object sender, EntityDataSourceSelectingEventArgs e)
        {
            string targetId = qExFalla.TargetControlID;
        }

        protected void GVFCIData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Obtener el tipo del equipo
                TipoEquipoRed tipoEquipo = (TipoEquipoRed)valFiltroEquipo;

                //Crear el objeto control relacionado con los valores: AlarmasFCI.Valor y AlarmasFCI.DatoAdicional(CausaApertura).
                Label lblVal = (Label)e.Row.FindControl("lblValor");
                Label lblCausaAper = (Label)e.Row.FindControl("lblCausaApertura");

                if (tipoEquipo == TipoEquipoRed.SIXDG)
                {
                    lblVal.Text = "N/A";
                    byte causaAperturaSix = (byte)DataBinder.Eval(e.Row.DataItem, "CausaApertura");
                    lblCausaAper.Text = UtilitariosWebGUI.GetNombreCausaAperturaSixLenguaje(_codLang, (byte)causaAperturaSix);
                }
                else if (tipoEquipo == TipoEquipoRed.FCI)
                {
                    int valorCte = (int)DataBinder.Eval(e.Row.DataItem, "Valor");
                    lblVal.Text = valorCte.ToString();
                    lblCausaAper.Text = "N/A";
                }
            }
        }

        protected void DDListEquipos_SelectedIndexChanged(object sender, EventArgs e)
        {
            TipoEquipoRed tipoEquipo = (TipoEquipoRed)byte.Parse(DDListEquipos.SelectedValue);

            if (tipoEquipo == TipoEquipoRed.SIXDG)
            {
                //SqDSFallas.SelectCommand = "select Id, Nombre from MtAlarmas WHERE CHARINDEX('Clear', Nombre, 1) = 0 AND TipoEquipo = 'A' and id in (178,179)";
                SqDSFallas.SelectCommand = @"select MtAlarmas_Lenguaje.Id, MtAlarmas_Lenguaje.Nombre 
                                            FROM MtAlarmas, MtAlarmas_Lenguaje, MtLenguajes
                                            WHERE MtAlarmas.Id = MtAlarmas_Lenguaje.Id 
                                            and CHARINDEX('Clear', MtAlarmas.Nombre, 1) = 0 AND MtAlarmas.TipoEquipo = 'A'
                                            and MtAlarmas_Lenguaje.Lang = MtLenguajes.Id
                                            and MtLenguajes.Cod = @IdLang 
                                            and MtAlarmas.id in (178,179,180) ";
            }
            else if (tipoEquipo == TipoEquipoRed.FCI)
            {
                //SqDSFallas.SelectCommand = "select Id, Nombre from MtAlarmas WHERE CHARINDEX('Clear', Nombre, 1) = 0 AND TipoEquipo = 'A'";
                SqDSFallas.SelectCommand = @"select MtAlarmas_Lenguaje.Id, MtAlarmas_Lenguaje.Nombre 
                                            FROM MtAlarmas, MtAlarmas_Lenguaje, MtLenguajes
                                            WHERE MtAlarmas.Id = MtAlarmas_Lenguaje.Id 
                                            and CHARINDEX('Clear', MtAlarmas.Nombre, 1) = 0 AND MtAlarmas.TipoEquipo = 'A'
                                            and MtAlarmas_Lenguaje.Lang = MtLenguajes.Id
                                            and MtLenguajes.Cod = @IdLang ";
            }
            DDListFallas.Items.Clear();
            ListItem itemTodos = new ListItem("Todos", "0");
            DDListFallas.Items.Add(itemTodos);
            DDListFallas.DataBind();

            DDListCntrs_SelectedIndexChanged(sender, e);
        }

        protected void TryMostrarMensajeNoData()
        {
            if (GVFCIData.Rows.Count > 0)
            {
                lblMsgNoData.Visible = false;
            }
            else
            {
                lblMsgNoData.Visible = true;
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


        #region Metodos Query Extender

        public static IQueryable<vw_app_alarmasFCI> FiltrarPorFecha(IQueryable<vw_app_alarmasFCI> query)
        {
            return from falla in query
                   where falla.Fecha >= txtFi && falla.Fecha <= txtFf
                   select falla;

        }

        public static IQueryable<vw_app_alarmasFCI> FiltrarPorFalla(IQueryable<vw_app_alarmasFCI> query)
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

        public static IQueryable<vw_app_alarmasFCI> FiltrarPorEquipo(IQueryable<vw_app_alarmasFCI> query)
        {
            return from falla in query
                   where falla.TipoEquipo == valFiltroEquipo
                   select falla;
        }

        public static IQueryable<vw_app_alarmasFCI> FiltrarPorFciFromFwt(IQueryable<vw_app_alarmasFCI> query)
        {
            if (_valFiltroFwt != 0)
            {
                if (_valFcisSeleccionados.Length == 0)
                {
                    return from falla in query
                           where falla.IdFWT == _valFiltroFwt
                           select falla;
                }
                else
                {
                    return from falla in query
                           where _valFcisSeleccionados.Contains(falla.IdFCI)
                           select falla;
                }
            }
            else
            {
                if (_valFcisSeleccionados.Length > 0)
                {
                    return from falla in query
                           where _valFcisSeleccionados.Contains(falla.IdFCI)
                           select falla;
                }
                else
                {
                    return from falla in query
                           select falla;
                }
            }
        }

        //***************************************************
        //Metodos para los QueryExtender de la vista que corresponde al inglés

        public static IQueryable<vw_app_alarmasFCI_en> FiltrarPorFechaEn(IQueryable<vw_app_alarmasFCI_en> query)
        {
            return from falla in query
                   where falla.Fecha >= txtFi && falla.Fecha <= txtFf
                   select falla;
        }

        public static IQueryable<vw_app_alarmasFCI_en> FiltrarPorFallaEn(IQueryable<vw_app_alarmasFCI_en> query)
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

        public static IQueryable<vw_app_alarmasFCI_en> FiltrarPorEquipoEn(IQueryable<vw_app_alarmasFCI_en> query)
        {
            return from falla in query
                   where falla.TipoEquipo == valFiltroEquipo
                   select falla;
        }

        public static IQueryable<vw_app_alarmasFCI_en> FiltrarPorFciFromFwtEn(IQueryable<vw_app_alarmasFCI_en> query)
        {
            if (_valFiltroFwt != 0)
            {
                if (_valFcisSeleccionados.Length == 0)
                {
                    return from falla in query
                           where falla.IdFWT == _valFiltroFwt
                           select falla;
                }
                else
                {
                    return from falla in query
                           where _valFcisSeleccionados.Contains(falla.IdFCI)
                           select falla;
                }
            }
            else
            {
                if (_valFcisSeleccionados.Length > 0)
                {
                    return from falla in query
                           where _valFcisSeleccionados.Contains(falla.IdFCI)
                           select falla;
                }
                else
                {
                    return from falla in query
                           select falla;
                }
            }
        }

        #endregion



        #region Metodos para Graficar


        protected void btnGrafFwtFallas_Click(object sender, EventArgs e)
        {
            //Se requiere: Una falla seleccionada, el rango de fechas, definir visibilidad de Serial/Codigo.
            //Configurar el SqlDataSource y luego el control Chart...

            if (DDListFallas.SelectedValue != "0")
            {
                //Capturar filtros...
                chartReporte.Series.Clear();
                chartReporte.Visible = true;
                string finicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
                string ffinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";
                string idFalla = DDListFallas.SelectedValue;

                //Configurar el DataSource...
                SqlDSGrafFwtsQtyFallas.SelectParameters["finicial"].DefaultValue = finicial;
                SqlDSGrafFwtsQtyFallas.SelectParameters["ffinal"].DefaultValue = ffinal;
                SqlDSGrafFwtsQtyFallas.SelectParameters["idAlarma"].DefaultValue = idFalla;

                //Definir si se visualiza Serial o Codigo de los FWT.
                _verCodificacionEquipos = (bool)Context.Profile.GetPropertyValue("VerCodificacionEquipos");
                //_verCodificacionEquipos = profileObj.CodificarEquipos;
                string datoXvisualizar = "";
                if (_verCodificacionEquipos)
                {
                    datoXvisualizar = "CodigoFWT";
                }
                else
                {
                    datoXvisualizar = "SerialFWT";
                }


                //Configurar el control Chart...
                chartReporte.DataSourceID = "SqlDSGrafFwtsQtyFallas";
                chartReporte.Titles["Unico"].Text = (string)this.GetLocalResourceObject("TextSqlDSGrafFwtsQtyFallasTit1") + " " + DDListFallas.SelectedItem.Text + " " + (string)this.GetLocalResourceObject("TextSqlDSGrafFwtsQtyFallasTit2");
                chartReporte.ChartAreas["CArea1"].AxisX.Title = (string)this.GetLocalResourceObject("TextSqlDSGrafFwtsQtyFallasAxisX"); // "Concentrador";
                chartReporte.ChartAreas["CArea1"].AxisY.Title = (string)this.GetLocalResourceObject("TextSqlDSGrafFwtsQtyFallasAxisY"); //"Cantidad Sucesos";
                chartReporte.Series.Add("infoFwts");
                chartReporte.Series["infoFwts"].ChartArea = "CArea1";
                chartReporte.Series["infoFwts"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                chartReporte.Series["infoFwts"].XValueMember = datoXvisualizar;
                chartReporte.Series["infoFwts"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.String;
                chartReporte.Series["infoFwts"].YValueMembers = "TotalEventos";
                chartReporte.Series["infoFwts"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
                chartReporte.Series["infoFwts"].IsValueShownAsLabel = true;
                //chartReporte.Series["infoFwts"].Legend = "EquipoIndividual";
                //chartReporte.Series["infoFwts"].LegendText = "FCI " + LstBoxFcis.Items[LstBoxFcis.GetSelectedIndices()[0]].Text;
                chartReporte.DataBind();

            }
            else
            {
                chartReporte.Visible = false;
                lblTextErrQtyFallasFwt.Visible = true;
            }



        }

        protected void btnGraficarFallas_Click(object sender, EventArgs e)
        {
            //Se requiere: No falla seleccionada, el rango de fechas, configurar SQLDataSource y luego el grafico.

            if (DDListFallas.SelectedValue == "0")
            {
                //Capturar filtros...
                chartReporte.Series.Clear();
                chartReporte.Visible = true;
                //string finicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
                //string ffinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";
                string finicial = txtFechaInicial.Text + " 00:00:00";
                string ffinal = txtFechaFinal.Text + " 23:59:59";
                string codIdioma = _codLang; //OJO, esto luego debe trabajar con lo de globalización.

                //Texto del título del Chart. Se va armando...
                string parteTituloChart = (string)this.GetLocalResourceObject("TextSqlDSGrafFallasQtyTit1"); //"Sistema completo de FCIs.";

                //Configurar el DataSource...
                SqlDSGrafFallasQty.SelectParameters["finicial"].DefaultValue = finicial;
                SqlDSGrafFallasQty.SelectParameters["ffinal"].DefaultValue = ffinal;
                SqlDSGrafFallasQty.SelectParameters["codIdioma"].DefaultValue = codIdioma;

                //Configurar el DataSource por medio de FilterExpression para los filtros críticos.
                if (LstBoxFcis.GetSelectedIndices().Length <= 1) //Debe haber uno o ningún FCI seleccionado
                {
                    if (LstBoxFcis.GetSelectedIndices().Length == 1)
                    {
                        SqlDSGrafFallasQty.SelectCommand = SqlDSGrafFallasQty.SelectCommand.Replace("and AlarmasFCI.FCIId = 0", "and AlarmasFCI.FCIId = " + LstBoxFcis.Items[LstBoxFcis.GetSelectedIndices()[0]].Value);
                        parteTituloChart = (string)this.GetLocalResourceObject("TextSqlDSGrafFallasQtyTit2") + " " + LstBoxFcis.Items[LstBoxFcis.GetSelectedIndices()[0]].Text;
                    }
                    else
                    {
                        SqlDSGrafFallasQty.SelectCommand = SqlDSGrafFallasQty.SelectCommand.Replace("and AlarmasFCI.FCIId = 0", "");
                        if (DDListCntrs.SelectedValue != "")
                        {
                            SqlDSGrafFallasQty.SelectCommand = SqlDSGrafFallasQty.SelectCommand.Replace("and FCIs.FWTId = 0", "and FCIs.FWTId = " + DDListCntrs.SelectedValue);
                            parteTituloChart = (string)this.GetLocalResourceObject("TextSqlDSGrafFallasQtyTit3") + " " + DDListCntrs.SelectedItem.Text;
                        }
                        else
                        {
                            SqlDSGrafFallasQty.SelectCommand = SqlDSGrafFallasQty.SelectCommand.Replace("and FCIs.FWTId = 0", "");
                        }
                    }
                    _selectCommandSQLDSGrafFallas = SqlDSGrafFallasQty.SelectCommand;

                    //Configurar el control Chart...
                    chartReporte.DataSourceID = "SqlDSGrafFallasQty";
                    chartReporte.Titles["Unico"].Text = (string)this.GetLocalResourceObject("TextSqlDSGrafFallasQtyTitPrimeraPte") + " " + parteTituloChart;
                    chartReporte.ChartAreas["CArea1"].AxisX.Title = (string)this.GetLocalResourceObject("TextSqlDSGrafFallasQtyAxisX"); //"Alarma";
                    chartReporte.ChartAreas["CArea1"].AxisY.Title = (string)this.GetLocalResourceObject("TextSqlDSGrafFallasQtyAxisY"); //"Cantidad Sucesos";
                    chartReporte.Series.Add("infoFallas");
                    chartReporte.Series["infoFallas"].ChartArea = "CArea1";
                    chartReporte.Series["infoFallas"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                    chartReporte.Series["infoFallas"].XValueMember = "Nombre";
                    chartReporte.Series["infoFallas"].XValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.String;
                    chartReporte.Series["infoFallas"].YValueMembers = "TotalEventos";
                    chartReporte.Series["infoFallas"].YValueType = System.Web.UI.DataVisualization.Charting.ChartValueType.Int32;
                    chartReporte.Series["infoFallas"].IsValueShownAsLabel = true;
                    //chartReporte.Series["infoFwts"].Legend = "EquipoIndividual";
                    //chartReporte.Series["infoFwts"].LegendText = "FCI " + LstBoxFcis.Items[LstBoxFcis.GetSelectedIndices()[0]].Text;
                    chartReporte.DataBind();

                }
                else
                {
                    chartReporte.Visible = false;
                    //Marcar error
                    lblMsgErrNoVariosFcis.Visible = true;
                }
            }
            else
            {
                chartReporte.Visible = false;
                //Marcar error
                lblMegErrTodasFallas.Visible = true;
            }
        }

        protected void DefinirSelectCommandSqlDSGraficaFallas()
        {
            Control posibleBotonPostBack = UtilitariosWebGUI.GetPostBackControl(this);

            if (posibleBotonPostBack is Button)
            {
                Button butControl = (Button)posibleBotonPostBack;
                if (butControl.ID != "btnGraficarFallas")
                {
                    if (_selectCommandSQLDSGrafFallas != "")
                    {
                        SqlDSGrafFallasQty.SelectCommand = _selectCommandSQLDSGrafFallas;
                    }
                }
            }
            else
            {
                if (_selectCommandSQLDSGrafFallas != "")
                {
                    SqlDSGrafFallasQty.SelectCommand = _selectCommandSQLDSGrafFallas;
                }
            }
        }

        

        #endregion

        //protected void chartReporte_Load(object sender, EventArgs e)
        //{
        //    if (_selectCommandSQLDSGrafFallas != "")
        //    {
        //        SqlDSGrafFallasQty.SelectCommand = _selectCommandSQLDSGrafFallas;
        //    }
        //}
       

        



        #region Visualizacion de Columnas
        //*********************** MANEJO DE LA VISUALIZACIÓN DE COLUMNAS *******************************


        //protected void DefinirColumnasVisualizadas(GridView gvObj, int idReporte, string nombreUsuario)
        //{

        //    List<string> listaHeadersConfigurados = AccesoDatosEFGUI.GetHeaderTextColumnasConfiguradasDelReporte(nombreUsuario, idReporte);

        //    //if (listaHeadersConfigurados.Count > 0)
        //    //{
        //        List<string> listaAllHeadersText = AccesoDatosEFGUI.GetAllHeaderTextColumnasReporte(idReporte);

        //        foreach (DataControlField gvCol in gvObj.Columns)
        //        {
        //            if (listaAllHeadersText.Contains(gvCol.HeaderText))
        //            {
        //                if (listaHeadersConfigurados.Contains(gvCol.HeaderText))
        //                {
        //                    gvCol.Visible = true;
        //                }
        //                else
        //                {
        //                    gvCol.Visible = false;
        //                }
        //            }
        //        }
        //    //}

        //}


        #endregion




    }
}