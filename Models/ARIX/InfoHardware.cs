using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SistemaGestionRedes.Models.ARIX
{
    [Table("ARIX_InfoHardware")]
    public class InfoHardware
    {
        [Key] public int Id { get; set; }

        /// <summary>
        /// Voltaje actual capacitor disparo
        /// </summary>
        public int VoltActualCapDisparo { get; set; }

        /// <summary>
        /// Voltaje actual super capacitor
        /// </summary>
        public int VoltActualSuperCapacitor { get; set; }

        /// <summary>
        /// Corriente actuación máxima apertura
        /// </summary>
        public int CorrActuacionAperturaMax { get; set; }

        /// <summary>
        /// Corriente de actuaciíon última apertura
        /// </summary>
        public int CorrActuacionAperturaUltima { get; set; }

        /// <summary>
        /// Corriente de actuación máxima cierre
        /// </summary>
        public int CorrActuacionCierreMax { get; set; }

        /// <summary>
        /// Corriente de actuación último cierre
        /// </summary>
        public int CorrActuacionCierreUltimo { get; set; }


        /// <summary>
        /// Tiempo de actuacion apertura máxima
        /// </summary>
        public int TiempoActuacionAperturaMax { get; set; }

        /// <summary>
        /// Tiempo actuacion ultima apertura
        /// </summary>
        public int TiempoActuacionAperturaUltima { get; set; }

        /// <summary>
        /// Tiempo de actuacion cierre máximo
        /// </summary>
        public int TiempoActuacionCierreMax { get; set; }

        /// <summary>
        /// Tiempo de actuacion último cierre
        /// </summary>
        public int TiempoActuacionCierreUltimo { get; set; }

        /// <summary>
        /// Temperatura máxima
        /// </summary>
        public int TemperaturaMax { get; set; }

        /// <summary>
        /// Temperatura mínima
        /// </summary>
        public int TemperaturaMin { get; set; }

        /// <summary>
        /// Temperatura actual
        /// </summary>
        public int TemperaturaActual { get; set; }

        /// <summary>
        /// Frecuencia actual
        /// </summary>
        public int FrecuenciaActual { get; set; }

        /// <summary>
        /// Velocidad de actuación máxima apertura
        /// </summary>
        public int VelActuacionAperturaMax { get; set; }

        /// <summary>
        /// Velocidad de actuación última apertura
        /// </summary>
        public int VelActuacionAperturaUltima { get; set; }

        /// <summary>
        /// Velocidad de actuación máxima cierre
        /// </summary>
        public int VelActuacionCierreMax { get; set; }

        /// <summary>
        /// Velocidad de actuación último cierre
        /// </summary>
        public int VelActuacionCierreUltimo { get; set; }

        /// <summary>
        /// Desplazamiento máximo entre contactos
        /// </summary>
        public int DesplazamientoContactosMax { get; set; }

        /// <summary>
        /// Desplazamiento último entre contactos
        /// </summary>
        public int DesplazamientoContactosUltimo { get; set; }

        /// <summary>
        /// Tensión
        /// </summary>
        public int AdcTension { get; set; }

        /// <summary>
        /// Frecuencia actual señal voltaje
        /// </summary>
        public int FrecuenciaActualSenalVoltaje { get; set; }

        /// <summary>
        /// Fecha que se creo el log en FWT
        /// </summary>
        public DateTime Fecha { get; set; }

        /// <summary>
        /// Id que representa el Arix.
        /// </summary>
        public int IdArix { get; set; }
    }
}