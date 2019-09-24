using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Security.Principal;
using SGR.DataAccessLayer;
using SGR.BussinessLayer;

namespace SistemaGestionRedes
{
    /// <summary>
    /// Clase que realiza funciones utilitarias a la interfaz de usuario Web
    /// </summary>
    public static class UtilitariosWebGUI
    {
        /// <summary>
        /// Ordena un  System.Web.UI.WebControls.ListBox
        /// </summary>
        /// <param name="lista">ListBox a ordenar</param>
        public static void SortListBox(ref ListBox lista)
        {
            ListControl listCont = (ListControl)lista;
            SortListControl(ref listCont);
        }

        /// <summary>
        /// Ordena un  System.Web.UI.WebControls.DropDownList
        /// </summary>
        /// <param name="lista">ListBox a ordenar</param>
        public static void SortDropDownList(ref DropDownList ddLista)
        {
            ListControl listCont = (ListControl)ddLista;
            SortListControl(ref listCont);
        }

        /// <summary>
        /// Ordena un  System.Web.UI.WebControls.ListControl . ListControl es la clase Base de las listas Web (DropdownList , ListBox , etc ) 
        /// </summary>
        /// <param name="lista"></param>
        private static void SortListControl(ref ListControl  lista)
        {
            List<ListItem> t = new List<ListItem>();
            Comparison<ListItem> compare = new Comparison<ListItem>(CompareListItemsValorEnteroAscendente);
            foreach (ListItem lbItem in lista.Items)
            { t.Add(lbItem); }

            t.Sort(compare);
            lista.Items.Clear();
            lista.Items.AddRange(t.ToArray());

        }

        /// <summary>
        /// Compara dos ListItems por su valor en entero ascendentemente
        /// </summary>
        /// <param name="li1"></param>
        /// <param name="li2"></param>
        /// <returns></returns>
        private static  int CompareListItemsValorEnteroAscendente(ListItem li1, ListItem li2)
        {
            if (int.Parse(li1.Value) < int.Parse(li2.Value))
            {
                return -1;
            }
            else if (int.Parse(li1.Value) == int.Parse(li2.Value))
            {
                return 0;
            }
            else
            {   //El item1 es mayor que item2
                return 1;
            }

        }


        public static string GetNombreCausaAperturaSixLenguaje(string codLang, byte cosCausa)
        {
            string causa = "";

            switch (cosCausa)
            {
                case 0:
                    //causa = "Sin Confirmar";
                    causa = (string)HttpContext.GetLocalResourceObject("~/UtilitariosWebGUI.aspx", "TextCausaSixNoConfirmado");
                    break;
                case 1:
                    //causa = "Corriente";
                    causa = (string)HttpContext.GetLocalResourceObject("~/UtilitariosWebGUI.aspx", "TextCausaSixCorriente");
                    break;
                case 2:
                    //causa = "RF";
                    causa = (string)HttpContext.GetLocalResourceObject("~/UtilitariosWebGUI.aspx", "TextCausaSixRF");
                    break;
                case 3:
                    //causa = "Comando";
                    causa = (string)HttpContext.GetLocalResourceObject("~/UtilitariosWebGUI.aspx", "TextCausaSixComando");
                    break;
            }

            //switch (codLang)
            //{
            //    case "es":
            //        switch (cosCausa)
            //        {
            //            case 0:
            //                causa = "Sin Confirmar";
            //                break;
            //            case 1:
            //                causa = "Corriente";
            //                break;
            //            case 2:
            //                causa = "RF";
            //                break;
            //            case 3:
            //                causa = "Comando";
            //                break;
            //        }
            //        break;

            //    case "pt":
            //        switch (cosCausa)
            //        {
            //            case 0:
            //                causa = "Nada";
            //                break;
            //            case 1:
            //                causa = "Corrente";
            //                break;
            //            case 2:
            //                causa = "RF";
            //                break;
            //            case 3:
            //                causa = "Comando";
            //                break;
            //        }
            //        break;

            //    case "en":
            //        switch (cosCausa)
            //        {
            //            case 0:
            //                causa = "Not Confirmed";
            //                break;
            //            case 1:
            //                causa = "Current";
            //                break;
            //            case 2:
            //                causa = "RF";
            //                break;
            //            case 3:
            //                causa = "Command";
            //                break;
            //        }
            //        break;
            //}

            return causa;
        }


