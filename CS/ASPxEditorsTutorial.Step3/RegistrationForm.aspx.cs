using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Configuration;

namespace ASPxEditorsTutorial {
    public partial class RegistrationForm : System.Web.UI.Page {
        protected void cityComboBox_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e) {
            if(string.IsNullOrEmpty(e.Parameter)) return;
            AccessDataSourceCities.SelectParameters[0].DefaultValue = e.Parameter;
            cityComboBox.DataBind();
        }
    }
}