using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Profile;
using SGR.DataAccessLayer;
using SGR.BussinessLayer;

namespace SistemaGestionRedes
{
    public partial class seccionC : System.Web.UI.Page
    {
        private bool _verSix;
        private AccesoDatos coneApp;
        //private ProfileCelsa profileObj = new ProfileCelsa();

        protected void Page_Load(object sender, EventArgs e)
        {
            _verSix = ConfigApp.VerSix;
            if (!Page.IsPostBack)
            {
                //_verSix = ConfigApp.VerSix;
                if (treeSistema.Nodes.Count == 0)
                {
                    PopulateTree();
                    treeSistema.CollapseAll();
                }
                chkVisualizarCodigosCorporativos.Checked = (bool)Context.Profile.GetPropertyValue("VerCodificacionEquipos");
                //chkVisualizarCodigosCorporativos.Checked = profileObj.CodificarEquipos;
            }
        }
        
        /// <summary>
        /// Llena Todo el arbol a partir de la información en base de datos .
        /// </summary>
        public void PopulateTree()
        {
            //Definir el verdadero nodo raíz.
            TreeNode nodoRaiz = new TreeNode((string)this.GetLocalResourceObject("TextTittleTree"));
            nodoRaiz.NavigateUrl = "~/PagesEquipment/SearchEquipment.aspx";
            nodoRaiz.Target = "content"; 
            //Creacion y Enlace con la base de datos
            coneApp = new AccesoDatos();

            //Anexar todo el arbol hijo de EQUIPOS....
            nodoRaiz.ChildNodes.Add(MakeTreeEquipos(coneApp));
            nodoRaiz.ChildNodes.Add(MakeTreeEstados());


            treeSistema.Nodes.Add(nodoRaiz);


        }


        private TreeNode MakeTreeEstados()
        {
            TreeNode nodoEstados = new TreeNode((string)this.GetLocalResourceObject("TextTittleEstados"));
            //nodoEstados.NavigateUrl = "~/PagesEquipment/StateDescription.aspx";  //Mejor que no apunte a pagina solo informativa 
            //nodoEstados.Target = "content";

            TreeNode nodoEquiposOK = new TreeNode((string)this.GetLocalResourceObject("TextTittleEquiposOK"));
            TreeNode nodoEquiposFallas = new TreeNode((string)this.GetLocalResourceObject("TextTittleFallasEquipos"));
            TreeNode nodoCircuitosFalla = new TreeNode((string)this.GetLocalResourceObject("TextTittleFallasCircuitos"));
            nodoCircuitosFalla.NavigateUrl = "~/PagesEquipment/CircuitFault.aspx";
            nodoCircuitosFalla.Target = "content";

            PasteEquiposOK(ref nodoEquiposOK);
            PasteEquiposFalla(ref nodoEquiposFallas);

             
 

            nodoEstados.ChildNodes.Add(nodoEquiposOK);
            nodoEstados.ChildNodes.Add(nodoEquiposFallas);
            nodoEstados.ChildNodes.Add(nodoCircuitosFalla);

            return nodoEstados;

        }

        private void PasteEquiposOK(ref TreeNode nodoPpal)
        {
            TreeNode nodoFwt = new TreeNode(ConstsTreeView.NOMBRE_EQU_FWT);
            TreeNode nodoFci = new TreeNode(ConstsTreeView.NOMBRE_EQU_FCI);

            nodoFwt.NavigateUrl = "~/PagesEquipment/FWTOK.aspx";
            nodoFwt.Target = "content";
            nodoFci.NavigateUrl = "~/PagesEquipment/FCIOK.aspx";
            nodoFci.Target = "content";
            nodoPpal.ChildNodes.Add(nodoFwt);
            nodoPpal.ChildNodes.Add(nodoFci);
        }

        private void PasteEquiposFalla(ref TreeNode nodoPpal)
        {
            TreeNode nodoFwt = new TreeNode(ConstsTreeView.NOMBRE_EQU_FWT);
            TreeNode nodoFci = new TreeNode(ConstsTreeView.NOMBRE_EQU_FCI);

            nodoFwt.NavigateUrl = "~/PagesEquipment/FWTFault.aspx";
            nodoFwt.Target = "content";
            nodoFci.NavigateUrl = "~/PagesEquipment/FCIFault.aspx";
            nodoFci.Target = "content";
            nodoPpal.ChildNodes.Add(nodoFwt);
            nodoPpal.ChildNodes.Add(nodoFci);
        }


