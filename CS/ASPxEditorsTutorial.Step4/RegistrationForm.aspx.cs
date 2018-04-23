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
        protected void cityComboBox_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e) {
            if(string.IsNullOrEmpty(e.Parameter)) return;
            AccessDataSourceCities.SelectParameters[0].DefaultValue = e.Parameter;
            cityComboBox.DataBind();
        }

        protected void signUp_Click(object sender, EventArgs e) {
            if(Captcha.IsValid) {
                using(OleDbConnection connection = GetConnection()) {
                    OleDbCommand command = new OleDbCommand(string.Empty, connection);
                    command.CommandText = "INSERT INTO [Users] (FirstName, LastName, Gender, BirthDate, Country, City, Email, UserPassword) VALUES (@firstName, @lastName, @gender, @birthDate, @country, @city, @email, @password)";

                    command.Parameters.AddWithValue("firstName", firstNameTextBox.Text);
                    command.Parameters.AddWithValue("lastName", lastNameTextBox.Text);
                    command.Parameters.AddWithValue("gender", genderRadioButtonList.Value);
                    command.Parameters.AddWithValue("birthDate", birthDateEdit.Date.ToShortDateString());
                    command.Parameters.AddWithValue("country", countryComboBox.Text);
                    command.Parameters.AddWithValue("city", cityComboBox.Text);
                    command.Parameters.AddWithValue("email", eMailTextBox.Text);
                    command.Parameters.AddWithValue("password", passwordTextBox.Text);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
                Response.Redirect("RegisteredPage.aspx");
            }
        }
        private OleDbConnection GetConnection() {
            OleDbConnection connection = new OleDbConnection();
            connection.ConnectionString = ConfigurationManager.ConnectionStrings["UsersConnectionString"].ConnectionString;
            return connection;
        }
    }
}