        public static string MostrarValorTensionFriendly(object valTensionBDObj)
        {

            if (valTensionBDObj != DBNull.Value)
            {
                bool tension = (bool)valTensionBDObj;
                if (tension)
                {
                    //return "Presencia";
                    return (string)HttpContext.GetLocalResourceObject("~/UtilitariosWebGUI.aspx", "TextPresenciaTension");
                }
                else
                {
                    //return "Ausencia";
                    return (string)HttpContext.GetLocalResourceObject("~/UtilitariosWebGUI.aspx", "TextAusenciaTension");
                }
            }
            else
            {
                return "N/A";
            }
        }

        public static string MostrarValorCorrienteSIXAjustado(object valCteObj)
        {
            string valAjustado = "";

            if (valCteObj != DBNull.Value)
            {
                
                    short sCte = (short)valCteObj;
                    decimal dCte = ((decimal)sCte / 10.0M);
                    valAjustado = String.Format("{0:0.0}", dCte);

            }
            else
            {
                valAjustado = "N/A";
            }

            return valAjustado;
        }


        public static void DefinirColumnasVisualizadas(GridView gvObj, int idReporte, string nombreUsuario)
        {
            List<string> listaHeadersConfigurados = AccesoDatosEFGUI.GetHeaderTextColumnasConfiguradasDelReporte(nombreUsuario, idReporte);

            List<string> listaAllHeadersText = AccesoDatosEFGUI.GetAllHeaderTextColumnasReporte(idReporte);

            foreach (DataControlField gvCol in gvObj.Columns)
            {
                if (listaAllHeadersText.Contains(gvCol.HeaderText))
                {
                    if (listaHeadersConfigurados.Contains(gvCol.HeaderText))
                    {
                        gvCol.Visible = true;
                    }
                    else
                    {
                        gvCol.Visible = false;
                    }
                }
            }
        }


        public static void DefinirColumnasVisualizadasCel(GridView gvObj, int idReporte, string nombreUsuario)
        {
            List<string> listaNombresConfigurados = AccesoDatosEFGUI.GetNombresColumnasConfiguradasDelReporte(nombreUsuario, idReporte);

            List<string> listaAllNombresText = AccesoDatosEFGUI.GetAllNombresColumnasReporte(idReporte);

            foreach (DataControlField gvCol in gvObj.Columns)
            {
                if (listaAllNombresText.Contains(GetNameAttribute(gvCol)))
                {
                    if (listaNombresConfigurados.Contains(GetNameAttribute(gvCol)))
                    {
                        gvCol.Visible = true;
                    }
                    else
                    {
                        gvCol.Visible = false;
                    }
                }
            }
        }


        private static string GetNameAttribute(DataControlField gvCol)
        {
            string valName = "";
            if (gvCol is BoundFieldCel)
            {
                valName = ((BoundFieldCel)gvCol).Name;
            }
            else if (gvCol is TemplateFieldCel)
            {
                valName = ((TemplateFieldCel)gvCol).Name;
            }

            return valName;
        }


        public static string GetSelectedItemsComaSeparated(int[] indexItems, ListBox lboxControl)
        {
            string strFinal = "";

            for (int i = 0; i < indexItems.Length; i++)
            {
                strFinal = strFinal + lboxControl.Items[indexItems[i]].Value;
                if (i < (indexItems.Length - 1))
                {
                    strFinal = strFinal + ",";
                }
            }
            
            return strFinal;
        }


        public static string GetItemsComaSeparatedFromDropDownList(DropDownList ddlControl)
        {
            string strFinal = "";

            for (int i = 0; i < ddlControl.Items.Count; i++)
            {
                strFinal = strFinal + ddlControl.Items[i].Value;
                if (i < (ddlControl.Items.Count - 1))
                {
                    strFinal = strFinal + ",";
                }
            }

            return strFinal;
        }


