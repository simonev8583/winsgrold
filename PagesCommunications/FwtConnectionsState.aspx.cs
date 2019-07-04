using System;
using System.Collections.Generic;
using System.Linq;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes.PagesCommunications
{
    public partial class FwtConnectionsState : System.Web.UI.Page
    {
        //private int _qtySegsLimite = 240;
        static private AccesoDatos _conexionBD = new AccesoDatos();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            //string textFwtConectados = "Conectados";
            //string textFwtDesconectados = "Desconectados";

            //int qtyConectados = GVConectados.Rows.Count;
            //int qtyDesconectados = GVDesconectados.Rows.Count;


            //ChartFwtConnections.Series["Series_Ppal"].Points.Clear();

            //ChartFwtConnections.Series["Series_Ppal"].MarkerStyle = System.Web.UI.DataVisualization.Charting.MarkerStyle.Diamond;
            //ChartFwtConnections.Series["Series_Ppal"].MarkerSize = 10;
            //ChartFwtConnections.Series["Series_Ppal"].MarkerColor = System.Drawing.Color.Red;
            //ChartFwtConnections.Series["Series_Ppal"].IsValueShownAsLabel = true;

            //ChartFwtConnections.Series["Series_Ppal"].Points.AddXY(textFwtConectados, new object[] { qtyConectados });
            //ChartFwtConnections.Series["Series_Ppal"].Points.AddXY(textFwtDesconectados, new object[] { qtyDesconectados });

        }

        protected void btnRefrescarFiltros_Click(object sender, EventArgs e)
        {
            GVConectados.DataBind();
            GVDesconectados.DataBind();
        }

        protected void GVConectados_DataBinding(object sender, EventArgs e)
        {
            if (txtInfoFwt.Text.Trim().Equals(""))
            {
                SqlDSConnected.SelectParameters["infoPrm"].DefaultValue = null;
            }
            else
            {
                SqlDSConnected.SelectParameters["infoPrm"].DefaultValue = "%" + txtInfoFwt.Text.Trim() + "%";
            }
            //SqlDSConnected.SelectParameters["qtySegs"].DefaultValue = _qtySegsLimite.ToString();
        }

        protected void GVDesconectados_DataBinding(object sender, EventArgs e)
        {
            if (txtInfoFwt.Text.Trim().Equals(""))
            {
                SqlDSDisconnected.SelectParameters["infoPrm"].DefaultValue = null;
            }
            else
            {
                SqlDSDisconnected.SelectParameters["infoPrm"].DefaultValue = "%" + txtInfoFwt.Text.Trim() + "%";
            }
            //SqlDSDisconnected.SelectParameters["qtySegs"].DefaultValue = _qtySegsLimite.ToString();
        }

        protected void GVDesconectados_DataBound(object sender, EventArgs e)
        {
            string textFwtConectados = "Conectados";
            string textFwtDesconectados = "Desconectados";

            //Setting del Chart...

            int qtyConectados = GVConectados.Rows.Count;
            int qtyDesconectados = GVDesconectados.Rows.Count;


            ChartFwtConnections.Series["Series_Ppal"].Points.Clear();

            ChartFwtConnections.Series["Series_Ppal"].MarkerStyle = System.Web.UI.DataVisualization.Charting.MarkerStyle.Diamond;
            ChartFwtConnections.Series["Series_Ppal"].MarkerSize = 10;
            ChartFwtConnections.Series["Series_Ppal"].MarkerColor = System.Drawing.Color.Red;
            ChartFwtConnections.Series["Series_Ppal"].IsValueShownAsLabel = true;

            ChartFwtConnections.Series["Series_Ppal"].Points.AddXY(textFwtConectados, new object[] { qtyConectados });
            ChartFwtConnections.Series["Series_Ppal"].Points.AddXY(textFwtDesconectados, new object[] { qtyDesconectados });

            //Setting del mensaje sobre disponibilidad del Cosoft..

            byte _isCosoftOk = _conexionBD.IsCosoftAvailable();
            if (_isCosoftOk == 0) //No disponible
            {
                lblAvailabilityCosoft.Text = (string)this.GetLocalResourceObject("TextCosoftNoDisponible");
            }
            else //Disponible
            {
                lblAvailabilityCosoft.Text = (string)this.GetLocalResourceObject("TextCosoftDisponible");
            }

        }

        protected void TimerRefresh_Tick(object sender, EventArgs e)
        {
            GVConectados.DataBind();
            GVDesconectados.DataBind();
        }

        
        

        

    }
}