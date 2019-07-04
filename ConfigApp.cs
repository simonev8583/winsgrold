using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

namespace SistemaGestionRedes
{
    public class ConfigApp
    {
        private static string msgsExcepcion = "";

        public static string MensajeExcepcion
        {
            get
            {
                return msgsExcepcion;
            }
        }

        public static double PeriodoSonidoAlarma
        {
            get
            {
                double valFinal = 0d;
                try
                {
                    string val = ConfigurationManager.AppSettings["periodoSonidoAlarma"];
                    if (!double.TryParse(val, out valFinal))
                    {
                        valFinal = 20d;
                    }
                }
                catch (ConfigurationErrorsException cErrEx)
                {
                    valFinal = 20d;
                    msgsExcepcion = "Se retorna valor PeriodoSonidoAlarma por defecto. Excepcion recuperando setting. Valor: " + valFinal.ToString() + ". ";
                    msgsExcepcion = msgsExcepcion + cErrEx.Message;
                }

                return valFinal;
            }
        }


        public static ushort MaxCanalesIEC104
        {
            get
            {
                ushort valFinal = 1;

                try
                {
                    string val = ConfigurationManager.AppSettings["MaxCanalesIEC104"];
                    if (!ushort.TryParse(val, out valFinal))
                    {
                        valFinal = 1;
                    }
                }
                catch (ConfigurationErrorsException cErrEx)
                {
                    valFinal = 1;
                    msgsExcepcion = "Se retorna valor MaxCanalesIEC104 por defecto. Excepcion recuperando setting. Valor: " + valFinal.ToString() + ". ";
                    msgsExcepcion = msgsExcepcion + cErrEx.Message;
                }

                return valFinal;
            }
        }


        public static ushort MaxEquiposCanalIEC104
        {
            get
            {
                ushort valFinal = 64;

                try
                {
                    string val = ConfigurationManager.AppSettings["MaxEquiposCanal"];
                    if (!ushort.TryParse(val, out valFinal))
                    {
                        valFinal = 64;
                    }
                }
                catch (ConfigurationErrorsException cErrEx)
                {
                    valFinal = 64;
                    msgsExcepcion = "Se retorna valor MaxEquiposCanal por defecto. Excepcion recuperando setting. Valor: " + valFinal.ToString() + ". ";
                    msgsExcepcion = msgsExcepcion + cErrEx.Message;
                }

                return valFinal;
            }
        }

        public static int CodigoPais
        {
            get
            {
                int valFinal = 57;

                try
                {
                    string val = ConfigurationManager.AppSettings["CodigoPais"];
                    if (!int.TryParse(val, out valFinal))
                    {
                        valFinal = 57;
                    }
                }
                catch (ConfigurationErrorsException cErrEx)
                {
                    valFinal = 57;
                    msgsExcepcion = "Se retorna valor CodigoPais por defecto. Excepcion recuperando setting. Valor: " + valFinal.ToString() + ". ";
                    msgsExcepcion = msgsExcepcion + cErrEx.Message;
                }

                return valFinal;
            }
        }

        public static bool VerSix
        {
            get
            {
                bool valFinal = false;
                try
                {
                    string val = ConfigurationManager.AppSettings["verSix"];
                    if (!bool.TryParse(val, out valFinal))
                    {
                        valFinal = true;
                    }
                }
                catch (ConfigurationErrorsException cErrEx)
                {
                    valFinal = true;
                    msgsExcepcion = "Se retorna valor verSix por defecto. Excepcion recuperando setting. Valor: " + valFinal.ToString() + ". ";
                    msgsExcepcion = msgsExcepcion + cErrEx.Message;
                }

                return valFinal;
            }
        }

        public static string QueueToCosoft
        {
            get
            {
                string valorCola = "";

                try
                {
                    valorCola = ConfigurationManager.AppSettings["queueToCosoft"];
                }
                catch (ConfigurationErrorsException cErrEx)
                {
                    msgsExcepcion = "Error recuperando la clave queueToCosoft del archivo Web.Config";
                    msgsExcepcion = msgsExcepcion + cErrEx.Message;
                }

                return valorCola;
            }
        }


        public static string QueueFromCosoft
        {
            get
            {
                string valorCola = "";

                try
                {
                    valorCola = ConfigurationManager.AppSettings["queueFromCosoft"];
                }
                catch (ConfigurationErrorsException cErrEx)
                {
                    msgsExcepcion = "Error recuperando la clave queueFromCosoft del archivo Web.Config";
                    msgsExcepcion = msgsExcepcion + cErrEx.Message;
                }

                return valorCola;
            }
        }


        public static string QueueToWinScada
        {
            get
            {
                string valorCola = "";

                try
                {
                    valorCola = ConfigurationManager.AppSettings["queueToWinScada"];
                }
                catch (ConfigurationErrorsException cErrEx)
                {
                    msgsExcepcion = "Error recuperando la clave queueToWinScada del archivo Web.Config";
                    msgsExcepcion = msgsExcepcion + cErrEx.Message;
                }

                return valorCola;
            }
        }


        public static string QueueFromWinScada
        {
            get
            {
                string valorCola = "";

                try
                {
                    valorCola = ConfigurationManager.AppSettings["queueFromWinScada"];
                }
                catch (ConfigurationErrorsException cErrEx)
                {
                    msgsExcepcion = "Error recuperando la clave queueFromWinScada del archivo Web.Config";
                    msgsExcepcion = msgsExcepcion + cErrEx.Message;
                }

                return valorCola;
            }
        }

    }//end of class
}