        public static int[] GetSelectedValuesFromListBox(int[] indexItems, ListBox lboxControl)
        {
            int[] values = new int[indexItems.Length];

            for (int i = 0; i < indexItems.Length; i++)
            {
                values[i] = int.Parse(lboxControl.Items[indexItems[i]].Value);
            }

            return values;
        }


        public static Control GetPostBackControl(Page page)
        {
            Control postbackControlInstance = null;

            string postbackControlName = page.Request.Params.Get("__EVENTTARGET");
            if (postbackControlName != null && postbackControlName != string.Empty)
            {
                postbackControlInstance = page.FindControl(postbackControlName);
            }
            else
            {
                // handle the Button control postbacks
                for (int i = 0; i < page.Request.Form.Keys.Count; i++)
                {
                    postbackControlInstance = page.FindControl(page.Request.Form.Keys[i]);
                    if (postbackControlInstance is System.Web.UI.WebControls.Button)
                    {
                        return postbackControlInstance;
                    }
                }
            }
            // handle the ImageButton postbacks
            if (postbackControlInstance == null)
            {
                for (int i = 0; i < page.Request.Form.Count; i++)
                {
                    if ((page.Request.Form.Keys[i].EndsWith(".x")) || (page.Request.Form.Keys[i].EndsWith(".y")))
                    {
                        postbackControlInstance = page.FindControl(page.Request.Form.Keys[i].Substring(0, page.Request.Form.Keys[i].Length - 2));
                        return postbackControlInstance;
                    }
                }
            }
            return postbackControlInstance;
        }


        public static byte GetTipoEquipo(string serialEquipo)
        {
            byte valTipo = (byte)TipoEquipoRed.UNKNOW;

            try
            {
                if (serialEquipo.Substring(0, 2).ToUpper().Equals("FI"))
                {
                    valTipo = (byte)TipoEquipoRed.FCI;
                }
                else if (serialEquipo.Substring(0, 1).ToUpper().Equals("C"))
                {
                    valTipo = (byte)TipoEquipoRed.SIXDG;
                }
            }
            catch (Exception exGen)
            {
                valTipo = (byte)TipoEquipoRed.UNKNOW;
            }

            return valTipo;
        }


        #region Metodos de Autorización

        public static bool HasAuthorization(OperacionGenerica operacion, IPrincipal user)
        {
            bool result = false;

            switch (operacion)
            {
                case OperacionGenerica.Update:
                    result = (user.IsInRole("administrador") || user.IsInRole("configurador"));
                    break;

                case OperacionGenerica.Insert:
                    result = (user.IsInRole("administrador") || user.IsInRole("configurador"));
                    break;

                case OperacionGenerica.Delete:
                    result = (user.IsInRole("administrador") || user.IsInRole("configurador"));
                    break;

                case OperacionGenerica.Select:
                    result = true;
                    break;
            }


            return result;
        }

        #endregion



        #region Metodos Auxiliares Para Manejo de Filtros en Reportes

        /// <summary>
        /// Elimina los registros de la tabla GUI_IDS_Equipos_Reportes para un usuario logueado dado.
        /// Se utiliza normalmente para antes de cada ejecución de una consulta con filtros donde se han
        /// seleccionado unos FCIs/SIXs específicos.
        /// </summary>
        /// <param name="sqlDSobj">Es el SQL DataSource control que da soporte al acceso de la tabla GUI_IDS_Equipos_Reportes.</param>
        /// <param name="usrName">Usuario loggeado en la aplicación Web.</param>
        public static void DeleteTablaGUI_IDS_Equipos_Reportes(SqlDataSource sqlDSobj, string usrName)
        {
            sqlDSobj.DeleteParameters["usuario"].DefaultValue = usrName;
            sqlDSobj.Delete();
        }

