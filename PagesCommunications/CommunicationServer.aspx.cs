using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Net;
using System.Web.UI.WebControls;
//using SGR.CommunicationLibrary;

namespace SistemaGestionRedes
{
    public partial class CommunicationServer : System.Web.UI.Page
    {

        private void LoadIpsServidor()
        {
            IPHostEntry ipHInfoLocal = Dns.GetHostEntry(Dns.GetHostName());//Se halla una entrada de hosts en el DNS
            foreach (IPAddress item in ipHInfoLocal.AddressList)
            {
                ddListIpsServidor.Items.Add(new ListItem(item.ToString()));
            }
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //if (Application["Servidor"] != null)
                //{
                //    lblEstado.Text = "Servidor Funcionando !";
                //    butIniciarComunicacion.Enabled = false;
                //    butDetenerComunicacion.Enabled = true;
                //    SGRServer serv = (SGRServer) Application["Servidor"];
                //    lblConexion.Text = "Escuchando en " + serv.EndPointListening;
                //    lblConexion.Visible = true;
                //    //butStopComunicacion.Enabled = true;
                //}
                //else
                //{
                //    lblEstado.Text = "Servidor Detenido.";
                //    butIniciarComunicacion.Enabled = true;
                //   // butStopComunicacion.Enabled = false;
                //}
                LoadIpsServidor();
            }
        }

        protected void butConfigurar_Click(object sender, EventArgs e)
        {
            if ((int.Parse(txtBoxPuerto.Text) > 1024) && (int.Parse(txtBoxPuerto.Text) < 65000))
            {
                
            }
            else
            {
                Response.Write("Valor incorrecto para puerto TCP");
                txtBoxPuerto.Focus();
            }
        }

        protected void butIniciarComunicacion_Click(object sender, EventArgs e)
        {

            Application.Lock();
            
            //if (Application["Servidor"] == null)
            //{ 
            //    Application["Servidor"] = new SGRServer(ddListIpsServidor.SelectedValue , int.Parse(txtBoxPuerto.Text));
            //}
            
            //SGRServer servidor = (SGRServer)Application["Servidor"];
            //if (servidor.IniciarComunicacionTCP())
            //{
            //    butIniciarComunicacion.Enabled = false;
            //    butDetenerComunicacion.Enabled = true;
            //    lblEstado.Text = "Servidor Funcionando !";
            //    lblConexion.Text = "Conexión Local " + servidor.EndPointListening ;
            //    lblConexion.Visible = true;
            //}
            //else
            //{
            //    Response.Write("Problemas al iniciar Comunicación Observe el Log del servidor.");
            
            //}

            Application.UnLock();
            
        }

       

        protected void butDetenerComunicacion_Click(object sender, EventArgs e)
        {
            Application.Lock();
            //lblEstado.Text = "Deteniendo Servidor ... ";
            //if (Application["Servidor"] !=  null)
            //{
            //    SGRServer svr = (SGRServer)Application["Servidor"];
            //    svr.DetenerServidor();
            //    Application["Servidor"] = null;
            //}
               
            
            //butDetenerComunicacion.Enabled = false;
            //butIniciarComunicacion.Enabled = true;
            //lblEstado.Text = "Servidor Detenido.";
            //lblConexion.Text = "";
            //lblConexion.Visible = false;
            Application.UnLock();
        }

      
  
    }
}