using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Configuration;
using System.Text.RegularExpressions;
using DevExpress.Web.ASPxEditors;

namespace ASPxEditorsTutorial {
	public partial class RegistrationForm : System.Web.UI.Page {
		protected void cityComboBox_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e) {
			if (string.IsNullOrEmpty(e.Parameter)) return;
			AccessDataSourceCities.SelectParameters[0].DefaultValue = e.Parameter;
			cityComboBox.DataBind();
		}

		protected void signUp_Click(object sender, EventArgs e) {
			if (eMailTextBox.IsValid && Captcha.IsValid) {
				using (OleDbConnection connection = GetConnection()) {
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
				if (ASPxEdit.ValidateEditorsInContainer(registrationFormLayout))
					Response.Redirect("RegisteredPage.aspx");
			}
		}
		private OleDbConnection GetConnection() {
			OleDbConnection connection = new OleDbConnection();
			connection.ConnectionString = ConfigurationManager.ConnectionStrings["UsersConnectionString"].ConnectionString;
			return connection;
		}

		protected void CheckEmailCallback_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e) {
			e.Result = GetIsEmailExist(eMailTextBox.Text).ToString();
		}

		private bool GetIsEmailExist(string email) {
			using (OleDbConnection connection = GetConnection()) {
				OleDbCommand cmd = new OleDbCommand("SELECT count(*) FROM [Users] WHERE Email = @Email", connection);
				cmd.Parameters.AddWithValue("Email", email);
				connection.Open();
				int total = (Int32)cmd.ExecuteScalar();
				connection.Close();
				return total > 0;
			}
		}

		protected void eMailTextBox_Validation(object sender, DevExpress.Web.ASPxEditors.ValidationEventArgs e) {
			if (!Page.IsCallback) {

				e.IsValid = e.Value != null;
				if (!e.IsValid){
					e.ErrorText = "Email is required";
					return;
				}

				Regex r = new Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
				e.IsValid = r.IsMatch(e.Value.ToString());
				if (!e.IsValid){
					e.ErrorText = "Email is invalid";
					return;
				}
				
				e.IsValid = !GetIsEmailExist(e.Value.ToString());
				if (!e.IsValid) {
					e.ErrorText = "Sorry, this email belongs to an existing account";
					return;
				}
			}
		}

		protected void requiredTextBox_Validation(object sender, DevExpress.Web.ASPxEditors.ValidationEventArgs e) {
			e.IsValid = e.Value != null;
			if (e.IsValid)
				e.ErrorText = "This field is required";
		}

		protected void password_Validation(object sender, DevExpress.Web.ASPxEditors.ValidationEventArgs e) {
			e.IsValid = e.Value != null;
			if (!e.IsValid) {
				e.ErrorText = "Password is required";
				return;
			}

			string password = e.Value.ToString();
			
			e.IsValid = String.Compare(password, confirmPasswordTextBox.Text) == 0;
			if (!e.IsValid) {
				e.ErrorText = "The password you entered do not match";
				return;
			}

			Regex r = new Regex(@"[A-Z]+|[a-z]+|\d+|[^\w\d\s]+");
			e.IsValid = r.Matches(password).Count > 1;
			if (!e.IsValid) {
				e.ErrorText = "The password is too simple";
				return;
			}
		}
	}
}