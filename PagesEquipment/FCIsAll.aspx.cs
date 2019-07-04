using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SGR.DataAccessLayer;

namespace SistemaGestionRedes
{
    public partial class FCIsAll : System.Web.UI.Page
    {
        static string _codLang;

        string _strCmdSp = @"select 
                            FCIs.Id, 
                            FCIs.Serial,
                            FCIs.Codigo,
                            FCIs.Identificador,
                            FCIs.Fase, 
                            FWTs.Serial as [Serial_FWT],
                            FWTs.Codigo as [Codigo_FWT],
                            FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion],
                            FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
                            FWTs.ParamFWT_DireccionElectrica_Tramo as [Tramo],
                            FWTs.ParamFWT_DireccionElectrica_Nodo as [Nodo],
                            FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Calle_Cra],
                            FWTs.ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad],
                            FWTs.ParamFWT_DireccionNomenclatura_Numero as [Numero],
                            FWTs.ASDU as [Asdu],
                            FCIs.FechaInstalacion, 
                            FCIs.FechaRegistroGestion, 
                            case FCIs.TipoCircuito
                            when 1 then 'Monofásico'
                            when 2 then 'Bifásico'
                            when 3 then 'Trifásico'
                            end as TipoCircuito
                            FROM FCIs LEFT JOIN FWTs on (FCIs.FWTId = FWTs.Id)
                            WHERE TipoEquipo = 1
                            ORDER BY Id asc";

        string _strCmdEn = @"select 
                            FCIs.Id, 
                            FCIs.Serial,
                            FCIs.Codigo,
                            FCIs.Identificador,
                            FCIs.Fase, 
                            FWTs.Serial as [Serial_FWT],
                            FWTs.Codigo as [Codigo_FWT],
                            FWTs.ParamFWT_DireccionElectrica_SubEstacion as [SubEstacion],
                            FWTs.ParamFWT_DireccionElectrica_Circuito as [Circuito],
                            FWTs.ParamFWT_DireccionElectrica_Tramo as [Tramo],
                            FWTs.ParamFWT_DireccionElectrica_Nodo as [Nodo],
                            FWTs.ParamFWT_DireccionNomenclatura_CalleCarrera as [Calle_Cra],
                            FWTs.ParamFWT_DireccionNomenclatura_Ciudad as [Ciudad],
                            FWTs.ParamFWT_DireccionNomenclatura_Numero as [Numero],
                            FWTs.ASDU as [Asdu],
                            FCIs.FechaInstalacion, 
                            FCIs.FechaRegistroGestion, 
                            case FCIs.TipoCircuito
                            when 1 then 'Single-Phase'
                            when 2 then 'Two-Phase'
                            when 3 then 'Three-Phase'
                            end as TipoCircuito
                            FROM FCIs LEFT JOIN FWTs on (FCIs.FWTId = FWTs.Id)
                            WHERE TipoEquipo = 1
                            ORDER BY Id asc";

        protected void Page_Load(object sender, EventArgs e)
        {
            _codLang = AccesoDatosEF.ConfirmarLenguaje(CultureInfo.CurrentUICulture.TwoLetterISOLanguageName);

            if (_codLang.Equals("en"))
            {
                SqDSFCIs.SelectCommand = _strCmdEn;
            }
            else
            {
                SqDSFCIs.SelectCommand = _strCmdSp;
            }
        }
      
    }
}