using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace SistemaGestionRedes
{
    public class BoundFieldCel : BoundField
    {
        public string Name { get; set; }

        public BoundFieldCel()
            : base()
        {
        }
    }


    public class TemplateFieldCel : TemplateField
    {
        public string Name { get; set; }

        public TemplateFieldCel()
            :base()
        {
        }
    }

}