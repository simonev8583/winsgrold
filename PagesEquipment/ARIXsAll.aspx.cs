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
    public partial class ARIXsAll : System.Web.UI.Page
    {
        static string _codLang;

        string _strCmdSp = @"select 
                            ARIXs.Id, 
                            ARIXs.Serial,
                            ARIXs.Codigo,
                            ARIXs.Identificador,
                            ARIXs.Fase, 
                            FWTs.Serial as [Serial_FWT],
                            FWTs.Codigo as [Codigo_FWT],
                            ARIXs.FechaInstalacion, 
                            ARIXs.FechaRegistroGestion
                            FROM ARIXs LEFT JOIN FWTs on (ARIXs.FWTId = FWTs.Id)
                            WHERE TipoEquipo = 4
                            ORDER BY Id asc";

        string _strCmdEn = @"select 
                            ARIXs.Id, 
                            ARIXs.Serial,
                            ARIXs.Codigo,
                            ARIXs.Identificador,
                            ARIXs.Fase, 
                            FWTs.Serial as [Serial_FWT],
                            FWTs.Codigo as [Codigo_FWT],
                            ARIXs.FechaInstalacion, 
                            ARIXs.FechaRegistroGestion
                            FROM ARIXs LEFT JOIN FWTs on (ARIXs.FWTId = FWTs.Id)
                            WHERE TipoEquipo = 4
                            ORDER BY Id asc";

        protected void Page_Load(object sender, EventArgs e)
        {
            _codLang = AccesoDatosEF.ConfirmarLenguaje(CultureInfo.CurrentUICulture.TwoLetterISOLanguageName);

            if (_codLang.Equals("en"))
            {
                SqDSARIXs.SelectCommand = _strCmdEn;
            }
            else
            {
                SqDSARIXs.SelectCommand = _strCmdSp;
            }
        }

    }
}