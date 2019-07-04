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
    public partial class FCIOK : System.Web.UI.Page
    {
        static string _codLang;

        string _strCmdSp = @"select Id, Serial, FWTId as [FWT], FechaInstalacion as [Fecha Instalacion], 
            FechaRegistroGestion as [Fecha Registro], 
            case TipoCircuito
            when 1 then 'Monofásico'
            when 2 then 'Bifásico'
            when 3 then 'Trifásico'
            end as [TipoCircuito]
            from FCIs
            where Serial not in
            (
            select FCIs.Serial as [Serial] 
            FROM FCIs left outer join FWTs on (FCIs.FWTId = FWTs.Id)
            join AlarmasFCI on (FCIs.Id = AlarmasFCI.FCIId)
            join MtAlarmas on (AlarmasFCI.Id = MtAlarmas.Id)
            WHERE AlarmasFCI.ClearAlarma is null and
            MtAlarmas.OrigenAlarma = 'E'
            )
            order by Serial asc";

        string _strCmdEn = @"select Id, Serial, FWTId as [FWT], FechaInstalacion as [Fecha Instalacion], 
            FechaRegistroGestion as [Fecha Registro], 
            case TipoCircuito
            when 1 then 'Single-Phase'
            when 2 then 'Two-Phase'
            when 3 then 'Three-Phase'
            end as [TipoCircuito]
            from FCIs
            where Serial not in
            (
            select FCIs.Serial as [Serial] 
            FROM FCIs left outer join FWTs on (FCIs.FWTId = FWTs.Id)
            join AlarmasFCI on (FCIs.Id = AlarmasFCI.FCIId)
            join MtAlarmas on (AlarmasFCI.Id = MtAlarmas.Id)
            WHERE AlarmasFCI.ClearAlarma is null and
            MtAlarmas.OrigenAlarma = 'E'
            )
            order by Serial asc";

        
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!Page.IsPostBack)
            //{
                _codLang = AccesoDatosEF.ConfirmarLenguaje(CultureInfo.CurrentUICulture.TwoLetterISOLanguageName);

                if (_codLang.Equals("en"))
                {
                    SqDSFCIsOK.SelectCommand = _strCmdEn;
                }
                else
                {
                    SqDSFCIsOK.SelectCommand = _strCmdSp;
                }
            //}
        }
    }
}