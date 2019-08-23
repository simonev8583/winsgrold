using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Web.SessionState;
using System.Data;
using System.IO;
using System.Threading;
using SGR.UtilityLibrary;
using SGR.BussinessLayer;
using SGR.DataAccessLayer;
using ADF.Comunicaciones;

namespace SistemaGestionRedes
{
    public partial class FWTFirmwareUpdating : System.Web.UI.Page
    {
        Dictionary<string, bool> equiposSelected;
        List<string> renglonesPPageAddress ; //PpageAddrress de cada renglon
        List<string> renglonesDatos; //Datos de cada renglon
        string nmActualizacionFinal; //Nombre de la actualizacion
        AccesoDatos _conexionBD = new AccesoDatos();
        SimpleFirmwareFactory _factoryFw = new SimpleFirmwareFactory();
        Firmware _fwObj;


        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Page.IsPostBack)
            {
                equiposSelected = (Dictionary<string, bool>)Session["equiposActFW"];
                lblMensaje.Text = "";
            }
            else
            {
               
                Session["equiposActFW"] = null;
                
            }
        }

        protected void btnRefrescarFiltros_Click(object sender, EventArgs e)
        {
            if (txtInfoFwt.Text.Trim().Equals(""))
            {
                SqDSGetFWT.SelectParameters["infoFwt"].DefaultValue = null;
            }
            else
            {
                SqDSGetFWT.SelectParameters["infoFwt"].DefaultValue = txtInfoFwt.Text.Trim();
            }

            equiposSelected.Clear();
            GVFwts.DataBind();

        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            string errProceso = "";

            errProceso = ValidarArchivoUpload();
            if (errProceso != "")
            {
                lblMensaje.Text = errProceso;
                return;
            }

            //Verificar los ultimos posibles equipos seleccionados
            VerificarEquiposSeleccionados();

            //Validar que al menos un equipo fuera seleccionado
            if (GetQtyProgramados() == 0)
            {
                lblMensaje.Text = (string)this.GetLocalResourceObject("lblMensajeAlMenosUnEquipo"); //"Se debe seleccionar al menos un equipo";
                return;
            }

            //Revisar que tipo de firmware se esta montando...
            FirmwareType fwType;
            try
            {
                _fwObj = _factoryFw.CreateFirmwareObj(Encoding.ASCII.GetString(FUpPrograma.FileBytes), out fwType);
                if (_fwObj == null)
                {
                    lblMensaje.Text = (string)this.GetLocalResourceObject("lblMensajeArchivoNoValido"); //"El archivo subido No es un archivo valido S19 para actualizar Firmware";
                    return;
                }
            }
            catch (Exception exGral)
            {
                lblMensaje.Text = (string)this.GetLocalResourceObject("lblMensajeArchivoNoValido"); //"El archivo subido No es un archivo valido S19 para actualizar Firmware";
                return;
            }


            if (fwType == FirmwareType.FMWR_TYPE_FWT)
            {

                List<string> renglonesS19 = ProcesadorArchivoS19.DevolverRenglonesProgramaS19(Encoding.ASCII.GetString(FUpPrograma.FileBytes));



                if (renglonesS19.Count == 0)
                {
                    lblMensaje.Text = (string)this.GetLocalResourceObject("lblMensajeArchivoNoValido"); //"El archivo subido No es un archivo valido S19 para actualizar Firmware";
                    return;
                }

                renglonesS19 = ProcesadorArchivoS19.DevolverRenglonesSortedByPPageAddress(renglonesS19);
                renglonesS19 = ProcesadorArchivoS19.DevolverRenglonesConDireccionesPares(renglonesS19);


                renglonesPPageAddress = new List<string>(); //PpageAddrress de cada renglon
                renglonesDatos = new List<string>(); //Datos de cada renglon



                foreach (string item in renglonesS19)
                {
                    renglonesPPageAddress.Add(item.Substring(0, 6));
                    renglonesDatos.Add(item.Substring(6, item.Length - 6));
                }

                //for (int i = 0; i < renglonesS19.Count; i++)
                //{
                //    Response.Write("Renglon Completo : " + renglonesS19[i] + "<br>");
                //    Response.Write("Renglon PPageAddress : " + renglonesPPageAddress[i] + "<br>");
                //    Response.Write("Renglon Datos : " + renglonesDatos[i] + "<br>");
                //}


                errProceso = TryInsertarActualizacionFW();

                if (errProceso == "")
                {

                    // StringBuilder object
                    StringBuilder str = new StringBuilder();
                    StringBuilder serialesNoProgramados = new StringBuilder();

                    foreach (KeyValuePair<string, bool> kvp in equiposSelected)
                    {
                        if (kvp.Value)
                        {
                            str.Append(kvp.Key + " - ");
                        }
                        else
                        {
                            serialesNoProgramados.Append(kvp.Key + " - ");
                        }
                    }
                    // prints out the result
                    //lblMensaje.Text = str.ToString() + " Qty FWTs en Diccionario: " + equiposSelected.Count.ToString() + " Qry Seleccionados: " + GetQtyProgramados().ToString();
                    lblMensaje.Text = (string)this.GetLocalResourceObject("lblMensajeCantidadFWTSeleccionados") + GetQtyProgramados().ToString() + " !!";
                    if (serialesNoProgramados.Length > 0)
                    {
                        lblMensajeNoAptos.Text = (string)this.GetLocalResourceObject("lblMensajeFWTNoAptos") + " : " + serialesNoProgramados.ToString();
                    }
                }
                else
                {
                    // prints out the result
                    lblMensaje.Text = errProceso;
                }
            }
            else if (fwType == FirmwareType.FMWR_TYPE_FCI)
            {
                FirmwareFCI fwFciObj = (FirmwareFCI)_fwObj;
                string fwtsNoHab = GetCadenaEquiposFWTNoHabilitados();
                string serialesFwt = GetCadenaSerialesFWTs();
                try
                {
                    _conexionBD.IniciarCargaFirmwareDEVRT(fwFciObj.VersionFirmware, (byte)fwFciObj.TipoFirmware, (int)fwFciObj.ChecksumFile, fwFciObj.PaginasDirecciones, fwFciObj.DatosFirmware, serialesFwt);
                    lblMensaje.Text = (string)this.GetLocalResourceObject("lblMensajeCantidadFWTSeleccionados") + GetQtyProgramados().ToString() + " !!";
                    if (!fwtsNoHab.Equals(""))
                    {
                        lblMensajeNoAptos.Text = (string)this.GetLocalResourceObject("lblMensajeFWTNoAptos") + " : " + fwtsNoHab;
                    }
                }
                catch (Exception exGral)
                {
                    lblMensaje.Text = (string)this.GetLocalResourceObject("lblBDErrorUploadingFwDevice"); //Error en las operaciones de BDs que insertan la informacion del firmaware a subir...
                    return;
                }
            }
            else if(fwType == FirmwareType.FMWR_TYPE_ARIX)
            {
                FirmwareARIX fwFciObj = (FirmwareARIX)_fwObj;
                string fwtsNoHab = GetCadenaEquiposFWTNoHabilitados();
                string serialesFwt = GetCadenaSerialesFWTs();
                try
                {
                    _conexionBD.IniciarCargaFirmwareDEVRT(fwFciObj.VersionFirmware, (byte)fwFciObj.TipoFirmware, (int)fwFciObj.ChecksumFile, fwFciObj.PaginasDirecciones, fwFciObj.DatosFirmware, serialesFwt);
                    //fwFciObj.ActualizarFirmware();
                    lblMensaje.Text = (string)this.GetLocalResourceObject("lblMensajeCantidadFWTSeleccionados") + GetQtyProgramados().ToString() + " !!";
                    if (!fwtsNoHab.Equals(""))
                    {
                        lblMensajeNoAptos.Text = (string)this.GetLocalResourceObject("lblMensajeFWTNoAptos") + " : " + fwtsNoHab;
                    }
                }
                catch (Exception exGral)
                {
                    lblMensaje.Text = (string)this.GetLocalResourceObject("lblBDErrorUploadingFwDevice"); //Error en las operaciones de BDs que insertan la informacion del firmaware a subir...
                    return;
                }
            }

        }

        protected string GetCadenaEquiposFWTNoHabilitados()
        {
            StringBuilder fwtsNo = new StringBuilder();

            for (int i = 0; i < equiposSelected.Count; i++)
            {
                if (equiposSelected.ElementAt(i).Value)
                {
                    if (_conexionBD.IsActualizacionFwDEVRTEnProceso(equiposSelected.ElementAt(i).Key))
                    {
                        equiposSelected[equiposSelected.ElementAt(i).Key] = false;
                        fwtsNo.Append(equiposSelected.ElementAt(i).Key + " ");
                    }
                }
            }

            //foreach (KeyValuePair<string, bool> kvp in equiposSelected)
            //{
            //    if (kvp.Value)
            //    {
            //        if (_conexionBD.IsActualizacionFwDEVRTEnProceso(kvp.Key))
            //        {
            //            equiposSelected[kvp.Key] = false;
            //            fwtsNo.Append(kvp.Key + " ");
            //        }
            //    }
            //}

            return fwtsNo.ToString();
        }

        protected string GetCadenaSerialesFWTs()
        {
            StringBuilder chain = new StringBuilder();

            foreach (KeyValuePair<string, bool> kvp in equiposSelected)
            {
                if (kvp.Value)
                {
                    chain.Append(kvp.Key);
                }
            }

            return chain.ToString();
        }

        /// <summary>
        /// Retorna "" si el archivo sí fue subido al servidor .
        /// </summary>
        /// <returns></returns>
        protected string ValidarArchivoUpload()
        {
            //Validar si hubo Upload de archivo real
            if (!FUpPrograma.HasFile)
            {
                return (string)this.GetLocalResourceObject("ValidarArchivoUploadNoUpload"); //"No se realizó Upload de archivo de programa";
            }

            if (FixNombreArchivo(FUpPrograma.FileName).Trim() == "")
            {
                return (string)this.GetLocalResourceObject("ValidarArchivoUploadNombreIncorrecto"); //"Nombre incorrecto del archivo de programa. Verificar";
            }

            if (FUpPrograma.FileBytes.LongLength == 0)
            {
                return (string)this.GetLocalResourceObject("ValidarArchivoUploadTamanoIncorrecto"); //"Tamaño de archivo incorrecto. Verificar";
            }
            return "";
        }

        protected void InsertarActualizacionFW()
        {
            
            int qtyAfectados = GetQtyProgramados();
            //string programaFW = Encoding.ASCII.GetString(FUpPrograma.FileBytes);
            ASCIIEncoding enc = new ASCIIEncoding();
            string programaFW = enc.GetString(FUpPrograma.FileBytes); //Diferencia entre Encoding.ASCII y ASCIIEncoding

     
            SqDSInsertActFW.InsertParameters["ActFw"].DefaultValue = nmActualizacionFinal;
            SqDSInsertActFW.InsertParameters["Qty"].DefaultValue = qtyAfectados.ToString();
            SqDSInsertActFW.InsertParameters["Prog"].DefaultValue = programaFW;
           

            SqDSInsertActFW.Insert();

            //Ahora a insertar cada uno de los strings particionados con los datos de la actualización
            for (short i = 1; i <=    renglonesPPageAddress.Count ; i++)
			{
			    using (SistemaGestionRemotoContainer Bdata = new SistemaGestionRemotoContainer())
                {
                    ActualizacionesFWs actFW = ActualizacionesFWs.CreateActualizacionesFWs(nmActualizacionFinal , i ,renglonesPPageAddress[i-1], renglonesDatos[i-1]); //El contador empieza en 1 , el indice en cade lista en cero
                    Bdata.ActualizacionesFWs.AddObject(actFW);
                    Bdata.SaveChanges();
            
                }  
			}

                      
           
        }

        protected string TryInsertarActualizacionFW()
        {
            try
            {
                nmActualizacionFinal = FixNombreArchivo(FUpPrograma.FileName) + " " + DateTime.Now.ToLongDateString() + " " + DateTime.Now.ToLongTimeString();
                SqDSInsertActFW.SelectParameters["nmAct"].DefaultValue = nmActualizacionFinal;
                IDataReader idr = (IDataReader)SqDSInsertActFW.Select(DataSourceSelectArguments.Empty);
                if (idr.Read())
                {
                    if ((int)idr["cant"] == 0)
                    {
                        InsertarActualizacionFW();
                    }
                    //else
                    //{
                    //    //Se permite una misma actualización, pero se controla que no se inserte dos veces:
                    //    //return (string)this.GetLocalResourceObject("TryInsertarActualizacionFWYaExiste"); //"Ya existe un registro de actualizacion con el mismo nombre de archivo. Verificar";
                    //}
                    VerificarFWTBajoProcesoActivo();
                    ModificarRegistrosFWT();
                }
            }
            catch (Exception gralEx)
            {
                return gralEx.Message;
            }

            return "";
        }

        protected void ModificarRegistrosFWT()
        {
            
            foreach (KeyValuePair<string, bool> kvp in equiposSelected)
            {
                if (kvp.Value)
                {
                    SqDSGetFWT.UpdateCommand = "update FWTs set ActFirmware = @actFirmware, ContActFw = 0, EstadoProcesoActFw = " + (byte)EstadoActualizacionFirmware.Inicio + " where Serial = @serial";
                    SqDSGetFWT.UpdateParameters["actFirmware"].DefaultValue = nmActualizacionFinal;
                    SqDSGetFWT.UpdateParameters["serial"].DefaultValue = kvp.Key;
                    SqDSGetFWT.Update();
                }
            }
        }

        protected void VerificarFWTBajoProcesoActivo()
        {
            for (int i = 0; i < equiposSelected.Count; i++)
            {
                if (equiposSelected.ElementAt(i).Value)
                {
                    if (_conexionBD.IsActualizacionFwFWTEnProceso(equiposSelected.ElementAt(i).Key))
                    {
                        equiposSelected[equiposSelected.ElementAt(i).Key] = false;
                    }
                }
            }

                //foreach (KeyValuePair<string, bool> kvp in equiposSelected)
                //{
                //    if (kvp.Value)
                //    {
                //        if (_conexionBD.IsActualizacionFwFWTEnProceso(kvp.Key))
                //        {
                //            equiposSelected[kvp.Key] = false;
                //        }
                //    }
                //}
        }

        protected string FixNombreArchivo(string nombreFileUsr)
        {
            return nombreFileUsr.Remove(nombreFileUsr.LastIndexOf("."));
        }

        protected void GVFwts_DataBound(object sender, EventArgs e)
        {
            if (GVFwts.Rows.Count > 0)
            {
                //lblMensaje.Text = "Seleccione archivo de FW y luego las FWT. Gracias.";
                InicializarDiccionarioEquipos();
            }
            for (int i = 0; i < GVFwts.Rows.Count; i++)
            {
                GridViewRow row = GVFwts.Rows[i];
                string serialStr = row.Cells[1].Text; //GVFwts.Rows[i].Cells[1].Text;
                ((CheckBox)row.FindControl("chkSelect")).Checked = equiposSelected[serialStr];
            }
        }

        protected void InicializarDiccionarioEquipos()
        {
            if (equiposSelected == null)
            {
                equiposSelected = new Dictionary<string, bool>();
            }
            for (int i = 0; i < GVFwts.Rows.Count; i++)
            {
                string serialStr = GVFwts.Rows[i].Cells[1].Text;
                if (!equiposSelected.ContainsKey(serialStr))
                {
                    equiposSelected.Add(serialStr, false);
                }
            }
            Session["equiposActFW"] = equiposSelected;
        }

        protected void GVFwts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            VerificarEquiposSeleccionados();
        }

        protected void VerificarEquiposSeleccionados()
        {
            for (int i = 0; i < GVFwts.Rows.Count; i++)
            {
                GridViewRow row = GVFwts.Rows[i];
                bool isChecked = ((CheckBox)row.FindControl("chkSelect")).Checked;

                string serialStr = GVFwts.Rows[i].Cells[1].Text;
                if (isChecked)
                {
                    equiposSelected[serialStr] = true;
                }
                else
                {
                    equiposSelected[serialStr] = false;
                }
            }
            Session["equiposActFW"] = equiposSelected;
        }

        protected int GetQtyProgramados()
        {
            int conta = 0;
            foreach (KeyValuePair<string, bool> kvp in equiposSelected)
            {
                if (kvp.Value)
                {
                    conta++;
                }
            }
            return conta;
        }

        

      

       


    }
}