        /// <summary>
        /// Inserta los registros de la tabla GUI_IDS_Equipos_Reportes para un usuario logueado dado.
        /// Se utiliza normalmente para antes de cada ejecución de una consulta con filtros donde se han
        /// seleccionado unos FCIs/SIXs específicos.
        /// </summary>
        /// <param name="sqlDSobj">Es el SQL DataSource control que da soporte al acceso de la tabla GUI_IDS_Equipos_Reportes.</param>
        /// <param name="idsFCI">Array de los IDs de los FCIs/SIXs particulares seleccionados como filtros en un reporte.</param>
        /// <param name="usrName">Usuario loggeado en la aplicación Web.</param>
        public static void InsertarIDsFCIsParaFiltros(SqlDataSource sqlDSobj, int[] idsFCI, string usrName)
        {
            foreach (int idFci in idsFCI)
            {
                sqlDSobj.InsertParameters["col_id"].DefaultValue = idFci.ToString();
                sqlDSobj.InsertParameters["usuario"].DefaultValue = usrName;
                sqlDSobj.Insert();
            }
        }

        /// <summary>
        /// Función genérica usada en algunos reportes cuyo objetivo es:
        /// Configurar un único SQL DataSource control que ejecutará la consulta final del reporte basado en los filtros 
        /// genéricos: Uno-Todos los concentradores, fecha inicial, fecha final, lista de FCIs/SIXs seleccionados y el usuario
        /// loggeado. El usuario sólo dará soporte a la consulta sobre la tabla GUI_IDS_Equipos_Reportes si se necesita.
        /// </summary>
        /// <param name="sqldsObj">SQL DataSource control genérico del reporte ejecutado.</param>
        /// <param name="ddListCntrsObj">DropDownList con los concentradores. Puede tener uno seleccionado o un indicador de todos.</param>
        /// <param name="fechaInicial">Fecha inicial del periodo a buscar.</param>
        /// <param name="fechaFinal">Fecha final del periodo a buscar.</param>
        /// <param name="strUsuario">Usuario loggeado en la aplicación Web.</param>
        /// <param name="listBoxEquiposObj">ListBox con la lista de FCIs/SIXs seleccionados. Uno, varios o ninguno.</param>
        /// <param name="organizarFCISeleccionados">Se asigna en True si hay al menos un FCI/SIX seleccionado. Esto indicará que se debe usar la tabla GUI_IDS_Equipos_Reportes para soportar la consulta fianl de la búsqueda.</param>
        public static void ConfigurarDataSourceReporteComun(SqlDataSource sqldsObj, DropDownList ddListCntrsObj, string fechaInicial, string fechaFinal, string strUsuario , ListBox listBoxEquiposObj, out bool organizarFCISeleccionados)
        {
            organizarFCISeleccionados = false;
            sqldsObj.SelectParameters["Finicial"].DefaultValue = fechaInicial;
            sqldsObj.SelectParameters["Ffinal"].DefaultValue = fechaFinal;
            sqldsObj.SelectParameters["usuario"].DefaultValue = strUsuario;

            if (ddListCntrsObj.SelectedValue == "")
            {
                sqldsObj.SelectParameters["idfwt"].DefaultValue = null;
                if (listBoxEquiposObj.GetSelectedIndices().Length > 0) //Hay varios seleccionados
                {
                    sqldsObj.SelectParameters["idequipo"].DefaultValue = "-1";
                    organizarFCISeleccionados = true;
                }
                else
                {
                    sqldsObj.SelectParameters["idequipo"].DefaultValue = null;
                }
            }
            else
            {
                if (listBoxEquiposObj.GetSelectedIndices().Length == 0) //Todos los FCIs del FWT
                {
                    sqldsObj.SelectParameters["idfwt"].DefaultValue = ddListCntrsObj.SelectedValue;
                    sqldsObj.SelectParameters["idequipo"].DefaultValue = null;
                }
                else
                {
                    //Hay algunos seleccionados...
                    sqldsObj.SelectParameters["idfwt"].DefaultValue = null;
                    sqldsObj.SelectParameters["idequipo"].DefaultValue = "-1";
                    organizarFCISeleccionados = true;
                }
            }
        }


        #endregion


    }
}