        //*****************************************************************************************************************************************
        // ***********  PUNTO DE ENTRADA AL SUB-ARBOL DE EQUIPOS  *****************
        private TreeNode MakeTreeEquipos(AccesoDatos baseDatos)
        {
            TreeNode nodoEquipos = new TreeNode((string)this.GetLocalResourceObject("TextTittleEquipos"));
            nodoEquipos.NavigateUrl = "~/PagesEquipment/SearchEquipment.aspx";
            nodoEquipos.Target = "content";
            TreeNode nodoNuevoFWT = new TreeNode((string)this.GetLocalResourceObject("TextNuevoConcentrador"));
            nodoNuevoFWT.NavigateUrl = "~/PagesEquipment/NewFWT.aspx";
            nodoNuevoFWT.Target = "content";
            TreeNode nodoNuevoFCI = new TreeNode((string)this.GetLocalResourceObject("TextNuevoIndicador"));
            nodoNuevoFCI.NavigateUrl = "~/PagesEquipment/NewFCI.aspx";
            nodoNuevoFCI.Target = "content";
            nodoEquipos.ChildNodes.Add(nodoNuevoFWT);
            nodoEquipos.ChildNodes.Add(nodoNuevoFCI);
            nodoEquipos.ChildNodes.Add(MakeEquiposFWT(baseDatos));
            nodoEquipos.ChildNodes.Add(MakeEquiposFCI(baseDatos));
            nodoEquipos.ChildNodes.Add(MakeEquiposARIX(baseDatos));
            if (_verSix)
            {
                nodoEquipos.ChildNodes.Add(MakeEquiposSIX(baseDatos));
            }
            return nodoEquipos;
        }

        // ***********    CONSTRUCCIÓN DEL SUB-ARBOL FWT  *****************
        private TreeNode MakeEquiposFWT(AccesoDatos baseDatos)
        {
            TreeNode nodoPpalFWT = new TreeNode((string)this.GetLocalResourceObject("TextTittleAllConcentradores"));
            nodoPpalFWT.NavigateUrl = "~/PagesEquipment/FWTsAll.aspx";
            nodoPpalFWT.Target = "content";
            PasteFWTsToNodoPpal(ref nodoPpalFWT, baseDatos);
            return nodoPpalFWT;
        }

        private void PasteFWTsToNodoPpal(ref TreeNode nodoPpal, AccesoDatos baseDatos)
        {
            bool verCodificacion = (bool)Context.Profile.GetPropertyValue("VerCodificacionEquipos");
            //bool verCodificacion = profileObj.CodificarEquipos;
            int[] vectFWTs = baseDatos.GetAllIdsFWTs();
            bool errorBaseDatos;
            //string[] vectSerFWTs = baseDatos.GetAllSerialesFWTs(out errorBaseDatos ); //Estos dos vectores tienen el mismo número de elementos (Ids y seriales)
            GenericaTwoStrings[] vectSerFWTs = baseDatos.GetSerialesCodigosAllFWTs(out errorBaseDatos);
            butConnectDataBase.Enabled = false;
            butRefresh.Enabled = true;
            if (vectFWTs != null)
            {
                lblErrorConnectionBaseDatos.Visible = false ;
                for (int i = 0; i < vectFWTs.Length; i++)
                {
                    string txtId = vectFWTs[i].ToString();
                    TreeNode nodoFwt = new TreeNode(ConstsTreeView.NOMBRE_EQU_FWT + " " + SerialOrCodigo(vectSerFWTs[i], verCodificacion), ConstsTreeView.EQU_FWT + " " + SerialOrCodigo(vectSerFWTs[i], verCodificacion));
                    nodoFwt.NavigateUrl = "~/PagesEquipment/EditFWT.aspx?Id=" + txtId; //El url se hace por Id
                    nodoFwt.Target = "content";
                    nodoFwt.ToolTip = ToolTipEquipo(vectSerFWTs[i], verCodificacion);
                    PasteFCI2FWT(ref nodoFwt, vectFWTs[i], baseDatos, verCodificacion);
                    nodoPpal.ChildNodes.Add(nodoFwt);
                }
            }
            else
            {
                lblErrorConnectionBaseDatos.Visible = true;
                if (errorBaseDatos)
                {
                    lblErrorConnectionBaseDatos.Text = (string)this.GetLocalResourceObject("TextErrorBaseDatos");
                    butConnectDataBase.Enabled = true;
                    butRefresh.Enabled = false;
                }
                else
                {
                    lblErrorConnectionBaseDatos.Text = (string)this.GetLocalResourceObject("TextNoHayFWTs");
                }
                
                
            }
        }

