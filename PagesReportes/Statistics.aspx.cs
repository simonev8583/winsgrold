using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes
{
    public partial class Statistics : System.Web.UI.Page
    {
        private const short _ID_REPORTE = 20;

        string fechaInicial;
        string fechaFinal;
        //string serialFCI;
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
                //LoadFCIs();
            }
            PopCalFi.Culture = CultureInfo.CurrentUICulture.ToString();
            PopCalFf.Culture = CultureInfo.CurrentUICulture.ToString();
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
                SqlDSInfoCompleta.SelectParameters.Clear();
                SqlDSInfoCompleta.SelectParameters.Add("Finicial", fechaInicial);
                SqlDSInfoCompleta.SelectParameters.Add("Ffinal", fechaFinal);

                SqlDSInfoCompletaCorriente.SelectParameters.Clear();
                SqlDSInfoCompletaCorriente.SelectParameters.Add("Finicial", fechaInicial);
                SqlDSInfoCompletaCorriente.SelectParameters.Add("Ffinal", fechaFinal);

                GVReporte.DataSourceID = "SqlDSInfoCompleta";
                GVReporteCorriente.DataSourceID = "SqlDSInfoCompletaCorriente";
            }
            else
            {
                SqDSInfoLikeSerial.SelectParameters.Clear();
                SqDSInfoLikeSerial.SelectParameters.Add("Finicial", fechaInicial);
                SqDSInfoLikeSerial.SelectParameters.Add("Ffinal", fechaFinal);
                SqDSInfoLikeSerial.SelectParameters.Add("Serial", txtSerialFCI.Text.Trim());
                SqDSInfoLikeSerial.SelectParameters.Add("fciId", AccesoDatosEF.GetIdBaseDatosFCI(txtSerialFCI.Text.Trim()).ToString());
                
                SqDSInfoLikeSerialCorriente.SelectParameters.Clear();
                SqDSInfoLikeSerialCorriente.SelectParameters.Add("Finicial", fechaInicial);
                SqDSInfoLikeSerialCorriente.SelectParameters.Add("Ffinal", fechaFinal);
                SqDSInfoLikeSerialCorriente.SelectParameters.Add("Serial", txtSerialFCI.Text.Trim());
                
                GVReporte.DataSourceID = "SqDSInfoLikeSerial";
                GVReporteCorriente.DataSourceID = "SqDSInfoLikeSerialCorriente";
            }

            //string nombreUsr = HttpContext.Current.User.Identity.Name;
            string nombreUsr = Membership.GetUser().UserName;
            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVReporte, _ID_REPORTE, nombreUsr); //Before: Membership.GetUser().UserName
            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVReporteCorriente, _ID_REPORTE, nombreUsr); //Before: Membership.GetUser().UserName

            GVReporte.DataBind();
            GVReporteCorriente.DataBind();
        }

        protected void btnNewBuscar_Click(object sender, EventArgs e)
        {
            fechaInicial = txtFechaInicial.Text.Replace("-", "") + " 00:00:00";
            fechaFinal = txtFechaFinal.Text.Replace("-", "") + " 23:59:59";

            if (ChkSoloAusenciaTension.Checked)
            {
                _EjecutarBusquedaFCISinTension();
            }
            else
            {
                _EjecutarBusquedaCompletaComun();
            }

            //_ConfigurarDataSourceReporteComun(SqlDSInfoCompleta);
            //_ConfigurarDataSourceReporteComun(SqlDSInfoCompletaCorriente);

            ////SqlDSInfoCompleta.SelectParameters["Finicial"].DefaultValue = fechaInicial;
            ////SqlDSInfoCompleta.SelectParameters["Ffinal"].DefaultValue = fechaFinal;
            ////SqlDSInfoCompleta.SelectParameters["usuario"].DefaultValue = Membership.GetUser().UserName;
            //GVReporte.DataSourceID = "SqlDSInfoCompleta";
            //GVReporteCorriente.DataSourceID = "SqlDSInfoCompletaCorriente";

            //DeleteTablaGUI_IDS_Equipos_Reportes(Membership.GetUser().UserName);
            //int[] vectIDs = UtilitariosWebGUI.GetSelectedValuesFromListBox(LstBoxFcis.GetSelectedIndices(), LstBoxFcis);
            //InsertarIDsFCIsParaFiltros(vectIDs, Membership.GetUser().UserName);


            //if (DDListCntrs.SelectedValue == "")
            //{
            //    SqlDSInfoCompleta.SelectParameters["idfwt"].DefaultValue = null;
            //    if (LstBoxFcis.GetSelectedIndices().Length > 0) //Hay varios seleccionados
            //    {
            //        SqlDSInfoCompleta.SelectParameters["idfci"].DefaultValue = "-1";
            //        DeleteTablaGUI_IDS_Equipos_Reportes(Membership.GetUser().UserName);
            //        int[] vectIDs = UtilitariosWebGUI.GetSelectedValuesFromListBox(LstBoxFcis.GetSelectedIndices(), LstBoxFcis);
            //        InsertarIDsFCIsParaFiltros(vectIDs, Membership.GetUser().UserName);
            //    }
            //    else
            //    {
            //        SqlDSInfoCompleta.SelectParameters["idfci"].DefaultValue = null;
            //    }
            //}
            //else
            //{
            //    if (LstBoxFcis.GetSelectedIndices().Length == 0) //Todos los FCIs del FWT
            //    {
            //        SqlDSInfoCompleta.SelectParameters["idfwt"].DefaultValue = DDListCntrs.SelectedValue;
            //        SqlDSInfoCompleta.SelectParameters["idfci"].DefaultValue = null;
            //    }
            //    else
            //    {
            //        //Hay algunos seleccionados...
            //        SqlDSInfoCompleta.SelectParameters["idfwt"].DefaultValue = null;
            //        SqlDSInfoCompleta.SelectParameters["idfci"].DefaultValue = "-1";
            //        DeleteTablaGUI_IDS_Equipos_Reportes(Membership.GetUser().UserName);
            //        int[] vectIDs = UtilitariosWebGUI.GetSelectedValuesFromListBox(LstBoxFcis.GetSelectedIndices(), LstBoxFcis);
            //        InsertarIDsFCIsParaFiltros(vectIDs, Membership.GetUser().UserName);
            //    }
            //}

            //string nombreUsr = Membership.GetUser().UserName;
            //UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVReporte, _ID_REPORTE, nombreUsr); //Before: Membership.GetUser().UserName
            //UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVReporteCorriente, _ID_REPORTE, nombreUsr); //Before: Membership.GetUser().UserName

            //GVReporte.DataBind();
            //GVReporte.PageIndex = 0;
            //GVReporteCorriente.DataBind();
            //GVReporteCorriente.PageIndex = 0;


        }

        private void _EjecutarBusquedaCompletaComun()
        {
            bool organizarFcis;

            //_ConfigurarDataSourceReporteComun(SqlDSInfoCompleta, out organizarFcis);
            //_ConfigurarDataSourceReporteComun(SqlDSInfoCompletaCorriente, out organizarFcis);

            UtilitariosWebGUI.ConfigurarDataSourceReporteComun(SqlDSInfoCompleta, DDListCntrs, fechaInicial, fechaFinal, _usuarioLogged, LstBoxFcis, out organizarFcis);
            UtilitariosWebGUI.ConfigurarDataSourceReporteComun(SqlDSInfoCompletaCorriente, DDListCntrs, fechaInicial, fechaFinal, _usuarioLogged, LstBoxFcis, out organizarFcis);
            
            //Para esta opcion del reporte, el parámetro Tension no se utiliza, por tanto se asigna NULL.
            //Cualquier otro parámetro que no se utiliza, se debe tratar igual.
            SqlDSInfoCompletaCorriente.SelectParameters["tension"].DefaultValue = null;

            GVReporte.DataSourceID = "SqlDSInfoCompleta";
            GVReporteCorriente.DataSourceID = "SqlDSInfoCompletaCorriente";

            if (organizarFcis)
            {
                //DeleteTablaGUI_IDS_Equipos_Reportes(Membership.GetUser().UserName);
                UtilitariosWebGUI.DeleteTablaGUI_IDS_Equipos_Reportes(SqlDSQueryFCIs, _usuarioLogged);
                int[] vectIDs = UtilitariosWebGUI.GetSelectedValuesFromListBox(LstBoxFcis.GetSelectedIndices(), LstBoxFcis);
                //InsertarIDsFCIsParaFiltros(vectIDs, Membership.GetUser().UserName);
                UtilitariosWebGUI.InsertarIDsFCIsParaFiltros(SqlDSQueryFCIs, vectIDs, _usuarioLogged);
            }

            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVReporte, _ID_REPORTE, _usuarioLogged); //Before: Membership.GetUser().UserName
            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVReporteCorriente, _ID_REPORTE, _usuarioLogged); //Before: Membership.GetUser().UserName

            GVReporte.DataBind();
            GVReporte.PageIndex = 0;
            GVReporteCorriente.DataBind();
            GVReporteCorriente.PageIndex = 0;
        }

        private void _EjecutarBusquedaFCISinTension()
        {
            _ConfigurarDataSourceReporteFCISinTension(SqlDSInfoCompletaCorriente);
            GVReporteCorriente.DataSourceID = "SqlDSInfoCompletaCorriente";

            string nombreUsr = Membership.GetUser().UserName;
            UtilitariosWebGUI.DefinirColumnasVisualizadasCel(GVReporteCorriente, _ID_REPORTE, nombreUsr); //Before: Membership.GetUser().UserName

            GVReporte.DataSourceID = "";
            GVReporte.DataBind();
            GVReporteCorriente.DataBind();
            GVReporteCorriente.PageIndex = 0;
        }

        private void _ConfigurarDataSourceReporteComun(SqlDataSource sqldsObj, out bool organizarFCISeleccionados)
        {
            organizarFCISeleccionados = false;
            sqldsObj.SelectParameters["Finicial"].DefaultValue = fechaInicial;
            sqldsObj.SelectParameters["Ffinal"].DefaultValue = fechaFinal;
            sqldsObj.SelectParameters["usuario"].DefaultValue = Membership.GetUser().UserName;
            //GVReporte.DataSourceID = "sqldsObj";

            if (DDListCntrs.SelectedValue == "")
            {
                sqldsObj.SelectParameters["idfwt"].DefaultValue = null;
                if (LstBoxFcis.GetSelectedIndices().Length > 0) //Hay varios seleccionados
                {
                    sqldsObj.SelectParameters["idfci"].DefaultValue = "-1";
                    organizarFCISeleccionados = true;
                    //DeleteTablaGUI_IDS_Equipos_Reportes(Membership.GetUser().UserName);
                    //int[] vectIDs = UtilitariosWebGUI.GetSelectedValuesFromListBox(LstBoxFcis.GetSelectedIndices(), LstBoxFcis);
                    //InsertarIDsFCIsParaFiltros(vectIDs, Membership.GetUser().UserName);
                }
                else
                {
                    sqldsObj.SelectParameters["idfci"].DefaultValue = null;
                }
            }
            else
            {
                if (LstBoxFcis.GetSelectedIndices().Length == 0) //Todos los FCIs del FWT
                {
                    sqldsObj.SelectParameters["idfwt"].DefaultValue = DDListCntrs.SelectedValue;
                    sqldsObj.SelectParameters["idfci"].DefaultValue = null;
                }
                else
                {
                    //Hay algunos seleccionados...
                    sqldsObj.SelectParameters["idfwt"].DefaultValue = null;
                    sqldsObj.SelectParameters["idfci"].DefaultValue = "-1";
                    organizarFCISeleccionados = true;
                    //DeleteTablaGUI_IDS_Equipos_Reportes(Membership.GetUser().UserName);
                    //int[] vectIDs = UtilitariosWebGUI.GetSelectedValuesFromListBox(LstBoxFcis.GetSelectedIndices(), LstBoxFcis);
                    //InsertarIDsFCIsParaFiltros(vectIDs, Membership.GetUser().UserName);
                }
            }
        }

        private void _ConfigurarDataSourceReporteFCISinTension(SqlDataSource sqldsObj)
        {
            sqldsObj.SelectParameters["Finicial"].DefaultValue = fechaInicial;
            sqldsObj.SelectParameters["Ffinal"].DefaultValue = fechaFinal;
            sqldsObj.SelectParameters["usuario"].DefaultValue = Membership.GetUser().UserName;
            sqldsObj.SelectParameters["idfwt"].DefaultValue = null;
            sqldsObj.SelectParameters["idequipo"].DefaultValue = null;
            sqldsObj.SelectParameters["tension"].DefaultValue = false.ToString();
        }

        #region Metodos Soporte Filtros

        protected void DeleteTablaGUI_IDS_Equipos_Reportes(string usrName)
        {
            SqlDSQueryFCIs.DeleteParameters["usuario"].DefaultValue = usrName;
            SqlDSQueryFCIs.Delete();
        }

        protected void InsertarIDsFCIsParaFiltros(int[] idsFCI, string usrName)
        {
            foreach (int idFci in idsFCI)
            {
                SqlDSQueryFCIs.InsertParameters["col_id"].DefaultValue = idFci.ToString();
                SqlDSQueryFCIs.InsertParameters["usuario"].DefaultValue = usrName;
                SqlDSQueryFCIs.Insert();
            }
        }

        #endregion

        //protected void GVReporte_DataBound(object sender, EventArgs e)
        //{
        //    if (GVReporte.Rows.Count == 0)
        //    {
        //        LblMsgNoData.Visible = true;
        //    }
        //    else
        //    {
        //        LblMsgNoData.Visible = false;
        //    }

        //    //GVReporteCorriente.Columns[2].ItemStyle.Width = new Unit("100px");
        //    //GVReporteCorriente.Columns[3].ItemStyle.Width = new Unit("100px");
        //    //GVReporteCorriente.Columns[4].ItemStyle.Width = new Unit("100px");
        //    //GVReporteCorriente.Columns[5].ItemStyle.Width = new Unit("100px");
        //}

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (GVReporte.Rows.Count == 0 && GVReporteCorriente.Rows.Count == 0)
            {
                LblMsgNoData.Visible = true;
            }
            else
            {
                LblMsgNoData.Visible = false;
            }
        }

        protected void GVReporteCorriente_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string valorTensionTxt = "";

                //Recuperar el control label que tendra el texto que representa el valor de la columna Tension
                Label lblVal = (Label)e.Row.FindControl("lblTension");
                //

                valorTensionTxt = UtilitariosWebGUI.MostrarValorTensionFriendly(DataBinder.Eval(e.Row.DataItem, "Tension"));

                //if (DataBinder.Eval(e.Row.DataItem, "Tension") != DBNull.Value)
                //{
                //    bool? valorTensionBD = (bool?)DataBinder.Eval(e.Row.DataItem, "Tension");
                //    if (valorTensionBD.Value)
                //    {
                //        valorTensionTxt = "Presencia";
                //    }
                //    else
                //    {
                //        valorTensionTxt = "Ausencia";
                //    }
                //}
                //else
                //{
                //    valorTensionTxt = "N/A";
                //}
                lblVal.Text = valorTensionTxt;
                //if (DataBinder.Eval(e.Row.DataItem, "Tension") != DBNull.Value)
                //{
                //    valorTxt = (string)DataBinder.Eval(e.Row.DataItem, "Valor");
                //}
            }
        }


        protected void GVReporteCorriente_DataBound(object sender, EventArgs e)
        {
            if (GVReporteCorriente.DataSourceObject != null)
            {
                SqlConnectionStringBuilder strConBuilder = new SqlConnectionStringBuilder(((SqlDataSource)GVReporteCorriente.DataSourceObject).ConnectionString);
                string nmDataBase = strConBuilder.InitialCatalog;
                if (!nmDataBase.ToUpper().StartsWith("SGRCelsa"))
                {
                    GVReporteCorriente.Columns[GVReporteCorriente.Columns.Count - 1].Visible = false;
                }
                else
                {
                    GVReporteCorriente.Columns[GVReporteCorriente.Columns.Count - 1].Visible = true;
                }
            }

            

        }


        #region Metodos Filtros Equipos

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

        #endregion

        

        


    }
}