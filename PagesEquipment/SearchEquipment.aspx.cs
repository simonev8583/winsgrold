using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;
using SGR.BussinessLayer;

namespace SistemaGestionRedes
{
    public partial class SearchEquipment : System.Web.UI.Page
    {
       

        protected void butBuscar_Click(object sender, EventArgs e)
        {
            NoMostrarResultadosConsultas();
            //Importante que los datos se actulicen en los gridView segun la consulta .
            gridViewConsultaFCI.DataBind();
            ////Se visualizan las consultas segun los datos encontrados en los gridViews
            if (gridViewConsultaFCI.Rows.Count > 0)
            {
                
                gridViewConsultaFCI.Visible = true;


            }
            
             
            gridViewConsultaFWT.DataBind();
            if (gridViewConsultaFWT.Rows.Count > 0) //Hay datos encontrados por ID 
            {
                
                gridViewConsultaFWT.Visible = true;


            }

        }

        /// <summary>
        /// Oculta todas las consultas 
        /// </summary>
        private void NoMostrarResultadosConsultas()
        {
            
            gridViewConsultaFCI.Visible = false;
          
            gridViewConsultaFCI.Visible = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //sqlDataScFWT.SelectParameters.Clear();
            //sqlDataScFWT.SelectParameters.Add("Serial", string.Format("{0}%", txtBoxIdEquipo.Text));
            //sqlDataScFWT.SelectCommand = "SELECT FechaRegistroGestion, Id, ParamFWT_DireccionNomenclatura_CalleCarrera, ParamFWT_DireccionNomenclatura_Numero, ParamFWT_DireccionNomenclatura_Ciudad, ParamFWT_DireccionElectrica_SubEstacion, ParamFWT_DireccionElectrica_Circuito, ParamFWT_DireccionElectrica_Tramo, Serial FROM FWTs WHERE (Serial LIKE @Serial)";
                

        }

        protected void sqlDataScFWT_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
           
        }

        protected void sqlDataScFCI_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

       

       

       
    }
}