        private void PasteFCI2FWT(ref TreeNode nodoFWTEquipo, int idFWTEquipo, AccesoDatos baseDatos, bool verCodigos)
        {
            int[] vectFCIs = baseDatos.GetIdsFCIs(idFWTEquipo);
            //string[] vectSerialFCIs = baseDatos.GetSerialesFCIs(idFWTEquipo);
            GenericaTwoStrings[] vectSerialFCIs = baseDatos.GetSerialesCodigosFCIs(idFWTEquipo);
            byte[] vectIdentifFCIs = baseDatos.GetIdentificadoresFCIs(idFWTEquipo);
            if (vectFCIs != null)
            {
                string nmEquipo;
                for (int i = 0; i < vectFCIs.Length; i++)
                {
                    string txtId = vectFCIs[i].ToString();
                    nmEquipo = GetNmEquipo(vectSerialFCIs[i].DatoString1);
                    TreeNode nodoFci = new TreeNode(nmEquipo + " " + SerialOrCodigo(vectSerialFCIs[i], verCodigos) + "- Id " + vectIdentifFCIs[i], nmEquipo + " " + SerialOrCodigo(vectSerialFCIs[i], verCodigos) + "- Id " + vectIdentifFCIs[i]);
                    nodoFci.NavigateUrl = GetURLEquipo(vectSerialFCIs[i].DatoString1, txtId);
                    nodoFci.Target = "content" ;
                    nodoFci.ToolTip = ToolTipEquipo(vectSerialFCIs[i], verCodigos);
                    if (nmEquipo == ConstsTreeView.NOMBRE_EQU_SIX)
                    {
                        if (_verSix)
                        {
                            nodoFWTEquipo.ChildNodes.Add(nodoFci);
                        }
                    }
                    else
                    {
                        nodoFWTEquipo.ChildNodes.Add(nodoFci);
                    }
                }
            }
        }




        private string GetNmEquipo(string serialEquipo)
        {
            string valNm = "";
            if (serialEquipo.Substring(0, 2).ToUpper().Equals("FI"))
            {
                valNm = ConstsTreeView.NOMBRE_EQU_FCI;
            }
            else if (serialEquipo.Substring(0, 1).ToUpper().Equals("C"))
            {
                valNm = ConstsTreeView.NOMBRE_EQU_SIX;
            }

            return valNm;
        }

        private string GetURLEquipo(string serialEquipo, string idTxt)
        {
            string valUrl = "";
            if (serialEquipo.Substring(0, 2).ToUpper().Equals("FI"))
            {
                valUrl = "~/PagesEquipment/EditFCI.aspx?Id=" + idTxt;
            }
            else if (serialEquipo.Substring(0, 1).ToUpper().Equals("C"))
            {
                valUrl = "~/PagesEquipment/EditSIX.aspx?Id=" + idTxt;
            }
            else if (serialEquipo.Substring(0, 2).ToUpper().Equals("RI"))
            {
                valUrl = "~/PagesEquipment/EditARIX.aspx?Id=" + idTxt;
            }
            return valUrl;
        }

        private string SerialOrCodigo(GenericaTwoStrings datos, bool verCodificacion)
        {
            string strFinal = "";

            if (verCodificacion)
            {
                if (datos.DatoString2.Trim() == "")
                {
                    strFinal = (string)this.GetLocalResourceObject("TextWordVacio");
                }
                else
                {
                    strFinal = datos.DatoString2.Trim();
                }
            }
            else
            {
                strFinal = datos.DatoString1;
            }

            return strFinal;

        }

