using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Celsa.ConexionMensajeria;
using SCADA104.Definiciones;

namespace SistemaGestionRedes
{
    public static class UtilsScada
    {
        public const int SEGS_WAIT_WINSCADA_QUEUE = 15;

        public static bool InicializarConectorQueue(out ConectorMQ conectorScada)
        {
            bool exito = true;
            conectorScada = null;
            string colaIn = ConfigApp.QueueFromWinScada;
            string colaOut = ConfigApp.QueueToWinScada;

            if (colaIn != "" && colaOut != "")
            {
                conectorScada = new ConectorMQ(colaIn, colaOut);
                conectorScada.SetInFormatter(typeof(RespuestaToWeb));
                conectorScada.PurgarColaEntrante();
            }
            else
            {
                exito = false;
            }

            return exito;
        }

        public static bool CheckWinScadaService(ConectorMQ conector, out string txtFromWinScada)
        {
            bool exito = true;
            txtFromWinScada = "";
            MessageToWinScada msgChk = new MessageToWinScada();
            msgChk.Comando = TipoOperacionInWinScada.ASK_FOR_RUNNING;

            conector.EnviarMensaje(msgChk);
            System.Messaging.Message msgRta = conector.Recibir(SEGS_WAIT_WINSCADA_QUEUE);
            RespuestaToWeb rta = (RespuestaToWeb)msgRta.Body;
            if (rta.Respuesta != RespuestaToWebSGR.OPERACION_OK)
            {
                exito = false;
                txtFromWinScada = rta.TextoRespuesta;
            }
            return exito;
        }


    }//end of class
}