        private string ToolTipEquipo(GenericaTwoStrings datos, bool verCodificacion)
        {
            string strFinal = "";

            if (!verCodificacion)
            {
                if (datos.DatoString2.Trim() == "")
                {
                    strFinal = (string)this.GetLocalResourceObject("TextNoCodigo");
                }
                else
                {
                    strFinal = datos.DatoString2.Trim();
                }
            }
            else
            {
                strFinal = datos.DatoString1;
            }

            return strFinal;
        }


        // ***********  CONSTRUCCIÓN DEL SUB-ARBOL TODOS LOS FCI ***************
        private TreeNode MakeEquiposFCI(AccesoDatos baseDatos)
        {
            TreeNode nodoPpalFCI = new TreeNode((string)this.GetLocalResourceObject("TextTittleAllFCIs"));
            nodoPpalFCI.NavigateUrl = "~/PagesEquipment/FCIsAll.aspx";
            nodoPpalFCI.Target = "content";
            PasteAllFCIsToNodoPpal(ref nodoPpalFCI, baseDatos);
            return nodoPpalFCI;
        }

        private void PasteAllFCIsToNodoPpal(ref TreeNode nodoPpal, AccesoDatos baseDatos)
        {
            bool verCodificacion = (bool)Context.Profile.GetPropertyValue("VerCodificacionEquipos");
            //bool verCodificacion = profileObj.CodificarEquipos;
            int[] vectFCIs = baseDatos.GetAllIdsFCIs();
            //string[] vectSerialFCIs = baseDatos.GetAllSerialesFCIs();
            GenericaTwoStrings[] vectSerialFCIs = baseDatos.GetAllSerialesCodigosFCIs();
            byte[] vectIdentifFCIs = baseDatos.GetAllIdentificadoresFCIs() ;
            if (vectFCIs != null)
            {
                for (int i = 0; i < vectFCIs.Length; i++)
                {
                    string txtId = vectFCIs[i].ToString();
                    TreeNode nodoFci = new TreeNode(ConstsTreeView.NOMBRE_EQU_FCI + " " + SerialOrCodigo(vectSerialFCIs[i], verCodificacion) + "- Id " + vectIdentifFCIs[i], ConstsTreeView.NOMBRE_EQU_FCI + " " + SerialOrCodigo(vectSerialFCIs[i], verCodificacion) + "- Id " + vectIdentifFCIs[i]);
                    nodoPpal.ChildNodes.Add(nodoFci);
                    nodoFci.NavigateUrl = "~/PagesEquipment/EditFCI.aspx?Id=" + txtId;
                    nodoFci.Target = "content";
                    nodoFci.ToolTip = ToolTipEquipo(vectSerialFCIs[i], verCodificacion);
                }
            }
        }


        // ************** CONSTRUCCION DEL SUB-ARBOL TODOS LOS SIX-DG ********************
        private TreeNode MakeEquiposSIX(AccesoDatos baseDatos)
        {
            TreeNode nodoPpalSIX = new TreeNode((string)this.GetLocalResourceObject("TextTittleAllSIXs"));
            nodoPpalSIX.NavigateUrl = "~/PagesEquipment/SIXsAll.aspx";
            //nodoPpalSIX.NavigateUrl = "";
            nodoPpalSIX.Target = "content";
            PasteAllSIXsToNodoPpal(ref nodoPpalSIX, baseDatos);
            return nodoPpalSIX;
        }

        private void PasteAllSIXsToNodoPpal(ref TreeNode nodoPpal, AccesoDatos baseDatos)
        {
            bool verCodificacion = (bool)Context.Profile.GetPropertyValue("VerCodificacionEquipos");
            //bool verCodificacion = profileObj.CodificarEquipos;
            int[] vectSIXs = baseDatos.GetAllIdsSIXs();
            //string[] vectSerialSIXs = baseDatos.GetAllSerialesSIXs();
            GenericaTwoStrings[] vectSerialSIXs = baseDatos.GetAllSerialesCodigosSIXs();
            byte[] vectIdentifSIXs = baseDatos.GetAllIdentificadoresSIXs();
            if (vectSIXs != null)
            {
                for (int i = 0; i < vectSIXs.Length; i++)
                {
                    string txtId = vectSIXs[i].ToString();
                    TreeNode nodoFci = new TreeNode(ConstsTreeView.NOMBRE_EQU_SIX + " " + SerialOrCodigo(vectSerialSIXs[i], verCodificacion) + "- Id " + vectIdentifSIXs[i], ConstsTreeView.NOMBRE_EQU_SIX + " " + SerialOrCodigo(vectSerialSIXs[i], verCodificacion) + "- Id " + vectIdentifSIXs[i]);
                    nodoPpal.ChildNodes.Add(nodoFci);
                    nodoFci.NavigateUrl = "~/PagesEquipment/EditSIX.aspx?Id=" + txtId; 
                    //nodoFci.NavigateUrl = "";
                    nodoFci.Target = "content";
                    nodoFci.ToolTip = ToolTipEquipo(vectSerialSIXs[i], verCodificacion);
                }
            }
        }

        // ***********  CONSTRUCCIÓN DEL SUB-ARBOL TODOS LOS ARIX ***************
        private TreeNode MakeEquiposARIX(AccesoDatos baseDatos)
        {
            TreeNode nodoPpalARIX = new TreeNode((string)this.GetLocalResourceObject("TextTittleAllARIXs"));
            nodoPpalARIX.NavigateUrl = "~/PagesEquipment/ARIXsAll.aspx";
            nodoPpalARIX.Target = "content";
            PasteAllARIXsToNodoPpal(ref nodoPpalARIX, baseDatos);
            return nodoPpalARIX;
        }

        private void PasteAllARIXsToNodoPpal(ref TreeNode nodoPpal, AccesoDatos baseDatos)
        {
            bool verCodificacion = (bool)Context.Profile.GetPropertyValue("VerCodificacionEquipos");
            //bool verCodificacion = profileObj.CodificarEquipos;
            int[] vectARIXs = baseDatos.GetAllIdsARIXs();
            //string[] vectSerialFCIs = baseDatos.GetAllSerialesFCIs();
            GenericaTwoStrings[] vectSerialARIXs = baseDatos.GetAllSerialesCodigosARIXs();
            byte[] vectIdentifARIXs = baseDatos.GetAllIdentificadoresARIXs();
            if (vectARIXs != null)
            {
                for (int i = 0; i < vectARIXs.Length; i++)
                {
                    string txtId = vectARIXs[i].ToString();
                    TreeNode nodoArix = new TreeNode(/*ConstsTreeView.NOMBRE_EQU_FCI + " " +*/ SerialOrCodigo(vectSerialARIXs[i], verCodificacion) + "- Id " + vectIdentifARIXs[i], ConstsTreeView.NOMBRE_EQU_FCI + " " + SerialOrCodigo(vectSerialARIXs[i], verCodificacion) + "- Id " + vectIdentifARIXs[i]);
                    nodoPpal.ChildNodes.Add(nodoArix);
                    nodoArix.NavigateUrl = "~/PagesEquipment/EditARIX.aspx?Id=" + txtId;
                    nodoArix.Target = "content";
                    nodoArix.ToolTip = ToolTipEquipo(vectSerialARIXs[i], verCodificacion);
                }
            }
        }


        /// <summary>
        /// Vuelve a cargar los datos del Arbol 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void butRefresh_Click(object sender, EventArgs e)
        {
            lblErrorConnectionBaseDatos.Text = "Processing...";
            treeSistema.Nodes.Clear();
            PopulateTree();
            //treeSistema.CollapseAll();
            treeSistema.ExpandAll();
          
        }

        /// <summary>
        /// Graba en objeto session la ruta abierta del arbol
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void treeSistema_SelectedNodeChanged(object sender, EventArgs e)
        {

        }

      

        protected void butConnectDataBase_Click(object sender, ImageClickEventArgs e)
        {
            lblErrorConnectionBaseDatos.Text = "Connecting Database...";
            butRefresh_Click(sender, e); //igual al inicio.
        }

        protected void chkVisualizarCodigosCorporativos_CheckedChanged(object sender, EventArgs e)
        {
            //HttpContext.Current.Profile
            Context.Profile.SetPropertyValue("VerCodificacionEquipos", chkVisualizarCodigosCorporativos.Checked);
            //profileObj.CodificarEquipos = chkVisualizarCodigosCorporativos.Checked;
            butRefresh_Click(sender, e);
            

        }
       
    }
}